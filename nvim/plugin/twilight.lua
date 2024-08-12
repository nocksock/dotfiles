local baggage = require "baggage".from {
  "https://github.com/folke/zen-mode.nvim",
  "https://github.com/folke/twilight.nvim"
}

baggage.setup("twilight", {})
baggage.setup("zen-mode", {})
