# Fennel Template
This is a (wip) template to use [fennel](https://fennel-lang.org) for scripting.

To package up the final lua code, I used a script provided by a forum member by the name of hdparm.
I committed the script here until it is publicly available.

# entry.lua
The entry.lua file is what imports and exposes your fennel code

# SLOTS
The SLOTS file contains the slot definitions. One per file.

# src
This is where your fennel code goes. Make sure there is a file named `main.fnl` for the scripts to work

# build.sh
The build.sh file builds and packages your fennel code into a DU consumable JSON file.

The is the following
1) compile the fennel code (`build/build.lua`)
2) pack `build/build.lua` and `entry.lua` into `build/package.lua` using [lua-amalg](https://github.com/siffiejoe/lua-amalg)
3) minify `build/package.lua` into `build/package_min.lua` with [luasrcdiet](https://github.com/jirutka/luasrcdiet)
4) wrap `build/package_min.lua` into the correct structure and save it into `out/final.json`