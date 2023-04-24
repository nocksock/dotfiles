return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function () 
      require "configs.cmp";
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- lsp source
      'hrsh7th/cmp-nvim-lua', -- neovim LUA Api source
      'hrsh7th/cmp-path',     -- path completions
      'hrsh7th/cmp-cmdline',  -- source for cmdline (:, /)
      'hrsh7th/cmp-buffer',   -- buffer source
      'L3MON4D3/LuaSnip',     -- the first snippet plugin to beat UltiSnips for me?
    }
  }
}
