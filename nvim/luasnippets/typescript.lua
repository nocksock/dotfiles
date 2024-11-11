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
  s('kt', fmt([[keyof typeof {}]], { i(0) })),
  s('clg', fmt([[console.log({});]], { i(0) })),
  s('log', fmt([[console.log({});]], { i(0) })),
  s('eafn', fmt([[
    export const {} = async () => {{
      return {}
    }}
  ]], { i(1), i(2) })),
  s(
    'ct',
    c(1, {
      fmt([[console.time({});]], { i(0) }),
      fmt([[console.timeEnd({});]], { i(0) }),
    })
  ),
  s('json', fmt([[JSON.stringify({}, null, 2)]], { i(0) })),
  -- todo: describe (with current file name, and maybe all exports?)
  s(
    'describe',
    fmt(
      [[
			describe('{}', () => {{
				it('{}', () => {{
						{}
				}})
			}})
			]],
      { i(1), i(2), i(0) }
    )
  ),
  s(
    'it',
    fmt(
      [[
		it('should {}', () => {{
				{}
		}})
	]],
      { i(1), i(0) }
    )
  ),
  s('fn', c(1, {
    fmt([[const {} = ({}) => {}]], { i(1), i(2), i(3) }),
    fmt([[
      const {} = ({}) => {{
        return {}
      }}]], { i(1), i(2), i(3) }),
    fmt([[
      function {}({}) {{
        return {}
      }}]], { i(1), i(2), i(3) }),
  })),

  s('cb', c(1, {
    fmt([[({}) => {}]], { i(1), i(2) }),
    fmt([[
      ({}) => {{
        return {}
      }}]], { i(1), i(2) }),
    fmt([[
      function {}({}) {{
        return {}
      }}]], { i(1), i(2), i(3) }),
  })),

  s('edafn', c(1, {
    fmt([[
      export default async function {}({}) {{
        return {}
      }}]], { i(1), i(2), i(3) }),
  })),
  s('edfn', c(1, {
    fmt([[
      export default function {}({}) {{
        return {}
      }}]], { i(1), i(2), i(3) }),
    fmt([[
      export default {} = ({}) => {{
        return {}
      }}]], { i(1), i(2), i(3) }),
    fmt([[export default ({}) => {}]], { i(1), i(2) }),
  })),
  s('efn', c(1, {
    fmt([[export const {} = ({}) => {}]], { i(1), i(2), i(3) }),
    fmt([[
      export const {} = ({}) => {{
        return {}
      }}]], { i(1), i(2), i(3) }),
    fmt([[
      export function {}({}) {{
        return {}
      }}]], { i(1), i(2), i(3) }),
  })),
}
