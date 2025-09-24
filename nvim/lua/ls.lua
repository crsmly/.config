local capabilities = require("cmp_nvim_lsp").default_capabilities()
local null_ls = require("null-ls")
local cmp = require("cmp")

local lspFormattingGroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

local function on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

null_ls.setup({
  debounce = 150,
  update_in_insert = false,
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = {
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "vue", "typescript", "javascript", "typescriptreact", "javascriptreact" },
      prefer_local = "node_modules/.bin",
    }),
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = lspFormattingGroup,
  pattern = { "*.vue", "*.ts", "*.js", "*.tsx", "*.jsx", "*.gleam" },
  callback = function()
    vim.lsp.buf.format({
      timeout_ms = 2000,
      filter = function(client) return client.name == "null-ls" end,
    })
  end,
})

vim.lsp.config("gleam", {
  cmd = { "gleam", "lsp" },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config("elixirls", {
  cmd = { "/Users/christiemolloy/lsp/elixir-ls/bin/language_server.sh" },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config("pylsp", {
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = lspFormattingGroup,
  pattern = "*.go",
  callback = function() vim.lsp.buf.format({ timeout_ms = 2000 }) end,
})

vim.lsp.config("eslint", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { format = { enable = false } },
  handlers = {
    ["window/showMessageRequest"] = function(_, result)
      return result.message:match("ENOENT") and vim.NIL or result
    end,
  },
})

do
  local fnm_dir = "/Users/christiemolloy/.local/share/fnm"
  local current_version = vim.fn.trim(vim.fn.system("fnm current"))
  local vue_language_server_path = string.format(
    "%s/node-versions/%s/installation/lib/node_modules/@vue/language-server",
    fnm_dir,
    current_version
  )

  vim.lsp.config("vtsls", {
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "vue" },
              configNamespace = "typescript",
            },
          },
        },
      },
      typescript = {
        preferences = { includePackageJsonAutoImports = "on" },
        inlayHints = { includeInlayParameterNameHints = "literals", includeInlayVariableTypeHints = true },
      },
      javascript = {
        preferences = { includePackageJsonAutoImports = "on" },
        inlayHints = { includeInlayParameterNameHints = "literals", includeInlayVariableTypeHints = true },
      },
    },
  })
end

vim.lsp.enable("gleam")
vim.lsp.enable("elixirls")
vim.lsp.enable("pylsp")
vim.lsp.enable("gopls")
vim.lsp.enable("eslint")
vim.lsp.enable("vtsls")

cmp.setup({
  completion = {
    autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
    keyword_length = 1,
  },
  performance = { debounce = 60, throttle = 30, fetching_timeout = 200 },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, { "i", "s" }),
  }),
  sources = { { name = "nvim_lsp" } },
})

