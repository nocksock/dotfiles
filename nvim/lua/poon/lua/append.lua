local Append = {}

function Append.text (line, config)
  local config = config or R "poon.lua.config"()
  local poon_file = R "poon.lua.get_poonfile"(config)

  local file = io.open(poon_file, 'a')
  if file then
    file:write(line .. '\n')
    file:close()
    vim.notify("Added to " .. poon_file .. ": " .. line)
  else
    vim.notify("Could not write to " .. poon_file, vim.log.levels.ERROR)
  end
end

function Append.current_file (line, config)
  local config = config or R "poon.lua.config"()
  local poon_file = R "poon.lua.get_poonfile"(config)

  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    vim.notify("Current buffer has no file", vim.log.levels.WARN)
    return
  end

  return Append.file(current_file, config)
end

function Append.file(path, config)
  local config = config or R "poon.lua.config"()
  local poon_file = R "poon.lua.get_poonfile"(config)

  local poon_dir = vim.fn.fnamemodify(poon_file, ':h')
  local relative_path = vim.fn.fnamemodify(current_file, ':.' .. poon_dir)

  return Append.text(relative_path, config)
end

return Append
