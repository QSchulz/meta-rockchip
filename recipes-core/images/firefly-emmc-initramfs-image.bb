# Copyright (C) 2015 Trevor Woerner <twoerner@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "Rockchip initrd for Firefly"
HOMEPAGE = "http://wiki.t-firefly.com/index.php/Firefly-RK3288/Build_kernel/en"
LICENSE = "CLOSED"
SECTION = "initramfs"

SRC_URI = "git://github.com/TeeFirefly/initrd.git;protocol=https"
SRCREV_pn-${PN} = "${AUTOREV}"
S = "${WORKDIR}/git"
B = "${S}"

IMAGE_FEATURES = ""
export IMAGE_BASENAME = "firefly-emmc-initramfs-image"
IMAGE_LINGUAS = ""

COMPATIBLE_MACHINE = "firefly-emmc"

do_compile () {
	cd ${S}
	make
}

inherit deploy

do_deploy () {
	cd ${S}
	cp ../initrd.img ${DEPLOYDIR}
}

addtask deploy before do_build after do_compile

do_configure[noexec] = "1"
do_package[noexec] = "1"
do_packagedata[noexec] = "1"
do_package_write[noexec] = "1"
do_package_write_ipk[noexec] = "1"
do_package_write_rpm[noexec] = "1"
do_package_write_deb[noexec] = "1"
do_package_write_tar[noexec] = "1"
