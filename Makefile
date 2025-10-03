CC=cl65
SRC_DIR=src
BUILD_DIR=build
NESFILE=nesgame.nes

all: $(NESFILE)

$(NESFILE): $(SRC_DIR)/main.c
	$(CC) -t nes -O -o $@ $<

clean:
	rm -f $(NESFILE) $(BUILD_DIR)/*.o
