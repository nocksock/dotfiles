---find the root project directory based on filenames
---@param filenames table
---@return unknown
return function(filenames)
  return vim.fs.dirname(
    vim.fs.find(
      filenames,
      { upward = true }
    )[1]
  )
end
