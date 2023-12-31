bin_PROGRAMS = icotool

# win32-endian.c should probably be moved to common
icotool_SOURCES = \
  create.c \
  extract.c \
  icotool.h \
  main.c \
  palette.c \
  win32-endian.c \
  win32-endian.h \
  win32.h

icotool_LDADD = \
  @PNG_LIBS@ \
  ../common/libcommon.a \
  ../compat-lib/src/libgnu.a \
  ../lib/libgnu.a \
  @LIBINTL@

man_MANS = \
  icotool.1

EXTRA_DIST = \
  $(man_MANS)

AM_CPPFLAGS = \
  -I$(top_srcdir)/lib \
  -I$(top_builddir)/compat-lib/src \
  -I$(top_srcdir)/compat-lib/src \
  -I$(top_srcdir)

AM_CFLAGS = $(WARN_CFLAGS) $(WERROR_CFLAGS)
