SERVICE_NAME=artifactory
include ../declarations.mk

install:
	install -Dm644 artifactory.container -t $(DESTDIR)$(QUADLETDIR)
	install -Dm644 artifactory.volume -t $(DESTDIR)$(QUADLETDIR)
	install -Dm644 nginx.srv $(DESTDIR)$(NGINXDIR)/$(SERVICE_NAME).conf
