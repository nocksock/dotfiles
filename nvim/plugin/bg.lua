vim.api.nvim_create_user_command("BG", function()
  vim.o.background = require 'nsck.cycle' ({"dark", "light"}, vim.o.background)
end, {})

local timer = vim.loop.new_timer()

timer:start(0, 5000, vim.schedule_wrap(require('nsck.darkmode').set_background_by_mode))
