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
  s(
    'rel',
    fmt([[{} {} @relation(fields: [{}], references: [id], onDelete: Cascade)]], {
      i(1),
      f(function(field_name)
        local name = field_name[1][1] or ""
        if not name.gsub then
          return name
        end

        return name:gsub("^%l", string.upper)
      end, { 1 }),
      f(function(field_name)
        return field_name[1][1] .. 'Id'
      end, { 1 }),
    })
  ),
}
