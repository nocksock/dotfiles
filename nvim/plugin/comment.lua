local comment = require "baggage".from('https://github.com/numToStr/Comment.nvim')
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    comment.load().setup()
    comment.load('Comment.ft').set('jq', '#%s')
  end
})
