local keymap = vim.api.nvim_set_keymap

keymap('i', 'jk', '<Esc>', {})
keymap('i', 'kj', '<Esc>', {})

keymap('n', '<Leader>e', ':Ex<CR>', {})
