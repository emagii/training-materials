KERNEL_LABS   = setup \
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

full-kernel-labs-help:
	$(HELP) "full-kernel-labs.pdf"			"Complete labs for the 'kernel' course"

LAB_HELPER+=full-kernel-labs-help


