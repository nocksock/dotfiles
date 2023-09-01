require "baggage".from('https://github.com/rose-pine/neovim').load('rose-pine').setup {}

vim.g.colors_name = 'rose-pine'
vim.o.background = vim.system({ 'is-dark-mode' }):wait().stdout == '1\n' and 'dark' or 'light'
