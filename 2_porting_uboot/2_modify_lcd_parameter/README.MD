# Edit files (u-boot root folder)
1. In `my_mx6ull_emmc.h` change LCD parameter to you LCD specs (refer LCD datasheet)
    ```diff
    - .name             = "TFT43AB",
    - .xres             = 480,
    - .yres             = 272,
    - .pixclock         = 108695,
    - .left_margin      = 8,
    - .right_margin     = 4,
    - .upper_margin     = 2,
    - .lower_margin     = 4,
    - .hsync_len        = 41,
    - .vsync_len        = 10,

    + .name             = "ST7265",
    + .xres             = 800,
    + .yres             = 480,
    + .pixclock         = 40000,
    + .hsync_len        = 4,
    + .left_margin      = 8,
    + .right_margin     = 8,
    + .vsync_len        = 4,
    + .upper_margin     = 16,
    + .lower_margin     = 16,
    ```

2. In `my_mx6ull_emmc` directory
    - `my_mx6ull_emmc.c`
    replace `panel=TFT43AB` with `panel=ST7265` (the LCD controller that you are using)

# Build
1. Using command line
    ```bash
    make ARCH=arm CROSS_COMPILE=../../../1_toolchain/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf- my_mx6ull_emmc_defconfig
    make ARCH=arm CROSS_COMPILE=../../../1_toolchain/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf- -j12
    ```
2. Using script file
    - Copy script file to u-boot folder
        ```bash
        cp ../build.sh .
        ```
    - Build
        ```bash
        ./build.sh
        ```
    - Clean build
        ```bash
        ./build.sh -clean
        ```
# Flash to emmc using uuu tool
1. Install uuu tool
    ```bash
    sudo apt install uuu
    ```
2. Connect dev kit usb port to PC
    - Check connected device
        ```bash
        uuu -lsusb
        ```
    - Download the `u-boot.imx` output file from the U-Boot root folder.
        ```bash
        uuu -b spl u-boot.imx
        ```