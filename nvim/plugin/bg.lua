vim.api.nvim_create_user_command("BG", function()
  vim.o.background = require 'nsck.cycle' ({"dark", "light"}, vim.o.background)
end, {})
