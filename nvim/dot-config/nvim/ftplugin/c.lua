vim.opt_local.wrap = false

-- switch between alternative file
vim.keymap.set("n", "<localleader>a", function()
  local alt = vim.fn.expand("%:r") .. (vim.bo.filetype == "c" and ".h" or ".c")
  vim.cmd("edit " .. alt)
end, { buffer = true, desc = "Switch between .c and .h" })
