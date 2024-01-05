cmake_minimum_required(VERSION 3.26)
project(icoutils)

include(CheckIncludeFile)

set(PACKAGE_NAME "icoutils")
set(PACKAGE_BUGREPORT "https://github.com/res2k/icoutils/issues")
set(PACKAGE_URL "https://www.nongnu.org/icoutils/")

# Find vcpkg'd icoutils_compat
find_library(ICOUTILS_COMPAT_LIB_REL NAMES libicoutils_compat REQUIRED)
find_library(ICOUTILS_COMPAT_LIB_DBG NAMES libicoutils_compat_d REQUIRED)
find_path(ICOUTILS_COMPAT_INCLUDE NAMES compat-lib/src/config.h)
add_library(icoutils_compat INTERFACE)
target_link_libraries(icoutils_compat INTERFACE "$<IF:$<CONFIG:Debug>,${ICOUTILS_COMPAT_LIB_DBG},${ICOUTILS_COMPAT_LIB_REL}>")
target_include_directories(icoutils_compat INTERFACE compat-lib/src "${ICOUTILS_COMPAT_INCLUDE}/compat-lib/src" "${ICOUTILS_COMPAT_INCLUDE}")
# TODO: Instead of "requiring" it, pull in as an external project -
# should work if a *nix shell is available (incl Cygwin & MSYS)

# Find libpng
find_package(PNG REQUIRED)
set(CMAKE_REQUIRED_LIBRARIES PNG::PNG)
CHECK_INCLUDE_FILE("png.h" HAVE_PNG_H)
CHECK_INCLUDE_FILE("libpng/png.h" HAVE_LIBPNG_PNG_H)
CHECK_INCLUDE_FILE("libpng10/png.h" HAVE_LIBPNG10_PNG_H)
CHECK_INCLUDE_FILE("libpng12/png.h" HAVE_LIBPNG12_PNG_H)

# Fashion a config.h
configure_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.h.in" config.h)
add_compile_definitions(HAVE_CONFIG_H)

add_library(gnulib STATIC)
target_sources(gnulib PRIVATE
    lib/version-etc.c
)
target_include_directories(gnulib PUBLIC "${CMAKE_CURRENT_BINARY_DIR}" lib)
target_link_libraries(gnulib PUBLIC icoutils_compat)

add_library(common STATIC)
target_sources(common PRIVATE
    common/error.c
    common/hmap.c
    common/intutil.c
    common/io-utils.c
    common/llist.c
    common/strbuf.c
    common/string-utils.c
    common/tmap.c
)
target_include_directories(common PUBLIC "${CMAKE_CURRENT_BINARY_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(common PUBLIC icoutils_compat)

add_executable(icotool)
target_sources(icotool PRIVATE
    icotool/create.c
    icotool/extract.c
    icotool/main.c
    icotool/palette.c
    icotool/win32-endian.c
)
target_include_directories(icotool PUBLIC "${CMAKE_CURRENT_BINARY_DIR}")
target_link_libraries(icotool PUBLIC common icoutils_compat gnulib PNG::PNG)

add_executable(wrestool)
target_sources(wrestool PRIVATE
    wrestool/extract.c
    wrestool/fileread.c
    wrestool/main.c
    wrestool/restable.c
)
target_include_directories(wrestool PUBLIC "${CMAKE_CURRENT_BINARY_DIR}" icotool)
target_link_libraries(wrestool PUBLIC common icoutils_compat gnulib)
