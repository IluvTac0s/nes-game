ASM=ca65
LD=ld65
ASMFLAGS=-t nes
LDFLAGS=-C cfg/nes.cfg
SRC_DIR=src/
BUILD_dir=build/

all: nesgame.nes

main.o: src/main.c
    $(ASM) $(ASMFLAGS) $< -o $@

nesgame.nes: main.o
    $(LD) $(LDFLAGS) $< -o $@

clean:
    rm -f *.o nesgame.nes
