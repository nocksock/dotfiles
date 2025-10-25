local M = {}

function M.cmd(cmd_str, mode)
  local ok, result = pcall(function()
    local handle = io.popen(cmd_str, mode)
    assert(handle)
    local result = handle:read("*a")
    handle:close()
    return result
  end)

  if not ok then
    print("something went wrong with: " .. cmd_str)
    print(result)
    os.exit()
  end

  return result or ""
end

return M
