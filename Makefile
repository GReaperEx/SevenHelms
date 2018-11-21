BIN := seven-helms
SRC := MUD2.BAS

ifeq ($(OS),Windows_NT)
    BIN := $(BIN).exe
endif

all:
	fbc $(SRC) -x %(BIN)
