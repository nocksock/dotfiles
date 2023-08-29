local group = vim.api.nvim_create_augroup('snock', { clear = true })

vim.api.nvim_create_autocmd('insertenter', {
  callback = function()
    if vim.o.nu then
      vim.o.rnu = false
    end
    vim.o.list = true
    vim.o.cursorline = true
  end,
  group = group,
})

vim.api.nvim_create_autocmd('insertleave', {
  callback = function()
    if vim.o.nu then
      vim.o.rnu = true
    end
    vim.o.list = false
    vim.o.cursorline = false
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

vim.api.nvim_create_autocmd({'RecordingEnter'--[[ , 'CmdlineEnter' ]]}, {
  callback = function()
    vim.o.cmdheight = 1
    vim.cmd('mode') -- fixes a render bug
  end,
  group = group,
})

vim.api.nvim_create_autocmd({ 'RecordingLeave'--[[ , 'CmdlineLeave' ]] }, {
  callback = function()
    vim.o.cmdheight = 0
  end,
  group = group,
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

-- vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
--   group = group,
--   callback = function()
--     if can_have_winbar() then
--       vim.wo.winbar = require("do.view").stl
--     end
--   end
-- })

-- -- using BufRead so that when there are multiple windows initially, inactive
-- -- windows have an empty winbar and there's no jumping when switching.
-- vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "BufRead" }, {
--   group = group,
--   callback = function()
--     if can_have_winbar() then
--       vim.wo.winbar = require("do.view").stl_nc
--     end
--   end
-- })

