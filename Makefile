SHELL = /bin/bash

PKGNAME = fusekibundle
VERSION = 3.9.0

apache-jena-$(VERSION):
	echo "Download from https://jena.apache.org/download/index.cgi"

packaging/rpm/fusekibundle.spec: apache-jena-$(VERSION)
	python rpmutil.py apache-jena-$(VERSION) > $@

rpm: packaging/rpm/fusekibundle.spec
	mkdir -p $(HOME)/rpmbuild/{BUILD,SOURCES,SPECS,RPMS}
	cp ./packaging/rpm/$(PKGNAME).spec $(HOME)/rpmbuild/SPECS
	cp -r apache-jena-$(VERSION) $(HOME)/rpmbuild/BUILD
	./packaging/rpm/buildrpm.sh $(PKGNAME)
	cp $(HOME)/rpmbuild/RPMS/x86_64/$(PKGNAME)*.rpm .

clean:
	rm -f packaging/rpm/fusekibundle.spec