local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
  ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<CR>'] = cmp.mapping.confirm({ select = false }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-e>'] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  ['<c-l>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.complete_common_string()
    else
      fallback()
    end
  end, { 's', 'c' }),
  ['<c-n>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end, { 'i', 's', 'c' }),
  ['<c-p>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end, { 'i', 's', 'c'}),
}),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' }
  }),
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'path' },
  }),
})

cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'cmdline' },
	}, {
		{ name = 'buffer' },
		{ name = 'path' },
	}),
})

