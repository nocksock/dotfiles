local M = {}
local builtin = require('telescope.builtin')

M.register = function (client, bufnr)
  local cmd = function(name, func) vim.api.nvim_create_user_command(name, func, {}) end
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  cmd('Format', function()
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end)

  cmd('FixAll', function()
    if vim.lsp.buf.code_action then
      vim.lsp.buf.code_action({
        apply = true,
        filter = function(action)
          return action.command.command == "eslint.applyAllFixes"
        end
      })
    end
  end)

  -- highlight references under cursor {{{
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   callback = vim.lsp.buf.document_highlight,
    --   buffer = bufnr,
    --   group = "lsp_document_highlight",
    -- })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
  end
  --}}}

  -- mappings {{{
  nmap('<leader>ss', builtin.lsp_dynamic_workspace_symbols, 'workspace symbols')
  nmap('<M-r>', builtin.lsp_dynamic_workspace_symbols, 'workspace symbols')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action (vscodey)')
  nmap('<leader>ff', ':Format<cr>', 'format file')
  nmap('<leader>fa', ':FixAll<cr>', 'fix all autofixables')

  nmap('[d', vim.diagnostic.goto_prev)
  nmap(']d', vim.diagnostic.goto_next)
  nmap("[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
  nmap("]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
  nmap("<leader>K", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
  nmap("<leader>J", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end)

  nmap('<leader>k', vim.diagnostic.goto_prev)
  nmap('<leader>j', vim.diagnostic.goto_next)
  nmap('<leader>e', vim.diagnostic.open_float)
  nmap('<leader>q', vim.diagnostic.setloclist)
  nmap("<leader>K", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
  nmap("<leader>J", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end)

  nmap('<leader>e', vim.diagnostic.open_float)
  nmap('<leader>q', vim.diagnostic.setloclist)
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
  nmap('<leader>ds', builtin.lsp_document_symbols, 'document symbols')
  nmap('<leader>rn', vim.lsp.buf.rename, 'rename symbol')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'add folder to workspace')
  nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    'list workspace folders')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'remove workspace folder')
  nmap('gr', require('telescope.builtin').lsp_references)

  nmap('gd', vim.lsp.buf.definition, 'goto definition')
  nmap('gD', vim.lsp.buf.declaration, 'goto Declaration')
  nmap('gi', vim.lsp.buf.implementation, 'goto implementation')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- preview
  nmap('gpd', require('goto-preview').goto_preview_definition)
  nmap('gpi', require('goto-preview').goto_preview_implementation)
  nmap('gpt', require('goto-preview').goto_preview_type_definition)
  nmap('gpr', require('goto-preview').goto_preview_references)
  nmap('gP', require('goto-preview').close_all_win)
  --}}}
end

return M
