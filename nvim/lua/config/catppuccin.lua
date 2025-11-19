-- ================================
-- Catppuccin Theme Configuration
-- ================================
vim.o.background = "light"
require("catppuccin").setup({
  no_italic = true,
})
vim.cmd([[colorscheme catppuccin-latte]])
