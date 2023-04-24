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
  { 'folke/tokyonight.nvim', lazy = true },
  { 'rktjmp/lush.nvim',      lazy = true },
  { 'nocksock/bloop.nvim',   dev = true,    lazy = true },
  { 'nocksock/nazgul-vim',   dev = true,    lazy = true },
  { 'nocksock/ghash.nvim',   dev = true,    lazy = true },
}
