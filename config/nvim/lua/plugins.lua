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

  -- TREESITTER
  -- https://github.com/nvim-treesitter/nvim-treesitter
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

  -- LSPSAGA
  use { 'glepnir/lspsaga.nvim', requires = 'lspconfig' }

  use { 'kabouzeid/nvim-lspinstall', requires = 'lspconfig' }

  -- TELESCOPE
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'}
    }
  }

  -- LIGHTBULB
  use 'kosayoda/nvim-lightbulb'

  -- MATERIAL THEME
  use 'marko-cerovac/material.nvim'

  use 'kyazdani42/nvim-web-devicons'

  -- Fugitive
  use 'tpope/vim-fugitive'

  -- DASHBOARD
  use 'glepnir/dashboard-nvim'

  -- TREE
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- vim-test
  use 'vim-test/vim-test'
end)
