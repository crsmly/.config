-- ================================
-- Catppuccin Theme Configuration
-- ================================
vim.o.background = "dark"
require("catppuccin").setup({
  flavour = "mocha",
  no_italic = true,
})
vim.cmd([[colorscheme catppuccin-mocha]])
