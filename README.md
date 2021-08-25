# Luax compiler plugin for Bitty Engine

This repository implements a custom compiler/transpiler plugin for [Bitty Engine](https://github.com/paladin-t/bitty) with an extended Lua syntex.

This plugin implements `+=` and `-=` operators which the original Lua doesn't support.

```lua
local a = 0
for i = 1, 42 do
  a += 1 -- Extended operator "+=".
end
print(a)

for i = 1, 42 do
  a -= 1 -- Extended operator "-=".
end
print(a)
```

Seealso [paladin-t/bitty.compiler_plugin](https://github.com/paladin-t/bitty.compiler_plugin) for details.

## Installing

1. Clone or download this repository.
2. Click "Project", "Browse Data Directory..." from the menu bar.
3. Ensure there is a "plugins" directory under that directory.
4. Put the "plugin.bit" into the new created "plugins" directory. And name it properly.
5. Reopen Bitty Engine.

## Injecting

1. Create a new asset, select the registered "luax" type.
2. Click "Install" to inject necessary assets to the target project.
3. Write and run Luax code.
