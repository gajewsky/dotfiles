-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local cmd = vim.cmd

-----------------------------------------------------------
-- Vim shortcuts:
-----------------------------------------------------------

-- clear search highlighting
map('n', '<leader>c', ':nohl<CR>', default_opts)

-- don't use arrow keys
map('', '<up>', '<C-W>+', {noremap = true})
map('', '<down>', '<C-W>-', {noremap = true})
map('', '<left>', '3<C-W><', {noremap = true})
map('', '<right>', '3<C-W>>', {noremap = true})

-- fast saving with c-s
map('n', '<C-s>', ':update<CR>', default_opts)
map('i', '<C-s>', '<ESC>:update<CR>', default_opts)

-- move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- close all windows and exit from neovim
map('n', '<leader>q', ':quitall<CR>', default_opts)

-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------

-- nvim-tree
map('n', '\\', ':NvimTreeToggle<CR>', default_opts)       -- open/close
map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>', default_opts) -- search file

-- fzf
map('n', '<leader>f', ':Files<CR>', default_opts)
map('n', '<leader>F', ':GFiles<CR>', default_opts)
map('n', '<leader>a', ':Rg<Space>', default_opts)

