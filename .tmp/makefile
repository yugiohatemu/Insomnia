LUAC = luac

all: .tmp/turnPoint.lua.bin .tmp/sleep.lua.bin .tmp/route.lua.bin .tmp/player.lua.bin .tmp/main.lua.bin .tmp/button.lua.bin

.tmp/turnPoint.lua.bin: turnPoint.lua
	$(LUAC) -o ".tmp/turnPoint.lua.bin" "turnPoint.lua"

.tmp/sleep.lua.bin: sleep.lua
	$(LUAC) -o ".tmp/sleep.lua.bin" "sleep.lua"

.tmp/route.lua.bin: route.lua
	$(LUAC) -o ".tmp/route.lua.bin" "route.lua"

.tmp/player.lua.bin: player.lua
	$(LUAC) -o ".tmp/player.lua.bin" "player.lua"

.tmp/main.lua.bin: main.lua
	$(LUAC) -o ".tmp/main.lua.bin" "main.lua"

.tmp/button.lua.bin: button.lua
	$(LUAC) -o ".tmp/button.lua.bin" "button.lua"

