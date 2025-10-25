require "baggage".from {
  "https://github.com/yioneko/nvim-vtsls"
}

require("lspconfig.configs").vtsls = require("vtsls").lspconfig -- set default server config, optional but recommended

-- If the lsp setup is taken over by other plugin, it is the same to call the counterpart setup function
require("lspconfig").vtsls.setup({
  on_attach = require("lsp-utils").on_attach,
  autostart = false
})
