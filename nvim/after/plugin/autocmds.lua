-- global auto commands 
local group = vim.api.nvim_create_augroup('snock', { clear = true })

vim.api.nvim_create_autocmd('insertenter', { --{{{
  callback = function()
    if vim.o.nu then
      vim.o.rnu = false
    end
    vim.o.list = true
  end,
  group = group,
}) --}}}

vim.api.nvim_create_autocmd('TermOpen', { --{{{
  callback = function()
    vim.bo.filetype = "terminal"
    print "termopen"
    vim.keymap.set('n', '<C-c>', 'i<C-c>', { buffer = true })
  end,
  group = group
}) --}}}

vim.api.nvim_create_autocmd('insertleave', { --{{{
  callback = function()
    if vim.o.nu then
      vim.o.rnu = true
    end
    vim.o.list = false
  end,
  group = group,
}) --}}}

vim.api.nvim_create_autocmd('TextYankPost', { --{{{
  callback = function()
    vim.highlight.on_yank()
  end,
  group = group,
  pattern = '*',
}) --}}}

