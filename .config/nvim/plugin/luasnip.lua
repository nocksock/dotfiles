local ls = require('luasnip')
-- config {{{
ls.config.set_config({
	history = true,
	enable_autosnippets = true,
	updateevents = 'TextChanged,TextChangedI',
})
-- }}}
-- helpers {{{

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

--}}}

ls.snippets = {
	-- TODO: move snippets into language files
	--		see: https://github.com/L3MON4D3/LuaSnip/wiki/Nice-Configs#split-up-snippets-by-filetype-load-on-demand-and-reload-after-change-first-iteration
	all = { -- {{{
		s(
			'trig',
			c(1, {
				t('Ugh boring, a text node'),
				t('foobar'),
				t('great'),
			})
		),
		s(
			'curdate',
			c(1, {
				f(function()
					return os.date('%Y-%m-%d')
				end),
				f(function()
					return os.date('%Y-%m-%d %H:%i')
				end),
				f(function()
					return os.date('%H:%m')
				end),
			})
		),
		s(
			'curtime',
			f(function()
				return os.date('%H:%M')
			end)
		),
	}, --}}}
	['typescript'] = {
		s('clg', fmt([[console.log({});]], { i(0) })),
	},
	['tsx'] = {
		-- TODO: a snippet that uses Tree Sitter to check whether pre or
		-- console.log
		s('cjson', fmt([[console.log(JSON.stringify({}, null, 2));]], { i(0) })),
		s('pjson', fmt([[<pre>{{JSON.stringify({}, null, 2)}}</pre>]], { i(0) })),
	},
	php = {
		s(
			'php',
			c(1, {
				fmt([[<?php {} ?>]], { i(1) }),
				fmt(
					[[
					<?php
						{}
					?>
					]],
					{ i(1) }
				),
			})
		),
		s(
			'?',
			c(1, {
				fmt([[?> {} <?php]], { i(1) }),
				fmt('?>\n{}\n<?php', { i(1) }),
			})
		),
	},
	['go'] = {
		s(
			'ife',
			c(1, {
				fmt(
					[[
					if err != nil {{
						return nil, err
					}}
					{}
				]],
					{ i(1) }
				),
				fmt(
					[[
					if err != nil {{
						{}
					}}
				]],
					{ i(1) }
				),
			})
		),
	},
	lua = { --{{{
		s(
			'req',
			fmt([[local {} = require('{}')]], {
				f(function(import_name)
					-- local foo = require('foobar.foo').thing
					local parts = vim.split(import_name[1][1], '.', true)
					return parts[#parts] or ''
				end, { 1 }),
				i(1),
			})
		),
		s(
			'fn',
			c(1, {
				fmt('function{}({}) {} end', { i(1), i(2), i(0) }),
				fmt(
					[[
					function{}({})
						{}
					end
					]],
					{ same(i(1)), i(1), i(0) }
				),
			})
		),
		s(
			'lf',
			fmt(
				[[
					local function {}({})
						{}
					end
				]],
				{ i(1), i(2), i(0) }
			)
		),
	}, --}}}
}

-- vim:fdl=0 fdm=marker
