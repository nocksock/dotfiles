require "lspconfig".cssls.setup {
  settings = {
    css = { validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
  }
}
