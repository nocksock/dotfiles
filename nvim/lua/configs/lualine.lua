require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { { 'mode' } },
    lualine_b = { { 'tabs', mode = 0, cond = function() return vim.fn.tabpagenr('$') > 1 end } },
    lualine_c = {
      { 'branch', padding = { left = 1, right = 0 }, separator = "", color = { fg = 8 } },
      {
        'filename',
        newfile_status = true,
        path = 1,
        symbols = {
          modified = '*',
          readonly = '',
          unnamed  = '[No Name]',
          newfile  = ' new',
        }
      }
    },
    lualine_x = {
      'diagnostics',
      { function() return vim.lsp.buf.server_ready() and "" or "no lsp" end },
    },
    lualine_y = { 'searchcount' },
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = { },
  extensions = {},
}
