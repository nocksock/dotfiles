return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          end
        end,
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "astro",
        "bash",
        "c",
        "comment",
        "fennel",
        "go",
        "hcl",
        "html",
        "http",
        "javascript",
        "json",
        "json5",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "php",
        "prisma",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    'theprimeagen/refactoring.nvim', -- Treesitter powered refactorings
    keys = {
      { "<leader>rr", ":lua require('refactoring').select_refactor()<CR>", noremap = true, silent = true, expr = false },
      { "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], noremap = true, silent = true, expr = false },
      { "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], noremap = true, silent = true, expr = false },
      { "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],  noremap = true, silent = true, expr = false },
      { "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],  noremap = true, silent = true, expr = false },
      { "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],  noremap = true, silent = true, expr = false},
      { "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],  noremap = true, silent = true, expr = false },
    },
    {
      'nvim-treesitter/nvim-treesitter-context',   -- sticky header
      event = { "BufReadPost", "BufNewFile" },
    },
    {
      'nvim-treesitter/playground',                -- visual representation and query playground for the AST of TS
      event = { "BufReadPost", "BufNewFile" },
    },
    {
      'kylechui/nvim-surround',
      config = true, -- replacement of vim-surround with some neat features like `dsf` powered by TreeSitter
      event = { "BufReadPost", "BufNewFile" },
    }
  }
}

