YOCTO_LABS   = setup

ifdef LABS
ifeq ($(LABS),full-yocto)
LABS_VARSFILE      = ${VENDOR}/labs/yocto-labs-vars.tex
LABS_CHAPTERS      = $(YOCTO_LABS)
LABS_CONFIGURED	   = yes
endif
endif

LAB_HELPER+=full-yocto-labs-help

full-yocto-labs-help:
	$(HELP) "full-yocto-labs.pdf"			"Complete labs for the 'yocto' course"
