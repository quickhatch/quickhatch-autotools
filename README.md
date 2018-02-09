# quickhatch-m4

Custom Autoconf macros from Quickhatch

## Macro List

See source code for macro usage instructions.

* [QH_ENABLE_DEBUG][1]
* [QH_ENABLE_WARN_ERROR][1]
* [QH_MANYWARN_ALL_GCC][1]
* [QH_PKG_CHECK_EXISTS][2]
* [QH_VAR_ENSURE][3]

## Installation as Git Submodule

To use these macros in your project, we recommend installing them as a Git
submodule.

* Add the `quickhatch-m4` repository as a submodule of your project.

        $ git submodule add https://github.com/quickhatch/quickhatch-m4.git .qh-m4

* Mention `-I .qh-m4` in `ACLOCAL_AMFLAGS` in `Makefile.am`.

        ACLOCAL_AMFLAGS = -I m4 -I .qh-m4 --install

### Integration with Gnulib

If your project uses Gnlib's [bootstrap][4] script, add the following to your
[bootstrap.conf][5] `bootstrap_post_import_hook` function override.

```bash
# non-gnulib submodules
submodules='
  quickhatch-m4
'

bootstrap_post_import_hook()
{
  # Automake requires that ChangeLog exist.
  touch ChangeLog || return 1

  # Update submodules
  for sm in $submodules; do
    sm_path=$(git_modules_config submodule.$sm.path)
    test "x$sm_path" = x && die "Could not determine submodule path for $sm"
    git submodule update --init $sm_path || return 1
  done
} # bootstrap_post_import_hook
```

[1]: ./qh-gnulib.m4
[2]: ./qh-pkg.m4
[3]: ./quickhatch.m4
[4]: https://github.com/coreutils/gnulib/blob/master/build-aux/bootstrap
[5]: https://github.com/coreutils/gnulib/blob/master/build-aux/bootstrap.conf

[comment]: # ( vim: set autoindent syntax=markdown textwidth=78: )
