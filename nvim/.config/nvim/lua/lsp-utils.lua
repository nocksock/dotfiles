local baggage = require "baggage"
    .from {
      "https://github.com/nvim-lua/plenary.nvim",
      'https://github.com/neovim/nvim-lspconfig',
      'https://github.com/hrsh7th/cmp-nvim-lsp'
    }

local M = {
  capabilities = require "cmp_nvim_lsp".default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args) return M.on_attach(args) end
})

M.on_attach = function(args, fn)
  local bufnr = args.buf
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- NOTE: usually checking if client_server_capabilities.completionProvider is
  -- true, but I want to see a proper error message if it's not, and not
  -- fallback to default (tag|omni)func
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"
  vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr()"

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

  vim.keymap.set('n', '<leader>j', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<leader>k', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', "<leader>J",
    function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, bufopts)
  vim.keymap.set('n', "<leader>K",
    function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', "]D", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    bufopts)
  vim.keymap.set('n', "[D", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    bufopts)

  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>q', ':Diagnostics<cr>', bufopts)
  vim.keymap.set('n', '<leader>Q', ':Diagnostics error<cr>', bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

  vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', bufopts)
  vim.keymap.set('n', 'gi', ':Telescope lsp_type_implementations<cr>', bufopts)
  vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration<cr>', bufopts)
  vim.keymap.set('n', 'gO', ':Telescope lsp_document_symbols<cr>', bufopts)

  vim.keymap.set('n', '<c-w>d', ':vs<cr>:lua vim.lsp.buf.definition()<cr>zt', bufopts)
  vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<cr>zt', bufopts)
  vim.keymap.set('n', '<c-w>D', ':vs<cr>:lua vim.lsp.buf.declaration()<cr>zt', bufopts)
  vim.keymap.set('n', '<c-w>t', ':vs<cr>:lua vim.lsp.buf.type_definition()<cr>zt', bufopts)
  vim.keymap.set('n', '<c-w>i', ':vs<cr>:lua vim.lsp.buf.implementation()<cr>zt', bufopts)
  vim.keymap.set('i', '<c-]>', vim.lsp.buf.signature_help)

  if type(fn) == 'function' then
    fn(args)
  end
end

function M.file_exists(filename)
  local buffer_dir = vim.fn.fnamemodify(vim.api.nvim_get_current_buf(), ':h')
  local full_path = buffer_dir .. '/' .. filename
  return vim.fn.filereadable(full_path) == 1
end

function M.some_file_exists(...)
  local files = { ... }

  for _, file in ipairs(files) do
    if M.file_exists(file) then
      return true
    end
  end

  return false
end

function M.has_root_file(...)
  local res = vim.fs.find({ ... }, { type = 'file', upward = true })
  return #res > 0
end

--- check if language server is attached to current buffer
function M.is_attached(name)
  local client = vim.lsp.get_clients({ name = name, bufnr = vim.api.nvim_get_current_buf() })[1]
  return client ~= nil
end

return M
