local keymap = vim.api.nvim_set_keymap

keymap('i', 'jk', '<Esc>', {})
keymap('i', 'kj', '<Esc>', {})

keymap('n', '<Leader>e', ':Ex<CR>', {})


-- telescop bindings
keymap('n', '<Leader>ff', ':Telescope find_files<CR>', {})
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', {})

