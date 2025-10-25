require 'baggage'.from('https://github.com/nocksock/t.nvim/').setup({})


local group = vim.api.nvim_create_augroup('terminal', { clear = true })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = group,
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end
})
