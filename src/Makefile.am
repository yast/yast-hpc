yncludedir = @yncludedir@/hpc

module_DATA =		\
	HPCMessages.ycp \
	HPCControl.ycp

client_DATA =       \
	hpc.ycp         \
	HPCMain.ycp

EXTRA_DIST = $(client_DATA) $(module_DATA)

include $(top_srcdir)/Makefile.am.common

SUBDIRS = dialog config
