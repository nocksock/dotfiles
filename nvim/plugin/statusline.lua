local function root_name()
   return string.match(vim.fn.getcwd(), "/([%w-_ ]+)$") or ""
end

local function lsp_status()
  return vim.lsp.buf.server_ready() and "%y+" or "%y"
end

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {root_name, 'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {lsp_status},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
