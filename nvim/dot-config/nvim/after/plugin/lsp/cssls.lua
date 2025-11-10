vim.lsp.config("cssls",{
  settings = {
    css = { 
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
  }
})
