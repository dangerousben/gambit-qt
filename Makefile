LDFLAGS=-lgambc `pkg-config --libs QtWebKit`

all: hello webkit

hello: bindings.o bindings-gambit.o hello.o hello_.o
	gcc $(LDFLAGS) $^ -o $@

webkit: bindings.o bindings-gambit.o webkit.o webkit_.o

bindings.o: bindings.cpp
	gcc -c $< -o $@ `pkg-config --cflags QtWebKit`

%.o: %.c
	gcc -c $< -o $@

%_.c: bindings-gambit.c %.c
	gsc -link -o $@ $^

%.c: %.scm
	gsc -c $<

clean:
	rm -f hello webkit *.o bindings-gambit.c hello.c hello_.c webkit.c webkit_.c

