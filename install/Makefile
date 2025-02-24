# File Variables
src=install.c
bin=install.out
bindir=.bin
mainobj=install.o


CC=gcc
CFLAGS=

all: libpacinst libmove libcustom libconfig libfileutils libsearep 

libpacinst: headers/libpacinst.h source/libpacinst.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libpacinst.so source/libpacinst.c -lc

libmove: headers/libmove.h source/libmove.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libmove.so source/libmove.c -lc

libcustom: headers/libcustom.h source/libcustom.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libcustom.so source/libcustom.c -lc

libconfig: headers/libconfig.h source/libconfig.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libconfig.so source/libconfig.c -lc

libfileutils: headers/utils/file_utils.h source/libfileutils.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libfileutils.so source/libfileutils.c -lc

libsearep: headers/utils/searep.h source/libsearep.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libsearep.so source/libsearep.c -lc


# Define Targets
run:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -c $(src) -o $(bindir)/$(mainobj)
	gcc -o $(bindir)/$(bin) $(bindir)/$(mainobj) -lmove -lconfig -lcustom -lpacinst -lfileutils -lsearep -L ./modules/lib 
	LD_LIBRARY_PATH="./modules/lib/:$LD_LIBRARY_PATH" ./$(bindir)/$(bin)

val:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -o $(bindir)/$(bin) $(src)
	valgrind ./$(bindir)/$(bin)
