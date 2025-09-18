require 'baggage'.from('https://github.com/ibhagwan/fzf-lua')

-- Setup {{{
require('fzf-lua').setup({
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<M-Esc>"]    = "hide",
      ["<F1>"]       = "toggle-help",
      ["<c-f>"]      = "toggle-fullscreen",
      ["<F3>"]       = "toggle-preview-wrap",
      ["<c-p>"]       = "toggle-preview",
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

vim.keymap.set({'n'} , '<c-b>'         , ':FzfLua buffers<cr>')
vim.keymap.set({'n'} , '<c-f>'         , ':FzfLua files<cr>')
vim.keymap.set({'n'} , '<leader>*'     , ':FzfLua grep_cWORD<cr>')
vim.keymap.set({'n'} , '<leader>*'     , ':FzfLua grep_cword<cr>')
vim.keymap.set({'n'} , '<leader>/'     , ':FzfLua lgrep_curbuf<cr>')
vim.keymap.set({'n'} , '<leader>:'     , ':FzfLua commands<cr>')
vim.keymap.set({'n'} , '<leader><c-r>' , ':FzfLua command_history<cr>')
vim.keymap.set({'n'} , '<leader><cr>'  , ':FzfLua resume<cr>')
vim.keymap.set({'n'} , '<leader>C'     , ':FzfLua colorschemes<cr>')
vim.keymap.set({'n'} , '<leader>H'     , ':FzfLua help_tags<cr>')
vim.keymap.set({'n'} , '<leader>S'     , ':FzfLua lsp_live_workspace_symbols<cr>')
vim.keymap.set({'n'} , '<leader>T'     , ':FzfLua builtin<cr>')
vim.keymap.set({'n'} , '<leader>M'     , ':FzfLua keymaps<cr>')
vim.keymap.set({'n'} , '<leader>f'     , ':FzfLua files<cr>')
vim.keymap.set({'n'} , '<leader>g'     , ':FzfLua live_grep<cr>')
vim.keymap.set({'n'} , '<leader>s'     , ':FzfLua lsp_document_symbols<cr>')
vim.keymap.set({'n'} , '<leader>F'     , ':FzfLua<cr><cr>')

vim.keymap.set({'n'} , '<leader>a'     , ':FzfLua args<cr>')
vim.keymap.set({'n'} , '<leader>A'     , ':argadd<cr><cr>')

vim.keymap.set({'n'}, '<leader>P', function()
  local filename = vim.fn.expand('%:t:r');
  require('fzf-lua').files({
    cmd = "fd '" .. filename .. "'"
  })
end)

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
