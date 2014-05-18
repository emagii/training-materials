SYSDEV_LABS   = setup-ubuntu \
		setup-git \
		setup-emagii \
		setup-applications-switcher \
		setup-serial \
		sysdev-SD-card \
		setup-tftpd \
		setup-usbnet-startech \
		setup-network \
		setup-dhcpd \
		setup-nfs \
		setup-yocto-toolchain-1.6 \
		setup-codesourcery \
		sysdev-toolchain-made-easy-BBB \
		sysdev-toolchain-BBB \
		sysdev-u-boot-BBB \
		sysdev-kernel-fetch-and-patch-BBB \
		sysdev-kernel-cross-compiling-BBB \
		sysdev-tinysystem-BBB \
		sysdev-block-filesystems-BBB \
		sysdev-thirdparty-BBB \
		sysdev-buildroot-BBB \
		sysdev-application-development \
		sysdev-application-debugging \
		sysdev-real-time \
		backup


ifdef LABS
ifeq ($(LABS),full-sysdev)
LABS_VARSFILE      = ${VENDOR}/labs/sysdev-labs-vars.tex
LABS_CHAPTERS      = $(SYSDEV_LABS)
LABS_CONFIGURED	   = yes
endif
endif

LAB_HELPER+=full-sysdev-labs-help

full-sysdev-labs.pdf:	SESSION_URL="${VENDOR_URL}doc/training/sysdev"

full-sysdev-labs-help:
	$(HELP) "full-sysdev-labs.pdf"			"Complete labs for the 'sysdev' course"
