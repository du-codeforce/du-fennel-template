#!/bin/bash
mkdir -p temp

fennel --require-as-include --compile src/main.fnl > temp/build.lua
amalg.lua -s entry.lua temp/build -o temp/package.lua
luasrcdiet --quiet --maximum --noopt-comments temp/package.lua -o temp/package_min.lua

SLOTS=$(cat SLOTS)
SLOTS=$(echo $SLOTS | tr '\r\n' ' ')
SLOTS=$(echo $SLOTS | tr '\n' ' ')

tools/wrap.lua temp/package_min.lua --slots $SLOTS --handle-errors > out/final.json
