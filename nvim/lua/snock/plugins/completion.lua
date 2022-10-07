--
-- Snippets and autocomplete settings
--
local cmp = require('cmp')
local luasnip = require('luasnip')

vim.api.nvim_create_user_command("SnippetEdit", function() require('luasnip.loaders.from_lua').edit_snippet_files() end, {})
vim.api.nvim_create_user_command("SnippetReload", function() require('luasnip.loaders.from_lua').lazy_load() end, {})


vim.keymap.set({ 'i', 's' }, '<c-l>', function() --{{{
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true }) --}}}
vim.keymap.set({ 'i', 's' }, '<c-j>', function() --{{{
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end, { silent = true }) --}}}
vim.keymap.set({ 'i', 's' }, '<c-h>', function() --{{{
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true }) --}}}

luasnip.config.set_config({ --{{{
  history = true,
  enable_autosnippets = true,
  updateevents = 'TextChanged,TextChangedI',
  region_check_events = "InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",
}) --}}}

local mapping = {
  ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<CR>'] = cmp.mapping.confirm({ select = false }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-e>'] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  ['<c-l>'] = cmp.mapping(function(fallback)
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
      cmp.close()
    elseif cmp.visible() then
      cmp.complete_common_string()
    else
      fallback()
    end
  end, { 'i', 's' }),
  ['<c-n>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end, { 'i', 's' }),
  ['<c-p>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' }),
}

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert(mapping),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'path' },
    { name = 'buffer' },
  }),
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'buffer' },
    { name = 'path' },
  }),
})

cmp.setup.filetype('lua', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
  }),
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'cmdline' },
	}, {
		{ name = 'buffer' },
		{ name = 'path' },
	}),
})

require('luasnip.loaders.from_lua').lazy_load({}) -- load filetype based snippets from snippet folder
