# Required packages (tested on Ubuntu 12.04):
# inkscape texlive-latex-base texlive-font-utils dia python-pygments

ifeq ($(VENDOR),)
ifeq ($(HOME),/home/ulf)
$(warning "Setting VENDOR to eMagii")
VENDOR=eMagii
else
$(warning "Setting VENDOR to common")
VENDOR=common
endif
endif
# Init some help variables, each slideshow/lab will add to these
HELPER=help-header
AGENDAS=agenda-help
SLIDE_HELPER=slides-help
LAB_HELPER=lab-help
TRAINING_HELPER=training-help
TRAININGS=

HELP_FORMAT=" %-32s%s\n"
HELP=@printf $(HELP_FORMAT)

# Needed tools
INKSCAPE = inkscape
PDFLATEX = pdflatex
DIA      = dia
EPSTOPDF = epstopdf

# Needed macros
UPPERCASE = $(shell echo $1 | tr "[:lower:]" "[:upper:]")

# List of slides for the different courses



# Output directory
OUTDIR   = $(PWD)/out

# Latex variable definitions
VARS = $(OUTDIR)/vars

# Environment for pdflatex, which allows it to find the stylesheet in the
# $(VENDOR)/ directory.
PDFLATEX_ENV = TEXINPUTS=.:$(PWD)/$(VENDOR):

# Arguments passed to pdflatex
PDFLATEX_OPT = -shell-escape -file-line-error -halt-on-error

# The $(VENDOR) slide stylesheet
include	${VENDOR}/vendor.mk

#
# === Picture lookup ===
#

