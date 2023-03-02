
  return {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
        require("rose-pine").setup()
        vim.cmd('colorscheme rose-pine')
        -- vim.g.colors_name = 'rose-pine'
    end
  }
