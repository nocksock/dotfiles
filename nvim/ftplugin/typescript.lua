vim.cmd.runtime({"ftplugin/javascript.lua",  bang = true })

vim.cmd('compiler tsc')
vim.opt_local.makeprg = 'pnpm exec tsc --noEmit'
vim.opt_local.foldmethod = 'marker'
