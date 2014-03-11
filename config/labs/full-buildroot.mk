BUILDROOT_LABS   = setup

ifdef LABS
ifeq ($(LABS),full-buildroot)
LABS_VARSFILE      = ${VENDOR}/labs/buildroot-labs-vars.tex
LABS_CHAPTERS      = $(BUILDROOT_LABS)
LABS_CONFIGURED	   = yes
endif
endif

LAB_HELPER+=full-buildroot-labs-help

full-buildroot-labs.pdf:	SESSION_URL="${VENDOR_URL}/doc/training/buildroot"

full-buildroot-labs-help:
	$(HELP) "full-buildroot-labs.pdf"		"Complete labs for the 'buildroot' course"
