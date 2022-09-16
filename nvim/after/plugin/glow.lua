local M = {}
local options = {
  min_height = 10,
  min_width = 10,
  padding = {
    x = 5,
    y = 4,
  }
}

function M.open_float(cmd)
  local max_width = vim.opt.columns:get()
  local max_height = vim.opt.lines:get()
  local output_buf = vim.api.nvim_create_buf(false, true)
  local output_win = vim.api.nvim_open_win(output_buf, true, {
    relative = "win",
    style = "minimal",
    border = "shadow",
    noautocmd = true,
    col = options.padding.x,
    row = options.padding.y,
    width = max_width - (2 * options.padding.x),
    height = max_height - (2 * options.padding.y),
  })

  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.api.nvim_win_close(output_win, true)
      vim.api.nvim_buf_delete(output_buf, { force = true })
    end
  })

  vim.cmd('startinsert')
end

function M.setup()
  vim.api.nvim_create_user_command("Glow", function (opts)
    P(opts)
  end, { nargs = "?" })
end

_G.Glow = M

M.setup()

return M
