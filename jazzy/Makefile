# Variables

# Compiler stuff
CC=gcc
CFLAGS= -Wall -Wno-unused-function -Wno-unused-variable

default: build/main.o build/pacinst.o build/searep.o build/fileutils.o build/backup.o build/config.o build/configutils.o \
		 build/custom.o build/move.o build/pkgutils.o build/menu.o build/customized.o
	${CC} ${CFLAGS} $^ -o build/jazzy

install: default
	cp build/jazzy ${HOME}/.local/bin/jazzy

build/main.o: src/main.c
	${CC} ${CFLAGS} -c $^ -o $@

build/pacinst.o: src/pacinst.c
	${CC} ${CFLAGS} -c $^ -o $@

build/searep.o: src/searep.c
	${CC} ${CFLAGS} -c $^ -o $@

build/fileutils.o: src/fileutils.c
	${CC} ${CFLAGS} -c $^ -o $@

build/backup.o : src/backup.c
	${CC} ${CFLAGS} -c $^ -o $@

build/config.o : src/config.c
	${CC} ${CFLAGS} -c $^ -o $@

build/configutils.o: src/configutils.c
	${CC} ${CFLAGS} -c $^ -o $@

build/custom.o : src/custom.c
	${CC} ${CFLAGS} -c $^ -o $@

build/move.o : src/move.c
	${CC} ${CFLAGS} -c $^ -o $@

build/pkgutils.o : src/pkgutils.c
	${CC} ${CFLAGS} -c $^ -o $@

build/menu.o : src/menu.c
	${CC} ${CFLAGS} -c $^ -o $@

build/customized.o : src/customized.c
	${CC} ${CFLAGS} -c $^ -o $@

