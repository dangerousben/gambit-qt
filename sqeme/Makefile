LDFLAGS=-shared -lgambc `pkg-config --libs QtWebKit`
CFLAGS=-fPIC -D___LIBRARY -D___SHARED

libsqeme-gambit.so: bindings.o tiny-clos/sort.o tiny-clos/support.o tiny-clos/tiny-clos.o bindings-gambit.o sqeme-gambit.o
	gcc $(LDFLAGS) -shared $^ -o $@

bindings.o: bindings.cpp
	gcc -c $(CFLAGS) `pkg-config --cflags QtWebKit` $< -o $@

%.o: %.c
	gcc -c $(CFLAGS) $< -o $@

sqeme-gambit.c: tiny-clos/sort.c tiny-clos/support.c tiny-clos/tiny-clos.c bindings-gambit.c
	gsc -link -o $@ $^

%.c: %.scm
	gsc -c -debug $<

clean:
	rm -f libsqeme-gambit.so *.o *.c tiny-clos/*.o tiny-clos/*.c
