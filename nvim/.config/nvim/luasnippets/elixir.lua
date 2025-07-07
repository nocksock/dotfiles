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
  s("link", c(1, {
    fmt([[
    def start_link({1}) do
      GenServer.start_link(__MODULE__, {1})
    end

    {}
    ]], { i(1), i(0) }),
  })),

  s("def", c(1, {
    fmt([[
    def {}({}) do
      {}
    end
    ]], { i(1), i(2), i(0) }),
    fmt([[
    def {}({}), do: {}
    ]], { i(1), i(2), i(0) })
  })),

  s("comp", c(1, {
    fmt([=[
      def {}(assigns) do
        ~H"""
          {}
        """
      end
    ]=], { i(1), i(0) })
  })),

  s('defp', c(1, {
    fmt([[
    defp {}({}) do
      {}
    end
    ]], { i(1), i(2), i(0) }),
    fmt([[
    defp {}({}), do: {}
    ]], { i(1), i(2), i(0) })
  })),

  s('hh', fmt([[
  ~H"""
    {}
  """
  ]], { i(0) })),
  s('mod', fmt([[
  defmodule {} do
    {}
  end
  ]], { i(1), i(0) })),
  s('do', fmt([[
  do
    {}
  end
  ]], { i(0) })),

  s('%', c(1, {
    fmt([[
      <% {} %>
    ]], { i(1) }),
    fmt([[
      <%= {} %>
    ]], { i(1) })
  })),

  s('dinsp', fmt([[

  <details open>
    <summary>Inspect</summary>
    <pre class="bg-slate-800 font-mono text-teal-400 p-8 shadow rounded-lg">
      <%= inspect {}, pretty: true %>
    </pre>
  </details>

  ]], { i(1, "assigns") })),

  s('rinsp', fmt([[
  raise(inspect({}, pretty: true))
  ]], { i(1, "") })),

  s('pinsp', fmt([[
  <pre>
    <%= inspect {}, pretty: true %>
  </pre>
  ]], { i(1, "assigns") }))

}
