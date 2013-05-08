LUAC = luac

all: .tmp/main.lua.bin .tmp/player.lua.bin .tmp/turnPoint.lua.bin .tmp/route.lua.bin

.tmp/main.lua.bin: main.lua
	$(LUAC) -o ".tmp/main.lua.bin" "main.lua"

.tmp/player.lua.bin: player.lua
	$(LUAC) -o ".tmp/player.lua.bin" "player.lua"

.tmp/turnPoint.lua.bin: turnPoint.lua
	$(LUAC) -o ".tmp/turnPoint.lua.bin" "turnPoint.lua"

.tmp/route.lua.bin: route.lua
	$(LUAC) -o ".tmp/route.lua.bin" "route.lua"

