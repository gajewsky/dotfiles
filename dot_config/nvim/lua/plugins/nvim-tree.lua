-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua

local nvim_tree = require('nvim-tree')

local function tail(path)
  return vim.fn.fnamemodify(path, ':t')
end

nvim_tree.setup {
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  hijack_cursor = true,
  git = {
    enable = true,
    ignore = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  renderer = {
    root_folder_label = tail,
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false, -- match previous config that hid git icons
      },
      glyphs = {
        default = '',
        symlink = '',
        folder = {
          default = '',
          open = '',
          symlink = '',
        },
      },
    },
  },
}
