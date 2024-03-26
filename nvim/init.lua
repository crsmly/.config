
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

-- Theme
vim.cmd.colorscheme "catppuccin-mocha"
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
vim.keymap.set('n', '<leader>ee',':E<CR>', {})

-- Bind 'jk' to enter command mode in insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true})
