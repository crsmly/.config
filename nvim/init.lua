require("config.lazy")
require('ls')
require('config.catppuccin')
require('config.telescope')
require('config.treesitter')
require('config.gitsigns')
require('config.blink-cmp')
require('config.conform')

-- Relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 4 space tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- line wrap
vim.opt.wrap = true

-- ---- KEYBINDS ---- --
-- Bind space to leader key
vim.g.mapleader = ' '

-- Bind 'jk' to enter command mode in insert mode
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, desc = '[Vim] Exit insert mode' })

-- Highlight current line
vim.opt.cursorline = true

-- Blinking Cursor
vim.opt.guicursor = {
  'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
  'i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100'
}

-- Persistent undo history
vim.opt.undofile = true

-- Faster split creation
vim.keymap.set('n', '<leader>.', ':vsplit<CR>', { noremap = true, silent = true, desc = '[Vim] Vertical split' })
vim.keymap.set('n', '<leader>,', ':split<CR>', { noremap = true, silent = true, desc = '[Vim] Horizontal split' })

-- Easy navigation between splits using Ctrl + [h,j,k,l]
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = '[Vim] Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = '[Vim] Move to below split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = '[Vim] Move to above split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = '[Vim] Move to right split' })

vim.diagnostic.config({ virtual_text = true })
