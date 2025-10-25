vim.keymap.set('n', '<localleader>rf', ':source %<CR>', { buffer = true, silent = true })
vim.keymap.set('n', '<localleader>tf', '<Plug>PlenaryTestFile %<CR>', { buffer = true, silent = true })
vim.keymap.set('n', '<localleader>td', ':PlenaryBustedDirectory .<CR>', { buffer = true, silent = true })

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*.lua',
  callback = function()
    vim.opt_local.list = false
  end,
})
