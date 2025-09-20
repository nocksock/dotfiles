local on_attach = function(_client, bufnr)
  vim.keymap.set("n", "gd", function()
    require("fzf-lua").lsp_workspace_symbols({ query = vim.fn.expand("<cword>") })
  end, { buffer = bufnr, noremap = true })
end

vim.lsp.config('expert', {
  cmd = { 'expert' },
  root_markers = { 'mix.exs', '.git' },
  filetypes = { 'elixir', 'eelixir', 'heex' },
})

vim.lsp.enable 'expert'
