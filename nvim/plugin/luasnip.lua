require("luasnip.loaders.from_lua").load({})

local ls = require('luasnip')

ls.config.set_config({
	history = true,
	enable_autosnippets = true,
	updateevents = 'TextChanged,TextChangedI',
})

-- vim:fdl=0 fdm=marker
