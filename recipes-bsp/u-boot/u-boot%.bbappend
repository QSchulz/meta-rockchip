do_compile:append:rock2-square () {
	# copy to default search path
	if [ "${SPL_BINARY}" = "u-boot-spl-dtb.bin" ]; then
		cp ${B}/spl/${SPL_BINARY} ${B}
	fi
}

DEPENDS:append:rock-pi-4 = " gnutls-native"
# various machines require the pyelftools library for parsing dtb files
DEPENDS:append = " python3-pyelftools-native"

ATF_DEPENDS ??= ""

EXTRA_OEMAKE:append = "${@" BL31=${DEPLOY_DIR_IMAGE}/${TFA_BUILD_TARGET}-${TFA_PLATFORM}.elf" if d.getVar("ATF_DEPENDS") else ""}"
do_compile[depends] .= "${@" trusted-firmware-a:do_deploy" if d.getVar("ATF_DEPENDS") else ""}"

