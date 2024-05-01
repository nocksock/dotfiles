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
local ts_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
-- }}}

return {
  s('=', { t('<?= $'), i(1, "var"), t(' ?>') }),
  s('if', c(1, {
    fmt([[
    <?php if({}): ?>
    {}
    <?php endif; ?>
    ]], {
      i(1), i(2)
    })
  })),
  s('foreach', c(1, {
    fmt(
      [[
      <?php foreach(${} as {}): ?>
        {}
      <?php endforeach; ?>
      ]],
      {
        i(1),
        c(2, {
          fmt([[${}]], { i(1, "item") }),
          fmt([[${} => ${}]], { i(1, "key"), i(2, "item") })
        }),
        i(3)
      }
    ),
    fmt(
      [[
      foreach({} as {}) {{
        {}
      }}
      ]],
      {
        i(1, "$items"),
        c(2, {
          fmt([[${}]], { i(1, "item") }),
          fmt([[${} => ${}]], { i(1, "key"), i(2, "item") })
        }),
        i(3)
      }
    ),
  })),
  s(
    'php',
    c(1, {
      fmt([[<?php {} ?>]], { i(1) }),
      fmt([[<?= {} ?>]], { i(1) }),
      fmt(
        [=[
					<?php
						{}
					?>
        ]=],
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
}
