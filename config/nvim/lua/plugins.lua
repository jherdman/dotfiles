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
    run = ':TSUpdate'
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
  use { 'kabouzeid/nvim-lspinstall', requires = 'lspconfig' }

  -- LIGHTBULB
  use 'kosayoda/nvim-lightbulb'

  -- AUTOCOMPLETION
  use 'hrsh7th/nvim-compe'

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

  -- DASHBOARD
  use 'glepnir/dashboard-nvim'

  -- TREE
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
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
end)
