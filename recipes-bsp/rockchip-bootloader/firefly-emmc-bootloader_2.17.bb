# Copyright (C) Trevor Woerner
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Firefly bootloader"
SECTION = "bootloaders"
LICENSE = "CLOSED"

SRC_URI = "git://github.com/neo-technologies/rockchip-bootloader.git"
SRCREV_pn-${PN} = "${AUTOREV}"

S = "${WORKDIR}/git"

LOADER ?= "RK3288Loader(L)_V${PV}.bin"

inherit deploy

do_deploy() {
    install -d ${DEPLOYDIR}
    install "${S}/${LOADER}" ${DEPLOYDIR}/loader.bin
}

addtask deploy before do_build after do_compile

do_package[noexec] = "1"
do_packagedata[noexec] = "1"
do_package_write[noexec] = "1"
do_package_write_ipk[noexec] = "1"
do_package_write_rpm[noexec] = "1"
do_package_write_deb[noexec] = "1"
do_package_write_tar[noexec] = "1"
