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
  s("pinsp", fmt([[
    println!("{{:?}}", {});
  ]], { i(0) })),
  s("tests", c(1, {
    fmt([[
    #[cfg(test)]
    mod test {{
      use crate::*;

      #[test]
      fn test_{}() {{
        {}
      }}
    }}
    ]], { i(1), i(0) }),
  })),

}
