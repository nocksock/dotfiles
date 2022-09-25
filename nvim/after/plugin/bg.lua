vim.api.nvim_create_user_command("BG", function()
  vim.o.background = R("snock.utils").cycle({"dark", "light"}, vim.o.background)
end, {})
