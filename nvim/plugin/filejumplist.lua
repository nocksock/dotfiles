local function back()
  local jumplist = vim.fn.getjumplist()[1]
  local cur_bufnr = vim.api.nvim_get_current_buf()

  for i = 1, #jumplist, 1 do
    local entry = jumplist[i]
    if entry.bufnr ~= cur_bufnr then
      vim.cmd('b' .. entry.bufnr)
      break
    end
  end
end

local function forward()
  local jumplist = vim.fn.getjumplist()[1]
  local cur_bufnr = vim.api.nvim_get_current_buf()

  for i = #jumplist, 1, -1 do
    local entry = jumplist[i]
    if entry.bufnr ~= cur_bufnr then
      vim.cmd('keepjumps b' .. entry.bufnr)
      break
    end
  end
end

vim.api.nvim_create_user_command('JumpPrevFile', back, {})
vim.api.nvim_create_user_command('JumpNextFile', forward, {})

vim.keymap.set('n', '<Leader>o', ':JumpPrevFile<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>i', ':JumpNextFile<CR>', { noremap = true, silent = true })
