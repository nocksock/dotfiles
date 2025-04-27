--- When yanking, highlight the text that was yanked.
--- useful feedback when using `yip` etc
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = group,
  pattern = '*',
})

