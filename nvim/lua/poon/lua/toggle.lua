local function get_floatwin_for_buf(bufnr)
  for _, winnr in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(winnr) == bufnr and vim.api.nvim_win_get_config(winnr).relative ~= "" then
      return winnr
    end
  end
end

return function(config, bufnr)
  local config = config or R "poon.lua.config"()
  local bufnr = R'poon.lua.get_poonbuffer'(config)
  
  -- window already open
  local winnr = get_floatwin_for_buf(bufnr)
  if winnr then
    -- Set flag on the WINDOW, not buffer
    vim.api.nvim_win_set_var(winnr, 'is_closing', true)
    return R('poon.lua.close')(config, {
      bufnr = bufnr,
      winnr = winnr
    })
  end
  
  -- window not yet open
  local winopts = vim.tbl_deep_extend("force", {
    relative = "editor",
    style = "minimal",
    border = "single",
    noautocmd = true,
  }, config.window())
  
  local winnr = vim.api.nvim_open_win(bufnr, true, winopts)
  local opts = {
    bufnr = bufnr,
    winnr = winnr
  }
  
  vim.api.nvim_create_autocmd('WinLeave', {
    buffer = bufnr,
    callback = function()
      -- Check if window is still valid and get the variable from WINDOW
      local current_win = vim.api.nvim_get_current_win()
      if not vim.api.nvim_win_is_valid(winnr) then
        return
      end
      
      local ok, is_closing = pcall(vim.api.nvim_win_get_var, winnr, 'is_closing')
      if ok and is_closing then
        return
      end
      
      R('poon.lua.close')(config, opts)
    end
  })
  
  config.on_open(opts)
end
