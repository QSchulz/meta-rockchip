# Copyright (C) 2015 Trevor Woerner <twoerner@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)

inherit kernel

DESCRIPTION = "Rockchip Linux kernel for Firefly"
HOMEPAGE = "http://wiki.t-firefly.com/index.php/Firefly-RK3288/Build_kernel/en"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"
SECTION = "kernel"

SRC_URI = "git://bitbucket.org/T-Firefly/firefly-rk3288-kernel.git;protocol=https;rev=f4d954d67f9e5689f1ddbbbd3050a8041424dd48"
LINUX_VERSION ?= "3.10.0"
PV = "${LINUX_VERSION}+git${SRCPV}"
S = "${WORKDIR}/git"
B = "${S}"

COMPATIBLE_MACHINE = "firefly-emmc"

KERNEL_CONFIG_COMMAND = "cd ${S}; make firefly-rk3288-linux_defconfig"
KERNEL_ALT_IMAGETYPE = "firefly-rk3288.img"
KERNEL_IMAGETYPE = "zImage"

inherit deploy

do_deploy_append () {
	install -d ${DEPLOYDIR}
	cp kernel.img resource.img ${DEPLOYDIR}
}

addtask deploy before do_build after do_compile
