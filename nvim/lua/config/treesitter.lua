-- ================================
-- Treesitter Configuration
-- ================================
local parsers = { "elixir", "go", "lua", "javascript", "typescript", "python", "gleam", "vue", "markdown", "json" }

require('nvim-treesitter').install(parsers)

-- Start highlighting for any filetype that has an installed parser
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Folding powered by treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false
