local baggage = require 'baggage'.from { 'https://github.com/stevearc/aerial.nvim' }

baggage.setup('aerial', {})

vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>")
vim.keymap.set("n", "}", "<cmd>AerialNext<CR>")
vim.keymap.set('n', '<leader>o', "<cmd>AerialToggle<CR>")
