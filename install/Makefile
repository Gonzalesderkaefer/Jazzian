# File Variables
src=main.c
bin=main.out
bindir=.bin
mainobj=main.o


CC=gcc
CFLAGS=

all: bundle

libs: libpacinst libmove libcustom libconfig libfileutils libsearep libconfigutils libpkgutils run

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

libconfigutils: modules/headers/utils/config_utils.h modules/source/libconfigutils.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libconfigutils.so modules/source/libconfigutils.c -lc

libpkgutils: modules/headers/utils/pkgutils.h modules/source/libpkgutils.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libpkgutils.so modules/source/libpkgutils.c -lc

libbackup: modules/headers/utils/pkgutils.h modules/source/libbackup.c
	$(CC) $(CFLAGS) -fPIC -shared -o modules/lib/libbackup.so modules/source/libbackup.c -lc

# Define Targets
run:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -c $(src) -o $(bindir)/$(mainobj)
	gcc -o $(bindir)/$(bin) $(bindir)/$(mainobj) -lmove -lconfig -lcustom -lpacinst -lfileutils \
		-lsearep -lconfigutils -lpkgutils -lbackup -L ./modules/lib 
	LD_LIBRARY_PATH="./modules/lib/:$LD_LIBRARY_PATH" ./$(bindir)/$(bin)


compile:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -c $(src) -o $(bindir)/$(mainobj)
	gcc -o $(bindir)/$(bin) $(bindir)/$(mainobj) -lmove -lconfig -lcustom -lpacinst -lfileutils -lsearep -L ./modules/lib 

bundle:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -g -o ./jazzy $(src) ./modules/source/libmove.c ./modules/source/libconfig.c \
		./modules/source/libcustom.c ./modules/source/libsearep.c ./modules/source/libpacinst.c \
		./modules/source/libpkgutils.c ./modules/source/libfileutils.c ./modules/source/libconfigutils.c \
		./modules/source/libbackup.c

clean:
	rm jazzy;


val:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -o $(bindir)/$(bin) $(src)
	valgrind ./$(bindir)/$(bin)