# Function that computes the list of pictures of the extension given
# in $(2) from the directories in $(1), and transforms the filenames
# in .pdf in the output directory. This is used to compute the list of
# .pdf files that need to be generated from .dia or .svg files.
PICTURES_WITH_TRANSFORMATION = \
	$(patsubst %.$(2),$(OUTDIR)/%.pdf,$(foreach s,$(1),$(wildcard $(s)/*.$(2))))

# Function that computes the list of pictures of the extension given
# in $(2) from the directories in $(1). This is used for pictures that
# to not need any transformation, such as bitmap files in the .png or
# .jpg formats.
PICTURES_NO_TRANSFORMATION = \
	$(patsubst %,$(OUTDIR)/%,$(foreach s,$(1),$(wildcard $(s)/*.$(2))))

# Function that computes the list of pictures from the directories in
# $(1) and returns output filenames in the output directory.
PICTURES = \
	$(call PICTURES_WITH_TRANSFORMATION,$(1),svg) \
	$(call PICTURES_WITH_TRANSFORMATION,$(1),dia) \
	$(call PICTURES_NO_TRANSFORMATION,$(1),png)   \
	$(call PICTURES_NO_TRANSFORMATION,$(1),jpg)

# List of $(VENDOR) pictures
COMMON_PICTURES   = $(call PICTURES,$(VENDOR))

default: help

#
# === Compilation of slides ===
#
# List of slides for the different courses
include	config/slides.mk

# This rule allows to build slides of the training. It is done in two
# parts with make calling itself because it is not possible to compute
# a list of prerequisites depending on the target name. See
# http://stackoverflow.com/questions/3381497/dynamic-targets-in-makefiles
# for details.
#
# The value of slide can be "full-kernel", "full-sysdev" (for the
# complete trainings) or the name of an individual chapter.
ifdef SLIDES
$(warning "SLIDES=$(SLIDES)")
# Compute the set of chapters to build depending on the name of the
# PDF file that was requested.
ifeq ($(firstword $(subst -, , $(SLIDES))),full)
SLIDES_TRAINING      = $(lastword $(subst -, , $(SLIDES)))
$(warning "SLIDES_TRAINING=$(SLIDES_TRAINING)")
SLIDES_COMMON_BEFORE = $(VENDOR)/slide-header.tex \
		       $(VENDOR)/slides/$(SLIDES_TRAINING)-title.tex
SLIDES_CHAPTERS      = $($(call UPPERCASE, $(SLIDES_TRAINING))_SLIDES)
SLIDES_COMMON_AFTER  = $(VENDOR)/slide-footer.tex
$(warning "SLIDES_COMMON_BEFORE=$(SLIDES_COMMON_BEFORE)")
$(warning "SLIDES_CHAPTERS=$(SLIDES_CHAPTERS)")
$(warning "SLIDES_COMMON_AFTER=$(SLIDES_COMMON_AFTER)")
else
SLIDES_TRAINING      = $(firstword $(subst -, ,  $(SLIDES)))
# We might be building multiple chapters that share a common
# prefix. In this case, we want to build them in the order they are
# listed in the <training>_SLIDES variable that corresponds to the
# current training, as identified by the first component of the
# chapter name.
SLIDES_CHAPTERS      = $(filter $(SLIDES)%, $($(call UPPERCASE, $(SLIDES_TRAINING))_SLIDES))
ifeq ($(words $(SLIDES_CHAPTERS)),1)
SLIDES_COMMON_BEFORE = $(VENDOR)/slide-header.tex $(VENDOR)/single-subsection-slide-title.tex
else
SLIDES_COMMON_BEFORE = $(VENDOR)/slide-header.tex $(VENDOR)/single-slide-title.tex
endif
SLIDES_COMMON_AFTER  = $(VENDOR)/slide-footer.tex
endif

ifeq ($(SLIDES_CHAPTERS),)
$(error "No chapter to build, maybe you're building a single chapter whose name doesn't start with a training session name")
endif

# Compute the set of corresponding .tex files and pictures
SLIDES_TEX      = \
	$(SLIDES_COMMON_BEFORE) \
	$(foreach s,$(SLIDES_CHAPTERS),$(wildcard slides/$(s)/$(s).tex)) \
	$(SLIDES_COMMON_AFTER)
SLIDES_PICTURES = $(call PICTURES,$(foreach s,$(SLIDES_CHAPTERS),slides/$(s))) $(COMMON_PICTURES)

%-slides.pdf: $(VARS) $(SLIDES_TEX) $(SLIDES_PICTURES) $(STYLESHEET)
	@echo $(SLIDES_CHAPTERS_NUM)
	@mkdir -p $(OUTDIR)
# We generate a .tex file with \input{} directives (instead of just
# concatenating all files) so that when there is an error, we are
# pointed at the right original file and the right line in that file.
	rm -f $(OUTDIR)/$(basename $@).tex
	echo "\input{$(VARS)}" >> $(OUTDIR)/$(basename $@).tex
	for f in $(filter %.tex,$^) ; do \
		echo -n "\input{../"          >> $(OUTDIR)/$(basename $@).tex ; \
		echo -n $$f | sed 's%\.tex%%' >> $(OUTDIR)/$(basename $@).tex ; \
		echo "}"                      >> $(OUTDIR)/$(basename $@).tex ; \
	done
	(cd $(OUTDIR); $(PDFLATEX_ENV) $(PDFLATEX) $(PDFLATEX_OPT) $(basename $@).tex)
# The second call to pdflatex is to be sure that we have a correct table of
# content and index
	(cd $(OUTDIR); $(PDFLATEX_ENV) $(PDFLATEX) $(PDFLATEX_OPT) $(basename $@).tex > /dev/null 2>&1)
# We use cat to overwrite the final destination file instead of mv, so
# that evince notices that the file has changed and automatically
# reloads it (which doesn't happen if we use mv here). This is called
# 'Maxime's feature'.
	cat out/$@ > $@
else
FORCE:
%-slides.pdf: FORCE
	@echo	"make SLIDES=$@"
	@$(MAKE) $@ SLIDES=$*
endif

include	config/labs.mk

ifeq (a,b)
#
# === Compilation of labs ===
#

ifdef LABS
LABS_HEADER        = $(VENDOR)/labs-header.tex
LABS_FOOTER        = $(VENDOR)/labs-footer.tex
# Compute the set of chapters to build depending on the name of the
# PDF file that was requested.
ifeq ($(LABS),full-kernel)
LABS_VARSFILE      = $(VENDOR)/kernel-labs-vars.tex
LABS_CHAPTERS      = $(KERNEL_LABS)
else ifeq ($(LABS),full-sysdev)
LABS_VARSFILE      = $(VENDOR)/sysdev-labs-vars.tex
LABS_CHAPTERS      = $(SYSDEV_LABS)
else ifeq ($(LABS),full-android)
LABS_VARSFILE      = $(VENDOR)/android-labs-vars.tex
LABS_CHAPTERS      = $(ANDROID_LABS)
else ifeq ($(LABS),full-boottime)
LABS_VARSFILE      = $(VENDOR)/boottime-labs-vars.tex
LABS_CHAPTERS      = $(BOOTTIME_LABS)
else
LABS_VARSFILE      = $(VENDOR)/single-lab-vars.tex
LABS_CHAPTERS      = $(LABS)
LABS_HEADER        = $(VENDOR)/single-lab-header.tex
LABS_FOOTER        = $(VENDOR)/labs-footer.tex
endif

# Compute the set of corresponding .tex files and pictures
LABS_TEX      = \
	$(LABS_VARSFILE) \
	$(LABS_HEADER) \
	$(foreach s,$(LABS_CHAPTERS),$(wildcard labs/$(s)/$(s).tex)) \
	$(LABS_FOOTER)
LABS_PICTURES = $(call PICTURES,$(foreach s,$(LABS_CHAPTERS),labs/$(s))) $(COMMON_PICTURES)

%-labs.pdf: $(VENDOR)/labs.sty $(VARS) $(LABS_TEX) $(LABS_PICTURES)
	@mkdir -p $(OUTDIR)
# We generate a .tex file with \input{} directives (instead of just
# concatenating all files) so that when there is an error, we are
# pointed at the right original file and the right line in that file.
	rm -f $(OUTDIR)/$(basename $@).tex
	echo "\input{$(VARS)}" >> $(OUTDIR)/$(basename $@).tex
	for f in $(filter %.tex,$^) ; do \
		echo -n "\input{../"          >> $(OUTDIR)/$(basename $@).tex ; \
		echo -n $$f | sed 's%\.tex%%' >> $(OUTDIR)/$(basename $@).tex ; \
		echo "}"                      >> $(OUTDIR)/$(basename $@).tex ; \
	done
	(cd $(OUTDIR); $(PDFLATEX_ENV) $(PDFLATEX) $(basename $@).tex)
# The second call to pdflatex is to be sure that we have a correct table of
# content and index
	(cd $(OUTDIR); $(PDFLATEX_ENV) $(PDFLATEX) $(basename $@).tex > /dev/null 2>&1)
# We use cat to overwrite the final destination file instead of mv, so
# that evince notices that the file has changed and automatically
# reloads it (which doesn't happen if we use mv here). This is called
# 'Maxime's feature'.
	cat out/$@ > $@
else
FORCE:
%-labs.pdf: FORCE
	@$(MAKE) $@ LABS=$*
endif

endif	#customization
# ------------------------------------------------------------------------------------

#
# === Compilation of agendas ===
#
ifdef AGENDA
AGENDA_TEX = agenda/$(AGENDA)-agenda.tex
AGENDA_PICTURES = $(COMMON_PICTURES) $(call PICTURES,agenda)

%-agenda.pdf: $(VENDOR)/agenda.sty $(AGENDA_TEX) $(AGENDA_PICTURES)
	rm -f $(OUTDIR)/$(basename $@).tex
	cp $(filter %.tex,$^) $(OUTDIR)/$(basename $@).tex
	(cd $(OUTDIR); $(PDFLATEX_ENV) $(PDFLATEX) $(basename $@).tex)
	cat $(OUTDIR)/$@ > $@
else
FORCE:
%-agenda.pdf: FORCE
	@$(MAKE) $@ AGENDA=$*
endif

#
# === Picture generation ===
#

.PRECIOUS: $(OUTDIR)/%.pdf

$(OUTDIR)/%.pdf: %.svg
	@printf "%-15s%-20s->%20s\n" INKSCAPE $(notdir $^) $(notdir $@)
	@mkdir -p $(dir $@)
ifeq ($(V),)
	$(INKSCAPE) -D -A $@ $< > /dev/null 2>&1
else
	$(INKSCAPE) -D -A $@ $<
endif

$(OUTDIR)/%.pdf: $(OUTDIR)/%.eps
	@printf "%-15s%-20s->%20s\n" EPSTOPDF $(notdir $^) $(notdir $@)
	@mkdir -p $(dir $@)
	$(EPSTOPDF) --outfile=$@ $^

.PRECIOUS: $(OUTDIR)/%.eps

$(OUTDIR)/%.eps: %.dia
	@printf "%-15s%-20s->%20s\n" DIA $(notdir $^) $(notdir $@)
	@mkdir -p $(dir $@)
	$(DIA) -e $@ -t eps $^

.PRECIOUS: $(OUTDIR)/%.png

$(OUTDIR)/%.png: %.png
	@mkdir -p $(dir $@)
	@cp $^ $@

.PRECIOUS: $(OUTDIR)/%.jpg

$(OUTDIR)/%.jpg: %.jpg
	mkdir -p $(dir $@)
	@cp $^ $@

#
# === Misc targets ===
#

$(VARS): FORCE
	@mkdir -p $(dir $@)
	/bin/echo "\def \sessionurl {$(SESSION_URL)}" > $@
	/bin/echo "\def \training {$(SLIDES_TRAINING)}" >> $@


# All training material
trainings:	$(TRAININGS)

clean:
	$(RM) -rf $(OUTDIR) *.pdf



help-header:
	printf "\033c"
	@echo 
	@echo "============================================================================"
	@echo "Available targets:"
	@echo
	$(HELP)	"trainings"	"All training material"


#	@echo " full-sysdev-labs.pdf            Complete labs for the 'sysdev' course"
#	@echo " full-kernel-labs.pdf            Complete labs for the 'kernel' course"
#	@echo " full-android-labs.pdf           Complete labs for the 'android' course"
#	@echo " full-boottime-labs.pdf          Complete labs for the 'boottime' course"
#	@echo " full-sysdev-slides.pdf          Complete slides for the 'sysdev' course"
#	@echo " full-kernel-slides.pdf          Complete slides for the 'kernel' course"
#	@echo " full-android-slides.pdf         Complete slides for the 'android' course"
#	@echo " full-boottime-slides.pdf        Complete slides for the 'boottime' course"
#	@echo " kernel-agenda.pdf               Agenda for the 'kernel' course"
#	@echo " boottime-agenda.pdf             Agenda for the 'boottime' course"

training-help:
	@echo
	@echo "----------------------------------------------------------------------------"
	@echo "TRAININGS:"
	@echo

agenda-help:
	@echo
	@echo "----------------------------------------------------------------------------"
	@echo "AGENDAS:"
	@echo

lab-help:
	@echo
	@echo "----------------------------------------------------------------------------"
	@echo "LABS:"
	@echo

slides-help:
	@echo
	@echo "----------------------------------------------------------------------------"
	@echo "SLIDES:"
	@echo

slides-trailer:
	@echo
	$(HELP) "<some-chapter>-slides.pdf"		"Slides for a particular chapter in slides/"
	@echo

lab-trailer:
	@echo
	$(HELP) "<some-chapter>-labs.pdf"		"Labs for a particular chapter in labs/"
	@echo

help-trailer:
	@echo "============================================================================"
	@echo


help:	$(HELPER) $(TRAINING_HELPER) $(AGENDAS) $(SLIDE_HELPER) slides-trailer $(LAB_HELPER) lab-trailer help-trailer

debug:
	@echo $(HELPER) $(TRAINING_HELPER) $(AGENDAS) $(SLIDE_HELPER) slides-trailer $(LAB_HELPER) lab-trailer help-trailer
