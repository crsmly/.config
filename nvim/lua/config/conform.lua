local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    javascript = { "prettier", stop_after_first = true },
    typescript = { "prettier", stop_after_first = true },
    json = { "prettier", stop_after_first = true },
    vue = { "prettier", stop_after_first = true },
  },
  formatters = {
    prettier = {
        require_cwd = true,
    },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = false,
  },
})
