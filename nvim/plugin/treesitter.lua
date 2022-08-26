require('nvim-ts-autotag').setup({ update_on_insert = true })
require("nvim-surround").setup()

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "astro",
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
    "markdown",
    "php",
    "prisma",
    "query",
    "swift",
    "toml",
    "tsx",
    "typescript",
  },
  playground = {
    enable = true
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" }
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["is"] = "@block.inner",
        ["as"] = "@block.outer",
      },
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
})
