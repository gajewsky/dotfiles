-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua

local api = vim.api
local g = vim.g

-- Set whether or not to show certain icons.
g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
}

-- Customize icons.
g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '',
    staged = '',
    unmerged = '',
    renamed = '',
    deleted = '',
    untracked = '',
    ignored = '',
  },
  folder = {
    default = '',
    open = '',
    symlink = '',
  },
}

-- Only show the current folder as the root instead of full path.
g.nvim_tree_root_folder_modifier = ':t'

-- Highlight nodes according to current git status.
g.nvim_tree_git_hl = 1

-- Enable indent markers.
g.nvim_tree_indent_markers = 1

require('nvim-tree').setup{
  update_cwd = true,
  hijack_cursor = true,
  git = {
    ignore = false,
  },
}
