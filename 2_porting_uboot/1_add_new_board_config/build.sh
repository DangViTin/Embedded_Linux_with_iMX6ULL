#!/bin/bash

set -e

# === Default values ===
DEFCONFIG="my_mx6ull_emmc_defconfig"
CROSS_COMPILE_PATH="../../../1_toolchain/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin"
CROSS_COMPILE="${CROSS_COMPILE_PATH}/arm-linux-gnueabihf-"
ARCH="arm"
DO_CLEAN=false

# === Help Message ===
usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "Options:"
  echo "  --defconfig=<name>     Set defconfig (default: ${DEFCONFIG})"
  echo "  --toolchain=<path>     Set toolchain path (default: ${CROSS_COMPILE_PATH})"
  echo "  --clean                Run 'make distclean' before build"
  echo "  --help                 Show this help message"
  echo ""
  exit 1
}

# === Parse Arguments ===
for arg in "$@"; do
  case $arg in
    -defconfig=*)
      DEFCONFIG="${arg#*=}"
      ;;
    -clean)
      DO_CLEAN=true
      ;;
    -help)
      usage
      ;;
    *)
      echo "Unknown option: $arg"
      usage
      ;;
  esac
done

# === Info ===
echo "======================================"
echo "DEFCONFIG         = $DEFCONFIG"
echo "CROSS_COMPILER    = $CROSS_COMPILE"
echo "ARCH              = $ARCH"
echo "CLEAN BUILD       = $DO_CLEAN"
echo "======================================"

# === Clean if requested ===
if $DO_CLEAN; then
  echo "Cleaning build..."
  make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE distclean
fi

# === Build ===
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE $DEFCONFIG
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE -j$(nproc)

echo "U-Boot build complete!"
