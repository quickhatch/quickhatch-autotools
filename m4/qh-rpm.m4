# qh-rpm.m4

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
