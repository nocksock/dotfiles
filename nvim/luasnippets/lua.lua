-- Helper Methods {{{
---@diagnostic disable: unused-local, unused-function
local ls = require('luasnip')
local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep
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
--
local function simple_restore(args, _)
  return sn(nil, { i(1, args[1]), i(2, "user_text") })
end

return {
  s("rest", {
    i(1, "preset"), t { "", "" },
    d(2, simple_restore, 1)
  }),
  s("paren_change", {
    c(1, {
      sn(nil, { t("("), r(1, "user_text"), t(")") }),
      sn(nil, { t("["), r(1, "user_text"), t("]") }),
      sn(nil, { t("{"), r(1, "user_text"), t("}") }),
    }),
  }, {
    stored = {
      user_text = i(1, "default_text")
    }
  }),

  -- s(
  --   {trig = [[al(%w+)]], regTrig = true},
  --   fmt([[local {} = {}]], {
  --     d(1, function()
  --       return f(function(import_name, snip)
  --         local parts = vim.split(import_name[1][1], '.', true)
  --         return parts[#parts] or ''
  --       end)
  --     end, { 1 }),
  --     f(function(args, snip)
  --       return snip.captures[1]
  --     end, { 1 }),
  --   })
  -- ),
  s(
    'al',
    fmt([[local {} = {}]], {
      f(function(import_name)
        -- local foo = require('foobar.foo')
        local parts = vim.split(import_name[1][1], '.', true)
        return parts[#parts] or ''
      end, { 1 }),
      i(1),
    })
  ),
  s(
    'req',
    fmt([[local {} = require('{}')]], {
      f(function(import_name)
        -- local foo = require('foobar.foo')
        local parts = vim.split(import_name[1][1], '.', true)
        return parts[#parts] or ''
      end, { 1 }),
      i(1),
    })
  ),
  s(
    'fn',
    c(1, {
      fmt('function{}({}) {} end', { i(1), r(2, "body"), i(3) }),
      fmt(
        [[
					function{}({})
						{}
					end
					]]  ,
        { i(1), r(2, "body"), i(3) }
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
				]] ,
      { i(1), i(2), i(0) }
    )
  ),
}
