#!/bin/bash
fennel --require-as-include --compile src/main.fnl > build/build.lua
amalg.lua -s entry.lua build/build -o build/package.lua
luasrcdiet --quiet --maximum --noopt-comments build/package.lua -o build/package_min.lua

SLOTS=$(cat SLOTS)
SLOTS=$(echo $SLOTS | tr '\r\n' ' ')
SLOTS=$(echo $SLOTS | tr '\n' ' ')

wrap.lua build/package_min.lua --slots $SLOTS --handle-errors > out/final.json
