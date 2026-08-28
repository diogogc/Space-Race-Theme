CC ?= gcc
CFLAGS ?= -O2 -Wall -Wextra

all: bin/hyprland-ipc-bridge bin/space-idle-daemon

bin/hyprland-ipc-bridge: src/hyprland-ipc-bridge.c
	mkdir -p bin
	$(CC) $(CFLAGS) -o bin/hyprland-ipc-bridge src/hyprland-ipc-bridge.c

bin/space-idle-daemon: src/space-idle-daemon.c
	mkdir -p bin
	$(CC) $(CFLAGS) -o bin/space-idle-daemon src/space-idle-daemon.c -lwayland-client -lpthread

clean:
	rm -f bin/hyprland-ipc-bridge bin/space-idle-daemon

.PHONY: all clean
