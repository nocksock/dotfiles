-- vim.cmd.LspStart("marksman")

vim.opt_local.formatoptions:remove({ 't', 'c' }) -- do not autowrap text at width
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.listchars:append({ precedes = '<', extends = '>' })
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt= "shift:4,sbr,list:2"
vim.opt_local.textwidth = 0
vim.opt_local.wrapmargin = 0

-- Key mapping
vim.keymap.set('n', '<F5>', ':Glow %<CR>', { buffer = true, silent = true })

vim.cmd([[
  augroup markdown
    autocmd!
    autocmd BufEnter *.md let b:copilot_enabled = v:false
  augroup END

]])

vim.cmd.Num()
