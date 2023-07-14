local M = {}

function M.capabilities()
  local cmp_nvim_lsp = require('cmp_nvim_lsp')
  local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
  return capabilities
end

M.handlers = {
      ["window/progress"] = function(params, client_id, bufnr, config)
    params.value.title = "[" .. params.value.kind .. "] " .. params.value.title
    vim.lsp.util.window_progress(params, client_id, bufnr, config)
  end,
}

return M
