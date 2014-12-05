#!/bin/sh
MAINDIR=training-materials
# ====================================
TOPDIR=${PWD}
BUILDDIR=${TOPDIR}/${MAINDIR}
top ()
{
	cd	${TOPDIR}
}

build ()
{
	cd	${BUILDDIR}
}

get ()
{
	sudo apt-get -y install $1
}
# ====================================

prepare_machine ()
{
	get	git-core
	get	inkscape
	get	texlive-latex-base 
	get	texlive-latex-extra
	get	texlive-font-utils
	get	dia python-pygments
	get	texlive-fonts-recommended
	get	python-setuptools
	sudo	easy_install	Pygments
}

get_fe_materials ()
{
	top
	git clone   git://git.free-electrons.com/training-materials.git	fe-training-materials
	git clone   git://git.free-electrons.com/training-scripts.git
}

configure ()
{
	build
	git am ../0001-beagleboneblack-Use-correct-path-to-picture.patch
}

make_presentation ()
{
	echo	"Making $1"
	make	-j 8 $1.pdf
}

build_presentations ()
{
	build
	export VENDOR=eMagii
	make_presentation full-sysdev-labs	 #	Complete labs for the 'sysdev' course
	make_presentation full-kernel-labs       #	Complete labs for the 'kernel' course
	make_presentation full-android-labs      #	Complete labs for the 'android' course
	make_presentation full-sysdev-slides     #	Complete slides for the 'sysdev' course
	make_presentation full-kernel-slides     #	Complete slides for the 'kernel' course
	make_presentation full-android-slides    #	Complete slides for the 'android' course
	make_presentation kernel-agenda          #	Agenda for the 'kernel' course
}

prepare_machine
get_materials
configure
build_presentations

