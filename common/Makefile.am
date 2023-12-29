noinst_LIBRARIES = libcommon.a

libcommon_a_SOURCES = \
	common.h \
	comparison.h \
	error.c \
	error.h \
	hmap.c \
	hmap.h \
	io-utils.c \
	io-utils.h \
	intutil.c \
	intutil.h \
	llist.c \
	llist.h \
	strbuf.c \
	strbuf.h \
	string-utils.c \
	string-utils.h \
	tmap.c \
	tmap.h

libcommon_la_LIBADD = \
	../compat-lib/src/libgnu.a

AM_CPPFLAGS = \
	-I$(top_builddir)/compat-lib/src \
	-I$(top_srcdir)/compat-lib/src

AM_CFLAGS = $(WARN_CFLAGS) $(WERROR_CFLAGS)
