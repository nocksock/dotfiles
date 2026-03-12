require "baggage".from {
    'https://github.com/elixir-tools/elixir-tools.nvim'
}

local on_attach = function(_client, bufnr)
    vim.keymap.set("n", "gd", function()
        require("fzf-lua").lsp_workspace_symbols({ query = vim.fn.expand("<cword>") })
    end, { buffer = bufnr, noremap = true })
end

require('lspconfig').lexical.setup {
  cmd = { "/home/nr/.local/bin/expert", "--stdio" },
  root_dir = function(fname)
    return require('lspconfig').util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
  end,
  filetypes = { "elixir", "eelixir", "heex" },
  -- optional settings
  settings = {}
}
