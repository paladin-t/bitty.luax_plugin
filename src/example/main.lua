require 'luax/compiler'           -- Require the compiler.

local f = compile('example.luax') -- Compile something.
f()                               -- Run the compiled chunk.
