return function(config, opts) 
  local config = config or R "poon.lua.config"()

  if config.save_on_close then
    vim.cmd([[
      :silent write!
    ]])
  end

  config.on_close({ winnr = opts.winnr })

  if vim.api.nvim_win_is_valid(opts.winnr) then
    vim.api.nvim_win_close(opts.winnr, true)
  end
end
