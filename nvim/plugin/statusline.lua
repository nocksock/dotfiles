local function lsp_filetype ()
  if vim.lsp.buf.server_ready() then
    return vim.bo.filetype .. "+"
  else
    return vim.bo.filetype
  end
end

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {},
    globalstatus = false,
  },
  sections = {
    lualine_a = {{'mode', fmt = function (str)
      return str:sub(1,3)
    end}},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'%(%m%r%h %)%-10.30f%q'},
    lualine_x = {'location'},
    lualine_y = {lsp_filetype},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'%-10.30f%q'},
    lualine_x = {'location'},
    lualine_y = {lsp_filetype},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
