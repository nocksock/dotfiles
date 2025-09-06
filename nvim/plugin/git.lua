require 'baggage'.from 'https://github.com/lewis6991/gitsigns.nvim'

vim.pack.add({"https://github.com/pwntester/octo.nvim"})
require 'octo'.setup {}

local nmap = function(keys, command)
  vim.keymap.set({ "n" }, keys, command)
end

local action = function(builtin)
  return function() require('gitsigns.actions')[builtin]() end
end

require 'gitsigns'.setup {}


-- nmap(  "<leader>hD" <cmd>lua require "gitsigns".diffthis("~")<cr> )
-- nmap(  "<leader>hb" <cmd>lua require("gitsigns").blame_line { full=true }<cr> )

nmap("[h", action "prev_hunk")
nmap("]h", action "next_hunk")
nmap("<leader>hR", action "reset_buffer")
nmap("<leader>hS", action "stage_buffer")
nmap("<leader>hd", action "diffthis")
nmap("<leader>hp", action "preview_hunk")
nmap("<leader>hr", action "reset_hunk")
nmap("<leader>hs", action "stage_hunk")
nmap("<leader>hu", action "undo_stage_hunk")
nmap("<leader>cc", "<cmd>Git commit --verbose<cr>")

vim.keymap.set({ "o", "x" }, "ic", action "select_hunk");
