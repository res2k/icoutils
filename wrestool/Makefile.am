bin_PROGRAMS = wrestool

# win32-endian.c should probably be moved to common
wrestool_SOURCES = \
  extract.c \
  main.c \
  restable.c \
  wrestool.h \
  fileread.c \
  fileread.h \
  ../icotool/win32-endian.c

wrestool_LDADD = \
  ../common/libcommon.a \
  ../compat-lib/src/libgnu.a \
  @LIBINTL@

man_MANS = \
  wrestool.1

EXTRA_DIST = \
  $(man_MANS)

AM_CPPFLAGS = \
  -I$(top_builddir)/compat-lib/src \
  -I$(top_srcdir)/compat-lib/src \
  -I$(top_srcdir) \
  -I$(srcdir)/../icotool

AM_CFLAGS = $(WARN_CFLAGS) $(WERROR_CFLAGS)
