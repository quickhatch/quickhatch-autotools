# Makefile.am

SUBDIRS = build-aux \
	  m4

gvg_version = $(top_srcdir)/.version
pkg_name = $(top_srcdir)/.package-name
pkg_release = $(PACKAGE)-release

ACLOCAL_AMFLAGS = -I m4

BUILT_SOURCES = $(gvg_version) \
		$(pkg_name)

dist_pkgdata_DATA = $(pkg_release)

CLEANFILES = $(gvg_version) \
	     $(pkg_name) \
	     $(pkg_release)

EXTRA_DIST = $(gvg_version) \
	     $(pkg_name) \
	     README.md

$(gvg_version):
	$(AM_V_GEN)echo $(VERSION) > $@-t && mv $@-t $@

$(pkg_name):
	$(AM_V_GEN)echo $(PACKAGE_NAME) > $@-t && mv $@-t $@

$(pkg_release): $(gvg_version)
	$(AM_V_GEN)echo "$(PACKAGE) release $(VERSION)" > $@-t && mv $@-t $@

.PHONY: gen-ChangeLog
gen-ChangeLog:
	$(AM_V_GEN)if test -d .git; then				\
	  $(top_srcdir)/build-aux/gitlog-to-changelog > $(distdir)/cl-t;\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

.PHONY: gen-tarball-version
gen-tarball-version:
	$(AM_V_GEN)echo $(VERSION) > $(distdir)/.tarball-version

dist-hook: gen-ChangeLog gen-tarball-version
