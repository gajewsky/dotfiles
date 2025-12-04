-----------------------------------------------------------
-- Statusline configuration file
-----------------------------------------------------------

-- Plugin: lualine.nvim
-- https://github.com/nvim-lualine/lualine.nvim

require('lualine').setup {
  options = {
    theme = 'gruvbox',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'NvimTree' },
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = '⚠ ', warn = ' ', info = ' ', hint = ' ' },
      },
    },
    lualine_c = {
      {
        'filename',
        path = 1, -- relative path
        symbols = { modified = ' ●', readonly = ' ' },
      },
    },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
}
