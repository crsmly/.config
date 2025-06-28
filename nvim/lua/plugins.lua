return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
  	'nvim-telescope/telescope.nvim',
  	  requires = { {'nvim-lua/plenary.nvim'} }
	}
    use "nvim-telescope/telescope-file-browser.nvim"
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' 
    use 'hrsh7th/cmp-nvim-lsp' 
    use 'nvim-treesitter/nvim-treesitter'
    use "nvimtools/none-ls.nvim"
    use 'nvim-tree/nvim-web-devicons'
    use 'tpope/vim-commentary'
    use 'ellisonleao/gruvbox.nvim'
end)
