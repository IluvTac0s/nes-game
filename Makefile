ASM=ca65
LD=ld65
ASMFLAGS=-t nes
LDFLAGS=-C cfg/nes.cfg

all: nesgame.nes

main.o: src/main.asm
    $(ASM) $(ASMFLAGS) $< -o $@

nesgame.nes: main.o
    $(LD) $(LDFLAGS) $< -o $@

clean:
    rm -f *.o nesgame.nes
