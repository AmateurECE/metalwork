# Setup for build directory
BUILD_DIR = build
B := $(shell pwd)/$(BUILD_DIR)
$(shell mkdir -p $(B))

SUBDIRS += artifactory

all: build-subdirs

.PHONY: force
BUILD_TARGETS += force
include declarations.mk

install: install-subdirs

clean: clean-subdirs
	rm -rf $(B)
	rm -rf debian/.debhelper
	rm -f debian/debhelper-build-stamp
	rm -f debian/files
	rm -rf debian/tmp
	rm -f debian/*.substvars
	$(foreach subdir,$(SUBDIRS),rm -rf debian/twardyece-$(subdir))

#------------------------------------------------------------------------------
# Packaging
#------------------------------------------------------------------------------
package:
	dpkg-buildpackage --no-sign -A -d

reinstall:
	dpkg -i ../$(PACKAGE)*.deb
