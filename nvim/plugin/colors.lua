require "baggage"
  .from('https://github.com/rose-pine/neovim')
  .setup('rose-pine')

vim.g.moonlight_italic_comments = true
vim.g.moonlight_italic_keywords = true
vim.g.moonlight_italic_functions = true
vim.g.moonlight_italic_variables = false
vim.g.moonlight_contrast = true
vim.g.moonlight_borders = false
vim.g.moonlight_disable_background = false

require "baggage"
  .from "https://github.com/shaunsingh/moonlight.nvim"
  .load()

vim.cmd.colorscheme 'rose-pine'
