BIN_DIR=$(HOME)/.local/bin
TARGET=$(BIN_DIR)/pen
SOURCE=$(CURDIR)/pen

install:
	ln -sf $(SOURCE) $(TARGET)

uninstall:
	rm -f $(TARGET)
