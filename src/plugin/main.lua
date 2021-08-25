--[[
Plugin for the Bitty Engine

Copyright (C) 2020 - 2021 Tony Wang, all rights reserved

Homepage: https://paladin-t.github.io/bitty/
]]

-- Which assets are supposed to be injected from this plugin to target project.
local assets = {
	'luax/compiler.lua',
	'luax/README.txt'
}

-- Tips and example code.
local tips = 'Usage:\n  require \'luax/compiler\'\n  f = compile(\'source.luax\')\n  f()'
local code = 'require \'luax/compiler\'\nf = compile(\'source.luax\')\nf()\n'

-- Plugin entry, called to determine the usage of this plugin.
function usage()
	return { 'compiler' } -- This plugin is a compiler.
end

-- Plugin entry, called to determine the schema of this plugin.
function schema()
	return {
		-- Common.
		name = 'Luax',      -- Asset name registered for this plugin.
		extension = 'luax', -- Asset extension registered for this plugin.

		-- List of string.
		keywords = {
			'and', 'break', 'do', 'else', 'elseif', 'end',
			'false', 'for', 'function', 'goto', 'if', 'in',
			'local', 'nil', 'not', 'or', 'repeat', 'return',
			'then', 'true', 'until', 'while'
		},
		identifiers = {
			'__add', '__sub', '__mul', '__div',
			'__mod', '__pow', '__unm', '__idiv',
			'__band', '__bor', '__bxor', '__bnot',
			'__shl', '__shr',
			'__concat', '__len',
			'__eq', '__lt', '__le',
			'__index', '__newindex', '__call',
			'__gc', '__close', '__mode', '__name', '__tostring',

			'char', 'len', 'pack', 'type', 'unpack',

			'_G', 'assert', 'collectgarbage', 'dofile', 'error', 'getmetatable', 'ipairs', 'load', 'loadfile', 'next', 'pairs', 'pcall', 'print', 'rawequal', 'rawget', 'rawlen', 'rawset', 'select', 'setmetatable', 'tonumber', 'tostring', 'xpcall',
			'coroutine', 'create', 'isyieldable', 'resume', 'running', 'status', 'wrap', 'yield',
			'require', 'package', 'config', 'cpath', 'loaded', 'loadlib', 'path', 'preload', 'searchers', 'searchpath',
			'string', 'byte', 'dump', 'find', 'format', 'gmatch', 'gsub', 'lower', 'match', 'packsize', 'rep', 'reverse', 'sub', 'upper',
			'utf8', 'charpattern', 'codes', 'codepoint', 'offset',
			'table', 'concat', 'insert', 'move', 'remove', 'sort',
			'math', 'abs', 'acos', 'asin', 'atan', 'ceil', 'cos', 'deg', 'exp', 'floor', 'fmod', 'huge', 'log', 'max', 'maxinteger', 'min', 'mininteger', 'modf', 'pi', 'rad', 'random', 'randomseed', 'sin', 'sqrt', 'tan', 'tointeger', 'ult',
			'self'
		},
		quotes = { '\'', '"' },
		-- String.
		multiline_comment_start = '--[[',
		multiline_comment_end = ']]',
		-- C++ regex.
		comment_patterns = { '\\-\\-.*' },
		number_patterns = {
			'0[xX][0-9a-fA-F]+[uU]?[lL]?[lL]?',
			'[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)([eE][+-]?[0-9]+)?[fF]?',
			'[+-]?[0-9]+[Uu]?[lL]?[lL]?'
		},
		identifier_patterns = { '[a-zA-Z_][a-zA-Z0-9_]*' },
		punctuation_patterns = {
			'[\\[\\]\\{\\}\\!\\#\\%\\^\\&\\*\\(\\)\\-\\+\\=\\~\\|\\:\\<\\>\\?\\/\\;\\,\\.]'
		},
		-- Boolean.
		case_sensitive = true,
		-- List of string.
		assets = assets
	}
end

-- Plugin entry, called to install necessary assets to your target project.
function compiler()
	print('Install Luax compiler to the current project.')

	waitbox('Installing')
		:thus(function (rsp)
			local install = function (name)
				local data = Project.main:read(name)
				data:poke(1)
				Project.editing:write(name, data) -- Write into the target project.
			end

			for _, asset in ipairs(assets) do -- Install all necessary assets.
				install(asset)
			end

			print('Done.')

			msgbox(tips)
				:thus(function ()
					Platform.setClipboardText(code) -- Put example code to clipboard.
				end)
		end)
end
