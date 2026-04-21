vim.cmd.LspStart("marksman")

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
vim.keymap.set('n', '<leader>h1', 'VypVr=<cr>', { buffer = true, silent = true })
vim.keymap.set('n', '<leader>h2', 'VypVr-<cr>', { buffer = true, silent = true })

vim.keymap.set({'i'}, '<c-t>', function ()
    vim.api.nvim_put({"- [ ] "}, 'c', true, true)
end, opts)

vim.cmd([[
  augroup markdown
    autocmd!
    autocmd BufEnter *.md let b:copilot_enabled = v:false
  augroup END
]])

-- run current line as ex on enter if first non-white character is :
vim.keymap.set('n', '<CR>', function ()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local before_cursor = line:sub(1, col)
    if before_cursor:match('^%s*:%S*') then
        P(vim.api.nvim_get_current_line())
        return '<Esc>:<C-u>' .. before_cursor:match('^%s*:(%S*)') .. '<CR>'
    else
        return '<CR>'
    end
end, { buffer = true, expr = true })

-- vim.cmd.Num()
