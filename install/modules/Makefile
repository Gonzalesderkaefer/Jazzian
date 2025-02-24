CC=gcc
CFLAGS=

all: libpacinst libmove libcustom libconfig

libpacinst: pacinst/libpacinst.h pacinst/libpacinst.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libpacinst.so pacinst/libpacinst.c -lc

libmove: move/libmove.h move/libmove.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libmove.so move/libmove.c -lc

libcustom: custom/libcustom.h custom/libcustom.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libcustom.so custom/libcustom.c -lc

libconfig: config/libconfig.h config/libconfig.c
	$(CC) $(CFLAGS) -fPIC -shared -o lib/libconfig.so config/libconfig.c -lc
