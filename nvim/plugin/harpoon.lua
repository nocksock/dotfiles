
require 'baggage' .from {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/ThePrimeagen/harpoon'
}
.setup(
  {
    global_settings = {
      enter_on_sendcmd = true
    }
  }
)

vim.keymap.set('n', "<leader>'",  '<cmd>lua require("harpoon.mark").add_file()<CR>' )
vim.keymap.set('n', "''",         ':lua require("harpoon.ui").toggle_quick_menu()<CR>' )
vim.keymap.set('n', "<leader>;;", '<cmd>lua lua require("harpoon.cmd-ui").toggle_quick_menu()<cr>' )
vim.keymap.set('n', "<leader>;f", '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>' )
vim.keymap.set('n',  "'f",        '<cmd>lua require("harpoon.ui").nav_file(1)<CR>' )
vim.keymap.set('n',  "'d",        '<cmd>lua require("harpoon.ui").nav_file(1)<CR>' )
vim.keymap.set('n',  "'s",        '<cmd>lua require("harpoon.ui").nav_file(1)<CR>' )
vim.keymap.set('n',  "'a",        '<cmd>lua require("harpoon.ui").nav_file(1)<CR>' )
