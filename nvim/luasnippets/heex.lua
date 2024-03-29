
-- Helper Methods {{{
---@diagnostic disable: unused-local, unused-function
local ls = require('luasnip')
local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep ---@diagnostic disable-line: unused-local
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require('luasnip.util.events')
local ai = require('luasnip.nodes.absolute_indexer')
local same = function(index)
	return f(function(arg)
		return arg[1]
	end, { index, index })
end
-- }}}

ls.filetype_extend('heex', {'elixir'})

return {}
