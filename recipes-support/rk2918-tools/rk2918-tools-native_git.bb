# Copyright (C) 2015 Trevor Woerner <twoerner@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "Tools for building Rockchip images"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = "file://rkcrc.c;beginline=1;endline=25;md5=2659accd8791d2d4caf29f277116acba"

DEPENDS += "openssl-native"
SRC_URI=" \
	git://github.com/TeeFirefly/rk2918_tools.git \
	file://fix-makefile.patch \
	"
SRCREV = "${AUTOREV}"
PR = "r1"
PV = "0.1+git${SRCREV}"

inherit native

S = "${WORKDIR}/git"
BUILD_CFLAGS = "-DUSE_OPENSSL"

do_compile() {
	oe_runmake
}

do_install() {
	install -d ${D}/${prefix}/bin
	install -m 0755 ${S}/img_maker ${D}/${prefix}/bin/rk2918_img_maker
	install -m 0755 ${S}/afptool ${D}/${prefix}/bin/rk2918_afptool
	install -m 0755 ${S}/mkkrnlimg ${D}/${prefix}/bin/rk2918_mkkrnlimg
}
