require "lspconfig".tailwindcss.setup {
  capabilities = capabilities,
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb"
    }
  },
  settings = {
    tailwindCSS = {
      experimental = {
        configFile = ".config/tailwind.config.js"
      },
      editor = {
        quickSuggestions = {
          strings = "on"
        }
      }
    }
  }
}
