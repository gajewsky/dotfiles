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

-- Don't use arrow keys
map('', '<up>', '<C-W>+', {noremap = true})
map('', '<down>', '<C-W>-', {noremap = true})
map('', '<left>', '3<C-W><', {noremap = true})
map('', '<right>', '3<C-W>>', {noremap = true})

-- fast saving with c-s
map('n', '<C-s>', ':update<CR>', default_opts)
map('i', '<C-s>', '<ESC>:update<CR>', default_opts)

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- Close all windows and exit from neovim
map('n', '<leader>q', ':quitall<CR>', default_opts)

-- New tab
map('n', '<C-t>', '<esc>:tabnew<CR>', default_opts)

-- Move visual block
map('v', 'J', ':m \'>+1<CR>gv=gv', {noremap = true})
map('v', 'K', ':m \'<-2<CR>gv=gv', {noremap = true})

-- Re-select visual block after indenting
map('v', '<', '<gv', {noremap = true})
map('v', '>', '>gv', {noremap = true})

-- BOL & EOL
map('n', 'H', '^', default_opts)
map('n', 'L', '$', default_opts)

-- Go substitute because the default map for sleeping is silly
map('', 'gs', ':%s/<c-r><c-w>//gc<Left><Left><Left>', default_opts)

-- Keep the cursor in place while joining lines
map('', 'J', 'mzJ`z', {noremap = true})

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

-- nvim-maximize-window-toggle
map('', '<leader>o', ':ToggleOnly<Enter>', {noremap = true})

-- lspsaga
map('', 'gh', ':Lspsaga lsp_finder<CR>', default_opts)
map('', 'gn', ':Lspsaga rename<CR>', default_opts)
