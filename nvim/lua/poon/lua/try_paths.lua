local function parse_errorformat_line(line)
  -- handle format: filename:line:col:message
  local filename, line_num, col_num = line:match("^([^:]+):(%d+):(%d+):")
  if filename and line_num then
    return filename, tonumber(line_num), tonumber(col_num)
  end
  
  -- handle format: filename:line:message
  filename, line_num = line:match("^([^:]+):(%d+):")
  if filename and line_num then
    return filename, tonumber(line_num), nil
  end
  
  -- handle format: filename:line
  filename, line_num = line:match("^([^:]+):(%d+)")
  if filename and line_num then
    return filename, tonumber(line_num), nil
  end
  
  return vim.fn.expand('<cfile>'), nil
end

return function(_config)
  local line = vim.api.nvim_get_current_line()
  local filename, line_num, col_num = parse_errorformat_line(line)
  local float_win = vim.api.nvim_get_current_win()
  
  if not filename or vim.fn.filereadable(filename) ~= 1 then
    P({"not readable", filename,  vim.fn.filereadable(filename)})
    return false
  end

  vim.cmd('wincmd p')
  
  local ok = pcall(function()
    vim.cmd('edit ' .. vim.fn.fnameescape(filename))
    if line_num then
      vim.api.nvim_win_set_cursor(0, {line_num, (col_num and col_num - 1) or 0})
    end
  end)
  
  if not ok then
    vim.notify("Could not open: " .. filename .. ":" .. (line_num or ""), vim.log.levels.WARN)
    return false
  end
  
  return true
end
