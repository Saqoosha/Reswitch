BIN := bin/reswitch
SRC := reswitch.swift

.PHONY: build clean

build: $(BIN)

$(BIN): $(SRC)
	@mkdir -p bin
	xcrun swiftc -O -o $(BIN) $(SRC) -framework CoreGraphics

clean:
	rm -rf bin

