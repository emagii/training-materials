YOCTO_SLIDES = \
		licensing \
		$(ABOUT_US) \
		$(CREDITS)

SLIDE_HELPER+=full-yocto-slides-help

full-yocto-slides-help:
	$(HELP) "full-yocto-slides.pdf"		"Complete slides for the 'yocto' course"

AGENDAS+=yocto-agenda-help

yocto-agenda-help:
	$(HELP) "yocto-agenda.pdf"		"Agenda for the 'yocto' course"

TRAINING_HELPER += yocto-help

yocto-help:
	$(HELP) "yocto"				"All printouts for the 'yocto' course"

yocto:	 yocto-agenda.pdf full-yocto-slides.pdf full-yocto-labs.pdf

TRAININGS += yocto
