-- testing the lua autocommands
local group = vim.api.nvim_create_augroup('ToggleListInsertLeave', { clear = true })

vim.api.nvim_create_autocmd('InsertEnter', { command = 'set list', group = group })
vim.api.nvim_create_autocmd('InsertLeave', { command = 'set nolist', group = group })
