
OPT ?= -Os

SRCS := src/jit.tmp.c

default: all

all: minivm

./minilua: luajit/src/host/minilua.c
	$(CC) -o minilua luajit/src/host/minilua.c -lm

src/jit.tmp.c: src/jit.dasc ./minilua
	./minilua luajit/dynasm/dynasm.lua -o src/jit.tmp.c src/jit.dasc

minivm: $(SRCS)
	$(CC) -I luajit $(OPT) $(SRCS) -o minivm $(CFLAGS)

.dummy:

clean: .dummy
	rm -f $(OBJS) minivm minivm.profdata minivm.profraw
