# File Variables
src=install.c
bin=install.out
bindir=.bin
mainobj=install.o


CC=gcc
CFLAGS=

all: libpacinst libmove libcustom libconfig libfileutils libsearep run

libpacinst: modules/headers/libpacinst.h modules/source/libpacinst.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libpacinst.so modules/source/libpacinst.c -lc

libmove: modules/headers/libmove.h modules/source/libmove.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libmove.so modules/source/libmove.c -lc

libcustom: modules/headers/libcustom.h modules/source/libcustom.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libcustom.so modules/source/libcustom.c -lc

libconfig: modules/headers/libconfig.h modules/source/libconfig.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libconfig.so modules/source/libconfig.c -lc

libfileutils: modules/headers/utils/file_utils.h modules/source/libfileutils.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libfileutils.so modules/source/libfileutils.c -lc

libsearep: modules/headers/utils/searep.h modules/source/libsearep.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libsearep.so modules/source/libsearep.c -lc


# Define Targets
run:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -c $(src) -o $(bindir)/$(mainobj)
	gcc -o $(bindir)/$(bin) $(bindir)/$(mainobj) -lmove -lconfig -lcustom -lpacinst -lfileutils -lsearep -L ./modules/lib 
	LD_LIBRARY_PATH="./modules/lib/:$LD_LIBRARY_PATH" ./$(bindir)/$(bin)


compile:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -c $(src) -o $(bindir)/$(mainobj)
	gcc -o $(bindir)/$(bin) $(bindir)/$(mainobj) -lmove -lconfig -lcustom -lpacinst -lfileutils -lsearep -L ./modules/lib 




val:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -o $(bindir)/$(bin) $(src)
	valgrind ./$(bindir)/$(bin)
