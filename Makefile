LDFLAGS=-lgambc `pkg-config --libs QtWebKit`

hello: bindings.o bindings-gambit.o hello.o link.o
	gcc $(LDFLAGS) $^ -o $@

bindings.o: bindings.cpp
	gcc -c $< -o $@ `pkg-config --cflags QtWebKit`

%.o: %.c
	gcc -c $< -o $@

link.c: bindings-gambit.c hello.c
	gsc -link -o $@ $^

%.c: %.scm
	gsc -c $<

clean:
	rm -f hello *.o bindings-gambit.c hello.c link.c
