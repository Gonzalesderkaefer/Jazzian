# Variables

# Compiler stuff
CC=gcc
CFLAGS= -Wall -Wno-unused-function -Wno-unused-variable

default: build/main.o build/libpacinst.o build/libsearep.o build/libfileutils.o build/libbackup.o build/libconfig.o build/libconfigutils.o \
		 build/libcustom.o build/libmove.o build/libpkgutils.o build/libmenu.o
	${CC} ${CFLAGS} $^ -o build/jazzy

install: default
	cp build/jazzy ${HOME}/.local/bin/jazzy

build/main.o: src/main.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libpacinst.o: src/libpacinst.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libsearep.o: src/libsearep.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libfileutils.o: src/libfileutils.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libbackup.o : src/libbackup.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libconfig.o : src/libconfig.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libconfigutils.o: src/libconfigutils.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libcustom.o : src/libcustom.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libmove.o : src/libmove.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libpkgutils.o : src/libpkgutils.c
	${CC} ${CFLAGS} -c $^ -o $@

build/libmenu.o : src/libmenu.c
	${CC} ${CFLAGS} -c $^ -o $@

