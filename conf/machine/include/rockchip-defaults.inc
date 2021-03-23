# meta-rockchip default settings

# kernel
RK_KERNEL_CONFIG_TYPE ?= "inkernel"
python __anonymous() {
    configtype = d.getVar("RK_KERNEL_CONFIG_TYPE")
    machine = d.getVar("MACHINE")
    kbuild_defconfig = ""
    inlayer_64_support = ['rock-pi-4b']
    noinlayer_64_support = ['rock-pi-4a', 'rock-pi-4c', 'nanopi-m4', 'nanopi-m4-2gb', 'rock-pi-e']
    inlayer_32_support = []
    noinlayer_32_support = ['tinker-board', 'tinker-board-s', 'vyasa-rk3288', 'firefly-rk3288',
        'radxarock', 'rock2-square', 'marsboard-rk3066']

    if configtype != "inkernel" and configtype != "inlayer":
        raise Exception("RK_KERNEL_CONFIG_TYPE must be set to one of 'inlayer' or 'inkernel'")
    if machine == "":
        raise Exception("please set the MACHINE")

    # aarch64 machines
    if machine in inlayer_64_support:
        if configtype == "inlayer":
            kbuild_defconfig = ""
        else:
            kbuild_defconfig = "defconfig"
    elif machine in noinlayer_64_support:
        if configtype == "inlayer":
            raise Exception("%s doesn't support in-layer kernel config" % machine)
        kbuild_defconfig = "defconfig"

    # arm machines
    elif machine in inlayer_32_support:
        if configtype == "inlayer":
            kbuild_defconfig = ""
        else:
            kbuild_defconfig = "multi_v7_defconfig"
    elif machine in noinlayer_32_support:
        if configtype == "inlayer":
            raise Exception("%s doesn't support in-layer kernel config" % machine)
        kbuild_defconfig = "multi_v7_defconfig"

    #otherwise
    else:
        raise Exception("unsupported machine: %s" % machine)

    d.setVar("KBUILD_DEFCONFIG", kbuild_defconfig)
}
PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
KCONFIG_MODE ?= "alldefconfig"
LINUX_VERSION_EXTENSION ?= "-rockchip"

# xserver
PREFERRED_PROVIDER_virtual/xserver = "xserver-xorg"
XSERVER = " \
	xserver-xorg \
	xserver-xorg-utils \
	xserver-xorg-xvfb \
	xserver-xorg-extension-glx \
	xserver-xorg-module-libwfb \
	xserver-xorg-module-exa \
	xf86-video-modesetting \
	xf86-input-evdev \
	xf86-input-mouse \
	xf86-input-keyboard \
	"

# misc
IMAGE_FSTYPES += "ext4"

# boot device (sd-card/emmc)
RK_BOOT_DEVICE ??= "mmcblk0"
WICVARS_append = " RK_BOOT_DEVICE"
