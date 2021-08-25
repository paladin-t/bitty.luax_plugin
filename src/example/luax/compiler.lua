--[[
Luax compiler for the Bitty Engine

Copyright (C) 2020 - 2021 Tony Wang, all rights reserved

Homepage: https://paladin-t.github.io/bitty/
]]

local interpreter = 'local function interpret(code, asset)\n' ..
	'	local chunk, ret = load(code, asset, "t", _ENV)\n' ..
	'	if chunk ~= nil then\n' ..
	'		chunk()\n' ..
	'	else\n' ..
	'		error(ret)\n' ..
	'	end\n' ..
	'end\n'

local function trim(str)
	return str:match'^%s*(.*%S)' or ''
end

-- Compiles from an asset.
function compile(asset)
	if not asset then
		error('Invalid asset.')
	end

	local bytes = Project.main:read(asset)
	if not bytes then
		error('Invalid asset.')
	end
	bytes:poke(1)

	local src = bytes:readString()
	local dst = ''
	for ln in src:gmatch('([^\n]*)\n?') do
		if #ln > 0 then
			local inc, dec = ln:find('+='), ln:find('-=')
			if inc then
				local head = ln:sub(1, inc - 1)
				local tail = ln:sub(inc + 2)
				local token = trim(head)
				ln = head .. '= ' .. token .. ' +' .. tail -- Concat parts.
			elseif dec then
				local head = ln:sub(1, dec - 1)
				local tail = ln:sub(dec + 2)
				local token = trim(head)
				ln = head .. '= ' .. token .. ' -' .. tail -- Concat parts.
			end
			ln = '\'' .. ln .. '\\n\' ..'
			dst = dst .. ln .. '\n'                        -- Concat lines.
		else
			ln = '\'\\n\' ..'
			dst = dst .. ln .. '\n'
		end
	end
	dst = dst .. '\'\'\n'
	local full = interpreter .. 'interpret(' .. dst .. ', \'' .. asset .. '\')' -- Link the source code with the interpreter together.

	return load(full, asset) -- Return loaded and parsed Lua chunk.
end
