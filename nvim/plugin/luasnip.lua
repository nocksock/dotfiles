require('luasnip.loaders.from_lua').load({})

local ls = require('luasnip')

vim.keymap.set({ 'i', 's' }, '<c-l>', function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<c-k>', function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

ls.config.set_config({
	history = true,
	enable_autosnippets = true,
	updateevents = 'TextChanged,TextChangedI',
})

-- vim:fdl=0 fdm=marker
