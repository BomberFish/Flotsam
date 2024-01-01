ARCHS = armv7 arm64 arm64e
TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

EXTERNAL_FILES = $(wildcard fishhook/*.c)
INTERNAL_FILES = $(wildcard *.m)

LIBRARY_NAME = flotsam

$(LIBRARY_NAME)_FILES = $(INTERNAL_FILES) $(EXTERNAL_FILES)
$(LIBRARY_NAME)_INSTALL_PATH = /Library/Frameworks
$(LIBRARY_NAME)_CFLAGS = -fobjc-arc
$(LIBRARY_NAME)_INSTALL_PATH = @rpath/Frameworks
$(LIBRARY_NAME)_FRAMEWORKS = Foundation
$(LIBRARY_NAME)_CODESIGN_FLAGS = -Srequired_entitlements.plist


include $(THEOS_MAKE_PATH)/library.mk
