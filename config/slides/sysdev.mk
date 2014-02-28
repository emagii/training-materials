SYSDEV_SLIDES = \
		licensing \
		$(ABOUT_US) \
		$(CREDITS) \
		course-information-title \
		igepv2-board \
		course-information \
		sysdev-intro \
		sysdev-dev-environment \
		setup-lab \
		sysdev-toolchains-title \
		sysdev-toolchains-definition \
		sysdev-toolchains-c-libraries-title \
		c-libraries \
		sysdev-toolchains-options \
		sysdev-toolchains-obtaining \
		sysdev-toolchains-lab \
		sysdev-bootloaders-title \
		sysdev-bootloaders-sequence \
		sysdev-bootloaders-u-boot \
		sysdev-bootloaders-lab \
		sysdev-linux-intro-title \
		sysdev-linux-intro-features \
		sysdev-linux-intro-versioning \
		sysdev-linux-intro-sources \
		sysdev-linux-intro-lab-sources \
		sysdev-linux-intro-configuration \
		sysdev-linux-intro-compilation \
		sysdev-linux-intro-cross-compilation \
		sysdev-linux-intro-lab-cross-compilation \
		sysdev-linux-intro-modules \
		sysdev-root-filesystem-title \
		sysdev-root-filesystem-principles \
		initramfs \
		sysdev-root-filesystem-contents \
		sysdev-root-filesystem-device-files \
		sysdev-root-filesystem-virtual-fs \
		sysdev-root-filesystem-minimal \
		boot-sequence-initramfs \
		sysdev-busybox \
		sysdev-block-filesystems \
		sysdev-flash-filesystems \
		sysdev-embedded-linux \
		sysdev-application-development \
		sysdev-realtime \
		sysdev-references \
		last-slides

SLIDE_HELPER+=full-sysdev-slides-help

full-sysdev-slides-help:
	$(HELP) "full-sysdev-slides.pdf"	"Complete slides for the 'sysdev' course"

AGENDAS+=sysdev-agenda-help

sysdev-agenda-help:
	$(HELP) "sysdev-agenda.pdf"		"Agenda for the 'sysdev' course"

TRAINING_HELPER += sysdev-help

sysdev-help:
	$(HELP) "sysdev"			"All printouts for the 'sysdev' course"

sysdev:	 full-sysdev-slides.pdf full-sysdev-labs.pdf

TRAININGS += sysdev
