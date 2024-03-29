-- BOOTSTRAP PACKER -----------------------------------------------------------
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- PACKER CONFIG --------------------------------------------------------------
return require('packer').startup(function()
  -- Packer can manage itself
  -- https://github.com/wbthomason/packer.nvim
  use 'wbthomason/packer.nvim'

  -- TREESITTER RELATED -------------------------------------------------------

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    branch = '0.5-compat'
  }

  use {
    'p00f/nvim-ts-rainbow',
    requires = 'nvim-treesitter/nvim-treesitter'
  }

  -- LSP RELATED --------------------------------------------------------------

  -- LSP Config
  use {
    'neovim/nvim-lspconfig',
    as = 'lspconfig'
  }

  -- LSPINSTALL
  use { 'williamboman/nvim-lsp-installer', require = 'lspconfig' }

  -- AUTOCOMPLETION
  use 'hrsh7th/nvim-compe'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- TELESCOPE ----------------------------------------------------------------

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'}
    }
  }

  -- THEME RELATED ------------------------------------------------------------

  -- MATERIAL THEME
  use 'marko-cerovac/material.nvim'

  -- ICONS
  use 'kyazdani42/nvim-web-devicons'

  -- TREE
  use 'preservim/nerdtree'

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup {
        options = {
          theme = 'material-nvim'
        }
      }
    end
  }

  -- OTHER --------------------------------------------------------------------

  -- Fugitive
  use 'tpope/vim-fugitive'

  -- vim-test
  use 'vim-test/vim-test'

  -- vim-unimpaired
  use 'tpope/vim-unimpaired'

  -- Super sexy colour highlighter
  use 'norcalli/nvim-colorizer.lua'

  -- Elixir support
  use 'elixir-editors/vim-elixir'

  -- Git helpers
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }
end)
