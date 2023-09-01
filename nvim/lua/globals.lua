RELOAD = require("baggage").from("https://github.com/nvim-lua/plenary.nvim").require('plenary.reload').reload_module

R = function(name)
  RELOAD(name)
  return require(name)
end

P = function(v)
  print(vim.inspect(v))
  return v
end

-- vim: fen fdm=marker fdl=0
