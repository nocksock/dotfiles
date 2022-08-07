-- OnSave.nvim
--  Run commands on save quickly. 
--
-- :OnSave[!] {command}
--    Whenever that buffer is saved the command will be run. If the command
--    starts with a !, it starts a background job and outputs the result in
--    a floating window. Using :OnSave! will clear all previous commands.
--
--    Note that {command} will be expanded, so you can use %, %:p:h and all
--    those things.
--
--    Examples:
--      :OnSave source %
--      :OnSave! !go run main.go
--      :OnSave! !/.yabairc
--      :OnSave! !http GET http://localhost:3000/foo
--
-- TODO: OnSaveClear to clear only current buffer augroups
-- TODO: when clearing, also delte bufferns
-- TODO: better options for window size etc

local options = {
  min_height = 10,
  min_width = 10,
  padding = {
    x = 30,
    y = 4,
  }
}

local buffers = {}
local augroup = vim.api.nvim_create_augroup("OnSave", { clear = true })

local function clearAll()
  vim.api.nvim_clear_autocmds({ group = augroup })

  for index in ipairs(buffers) do
    vim.api.nvim_buf_delete(table.remove(buffers, index), {})
  end
end

local parse_command = function(cmd)
  local command = vim.split(vim.fn.expandcmd(cmd), " ")
  local is_job = command[1]:sub(1, 1) == "!"

  if is_job then
    command[1] = command[1]:sub(2, -1)
  else
    command = table.concat(command, " ")
  end

  return is_job, command
end

vim.api.nvim_create_user_command("OnSaveClearAll", clearAll, {})
vim.api.nvim_create_user_command("OnSave", function(opts)
  if opts.bang then clearAll() end

  local is_job, command = parse_command(opts.args)
  local bufnr = vim.api.nvim_get_current_buf()
  local winnr = vim.api.nvim_get_current_win()
  local output_buf = vim.api.nvim_create_buf(false, true)
  local output_win = nil

  table.insert(buffers, output_buf)
  print(is_job, command)

  vim.api.nvim_buf_set_keymap(output_buf, "n", "q", ":close<cr>", {})

  local function open_win()
    if output_win ~= nil then return end
    local max_width = vim.api.nvim_win_get_width(winnr)
    local max_height = vim.api.nvim_win_get_height(winnr)
    local height = vim.fn.max({ math.floor(max_height / 10), options.min_height })
    local width = vim.fn.max({ max_width - (2 * options.padding.x), options.min_width })

    output_win = vim.api.nvim_open_win(output_buf, true, {
      relative = "win",
      style = "minimal",
      border = "single",
      noautocmd = true,
      width = width,
      height = height,
      row = max_height - height - options.padding.y,
      col = options.padding.x,
    })

    vim.api.nvim_create_autocmd("WinClosed", {
      pattern = tostring(output_win),
      callback = function()
        output_win = nil
      end
    })
  end

  local function print_out(_, data)
    if table.concat(data, "") ~= "" then
      vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, data)
      open_win()
    end
  end

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    buffer = bufnr,
    callback = vim.schedule_wrap(function()
      vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})

      if is_job then
        vim.fn.jobstart(command, {
          stdout_buffered = true,
          on_stdout = print_out,
          on_stderr = function(_, data)
            P(data)
          end
        })
      else
        vim.cmd(table.concat(command, " "))
      end
    end)
  })
end, { nargs = '+', bang = true })
