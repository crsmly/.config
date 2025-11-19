local builtin = require('telescope.builtin')

-- ================================
-- Telescope Configuration
-- ================================
require("telescope").setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
}
require("telescope").load_extension "file_browser"

-- ================================
-- Keybindings
-- ================================
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[Telescope] Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[Telescope] Live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[Telescope] Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[Telescope] Help tags' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[Telescope] Find keymaps' })
vim.keymap.set("n", "<leader>ee", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = '[Telescope] File browser' })
