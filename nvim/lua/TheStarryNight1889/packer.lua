-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {'github/copilot.vim'}
  use {'neovim/nvim-lsp'}
  use {'neovim/nvim-lspconfig'}
  use {'nvim-telescope/telescope.nvim'}
  use {'nvim-treesitter/nvim-treesitter'}
  use {'nvim-lua/plenary.nvim'}
end)
