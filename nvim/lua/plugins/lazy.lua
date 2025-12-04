-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: lazy.nvim
-- https://github.com/folke/lazy.nvim

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
  'windwp/nvim-autopairs',
  'nvim-treesitter/nvim-treesitter',
  'AaronLasseigne/yank-code',

  -- LSP
  'neovim/nvim-lspconfig',
  'williamboman/nvim-lsp-installer',
  'folke/lsp-colors.nvim',

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- UI
  { "ellisonleao/gruvbox.nvim", dependencies = { "rktjmp/lush.nvim" } },
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',
  'Yggdroot/indentLine',
  'justincampbell/vim-eighties',
  'caenrique/nvim-maximize-window-toggle',
  'junegunn/vim-peekaboo',
  'psliwka/vim-smoothie',
  {
    'famiu/feline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  'folke/trouble.nvim',

  -- Git support
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- File navigation
  { 'junegunn/fzf', build = './install --bin' },
  'junegunn/fzf.vim',
  'christoomey/vim-tmux-navigator',
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'bogado/file-line',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Navigation
  'ggandor/lightspeed.nvim',
  'unblevable/quick-scope',

  -- Ruby
  'vim-ruby/vim-ruby',
  'tpope/vim-rails',
  'tpope/vim-endwise',
  'AndrewRadev/splitjoin.vim',

  -- Tpope
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-rsi',
  'tpope/vim-eunuch',
  'tpope/vim-fugitive',

  -- Javascript
  'pangloss/vim-javascript',
  'leafgarland/typescript-vim',
  'peitalin/vim-jsx-typescript',
  'styled-components/vim-styled-components',
  'jparise/vim-graphql',

  -- Plugins in testing phase
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "jj" },
        timeout = vim.o.timeoutlen,
        clear_empty_lines = false,
        keys = "<Esc>",
      }
    end,
  },
}

require("lazy").setup(plugins)
