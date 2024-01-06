Building & Installation using CMake
===================================

Experimental support for build using CMake is available.
While functional, it is not fully equivalent to the autotools-based build
system - the binaries are built with some different flags (compile warnings,
mostly) and only a subset of the files are installed.
However, in conjuntion with `vcpkg`, it can be used to build icotools on
platforms that are only poorly supported by autotools (chiefly, Windows with
MSVC).

Using `vcpkg`
-------------

`vcpkg` can be used to fetch the required libpng dependency. Usage of it is
optional on systems that support a *nix shell (eg Cygwin).

To build with MSVC, using `vcpkg` is _required_, as it's used to support
building parts that have to be built using autotools.

A CMake preset `default` is available which enables building with `vcpkg`.

Building without `vcpkg`
------------------------

It's also possible to build without `vcpkg`. Just configure the sources as
usual, without the required `vcpkg` environment variables.

_Note:_ Requires a working *nix shell.
