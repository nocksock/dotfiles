R "poon".setup {}

vim.keymap.set({'n'}, "<c-p>",     function() R'poon.window_float'.toggle() end)
vim.keymap.set({'n'}, "<leader>a", function() R'poon.append'.current_file() end)
vim.keymap.set({'n'}, "<leader>A", function() R'poon.append'.current_file_location() end)
