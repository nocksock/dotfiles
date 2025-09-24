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

return {
    s('do', fmt([[- [ ] {}]], { i(0) })),
    s('note', fmt([[
        ---
        title: {}
        tags: []
        # channels: [rss, html] # rss, html, bsky, apub
        # only: [dev] # eg.: dev | beta | prod
        ---

        {}
    ]], { i(1), i(0) })),

    s('adr', fmt([[
        ## Status

        {}

        ## Context

        The issue motivating this decision, and any context that influences or constrains the decision.

        ## Decision

        The change that we're proposing or have agreed to implement.

        ## Consequences

        What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.
    ]], {i(0, "Pending")}))
}
