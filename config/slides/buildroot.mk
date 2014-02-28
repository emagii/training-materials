BUILDROOT_SLIDES = \
		licensing \
		$(ABOUT_US) \
		$(CREDITS)

SLIDE_HELPER+=full-buildroot-slides-help

full-buildroot-slides-help:
	$(HELP)	"full-buildroot-slides.pdf"	"Complete slides for the 'buildroot' course"

AGENDAS+=buildroot-agenda-help

buildroot-agenda-help:
	$(HELP) "buildroot-agenda.pdf"		"Agenda for the 'buildroot' course"

TRAINING_HELPER += buildroot-help

buildroot-help:
	$(HELP) "buildroot"			"All printouts for the 'buildroot' course"

buildroot:	 buildroot-agenda.pdf full-buildroot-slides.pdf full-buildroot-labs.pdf

TRAININGS += buildroot
