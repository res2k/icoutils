set(SOURCE_ROOT "${CMAKE_CURRENT_LIST_DIR}/../..")

# Copy source dir since we'll do a bootstrap in it
set(ORG_SOURCE_PATH "${SOURCE_ROOT}/compat-lib")
set(SOURCE_PATH "${CURRENT_BUILDTREES_DIR}/src")
file(COPY "${ORG_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}")


if(VCPKG_HOST_IS_WINDOWS)
    vcpkg_acquire_msys(
        MSYS_ROOT
        PACKAGES autoconf2.71 autoconf-wrapper automake1.16 automake-wrapper libtool
            )
    set(SHELL "${MSYS_ROOT}/usr/bin/bash.exe")
    vcpkg_add_to_path("${MSYS_ROOT}/usr/bin")
    #vcpkg_add_to_path("${MSYS_ROOT}/usr/share/automake-1.16")
    # string(APPEND OPTIONS " --pkg-config=${CURRENT_HOST_INSTALLED_DIR}/tools/pkgconf/pkgconf${VCPKG_HOST_EXECUTABLE_SUFFIX}")
else()
    find_program(SHELL bash)
endif()

vcpkg_execute_required_process(
    COMMAND "${SHELL}" ./bootstrap
    WORKING_DIRECTORY "${SOURCE_PATH}"
    LOGNAME "bootstrap-${TARGET_TRIPLET}"
)

vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    USE_WRAPPERS
)

vcpkg_build_make()

# Copy libs
file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/src/libicoutils_compat.a" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/src/libicoutils_compat.a" DESTINATION "${CURRENT_PACKAGES_DIR}/lib" RENAME libicoutils_compat_d.a)

# Handle copyright & files vcpkg likes to have
file(INSTALL ${SOURCE_ROOT}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/icoutils-compat-lib RENAME copyright)

# Create a dummy include to silence vcpkg warning
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/include")
file(TOUCH "${CURRENT_PACKAGES_DIR}/include/.dummy")
