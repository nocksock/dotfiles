require "baggage".from 'https://github.com/prettier/vim-prettier'

vim.api.nvim_create_user_command('Format', ':lua vim.lsp.buf.format()<cr>' , {})
