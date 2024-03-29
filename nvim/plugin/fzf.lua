require 'baggage'.from('https://github.com/ibhagwan/fzf-lua')

R 'fzf-lua'.setup({
  winopts = {
    preview = {
      layout = "vertical"
    }
  }
})

local fzf = function(builtin, opts)
  return function() require('fzf-lua')[builtin](opts or {}) end
end

local nmap = function(keys, command)
  vim.keymap.set({ "n" }, keys, command)
end

nmap('<leader>w', function()
end)

nmap('<leader>f', fzf 'files')
nmap('<leader>*', fzf 'grep_cWORD')
nmap('<leader>g', fzf 'live_grep')
nmap('<leader><leader>', fzf 'buffers')
nmap('<leader>:', fzf 'commands')
nmap('<leader>S', fzf 'lsp_live_workspace_symbols')
nmap('<leader>s', fzf 'lsp_document_symbols')
nmap('<leader>/', fzf 'lgrep_curbuf')
nmap('<leader><c-r>', fzf 'command_history')
nmap('<leader>H', fzf 'help_tags')
nmap('<leader><cr>', fzf 'resume')
nmap('<leader>C', fzf 'colorschemes')
nmap('<leader>T', fzf 'builtin')

nmap('<leader>a', '<cmd>argadd<cr>')
nmap('©', '<cmd>1argu<cr>')
nmap('×', '<cmd>2argu<cr>')
nmap('‘', '<cmd>3argu<cr>')
nmap('’', '<cmd>4argu<cr>')
nmap('<leader>b', fzf 'args')


vim.keymap.set({ "i" }, "<C-x><C-f>",
  function()
    require("fzf-lua").complete_file({
      cmd = "rg --files",
      winopts = { preview = { hidden = "nohidden" } }
    })
  end, { silent = true, desc = "Fuzzy complete file" })
