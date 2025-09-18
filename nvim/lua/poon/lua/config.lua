local fn_close = function () vim.api.nvim_win_close(0, true) end

local default_config = {
  save_on_close = true,
  close_on_leave = true,

  filepath = function() 
    local filepath = vim.fn.findfile(".poon", ".;")
    if filepath == "" then
      filepath = vim.fn.input("Enter path for .poon file: ", ".poon", "file")
      if filepath == "" then
        vim.notify("No .poon file found or provided", vim.log.levels.ERROR)
        return nil
      end
    end
    return filepath
  end,

  on_close = function() 
  end,

  on_open = function()
    local opts = { buffer = true, silent = true, }
    vim.wo.winfixbuf = true -- Prevent opening other buffers 
    vim.keymap.set({'n'}, 'q', fn_close, opts)
    vim.keymap.set({'n'}, '<esc>', fn_close, opts)
    vim.keymap.set({'n'}, '<cr>', R('poon.lua.handle_line'), opts)
  end,

  window = function() 
    local vim_width = vim.opt.columns:get()
    local vim_height = vim.opt.lines:get()
    local height = math.floor(vim_height * 0.66)
    local width = math.floor(vim_width * 0.66)
    return {
      row = math.floor(((vim_height - height) / 2) - 1),
      col = math.floor((vim_width - width) / 2),
      width = width,
      height = height
    }
  end
}

local config = {}

return function(config)
  if not config then
      config = vim.tbl_deep_extend("force", {}, default_config)
  end

  if config then 
    config = vim.tbl_deep_extend("force", config or {}, config or {})
  end

  return config
end
