local function lsp_filetype ()
  if vim.lsp.buf.server_ready() then
    return "+" .. vim.bo.filetype
  else
    return vim.bo.filetype
  end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '·',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    globalstatus = false,
  },
  sections = {
    lualine_a = {{'mode', fmt = function (str)
      return str:sub(1,1)
    end}},
    lualine_b = {{'branch', icons_enabled = false}, 'diff', 'diagnostics'},
    lualine_c = {'%(%m%r%h %)%-10.30f%q'},
    lualine_x = {'location', '%n'},
    lualine_y = {lsp_filetype},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'%-10.30f%q'},
    lualine_x = {'%n'},
    lualine_y = {lsp_filetype},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
