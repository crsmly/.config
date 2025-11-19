-- ================================
-- Treesitter Configuration
-- ================================
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"elixir","go", "lua", "javascript","typescript", "python", "gleam", "vue", "markdown", "json"},

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Folding powered by treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
