vim.api.nvim_create_user_command("LazyGit", function()
  R('snock.utils').open_float_term("lazygit", {})
end, { nargs = "?" })

