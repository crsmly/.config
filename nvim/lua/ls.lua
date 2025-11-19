local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = 'I dont think this matters',
  languages = { 'vue' },
  configNamespace = 'typescript',
}

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
    typescript = {
      format = {
        enable = false
      }
    },
    javascript = {
      format = {
        enable = false
      }
    }
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

vim.lsp.config('eslint',{
    settings = {
        format = { enable = false },
    },
})

vim.lsp.enable({"vtsls", "eslint", "vue_ls"})
