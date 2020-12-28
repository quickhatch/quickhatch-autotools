# quickhatch.m4

# QH_ARG_ENABLE(PARAMETER, DEFAULT_VALUE)
# ----------------------------------------------------------
# Wrapper around AC_ARG_ENABLE
# e.g.: QH_ARG_ENABLE([foo], [no])
# will generate a configure option --enable-foo. The option's argument will be
# stored in enable_foo. The default value for the option will be no.
AC_DEFUN([QH_ARG_ENABLE],
[
AC_ARG_ENABLE([m4_translit([$1], [_], [-])],
              [AS_HELP_STRING([--enable-m4_translit([$1], [_], [-])],
                              [enable $1 (default=$2)])],
              [enable_[]$1=$enableval],
              [enable_[]$1=$2])
]) # QH_ARG_ENABLE

# QH_ARG_WITH(PARAMETER, DEFAULT_VALUE)
# ----------------------------------------------------------
# Wrapper around AC_ARG_WITH
# e.g.: QH_ARG_WITH([foo], [bar])
# will generate a configure option --with-foo. The option's argument will be
# stored in with_foo. The default value for the option will be bar.
AC_DEFUN([QH_ARG_WITH],
[
AC_ARG_WITH([m4_translit([$1], [_], [-])],
            [AS_HELP_STRING([--with-m4_translit([$1], [_], [-])],
                            [with $1 (default=$2)])],
            [with_[]$1=$withval],
            [with_[]$1=$2])
]) # QH_ARG_WITH

# QH_ENABLE_DEBUG(VARIABLE, [DEFINE_SYMBOL])
# ------------------------------------------
# Add configure option (--enable-debug). If enabled, add compiler flags
# -g and -O0 to VARIABLE. If DEFINE_SYMBOL is given, call
# AC_DEFINE([DEFINE_SYMBOL], [1], [enable debug]).
#
AC_DEFUN([QH_ENABLE_DEBUG],
[
AC_ARG_ENABLE([debug],
              [AS_HELP_STRING([--enable-debug],
                              [enable debug (default=no)])],
              [qh_enable_debug=$enableval],
              [qh_enable_debug=no])
AS_IF([test "x$qh_enable_debug" = xyes],
      [gl_WARN_ADD([-g], [$1])
       gl_WARN_ADD([-O0], [$1])
       m4_ifval([$2], [AC_DEFINE([$2], [1], [enable debug])])])
]) # QH_ENABLE_DEBUG

# QH_ENABLE_WARN_ERROR([VARIABLE = WARN_CFLAGS/WARN_CXXFLAGS])
# ------------------------------------------------------------
# Add configure option (--enable-warn-error) to make the compiler treat
# warnings as errors. If enabled, add -Werror to VARIABLE which defaults to
# WARN_CFLAGS/WARN_CXXFLAGS.
#
AC_DEFUN([QH_ENABLE_WARN_ERROR],
[
AC_ARG_ENABLE([warn-error],
              [AS_HELP_STRING([--enable-warn-error],
                              [treat compiler warnings as errors (default=no)])],
              [qh_enable_warn_error=$enableval],
              [qh_enable_warn_error=no])
AS_IF([test "x$qh_enable_warn_error" = xyes],
      [gl_WARN_ADD([-Werror], [$1])])
]) # QH_ENABLE_WARN_ERROR

# QH_MANYWARN_ALL_GCC([VARIABLE = WARN_CFLAGS/WARN_CXXFLAGS],
#                     [NOWARN_VARIABLE = QH_NOWARN])
# -----------------------------------------------------------
# Add all documented GCC warning parameters to variable VARIABLE
# which defaults to WARN_CFLAGS/WARN_CXXFLAGS. Exclude warnings
# contained in NOWARN_VARIABLE which defaults to QH_NOWARN.
#
AC_DEFUN([QH_MANYWARN_ALL_GCC],
[
gl_MANYWARN_ALL_GCC([qh_all_warnings])
gl_MANYWARN_COMPLEMENT([qh_warnings],
                       [$qh_all_warnings],
                       [m4_if([$2], [], [$QH_NOWARN], [$$2])])
for qh_warn in $qh_warnings; do
  gl_WARN_ADD([$qh_warn], [$1])
done
]) # QH_MANYWARN_ALL_GCC

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

# QH_RPM_VERSION_RELEASE('VERSION RELEASE',
#                        [VERSION_VARIABLE = QH_RPM_VERSION],
#                        [RELEASE_VARIABLE = QH_RPM_RELEASE])
# ----------------------------------------------------------
# Set variables containing RPM Version and Release tags.
AC_DEFUN([QH_RPM_VERSION_RELEASE],
[
m4_define([qh_vr], m4_split($1))
AC_SUBST(m4_if([$2], [], [QH_RPM_VERSION], [$$2]), [m4_argn([1], qh_vr)])
AC_SUBST(m4_if([$3], [], [QH_RPM_RELEASE], [$$3]), [m4_argn([2], qh_vr)])
]) # QH_RPM_VERSION_RELEASE

# QH_VAR_ENSURE(VARIABLE, DESCRIPTION, VALUE-IF-NOT-SET)
# ----------------------------------------------------------
# Ensure the literal shell VARIABLE is set, and make it
# precious by passing to AC_ARG_VAR along with DESCRIPTION.
# If not set, set the contents to the shell expansion of
# VALUE-IF-NOT-SET.
AC_DEFUN([QH_VAR_ENSURE],
[
AC_ARG_VAR([$1],[$2])
AC_MSG_CHECKING([if $1 is set])
AS_VAR_SET_IF([$1],
              [AC_MSG_RESULT([$$1])],
              [AC_MSG_RESULT([no])
               AS_ECHO_N(['setting $1 to default value... '])
               AS_VAR_SET([$1],[$3])
               AS_IF([test "x$$1" = x],
                     [AC_MSG_RESULT([empty])
                      AC_MSG_WARN([$1 set to empty value!])],
                     [AC_MSG_RESULT([$$1])])])
]) # QH_VAR_ENSURE

# QH_REQUIRE_PROG(VARIABLE, PROG-TO-CHECK, DESCRIPTION)
# ----------------------------------------------------------
# Ensure program PROG-TO-CHECK exists in PATH. Set VARIABLE to absolute path
# of PROG-TO-CHECK, and make it precious by passing to AC_ARG_VAR along with
# DESCRIPTION.
AC_DEFUN([QH_REQUIRE_PROG],
[
AC_ARG_VAR([$1],[$3])
AC_PATH_PROG([$1],[$2])
AS_IF([test "x$$1" = x], [AC_MSG_ERROR([failed to find program: $2])])
]) # QH_REQUIRE_PROG
