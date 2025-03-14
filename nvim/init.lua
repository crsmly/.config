vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
 end
  return false 
end

local packer_bootstrap = ensure_packer()

require('plugins')
require('ls')
local builtin = require('telescope.builtin')

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {"elixir","go", "lua", "javascript","typescript", "python", "gleam"}, -- or "all"

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- List of language that will be disabled
    -- disable = { "c", "rust" },

    additional_vim_regex_highlighting = false,
  },
}
require('nvim-tree').setup()

-- Theme
vim.o.background = "dark"
vim.cmd("colorscheme terafox")

-- Relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Updatetime
vim.opt.updatetime = 100

-- 4 space tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- line wrap
vim.opt.wrap = false

-- Blinking cursor
vim.opt.guicursor = vim.opt.guicursor + "a:blinkon1"
vim.opt.ttyfast = true
-- ---- KEYBINDS ---- --
-- Bind space to leader key
vim.g.mapleader = ' '

-- telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ee',':NvimTreeFocus<CR>', {})

-- Bind 'jk' to enter command mode in insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true})

-- Highlight current line
vim.opt.cursorline = true

-- Persistent undo history
vim.opt.undofile = true

-- Folding powered by treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false -- disable automatic folding on file open

vim.opt.lazyredraw = true -- Reduces unnecessary redraws significantly improving speed
vim.opt.ttyfast = true -- optimized redraw performance

-- Faster key repetition and improved responsiveness
vim.opt.timeoutlen = 300    -- Time in ms to wait for a mapped sequence
vim.opt.ttimeoutlen = 10    -- Faster response for key codes

-- Faster split creation
vim.api.nvim_set_keymap('n', '<leader>.', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>,', ':split<CR>', {})

-- Easy navigation between splits using Ctrl + [h,j,k,l]
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
