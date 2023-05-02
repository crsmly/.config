require('plugins')
local builtin = require('telescope.builtin')

-- Theme
vim.cmd.colorscheme "catppuccin"
-- Relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- 4 space tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- ---- KEYBINDS ---- --
-- Bind space to leader key
vim.g.mapleader = ' '

-- telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Bind 'jk' to enter command mode in insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true})
