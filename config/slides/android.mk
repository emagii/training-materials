ANDROID_SLIDES = \
		licensing \
		$(ABOUT_US) \
		$(CREDITS) \
		course-information-title \
		beagleboneblack-board \
		android-course-outline \
		course-information \
		setup-lab \
		android-introduction-title \
		android-introduction-features \
		android-introduction-history \
		android-introduction-architecture \
		android-introduction-lab \
		android-source-title \
		android-source-obtaining \
		android-source-organization \
		android-source-compilation \
		android-source-contribute \
		android-source-lab \
		sysdev-linux-intro-title \
		sysdev-linux-intro-features \
		sysdev-linux-intro-versioning \
		sysdev-linux-intro-configuration \
		sysdev-linux-intro-compilation \
		sysdev-linux-intro-cross-compilation \
		android-kernel-lab-compilation \
		android-kernel-changes-title \
		android-kernel-changes-wakelocks \
		android-kernel-changes-binder \
		android-kernel-changes-klogger \
		android-kernel-changes-ashmem \
		android-kernel-changes-timers \
		android-kernel-changes-lmk \
		android-kernel-changes-ion \
		android-kernel-changes-network \
		android-kernel-changes-misc \
		android-kernel-changes-mainline \
		android-bootloaders-title \
		sysdev-bootloaders-sequence \
		android-bootloaders-fastboot \
		android-new-board-lab \
		android-adb-title \
		android-adb-introduction \
		android-adb-use \
		android-adb-examples \
		android-adb-lab \
		android-fs-title \
		sysdev-root-filesystem-principles \
		initramfs \
		android-fs-contents \
		sysdev-root-filesystem-device-files \
		sysdev-root-filesystem-minimal \
		android-build-system-title \
		android-build-system-basics \
		android-build-system-envsetup \
		android-build-system-configuration \
		android-build-system-modules \
		android-build-system-lab-library \
		android-build-system-product \
		android-build-system-lab-product \
		android-native-layer-title \
		sysdev-toolchains-definition \
		android-native-layer-bionic \
		android-native-layer-toolbox \
		android-native-layer-init \
		android-native-layer-daemons \
		android-native-layer-flingers \
		android-native-layer-stagefright \
		android-native-layer-dalvik \
		android-native-layer-hal \
		android-native-layer-jni \
		android-native-layer-lab-binary \
		android-framework-title \
		android-framework-native-services \
		android-framework-ipc \
		android-framework-java-services \
		android-framework-extend \
		android-framework-lab \
		android-application-title \
		android-application-basics \
		android-application-activities \
		android-application-services \
		android-application-providers \
		android-application-intents \
		android-application-processes \
		android-application-resources \
		android-application-storage \
		android-application-apk \
		android-application-lab \
		android-resources \
		last-slides

SLIDE_HELPER+=full-android-slides-help

full-android-slides-help:
	$(HELP) "full-android-slides.pdf"	"Complete slides for the 'android' course"

AGENDAS+=android-agenda-help

android-agenda-help:
	$(HELP) "android-agenda.pdf"		"Agenda for the 'android' course"

TRAINING_HELPER += android-help

android-help:
	$(HELP) "android"			"All printouts for the 'android' course"

android:	 android-agenda.pdf full-android-slides.pdf full-android-labs.pdf

TRAININGS += android
