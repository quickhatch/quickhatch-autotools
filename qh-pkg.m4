# qh-pkg.m4

# QH_PKG_CHECK_EXISTS(MODULE, SYSTEM-PACKAGE)
# ----------------------------------------------------------
# Call PKG_CHECK_EXISTS with MODULE. If MODULE does not
# exist, call AC_MSG_ERROR with a message indicating that
# SYSTEM-PACKAGE could not be found.
#
AC_DEFUN([QH_PKG_CHECK_EXISTS],
[
AC_REQUIRE([PKG_PROG_PKG_CONFIG])
AC_MSG_CHECKING([for pkg-config module $1])
PKG_CHECK_EXISTS([$1],
                 [AC_MSG_RESULT([yes])],
                 [AC_MSG_RESULT([no])
                  AC_MSG_ERROR([Could not find system package $2])])
]) # QH_PKG_CHECK_EXISTS
