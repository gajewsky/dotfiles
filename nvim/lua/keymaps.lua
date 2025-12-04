-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-----------------------------------------------------------
-- Vim shortcuts:
-----------------------------------------------------------

-- Clear search highlighting
map('n', '<leader>c', ':nohl<CR>', opts)

-- Arrow keys resize windows
map('', '<up>', '<C-W>+', { noremap = true })
map('', '<down>', '<C-W>-', { noremap = true })
map('', '<left>', '3<C-W><', { noremap = true })
map('', '<right>', '3<C-W>>', { noremap = true })

-- Fast saving with c-s
map('n', '<C-s>', ':update<CR>', opts)
map('i', '<C-s>', '<ESC>:update<CR>', opts)

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Move around tabs
map('n', '<C-n>', ':tabnext<CR>', opts)
map('n', '<C-p>', ':tabprevious<CR>', opts)

-- Close all windows and exit from neovim
map('n', '<leader>q', ':quitall<CR>', opts)

-- New tab
map('n', '<C-t>', '<esc>:tabnew<CR>', opts)

-- Move visual block
map('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- Re-select visual block after indenting
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

-- BOL & EOL
map('n', 'H', '^', opts)
map('n', 'L', '$', opts)

-- Move cursor by display lines when wrapping
map('n', 'k', 'gk', opts)
map('n', 'j', 'gj', opts)

-- Go substitute because the default map for sleeping is silly
map('', 'gs', ':%s/<c-r><c-w>//gc<Left><Left><Left>', opts)

-- Keep the cursor in place while joining lines
map('', 'J', 'mzJ`z', { noremap = true })

-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------

-- nvim-tree
map('n', '\\', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>r', ':NvimTreeRefresh<CR>', opts)
map('n', '<leader>n', ':NvimTreeFindFile<CR>', opts)

-- nvim-maximize-window-toggle
map('', '<leader>o', ':ToggleOnly<Enter>', { noremap = true })
