# (C) Copyright 2015 Freescale Semiconductor, Inc.
#
# SPDX-License-Identifier:	GPL-2.0+
#

obj-y  := my_mx6ull_emmc.o

extra-$(CONFIG_USE_PLUGIN) :=  plugin.bin
$(obj)/plugin.bin: $(obj)/plugin.o
	$(OBJCOPY) -O binary --gap-fill 0xff $< $@
