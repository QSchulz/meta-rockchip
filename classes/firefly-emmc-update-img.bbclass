# Copyright (C) 2015 Trevor Woerner <twoerner@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)
#
# based on "rockchip-update-img.bbclass" from
# romain.perier@gmail.com of NEO-Technologies

inherit image_types

# This image depends on the rootfs ext4 image
IMAGE_TYPEDEP_firefly-emmc-update-img = "ext4"

DEPENDS = "mkbootimg-native rk2918-tools-native firefly-emmc-bootloader firefly-emmc-initramfs-image virtual/kernel"

FIRMWARE_VER  ?= "1.0"
MANUFACTURER  ?= "OpenEmbedded"
MACHINE_MODEL ?= "${MACHINE}"
CMDLINE       ?= "console=tty0 console=ttyS2 earlyprintk root=/dev/block/mtd/by-name/linuxroot rw rootfstype=ext4 init=/sbin/init"
MTDPARTS      ?= "0x00008000@0x00002000(resource),0x000080000@0x0000A000(boot),-@0x00012000(linuxroot)"

PACKAGE_FILE = "package-file"
PARAMETER    = "parameter"
LOADER       = "loader.bin"
KERNEL_IMG   = "kernel.img"
INITRD_IMG   = "initrd.img"
RESOURCE_IMG = "resource.img"
BOOT_IMG     = "boot.img"
RAW_IMG      = "${IMAGE_NAME}.raw.img"
UPDATE_IMG   = "${IMAGE_NAME}.update.img"

IMAGE_CMD_firefly-emmc-update-img () {
	cd ${DEPLOY_DIR_IMAGE}
	rm -fr update.pack
	mkdir -p update.pack
	cd update.pack
	cp ../${LOADER} .
	cp ../${KERNEL_IMG} .
	cp ../${INITRD_IMG} .
	cp ../${RESOURCE_IMG} .
	cp ../${IMAGE_NAME}.rootfs.ext4 .

	# Create parameter file
	cat > ${PARAMETER} << EOF
FIRMWARE_VER:${FIRMWARE_VER}
MACHINE_MODEL:${MACHINE_MODEL}
MACHINE_ID:007
MANUFACTURER:${MANUFACTURER}
MAGIC: 0x5041524B
ATAG: 0x60000800
MACHINE: 3066
CHECK_MASK: 0x80
PWR_HLD: 0,0,A,0,1
#KERNEL_IMG: 0x60408000
#FDT_NAME: rk-kernel.dtb
#RECOVER_KEY: 1,1,0,20,0
CMDLINE:${CMDLINE} initrd=0x62000000,0x00800000 mtdparts=rk29xxnand:${MTDPARTS}
EOF

	# Create package-file
	cat > ${PACKAGE_FILE} << EOF
# NAME		Relative path
package-file	${PACKAGE_FILE}
bootloader	${LOADER}
parameter	${PARAMETER}
resource	${RESOURCE_IMG}
boot		${BOOT_IMG}
linuxroot	${IMAGE_NAME}.rootfs.ext4
EOF

	# Create boot.img
	mkbootimg --kernel ${KERNEL_IMG} --ramdisk ${INITRD_IMG} --second ${RESOURCE_IMG} -o ${BOOT_IMG}

	# Build update.img using afptool and img_maker
	rk2918_afptool -pack . ${RAW_IMG}
	rk2918_img_maker -rk32 ${LOADER} ${RAW_IMG} ../${UPDATE_IMG}

	# Clean directory
	cd ..
	rm -f update.img
	ln -s ${UPDATE_IMG} update.img
}
