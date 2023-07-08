--
-- ʕ •ᴥ•ʔ 
--  This config is in between haircuts. 
--

-- Automatically install lazy.nvim when it is not yet installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require("configs.settings")

require('lazy').setup("plugins", {
  dev = {
    path = '~/code',
    fallback = true
  },
  change_detection = {
    enabled = false, -- I found this annoying when having multiple long running nvim sessions.
  },
})
