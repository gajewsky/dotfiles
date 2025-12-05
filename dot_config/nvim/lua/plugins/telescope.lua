-----------------------------------------------------------
-- Telescope configuration file
-----------------------------------------------------------

-- Plugin: telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim

local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    prompt_prefix = '  ',
    selection_caret = ' ',
    path_display = { 'truncate' },
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        ['<Esc>'] = actions.close,
      },
    },
    file_ignore_patterns = {
      'node_modules',
      '.git/',
      'vendor/',
      '%.lock',
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
    },
    live_grep = {
      additional_args = function()
        return { '--hidden', '--glob', '!.git/*' }
      end,
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ['<C-d>'] = actions.delete_buffer,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}

-- Load fzf extension for better performance
telescope.load_extension('fzf')

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>f', builtin.find_files, opts)
map('n', '<leader>F', builtin.git_files, opts)
map('n', '<leader>a', builtin.live_grep, opts)
map('n', '<leader>b', builtin.buffers, opts)
map('n', '<leader>t', builtin.builtin, opts)
map('n', '<leader>/', builtin.current_buffer_fuzzy_find, opts)
map('n', '<leader>s', builtin.lsp_document_symbols, opts)
map('n', '<leader>S', builtin.lsp_workspace_symbols, opts)
map('n', '<leader>d', builtin.diagnostics, opts)
map('n', '<leader>h', builtin.help_tags, opts)
map('n', '<leader>gc', builtin.git_commits, opts)
map('n', '<leader>gb', builtin.git_branches, opts)
map('n', '<leader>gs', builtin.git_status, opts)
