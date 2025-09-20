vim.api.nvim_create_user_command('X', function()
    vim.cmd([[":execute getline('.')<cr>"]])
end, {})
