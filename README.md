# quickhatch-autotools

Autoconf macros and auxiliary build tools for use with the [GNU Autotools][4].

## Macros

See source code for usage instructions.

* [QH_ARG_ENABLE][1]
* [QH_ARG_WITH][1]
* [QH_COMPILER_C_VERSION_MAJOR][1]
* [QH_ENABLE_DEBUG][1]
* [QH_ENABLE_WARN_ERROR][1]
* [QH_MANYWARN_ALL_GCC][1]
* [QH_OS_RELEASE][1]
* [QH_PKG_CHECK_EXISTS][1]
* [QH_REQUIRE_PROG][1]
* [QH_RPM_VERSION_RELEASE][1]
* [QH_VAR_ENSURE][1]

## Auxiliary Build Tools

See source code for usage instructions.

* [git-rpm-version-gen][5]

## Installation as Git Submodule

To use these macros in your project, we recommend installing them as a Git
submodule.

### Initial Setup

* Add the `quickhatch-autotools` repository as a submodule of your project.

        $ git submodule add --name quickhatch-autotools \
            https://github.com/quickhatch/quickhatch-autotools.git .quickhatch
        $ git config -f .gitmodules submodule.quickhatch-autotools.shallow true
        $ git submodule set-branch --branch master quickhatch-autotools

* Mention `-I .quickhatch/m4` in `ACLOCAL_AMFLAGS` in `Makefile.am`.

        ACLOCAL_AMFLAGS = -I m4 -I .quickhatch/m4 --install

### Updating

Here are the steps to update the quickhatch-autotools submodule to the latest
upstream version, assuming the initial setup was done as specified above.

        $ git submodule update --recursive --remote .quickhatch
        $ git add .quickhatch
        $ git commit -m 'Updating quickhatch-autotools submodule'

### Integration with Gnulib

If your project uses Gnulib's [bootstrap][2] script, add the following to your
[bootstrap.conf][3] `bootstrap_post_import_hook` function override.

```bash
# non-gnulib submodules
submodules='
  quickhatch-autotools
'

qh_build_aux_files='
  git-rpm-version-gen
'

bootstrap_post_import_hook()
{
  # Update submodules
  for sm in $submodules; do
    sm_path=$(git_modules_config submodule.$sm.path)
    test "x$sm_path" = x && die "Could not determine submodule path for $sm"
    git submodule update --init $sm_path || return 1
  done

  # symlink quickhatch build-aux files
  qh_at_path=$(git_modules_config submodule.quickhatch-autotools.path)
  qh_at_build_aux="$qh_at_path/build-aux"
  for file in $qh_build_aux_files; do
    dest="$build_aux/$file"
    symlink_to_dir $qh_at_build_aux $file $dest
  done
} # bootstrap_post_import_hook
```

[1]: ./m4/quickhatch.m4
[2]: https://github.com/coreutils/gnulib/blob/master/build-aux/bootstrap
[3]: https://github.com/coreutils/gnulib/blob/master/build-aux/bootstrap.conf
[4]: https://www.gnu.org/software/automake/faq/autotools-faq.html
[5]: ./build-aux/git-rpm-version-gen

[comment]: # ( vim: set autoindent syntax=markdown textwidth=78: )
