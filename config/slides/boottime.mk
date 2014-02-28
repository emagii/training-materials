BOOTTIME_SLIDES = \
		licensing \
		thanks-atmel \
		about-us \
		course-information-title \
		sama5d3-board \
		boottime-course-outline \
		boottime-principles \
		boottime-measuring \
		boottime-filesystems \
		boottime-init-scripts \
		boottime-c-libraries-title \
		c-libraries \
		boottime-init-scripts2 \
		initramfs \
		boot-sequence-initramfs \
		boottime-init-scripts3 \
		boottime-application \
		boottime-kernel \
		boottime-bootloader \
		boottime-hardware-init \
		boottime-alternatives \

SLIDE_HELPER+=full-boottime-slides-help

full-boottime-slides-help:
	$(HELP) "full-boottime-slides.pdf"	"Complete slides for the 'boottime' course"

AGENDAS+=boottime-agenda-help

boottime-agenda-help:
	$(HELP) "boottime-agenda.pdf"		"Agenda for the 'boottime' course"

TRAINING_HELPER += boottime-help

boottime-help:
	$(HELP) "boottime"			"All printouts for the 'boottime' course"

boottime:	 boottime-agenda.pdf full-boottime-slides.pdf full-boottime-labs.pdf

TRAININGS += boottime
