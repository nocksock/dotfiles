require "baggage".from {
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/hrsh7th/cmp-nvim-lua',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/zbirenbaum/copilot-cmp',
  'https://github.com/zbirenbaum/copilot.lua'
}

local cmp = require('cmp')

cmp.setup({-- {{{
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<A-y>"] = require('minuet').make_cmp_map(),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<c-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<c-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 'c' }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = 'minuet' },
    { name = "buffer" },
    { name = "path" },
    { name = "copilot" },
  }, {
    -- 
  }),
})-- }}}
cmp.setup.filetype('gitcommit', {-- {{{
  sources = cmp.config.sources({
    { name = 'path' },
  }),
})-- }}}
cmp.setup.cmdline(':', {-- {{{
  sources = cmp.config.sources({
    { name = 'cmdline' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})-- }}}

require("copilot_cmp").setup()
