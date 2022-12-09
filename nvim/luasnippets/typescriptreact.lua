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

return {
	-- TODO: a snippet that uses Tree Sitter to check whether pre or
	-- console.log
	s('pjson', fmt([[<pre>{{JSON.stringify({}, null, 2)}}</pre>]], { i(0) })),
	s('rjson', fmt([[return <pre>{{JSON.stringify({}, null, 2)}}</pre>]], { i(0) })),
	s('tern', fmt([[{{{} ? ({}) : null}}]], { i(1), i(0) })),
	s('clg', fmt([[console.log({});]], { i(0) })),
	s('edfn', c(1, {
    fmt([[export default const {} = ({}) => {}]], {i(1), i(2), i(3)}),
    fmt([[
      export default const {} = ({}) => {{
        return {}
      }}]], {i(1), i(2), i(3)}),
    fmt([[
      export default function {}({}) {{
        return {}
      }}]], {i(1), i(2), i(3)}),
  })),
	s('efn', c(1, {
    fmt([[export const {} = ({}) => {}]], {i(1), i(2), i(3)}),
    fmt([[
      export const {} = ({}) => {{
        return {}
      }}]], {i(1), i(2), i(3)}),
    fmt([[
      export function {}({}) {{
        return {}
      }}]], {i(1), i(2), i(3)}),
  })),
	s('fn', c(1, {
    fmt([[const {} = ({}) => {}]], {i(1), i(2), i(3)}),
    fmt([[
      const {} = ({}) => {{
        return {}
      }}]], {i(1), i(2), i(3)}),
    fmt([[
      const {} = function {}({}) {{
        return {}
      }}]], {i(1), i(2), i(3), i(4)}),
  })),
	s('cb', c(1, {
    fmt([[({}) => {}]], {i(1), i(2)}),
    fmt([[
      ({}) => {{
        return {}
      }}]], {i(1), i(2)}),
    fmt([[
      function {}({}) {{
        return {}
      }}]], {i(1), i(2), i(3)}),
  })),
}
