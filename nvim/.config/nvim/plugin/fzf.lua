require 'baggage'.from('https://github.com/ibhagwan/fzf-lua')

-- Setup {{{
require('fzf-lua').setup({
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<M-Esc>"]    = "hide",
      ["<F1>"]       = "toggle-help",
      ["<F2>"]       = "toggle-fullscreen",
      ["<F3>"]       = "toggle-preview-wrap",
      ["<F4>"]       = "toggle-preview",
      ["<F5>"]       = "toggle-preview-cw",
      ["<F6>"]       = "toggle-preview-behavior",
      ["<F7>"]       = "toggle-preview-ts-ctx",
      ["<F8>"]       = "preview-ts-ctx-dec",
      ["<F9>"]       = "preview-ts-ctx-inc",
      ["<c-d>"]      = "preview-page-down",
      ["<c-u>"]      = "preview-page-up",
    },
    fzf              = {
      -- fzf '--bind=' options
      ["ctrl-z"]     = "abort",
      ["ctrl-u"]     = "unix-line-discard",
      ["ctrl-f"]     = "half-page-down",
      ["ctrl-b"]     = "half-page-up",
      ["ctrl-a"]     = "beginning-of-line",
      ["ctrl-e"]     = "end-of-line",
      ["alt-a"]      = "toggle-all",
      ["alt-g"]      = "first",
      ["alt-G"]      = "last",
      ["f3"]         = "toggle-preview-wrap",
      ["f4"]         = "toggle-preview",
      ["shift-down"] = "preview-page-down",
      ["shift-up"]   = "preview-page-up",
    },
  },
  winopts = {
    preview = {
      vertical       = "up:60%",
      layout         = "vertical",
    }
  }
})
-- }}}

-- thunk that calls the given fzf-lua builtin with optional opts
local fzf = function(builtin, opts) return function() require('fzf-lua')[builtin](opts or {}) end end

vim.keymap.set({'n'} , '<c-b>'         , fzf 'buffers')
vim.keymap.set({'n'} , '<leader>*'     , fzf 'grep_cWORD')
vim.keymap.set({'n'} , '<leader>*'     , fzf 'grep_cword');
vim.keymap.set({'n'} , '<leader>/'     , fzf 'lgrep_curbuf')
vim.keymap.set({'n'} , '<leader>:'     , fzf 'commands')
vim.keymap.set({'n'} , '<leader><c-r>' , fzf 'command_history')
vim.keymap.set({'n'} , '<leader><cr>'  , fzf 'resume')
vim.keymap.set({'n'} , '<leader>A'     , '<cmd>argadd<cr>')
vim.keymap.set({'n'} , '<leader>C'     , fzf 'colorschemes')
vim.keymap.set({'n'} , '<leader>H'     , fzf 'help_tags')
vim.keymap.set({'n'} , '<leader>S'     , fzf 'lsp_live_workspace_symbols')
vim.keymap.set({'n'} , '<leader>T'     , fzf 'builtin')
vim.keymap.set({'n'} , '<leader>M'     , fzf 'keymaps')
vim.keymap.set({'n'} , '<leader>a'     , fzf 'args')
vim.keymap.set({'n'} , '<leader>f'     , fzf 'files');
vim.keymap.set({'n'} , '<leader>g'     , fzf 'live_grep')
vim.keymap.set({'n'} , '<leader>s'     , fzf 'lsp_document_symbols')
vim.keymap.set({'n'} , '<leader>F'     , ':FzfLua<cr>')

vim.keymap.set({'n'}, '<leader>E', function()
  local filename = vim.fn.expand('%:t:r');
  require('fzf-lua').files({
    cmd = "fd '" .. filename .. "'"
  })
end)

vim.keymap.set({ "i" }, "<C-x><C-f>", function()
  require("fzf-lua").complete_file({
    cmd = "fd",
    winopts = { preview = { hidden = "nohidden" } }
  })
end, { silent = true, desc = "Fuzzy complete file" })
