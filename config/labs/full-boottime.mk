BOOTTIME_LABS = boottime-install \
		boottime-getting-started \
		boottime-measuring \
		boottime-setup \
		boottime-init-scripts \
		boottime-application \
		boottime-kernel \
		boottime-bootloader \
		boottime-results \

ifdef LABS
ifeq ($(LABS),full-boottime)
LABS_VARSFILE      = ${VENDOR}/labs/boottime-labs-vars.tex
LABS_CHAPTERS      = $(SYSDEV_LABS)
LABS_CONFIGURED	   = yes
endif
endif

LAB_HELPER+=full-boottime-labs-help

full-boottime-labs.pdf:	SESSION_URL="${VENDOR_URL}/doc/training/boottime"

full-boottime-labs-help:
	$(HELP) "full-boottime-labs.pdf"		"Complete labs for the 'boottime' course"
