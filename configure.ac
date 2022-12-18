#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_INIT([quickhatch-autotools],
        [m4_esyscmd([build-aux/git-version-gen .tarball-version])],
        [mike@detwiler.io], [],
        [https://github.com/quickhatch/quickhatch-autotools])

AC_PREREQ([2.64])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([build-aux/git-rpm-version-gen])

AM_INIT_AUTOMAKE([-Wall -Wno-portability -Werror foreign])
AM_SILENT_RULES([yes])

AC_CONFIG_FILES([Makefile
                 build-aux/Makefile
                 m4/Makefile
                 ])
AC_OUTPUT
