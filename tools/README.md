# Usage example

Let's make a simple script that will react to key presses and display some text on the screen.

1. Edit and save a Lua script in some kind of text editor:

```lua
-- Define a global script object with event handlers
script = {}

function script.onStart ()
  -- Display some text
  screen.setCenteredText("script started")

  -- Create some timers to show that the script is working
  unit.setTimer("a", 2) -- timer id "a", ticks every 2 seconds
  unit.setTimer("b", 3) -- timer id "b", ticks every 3 seconds
end

function script.onStop ()
  screen.setCenteredText("script stopped")
end

function script.onActionStart (actionName)
  screen.setCenteredText(actionName .. " key pressed")
end

function script.onActionStop (actionName)
  screen.setCenteredText(actionName .. " key released")
end

function script.onTick (timerId)
  screen.setCenteredText("timer " .. timerId .. " ticked")
end

-- Other events that are available by default:
-- * onActionLoop(actionName): action key is held
-- * onUpdate(): executed once per frame
-- * onFlush(): executed 60 times per second, for physics calculations only; setEngineCommand must be called from here

-- Slot events are available if slot type is set with the --slot command line option.
function script.onMouseDown (x, y)
  screen.setCenteredText("mouse down: x=" .. x .. " , y=" .. y)
end

-- Call the start event handler
-- Alternatively, initialization code can be placed anywhere in this file.
-- The only requirement is that there is a global "script" object with event handlers
script.onStart()
```

2. Run the packaging script:

lua wrap.lua yourscript.lua --slots screen:type=screen --handle-errors > yourscript.json

```
--slots screen:type=screen sets first slot's name to screen and adds mouse down/up event support for that slot.
```

```
--handle-errors adds error handling code, so that run-time Lua errors are displayed on the screen and in the notification tab.
```

3. Open the resulting configuration file in a text editor, and copy everything to clipboard.

4. Inside Dual Universe, prepare a construct. There must be a programming board and a screen, and the screen must be linked into the programming board's slot 1.

5. Right-click on the programming board, select "Actions for this Element", "Paste Lua configuration from clipboard".

Done! The DU construct has been programmed without opening the in-game editor once. Activate the programming board and see if it works.

Command line arguments

```
Usage: wrap.lua ([--handle-errors] | [--handle-errors-min])
       [--output <format>] [--name <name>]
       [--object <script_object_name>] [--call-with <dot_or_colon>]
       [--default-slot type=<slot_type>] [--fix-gc] [--fix-require]
       [--indent-json] [--list-slot-types] [-h] <file>
       [--slots [<slot_name>[:type=<slot_type>[,class=<slot_class>][,select=all]]] [<slot_name>[:type=<slot_type>[,class=<slot_class>][,select=all]]] [<slot_name>[:type=<slot_type>[,class=<slot_class>][,select=all]]] ...]
       [--methods [<method_signature>] ...]

Arguments:
   file                  The Lua file that contains script code.

Options:
   --output <format>     Output format. Valid values: "json", "yaml". Defaults to "json".
                         JSON output can be pasted in-game by right-clicking on the control unit.
                         YAML files the with .conf extension can be placed in data/lua/autoconf/custom.
   --name <name>         Script name. Only used when outputting YAML.
   --slots [<slot_name>[:type=<slot_type>[,class=<slot_class>][,select=all]]] [<slot_name>[:type=<slot_type>[,class=<slot_class>][,select=all]]] [<slot_name>[:type=<slot_type>[,class=<slot_class>][,select=all]]] ...
                         Control unit slot names and, optionally, element types (to generate element type specific event handlers).
                         When output format is YAML, "class" option can be used to link elements that do not have a type defined in this script, and the "select=all" option can be used to link all elements of that type or class.
                         Unit, system and library slots are added automatically. Slot names default to slot1, slot2, ..., slot10.
   --methods [<method_signature>] ...
                         Methods to define on the control unit. This is not very useful and is only supported when outputting JSON.
   --object <script_object_name>
                         The name of the object containing the event handlers. Defaults to "script".
   --call-with <dot_or_colon>
                         Event handler function call operator. Valid values: ".", ":". Defaults to ".".
   --default-slot type=<slot_type>
                         Default slot options.
   --fix-gc              Adjust GC to run more frequently. This can help prevent memory overload errors.
   --fix-require         Replace non-working require() with a function that looks in package.preload and package.loaded.
                         This is not necessary unless require() is disabled in-game again.
   --handle-errors       Add error handling code that displays errors on screen elements.
   --handle-errors-min   Add minified error handling code that displays errors on screen elements.
   --indent-json         Indent the JSON output.
   --list-slot-types     Lists slot types supported by the --slots option.
   -h, --help            Show this help message and exit.
```

Command line examples

To produce a pasteable configuration for a custom piloting script:

```bash
lua wrap.lua pilot.bundle.lua --slots core gyro container_0 screen verticalEngine > pilot.bundle.json
```

To produce a pasteable configuration for a radar script:

```bash
lua wrap.lua radar.bundle.lua --handle-errors --default-slot type=pressable > radar.bundle.json
```

To produce an autoconf file for another custom piloting script:

```bash
lua wrap.lua flight-enhancednav.bundle.lua --output yaml --name "Airplane Cockpit (Enhanced)" --slots core:type=core gyro:type=gyro container:type=fuelContainer,select=all --handle-errors > flight-enhancednav.conf
```

Known issues

"Root node should be a map"

This error is caused by wrong .conf file encoding. If you are using Powershell, the > operator saves the output with UCS-2 LE BOM encoding. Use cmd.exe instead, or replace > my.conf with | Out-File -Encoding UTF8 my.conf

Credits

This tool uses argparse and dkjson libraries, and was bundled using amalg.