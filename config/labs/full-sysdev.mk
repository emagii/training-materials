SYSDEV_LABS   = setup \
		sysdev-toolchain \
		sysdev-u-boot \
		sysdev-kernel-fetch-and-patch \
		sysdev-kernel-cross-compiling \
		sysdev-tinysystem \
		sysdev-block-filesystems \
		sysdev-flash-filesystems \
		sysdev-thirdparty \
		sysdev-buildroot \
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

full-sysdev-labs-help:
	$(HELP) "full-sysdev-labs.pdf"			"Complete labs for the 'sysdev' course"
