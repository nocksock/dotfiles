return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("rose-pine").setup()
      vim.cmd('colorscheme rose-pine')
      vim.g.colors_name = 'rose-pine'
    end
  },
  { 'folke/tokyonight.nvim', event = "VeryLazy" },
  { 'rktjmp/lush.nvim',      event = "VeryLazy" },
  { 'nocksock/bloop.nvim',   dev = true,    event = "VeryLazy" },
  { 'nocksock/nazgul-vim',   dev = true,    event = "VeryLazy" },
  { 'nocksock/ghash.nvim',   dev = true,    event = "VeryLazy" },
}
