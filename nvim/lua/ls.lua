-- @vue/typescript-plugin ships inside @vue/language-server; resolve from the binary on PATH
local vue_ls_bin = vim.uv.fs_realpath(vim.fn.exepath('vue-language-server'))
local vue_ls_pkg = vue_ls_bin and vim.fs.dirname(vim.fs.dirname(vue_ls_bin)) or ''

-- vtsls bundles TypeScript 5.9.3 (no Temporal types); resolve the global TS 6.x lib from PATH.
-- An absolute path is required because a relative tsdk resolves against vtsls's workspace root,
-- which in a hoisted monorepo (e.g. apps/web-vue) has no local node_modules/typescript.
local tsserver_bin = vim.uv.fs_realpath(vim.fn.exepath('tsserver'))
local ts_tsdk = tsserver_bin and (vim.fs.dirname(vim.fs.dirname(tsserver_bin)) .. '/lib') or ''

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_ls_pkg,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      -- vtsls only honors typescript.tsdk from a VS Code workspaceValue scope, which the neovim
      -- client can't set; vtsls.typescript.globalTsdk is read from plain settings and wins over
      -- the bundled 5.9.3, giving us the global TS 6.x with Temporal types.
      typescript = {
        globalTsdk = ts_tsdk,
      },
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
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte' },
})

vim.lsp.config('eslint',{
    settings = {
        format = { enable = false },
    },
})

vim.lsp.config('oxlint', {
    filetypes = {"typescript", "svelte"}
})

vim.lsp.enable({"vtsls", "eslint", "vue_ls", "oxlint", "svelte"})
