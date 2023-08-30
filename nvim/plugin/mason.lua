vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    vim.cmd('packadd! mason.nvim')
    require("mason").setup {}
  end
})
