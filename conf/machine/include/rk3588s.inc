# Copyright (C) 2023 Theobroma Systems Design und Consulting GmbH
# Released under the MIT license (see COPYING.MIT for the terms)

SOC_FAMILY = "rk3588s"

DEFAULTTUNE ?= "cortexa76-cortexa55-crypto"

require conf/machine/include/soc-family.inc
require conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
require conf/machine/include/rockchip-defaults.inc
require conf/machine/include/rockchip-wic.inc

KBUILD_DEFCONFIG ?= "defconfig"
KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
KERNEL_CLASSES = "kernel-fitimage"
KERNEL_IMAGETYPE = "fitImage"

PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-bin"
PREFERRED_PROVIDER_optee-os = "rockchip-bin"

TFA_PLATFORM = "rk3588"
TFA_BUILD_TARGET = "bl31"

UBOOT_SUFFIX ?= "itb"
UBOOT_ENTRYPOINT ?= "0x06000000"
