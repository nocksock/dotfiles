local bag = require "baggage".from {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/IndianBoy42/tree-sitter-just'
}

local opts = {
  highlight = { enable = true },
  indent = { enable = false },     -- vim's is smartindent is better than treesitter's indent
  context_commentstring = { enable = true, enable_autocmd = false },
  ensure_installed = {
    "astro",
    "bash",
    "c",
    "comment",
    "elixir",
    "fennel",
    "go",
    "html",
    "javascript",
    "json",
    "json5",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
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
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      goto_next_start = {
        ["]f"] = "@function.outer",
      },
      goto_prev_start = {
        ["[f"] = "@function.outer",
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v',         -- charwise
        ['@function.outer'] = 'V',          -- linewise
        ['@class.outer'] = '<c-v>',         -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
  },
}

---@type table<string, boolean>
local added = {}
opts.ensure_installed = vim.tbl_filter(function(lang)
  if added[lang] then
    return false
  end
  added[lang] = true
  return true
  ---@diagnostic disable-next-line: param-type-mismatch
end, opts.ensure_installed)

vim.api.nvim_create_autocmd("BufEnter", {
    callback = bag.lazily('nvim-treesitter.configs', opts)
})

---@class ParserInfo[]
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.caddyfile = {
  install_info = {
    url = "/home/code/tree-sitter-caddy", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = true, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
  },
  filetype = "zu", -- if filetype does not match the parser name
}
