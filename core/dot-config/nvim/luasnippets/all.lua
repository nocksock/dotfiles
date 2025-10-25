-- Helper Methods
---@diagnostic disable: unused-local, unused-function
local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep ---@diagnostic disable-line: unused-local
local extras = require('luasnip.extras')

return {
  ls.s({
    trig = ",,date",
    snippetType = "autosnippet",
  }, extras.partial(os.date, "%Y-%m-%d")),
  ls.s({
    trig = ",,time",
    snippetType = "autosnippet",
    }, extras.partial(os.date, "%H:%M")),
}
