-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- Bootstrap packer.nvim if not installed

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- packer can manage itself
  use 'windwp/nvim-autopairs'
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  use 'unblevable/quick-scope'
  use 'AaronLasseigne/yank-code'

  -- Completion
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  -- UI
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'Yggdroot/indentLine'
  use 'justincampbell/vim-eighties'
  use 'caenrique/nvim-maximize-window-toggle'
  use 'junegunn/vim-peekaboo'
  use 'psliwka/vim-smoothie'
  use 'folke/lsp-colors.nvim'


  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  -- File navigation
  use { 'junegunn/fzf', run = './install --bin' }
  use 'junegunn/fzf.vim'
  use 'christoomey/vim-tmux-navigator'
  use 'bogado/file-line'

  -- Ruby
  use 'vim-ruby/vim-ruby'
  use 'tpope/vim-rails'
  use 'tpope/vim-endwise'
  use  'AndrewRadev/splitjoin.vim'

  -- Tpope
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-rsi'
  use 'tpope/vim-eunuch'

  -- Plugins in testing faze
  use 'glepnir/lspsaga.nvim'
  use {
    requires = "kyazdani42/nvim-web-devicons",
  }
  use { 'famiu/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    "folke/trouble.nvim",
  }
end)
