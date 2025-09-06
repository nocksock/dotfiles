require 'baggage'.from('https://github.com/ibhagwan/fzf-lua')

require('fzf-lua').setup({
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

nmap('<leader>q', fzf('files', {
  cmd = "cat ~/file_index",
  cwd = "~/"
}))

--
-- nmap('<leader>f', fzf 'files')
-- nmap('<leader>*', fzf 'grep_cWORD')
-- nmap('<leader>g', fzf 'live_grep')
-- nmap('<leader><leader>', fzf('buffers'))
-- nmap('<leader>:', fzf 'commands')
-- nmap('<leader>S', fzf 'lsp_live_workspace_symbols')
-- nmap('<leader>s', fzf 'lsp_document_symbols')
-- nmap('<leader>/', fzf 'lgrep_curbuf')
-- nmap('<leader><c-r>', fzf 'command_history')
-- nmap('<leader>H', fzf 'help_tags')
-- nmap('<leader><cr>', fzf 'resume')
-- nmap('<leader>C', fzf 'colorschemes')
-- nmap('<leader>T', fzf 'builtin')
--
--
-- -- nmap('<leader>\'', '<cmd>argadd<cr>')
-- -- nmap('ú', '<cmd>1argu<cr>')
-- -- nmap('ĳ', '<cmd>2argu<cr>')
-- -- nmap('ø', '<cmd>3argu<cr>')
-- -- nmap('°', '<cmd>4argu<cr>')
-- -- nmap('<leader>a', fzf 'args')
--
-- vim.keymap.set({ 'n' }, '<leader>A', function()
--   local filename = vim.fn.expand('%:t:r');
--   require('fzf-lua').files({
--     cmd = "fd '" .. filename .. "'"
--   })
-- end)
--
--
vim.keymap.set({ "i" }, "<C-x><C-f>",
  function()
    require("fzf-lua").complete_file({
      cmd = "fd ",
      winopts = { preview = { hidden = "nohidden" } }
    })
  end, { silent = true, desc = "Fuzzy complete file" })
