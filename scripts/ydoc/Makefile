
TEXMF=~/texmf

SUBDIR=${TEXMF}/tex/latex/ydoc
SUBDIR+=${TEXMF}/source/latex/ydoc
SUBDIR+=${TEXMF}/doc/latex/ydoc
SUBDIR+=${TEXMF}/tex/generic/ydoc

all:	$(SUBDIR)

$(TEXMF):
	mkdir	-p	$@

files:
	mkdir -p files

files/ydoc.log:	files	ydoc.dtx
	(cd files; cp ../ydoc.dtx . ; tex ydoc.dtx
)

${TEXMF}/tex/latex/ydoc:	files/ydoc.log
	mkdir	-p	$@
	(cd files; cp ydoc.sty ydoc.cls ydoc-code.sty ydoc-desc.sty ydoc-doc.sty ydoc-expl.sty ydoc.cfg $@)

${TEXMF}/source/latex/ydoc:	files/ydoc.log
	mkdir	-p	$@
	cp ydoc.dtx files/ydoc.ins $@

${TEXMF}/doc/latex/ydoc:	files/ydoc.log
	mkdir	-p	$@
	cp ydoc.pdf README $@

${TEXMF}/tex/generic/ydoc:	files/ydoc.log
	mkdir	-p	$@
	(cd files; cp ydocincl.tex ydocstrip.tex $@)

clean:
	rm	-fr files
	rm	-fr $(SUBDIR)




