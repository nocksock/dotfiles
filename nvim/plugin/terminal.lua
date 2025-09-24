local group = vim.api.nvim_create_augroup('terminal', { clear = true })

vim.keymap.set({ 't' }, '<Esc>', '<C-\\><C-n>')

--
local nvim_buf_get_win = function(buf)
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(w) == buf then
      return w
    end
  end
end

-- simple terminal toggle
local terminal_buf = nil
for _,key in pairs({ '<M-;>', '<D-;>' }) do
  vim.keymap.set({'n', 't'}, key, function()
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    -- terminal_buf already focused, close
    if terminal_buf == buf then
      vim.api.nvim_win_close(win, true)
      return
    end

    -- terminal_buf invalid, reset
    if terminal_buf and not vim.api.nvim_buf_is_valid(terminal_buf) then
      terminal_buf = nil
    end

    -- no terminal_buf, create
    if not terminal_buf then
      vim.cmd('split')
      vim.cmd('terminal')
      vim.cmd('startinsert')
      terminal_buf = vim.api.nvim_get_current_buf()
      vim.wo.winfixbuf = true

      -- vim.keymap.set('n', '<esc>', function()
      --   win = vim.api.nvim_get_current_win()
      --   vim.api.nvim_win_close(win, true)
      -- end, { buffer = terminal_buf })

    -- -- terminal_buf exists, focus?
    -- -- TODO: consider this for a .open/.open_or_focus function
    -- else
    --   win = nvim_buf_get_win(terminal_buf)
    --   if win then
    --     -- terminal_buf visible, focus
    --     vim.api.nvim_set_current_win(win)
    --     return
    --   end

    -- terminal_buf exists, close
    else
      win = nvim_buf_get_win(terminal_buf)
      if win then
        -- terminal_buf visible, close
        vim.api.nvim_win_close(win, true)
        return
      end

      -- terminal_buf not visible, open
      vim.cmd('split')
      -- vim.cmd('startinsert') -- start in insert mode?
      vim.api.nvim_set_current_buf(terminal_buf)
    end
  end)
end


vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = group,
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false

    table.foreach({'q', '<c-c>'}, function(_i, keys)
      vim.keymap.set({ 'n' }, keys, function()
        if vim.bo.modified then return end
        vim.cmd('bd!')
      end, { buffer = true })
    end)
  end
})
