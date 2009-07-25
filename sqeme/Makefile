LDFLAGS=-shared -lgambc `pkg-config --libs QtWebKit`
CFLAGS=-fPIC -D___LIBRARY -D___SHARED

libsqeme.so: bindings.o bindings-gambit.o sqeme.o
	gcc $(LDFLAGS) -shared $^ -o $@

bindings.o: bindings.cpp
	gcc -c $(CFLAGS) `pkg-config --cflags QtWebKit` $< -o $@

%.o: %.c
	gcc -c $(CFLAGS) $< -o $@

sqeme.c: bindings-gambit.c
	gsc -link -o $@ $<

%.c: %.scm
	gsc -c $<

clean:
	rm -f libsqeme.so *.o bindings-gambit.c bindings-gambit_.c
