
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
  ensure_installed = {"elixir","go", "lua", "javascript","typescript", "python"}, -- or "all"

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
require("rose-pine").setup({
    variant = "",
    dark_variant = "main",
    extend_background_behind_borders = true,
    enable = {
        terminal = true
    }
})

-- Theme
vim.o.background = "dark"
vim.cmd("colorscheme rose-pine")
vim.opt.termguicolors = true

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
vim.opt.updatetime = 250

-- 4 space tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

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
vim.keymap.set('n', '<leader>ee',':Explore<CR>', {})

-- Bind 'jk' to enter command mode in insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true})
