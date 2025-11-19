-- ================================
-- Visual Configuration
-- ================================
require('gitsigns').setup {
  signs = {
    add          = { text = '▎' },
    change       = { text = '▎' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },

  -- Inline blame
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 300,
  },

  -- Diff appearance
  word_diff = false,

  -- Update signs responsively
  update_debounce = 100,

  -- ================================
  -- Keybindings
  -- ================================
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    -- Navigation between hunks
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, { buffer = bufnr, desc = '[Gitsigns] Next git hunk' })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end, { buffer = bufnr, desc = '[Gitsigns] Previous git hunk' })

    -- Stage operations
    vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = '[Gitsigns] Stage hunk' })
    vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { buffer = bufnr, desc = '[Gitsigns] Stage selected lines' })
    vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { buffer = bufnr, desc = '[Gitsigns] Stage entire buffer' })

    -- Unstage operations
    vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = '[Gitsigns] Undo stage hunk' })

    -- Reset/revert operations
    vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = '[Gitsigns] Reset hunk' })
    vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { buffer = bufnr, desc = '[Gitsigns] Reset selected lines' })
    vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { buffer = bufnr, desc = '[Gitsigns] Reset entire buffer' })

    -- Preview and blame
    vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = '[Gitsigns] Preview hunk diff' })
    vim.keymap.set('n', '<leader>hb', gitsigns.blame_line, { buffer = bufnr, desc = '[Gitsigns] Git blame line' })
    vim.keymap.set('n', '<leader>hB', function() gitsigns.blame_line{full=true} end, { buffer = bufnr, desc = '[Gitsigns] Git blame line (full)' })

    -- Toggle features
    vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = '[Gitsigns] Toggle inline blame' })
    vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted, { buffer = bufnr, desc = '[Gitsigns] Toggle deleted lines' })
  end
}
