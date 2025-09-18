-- Yank the code block (enclosed in triple backticks) at the current cursor position.
-- It's a naive implementation - only looks for betwee triple, which might
-- actually be in between two codeblock.
-- TODO: Find all fences and check if the starting fence is an odd number.
return function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor[1]  -- Extract the line number from the cursor position
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  
  -- Find opening ```
  local start_line = nil
  for i = current_line, 1, -1 do
    if lines[i] and lines[i]:match('^%s*```') then
      start_line = i
      break
    end
  end
  
  if not start_line then
    return false
  end
  
  -- Find closing ```
  local end_line = nil
  for i = current_line + 1, #lines do
    if lines[i] and lines[i]:match('^%s*```') then
      end_line = i
      break
    end
  end
  
  if not end_line then
    return false
  end
  
  -- Extract and yank the code
  local code_lines = {}
  for i = start_line + 1, end_line - 1 do
    table.insert(code_lines, lines[i] or '')
  end
  
  local code_content = table.concat(code_lines, '\n')
  vim.fn.setreg('"', code_content)
  vim.fn.setreg('+', code_content) -- also copy to system clipboard
  
  vim.notify("Yanked code block (" .. #code_lines .. " lines)")
  return true
end
