return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-telescope/telescope-file-browser.nvim',
  'neovim/nvim-lspconfig',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  'nvim-tree/nvim-web-devicons',
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000
  },
  'lewis6991/gitsigns.nvim',
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
  },
  {
  'stevearc/conform.nvim',
  opts = {},
  }
}
