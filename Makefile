CFLAGS=-g
LDFLAGS=-Lsqeme -lsqeme-gambit

all: hello webkit

hello: hello.scm sqeme/libsqeme-gambit.so sqeme/sqeme-gambit.c
	gsc -debug -link -l sqeme/sqeme-gambit $<
	gcc $(CFLAGS) $(LDFLAGS) $@.c $@_.c -o $@

webkit: webkit.scm sqeme/libsqeme-gambit.so sqeme/sqeme-gambit.c
	gsc -debug -link -l sqeme/sqeme-gambit $<
	gcc $(CFLAGS) $(LDFLAGS) $@.c $@_.c -o $@

sqeme/libsqeme-gambit.so sqeme/sqeme-gambit.c: FORCE
	cd sqeme && $(MAKE)

FORCE:

clean:
	rm -f hello webkit *.o *.c
	cd sqeme && $(MAKE) clean

