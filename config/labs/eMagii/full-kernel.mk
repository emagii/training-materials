ifeq ($(VENDOR),eMagii)

KERNEL_LABS   = emagii-setup \
		kernel-sources-download \
		kernel-sources-exploring \
		kernel-board-setup \
		kernel-compiling-and-nfs-booting \
		kernel-module-simple \
		kernel-i2c-device-model \
		kernel-i2c-communication \
		kernel-i2c-input-interface \
		kernel-serial-iomem \
		kernel-serial-output \
		kernel-serial-interrupt \
		kernel-locking \
		kernel-debugging \
		kernel-git \
#		backup # Currently broken for kernel course

ifdef LABS
ifeq ($(LABS),full-kernel)
LABS_VARSFILE      = ${VENDOR}/labs/kernel-labs-vars.tex
LABS_CHAPTERS      = $(KERNEL_LABS)
LABS_CONFIGURED	   = yes
endif
endif

LAB_HELPER+=emagii-full-kernel-labs-help

full-kernel-labs.pdf:	SESSION_URL="http://www.emagii.com/doc/training/embedded-linux"

emagii-full-kernel-labs-help:
	$(HELP) "emagii-full-kernel-labs.pdf"		"Complete labs for the 'eMagii kernel' course"

endif
