-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: lazy.nvim
-- https://github.com/folke/lazy.nvim

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'AaronLasseigne/yank-code',

  -- LSP
  'neovim/nvim-lspconfig',
  { 'williamboman/mason.nvim', config = true },
  { 'williamboman/mason-lspconfig.nvim' },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
  },

  -- UI
  { 'ellisonleao/gruvbox.nvim', priority = 1000 },
  'nvim-tree/nvim-web-devicons',
  { 'nvim-tree/nvim-tree.lua', cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' } },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  'caenrique/nvim-maximize-window-toggle',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  'folke/trouble.nvim',

  -- Git support
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- File navigation
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'bogado/file-line',
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
  },

  -- Navigation
  {
    'ggandor/leap.nvim',
    config = function()
      vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)')
      vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)')
      vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
    end,
  },

  -- Ruby
  'vim-ruby/vim-ruby',
  'tpope/vim-rails',
  'tpope/vim-endwise',
  'AndrewRadev/splitjoin.vim',

  -- Tpope
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-eunuch',
  'tpope/vim-fugitive',

  -- Better escape
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup {
        mapping = { 'jk', 'jj' },
        timeout = vim.o.timeoutlen,
        clear_empty_lines = false,
        keys = '<Esc>',
      }
    end,
  },
}

require('lazy').setup(plugins)
