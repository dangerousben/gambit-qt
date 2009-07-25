CFLAGS=-g
LDFLAGS=-Lsqeme -lsqeme

all: hello webkit

hello: hello.scm sqeme/libsqeme.so sqeme/sqeme.c
	gsc -debug -link -l sqeme/sqeme $<
	gcc $(CFLAGS) $(LDFLAGS) $@.c $@_.c -o $@

webkit: webkit.scm sqeme/libsqeme.so sqeme/sqeme.c
	gsc -debug -link -l sqeme/sqeme $<
	gcc $(CFLAGS) $(LDFLAGS) $@.c $@_.c -o $@

sqeme/libsqeme.so sqeme/sqeme.c: FORCE
	cd sqeme && $(MAKE)

FORCE:

clean:
	rm -f hello webkit *.o *.c
	cd sqeme && $(MAKE) clean

