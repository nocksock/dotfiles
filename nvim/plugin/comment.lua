vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    vim.cmd('packadd! Comment.nvim')
    require('Comment').setup()
    require('Comment.ft').set('jq', '#%s')
  end
})
