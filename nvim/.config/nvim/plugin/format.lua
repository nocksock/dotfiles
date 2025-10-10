require "baggage".from 'https://github.com/prettier/vim-prettier'

vim.api.nvim_create_user_command('Format', ':lua vim.lsp.buf.format()<cr>' , {})
vim.api.nvim_create_user_command('Fmt', ':lua vim.lsp.buf.format()<cr>' , {})
vim.api.nvim_create_user_command('W', ':w' , {})
