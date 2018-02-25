# qh-gnulib.m4

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
