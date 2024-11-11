local group = vim.api.nvim_create_augroup('snock', { clear = true })

vim.api.nvim_create_autocmd('insertenter', {
  callback = function()
    if vim.o.nu then
      vim.o.rnu = false
    end
    vim.o.list = true
    vim.wo.colorcolumn = '80'
  end,
  group = group,
})

vim.api.nvim_create_autocmd('insertleave', {
  callback = function()
    if vim.o.nu then
      vim.o.rnu = true
    end
    vim.o.list = false
    vim.wo.colorcolumn = ''
  end,
  group = group,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = group,
  pattern = '*',
})

---Check whether the current window/buffer can display a winbar
local function can_have_winbar(winnr)
  winnr = winnr or 0
  if vim.api.nvim_win_get_height(winnr) <= 6 or vim.api.nvim_win_get_width(winnr) < 30 then
    return false
  end

  local wintype = vim.fn.win_gettype(winnr)
  local buftype = vim.bo.buftype

  if wintype == "" and buftype ~= "prompt" then
    return true
  end
end
