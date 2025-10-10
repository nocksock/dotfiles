local group = vim.api.nvim_create_augroup('insert-nu-rnu-swap', { clear = true })

vim.api.nvim_create_autocmd('insertenter', {
  callback = function()
    if vim.o.nu then
      vim.o.rnu = false
    end
    vim.o.list = true
    vim.wo.colorcolumn = '80'
  end,
  group = group,
})

vim.api.nvim_create_autocmd('insertleave', {
  callback = function()
    if vim.o.nu then
      vim.o.rnu = true
    end
    vim.o.list = false
    vim.wo.colorcolumn = ''
  end,
  group = group,
})

