-----------------------------------------------------------
-- Statusline configuration file
-----------------------------------------------------------

-- Plugin: feline.nvim
-- https://github.com/famiu/feline.nvim

local colors = {
  bg1 = '#3c3836',
  bg2 = '#504945',
  fg = '#ebdbb2',
  red1 = '#cc241d',
  red2 = '#fb4934',
  green1 = '#98971a',
  green2 = '#b8bb26',
  yellow1 = '#d79921',
  yellow2 = '#fabd2f',
  blue1 = '#458588',
  blue2 = '#83a598',
  purple1 = '#b16286',
  purple2 = '#d3869b',
  aqua1 = '#689d6a',
  aqua2 = '#8ec07c',
  orange1 = '#d65d0e',
  orange2 = '#fe8019',
  gray = '#a89984',
}

local vi_mode_colors = {
  NORMAL = colors.gray,
  INSERT = colors.aqua2,
  VISUAL = colors.yellow1,
  OP = colors.green2,
  BLOCK = colors.green2,
  REPLACE = colors.red1,
  ['V-REPLACE'] = colors.red1,
  ENTER = colors.orange1,
  MORE = colors.orange1,
  SELECT = colors.gray,
  COMMAND = colors.green2,
  SHELL = colors.green2,
  TERM = colors.green1,
  NONE = colors.orange2,
  LINES = colors.orange2
}

local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local lsp_get_diag = function(str)
  local count = vim.lsp,diagnostic.get_count(0, str)
  return (count > 0) and ' '..count..' ' or ''
end

-- My components
local comps = {
  vi_mode = {
    left = {
      provider = function()
        local label = ' '..vi_mode_utils.get_vim_mode()..' '
        return label
      end,
      hl = function()
        local set_color = {
          name = vi_mode_utils.get_mode_highlight_name(),
          fg = colors.bg1,
          bg = vi_mode_utils.get_mode_color(),
          style = 'bold'
        }
        return set_color
      end,
      left_sep = ' ',
      right_sep = ' '
    }
  },
  file = {
    info = {
      provider = {
        name = 'file_info',
        opts = {
          type = 'relative',
          file_modified_icon = ''
        }
      },
      hl = { fg = colors.green2 },
      icon = '',
    },
  type = {
      provider = { name = 'file_type' },
    },
    os = {
      provider = function()
        local os = vim.bo.fileformat:lower()
        local icon = ' ◬  '
        return icon .. os
      end,
      hl = { fg = colors.fg },
      left_sep = ' ',
      right_sep = ' '
    },
    line_percentage = {
      provider = { name = 'line_percentage' },
      hl = {
        fg = colors.purple1
      },
      left_sep = ' ',
      right_sep = ' '
    },
    position = {
      provider = {name = 'position'},
      hl = {
        fg = colors.green2,
        style = 'bold'
      },
      right_sep = ' ',
    },
    scroll_bar = {
      provider = { name = 'scroll_bar' },
      hl = { fg = colors.green1 },
      left_sep = ' ',
      right_sep = ' '
    },
  },
  -- LSP info
  diagnos = {
    err = {
      provider = 'diagnostic_errors',
      icon = '⚠ ',
      hl = { fg = colors.red1 },
      left_sep = ' ',
    },
    warn = {
      provider = 'diagnostic_warnings',
      icon = ' ',
      hl = { fg = colors.yellow1 },
      left_sep = ' ',
    },
    info = {
      provider = 'diagnostic_info',
      icon = ' ',
      hl = { fg = colors.green1 },
      left_sep = ' ',
    },
    hint = {
      provider = 'diagnostic_hints',
      icon = ' ',
      hl = { fg = colors.green2 },
      left_sep = ' ',
    },
  },
  lsp = {
    name = {
      provider = 'lsp_client_names',
      icon = '  ',
      hl = { fg = colors.purple1 },
      left_sep = '  ',
    }
  },
  -- git info
  git = {
    branch = {
      provider = 'git_branch',
      icon = ' ',
      hl = { fg = colors.yellow2 },
      left_sep = '  ',
    },
    add = {
      provider = 'git_diff_added',
      icon = '  ',
      hl = { fg = colors.aqua2 },
      left_sep = ' ',

    },
    change = {
      provider = 'git_diff_changed',
      icon = '  ',
      hl = { fg = colors.orange2 },
      left_sep = ' ',
    },
    remove = {
      provider = 'git_diff_removed',
      icon = '  ',
      hl = { fg = colors.red1 },
      left_sep = ' ',
    }
  }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

-- Right section
table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.inactive[1], comps.file.info)

-- Left Section
table.insert(components.active[2], comps.diagnos.err)
table.insert(components.active[2], comps.diagnos.warn)
table.insert(components.active[2], comps.diagnos.hint)
table.insert(components.active[2], comps.diagnos.info)
table.insert(components.active[2], comps.lsp.name)
table.insert(components.active[2], comps.file.os)
table.insert(components.active[2], comps.file.line_percentage)
table.insert(components.active[2], comps.file.position)

require('feline').setup {
  colors = {
    bg = colors.bg1,
    fg = colors.fg
  },
  components = components,
  vi_mode_colors = vi_mode_colors,
  force_inactive = {
    filetypes = {
      'NvimTree',
      'vista',
      'term'
    },
    buftypes = {},
    bufnames = {},
  },
}
