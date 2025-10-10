vim.api.nvim_create_user_command("Ex", function()
  local lineNum = vim.api.nvim__buf_stats(0).current_lnum
  local filepath = vim.api.nvim_buf_get_name(0)
  vim.fn.system("mix test " .. filepath .. ":" .. lineNum)
end, {})

vim.keymap.set("n", "<c-f>", ":w<cr>:!mix format %<cr>", { silent=true, buffer=true})
vim.keymap.set("n", "<localleader>f", ":w<cr>:!mix format %<cr>", { silent=true, buffer=true})
vim.keymap.set("n", "<m-s>", ":w<cr>:!mix format %<cr>", { silent=true, buffer=true})
