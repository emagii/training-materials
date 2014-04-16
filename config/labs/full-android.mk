ANDROID_LABS  = setup \
		android-source-code \
		android-first-compilation \
		android-boot \
		android-new-board \
		android-adb \
		android-native-library \
		android-system-customization \
		android-native-app \
		android-jni-library \
		android-application \


ifdef LABS
ifeq ($(LABS),full-android)
LABS_VARSFILE      = ${VENDOR}/labs/android-labs-vars.tex
LABS_CHAPTERS      = $(ANDROID_LABS)
LABS_CONFIGURED	   = yes
endif
endif

LAB_HELPER+=full-android-labs-help

full-android-labs.pdf:	SESSION_URL="${VENDOR_URL}doc/training/android"

full-android-labs-help:
	$(HELP) "full-android-labs.pdf"			"Complete labs for the 'android' course"
