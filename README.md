# quickhatch-m4

Custom Autoconf macros from Quickhatch

## Macro List

See source code for macro usage instructions.

* [QH_ENABLE_DEBUG](qh-gnulib.m4)
* [QH_ENABLE_WARN_ERROR](qh-gnulib.m4)
* [QH_MANYWARN_ALL_GCC](qh-gnulib.m4)
* [QH_PKG_CHECK_EXISTS](qh-pkg.m4)
* [QH_VAR_ENSURE](quickhatch.m4)

## Installation as Git Submodule

To use these macros in your project, we recommend installing them as a Git
submodule.

* Add the `quickhatch-m4` repository as a submodule of your project.

        `$ git submodule add https://github.com/quickhatch/quickhatch-m4.git .qh-m4`

* Mention `-I .qh-m4` in `ACLOCAL_AMFLAGS` in `Makefile.am`.

`ACLOCAL_AMFLAGS = -I m4 -I .qh-m4 --install`

### Integration with Gnulib


[comment]: # (vim: textwidth=78 autoindent)
