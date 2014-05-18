UBUNTU_LABS   = setup-ubuntu \
		setup-git \
		setup-emagii \
		setup-samba \
		setup-serial \
		sysdev-SD-card \
		setup-tftpd \
		setup-usbnet-startech \
		setup-nfs \
		setup-yocto-toolchain-1.6 \
		setup-codesourcery

ifdef LABS
ifeq ($(LABS),full-ubuntu)
LABS_VARSFILE      = ${VENDOR}/labs/ubuntu-labs-vars.tex
LABS_CHAPTERS      = $(UBUNTU_LABS)
LABS_CONFIGURED	   = yes
endif
endif

LAB_HELPER+=full-ubuntu-labs-help

full-ubuntu-labs.pdf:	SESSION_URL="${VENDOR_URL}doc/training/ubuntu"

full-ubuntu-labs-help:
	$(HELP) "full-ubuntu-labs.pdf"			"Ubuntu setup"
