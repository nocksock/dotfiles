--
-- ʕ •ᴥ•ʔ 
--  This config is in between haircuts. 
--

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module
  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

P = function(v)
  print(vim.inspect(v))
  return v
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- global auto commands {{{
local group = vim.api.nvim_create_augroup('snock', { clear = true })
vim.api.nvim_create_autocmd('BufAdd', { --{{{
  callback = function()
    -- lazy load lsp and git
    -- require("snock.lsp")
    -- require("snock.git")
    -- require("snock.completion")
  end,
  group = group,
}) --}}}
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
-- }}}

require("snock.globals")
require("snock.settings")
require("snock.plugins")
require("snock.mappings")

-- vim: fen fdm=marker fdl=0 nowrap nolinebreak
