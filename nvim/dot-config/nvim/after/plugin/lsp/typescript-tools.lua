local setup = require "baggage"
    .from {
      'https://github.com/neovim/nvim-lspconfig',
      'https://github.com/marilari88/twoslash-queries.nvim',
      'https://github.com/pmizio/typescript-tools.nvim'
    }


-- require 'typescript-tools'.setup {
--   capabilities = require "lsp-utils".capabilities,
--   root_dir     = require('lspconfig.util').root_pattern("package.json"),
--   on_attach    = function(client, bufnr)
--     require("twoslash-queries").attach(client, bufnr)
--     local keyopts = { noremap = true, silent = true, buffer = bufnr }
--     vim.keymap.set('n', '<leader>ci', ':print use , for ft specific bindings<CR>', keyopts)
--     vim.keymap.set('n', '<leader>co', ':print use , for ft specific bindings<CR>', keyopts)
--     vim.keymap.set('n', '<leader>cu', ':print use , for ft specific bindings<CR>', keyopts)
--     vim.keymap.set('n', '<leader>cA', ':print use , for ft specific bindings<CR>', keyopts)
--     vim.keymap.set('n', '<leader>cR', ':print use , for ft specific bindings<CR>', keyopts)
--     -- TODO once adjusted, remove those above
--     vim.keymap.set('n', '<localleader>ci', ':TSToolsAddMissingImports<cr>', keyopts)
--     vim.keymap.set('n', '<localleader>co', ':TSToolsOrganizeImports<cr>', keyopts)
--     vim.keymap.set('n', '<localleader>cu', ':TSToolsRemoveUnused<cr>', keyopts)
--     vim.keymap.set('n', '<localleader>cA', ':TSToolsFixAll<cr>', keyopts)
--     vim.keymap.set('n', '<localleader>cR', ':TSToolsRenameFile<cr>', keyopts)
--   end,
--   filetypes    = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
-- }
