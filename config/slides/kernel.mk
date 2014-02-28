KERNEL_SLIDES = \
		licensing \
		$(ABOUT_US) \
		$(CREDITS) \
		course-information-title \
		beagleboneblack-board \
		kernel-shopping-list \
		course-information \
		setup-lab \
		kernel-introduction-title \
		sysdev-linux-intro-features \
		kernel-embedded-linux-usage-title \
		kernel-linux-intro-sources \
		kernel-source-code-download-lab \
		kernel-source-code-title \
		kernel-source-code-drivers \
		kernel-source-code-layout \
		kernel-source-code-management \
		kernel-source-code-exploring-lab \
		sysdev-linux-intro-configuration \
		sysdev-linux-intro-compilation \
		sysdev-linux-intro-cross-compilation \
		kernel-board-setup-kernel-compiling-and-booting-labs \
		sysdev-linux-intro-modules \
		kernel-driver-development-modules \
		kernel-driver-development-lab-modules \
		kernel-driver-development-general-apis \
		kernel-device-model \
		kernel-i2c \
		kernel-pinmuxing \
		kernel-frameworks \
		kernel-input \
		kernel-driver-development-memory \
		kernel-driver-development-io-memory \
		kernel-driver-development-lab-io-memory \
		kernel-misc-subsystem \
		kernel-driver-development-processes \
		kernel-driver-development-sleeping \
		kernel-driver-development-interrupts \
		kernel-driver-development-lab-interrupts \
		kernel-driver-development-concurrency \
		kernel-driver-development-lab-locking \
		kernel-driver-development-debugging \
		kernel-driver-development-lab-debugging \
		kernel-porting-title \
		kernel-porting-content \
		kernel-power-management-title \
		kernel-power-management-content \
		kernel-development-process-title \
		sysdev-linux-intro-versioning \
		kernel-contribution \
		kernel-resources-title \
		kernel-resources-references \
		last-slides \
		kernel-backup-slides-title \
		kernel-driver-development-dma \
		kernel-driver-development-mmap \
		kernel-git-title \
		kernel-git-content \
		kernel-git-lab 

SLIDE_HELPER+=full-kernel-slides-help

full-kernel-slides-help:
	$(HELP) "full-kernel-slides.pdf"	"Complete slides for the 'kernel' course"

AGENDAS+=kernel-agenda-help

kernel-agenda-help:
	$(HELP) "kernel-agenda.pdf"		"Agenda for the 'kernel' course"

TRAINING_HELPER += kernel-help

kernel-help:
	$(HELP) "kernel"			"All printouts for the 'kernel' course"

kernel:	 kernel-agenda.pdf full-kernel-slides.pdf full-kernel-labs.pdf

TRAININGS += kernel
