FILESEXTRAPATHS_prepend := "${THISDIR}:${THISDIR}/linux-yocto:"

SRC_URI_append = " ${@bb.utils.contains( \
	'RK_KERNEL_CONFIG_TYPE', 'inlayer', ' \
	file://defconfig \
	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta', \
	'', d)}"

COMPATIBLE_MACHINE_marsboard-rk3066 = "marsboard-rk3066"
COMPATIBLE_MACHINE_rock2-square = "rock2-square"
COMPATIBLE_MACHINE_radxarock = "radxarock"
COMPATIBLE_MACHINE_firefly-rk3288 = "firefly-rk3288"
COMPATIBLE_MACHINE_vyasa-rk3288 = "vyasa-rk3288"
COMPATIBLE_MACHINE_tinker-board = "tinker-board"
COMPATIBLE_MACHINE_tinker-board-s = "tinker-board-s"
COMPATIBLE_MACHINE_rock-pi-4 = "rock-pi-4"
COMPATIBLE_MACHINE_nanopi-m4 = "nanopi-m4"
COMPATIBLE_MACHINE_nanopi-m4-2gb = "nanopi-m4-2gb"
