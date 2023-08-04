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

-- autocmd RecordingEnter * set cmdheight=1
-- autocmd RecordingLeave * set cmdheight=0
