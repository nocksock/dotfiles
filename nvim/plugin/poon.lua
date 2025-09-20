package.path = package.path .. ";" .. "/home/code/plugins.nvim/poon.nvim/lua/?.lua"
package.path = package.path .. ";" .. "/home/code/plugins.nvim/poon.nvim/lua/?/init.lua"

R "poon".setup {}

vim.keymap.set({'n'}, "<c-p>",     function() R'poon.window_float'.toggle() end)
vim.keymap.set({'v'}, "<c-p>",     function() R'poon.window_float'.toggle({
  -- pass current selection as input
  input = vim.fn.getreg('"'),
  callback_after_close = function(selected) 
    vim.fn.setreg('"', selected)
  end,
}) end)
vim.keymap.set({'n'}, "<leader>a", function() R'poon.append'.current_file() end)
vim.keymap.set({'n'}, "<leader>A", function() R'poon.append'.current_file_location() end)
