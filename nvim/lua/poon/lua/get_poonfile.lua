return function(config)
  config = config or R "poon.lua.config"()

  if type(config.filepath) == "function" then
    return config.filepath()
  end

  if type(config.filepath) == "string" then
    return config.filepath
  end

  local filepath = vim.fn.findfile(config.filename, ".;")

  if filepath == "" then
    return get_filepath_from_user()
  end

  return filepath
end
