require "baggage".from { 
  'https://github.com/elixir-tools/elixir-tools.nvim'
}

local on_attach = function(_client, bufnr)
  vim.keymap.set("n", "gd", function()
    require("fzf-lua").lsp_workspace_symbols({ query = vim.fn.expand("<cword>") })
  end, { buffer = bufnr, noremap = true })
end

require("elixir").setup({
  nextls = { enable = false },
  elixirls = { enable = true, on_attach = on_attach },
  projectionist = { enable = true, on_attach = on_attach },
})
