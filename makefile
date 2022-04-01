
OPT ?= -Os

SRCS := src/jit.tmp.c

default: all

all: jit49

./minilua: luajit/src/host/minilua.c
	$(CC) -o minilua luajit/src/host/minilua.c -lm

src/jit.tmp.c: src/jit.dasc ./minilua
	./minilua luajit/dynasm/dynasm.lua -o src/jit.tmp.c src/jit.dasc

jit49: $(SRCS)
	$(CC) -I luajit $(OPT) $(SRCS) -o jit49 $(CFLAGS)

.dummy:

clean: .dummy
	rm -f $(OBJS) jit49 jit49.profdata jit49.profraw
