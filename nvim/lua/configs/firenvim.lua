vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never"
        }
    }
}

if vim.g.started_by_firenvim then
  vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, {
    nested = true,
    command = "write"
  })
end
