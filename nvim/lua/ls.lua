-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Formatter setup
local null_ls = require("null-ls")

local lspconfig = require('lspconfig')
-- Create a single autocommand group for LSP formatting
local lspFormattingGroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

-- volar setup
local fnm_dir = "/Users/christiemolloy/.local/share/fnm"
local current_version = vim.fn.trim(vim.fn.system('fnm current'))
local tsdk = string.format("%s/node-versions/%s/installation/lib/node_modules/typescript/lib", fnm_dir, current_version)
local typescriptPlugin = string.format("%s/node-versions/%s/installation/lib/node_modules/@vue/typescript-plugin", fnm_dir, current_version)

lspconfig.volar.setup({
    filetypes = { "vue" },
    init_options = {
        vue = {
            hybridMode = true,
        },
        typescript = {
            tsdk = tsdk,
        }
    },
    settings = {
        vue = {
            format = {
                enable = false
            }
        }
    },
    capabilities = {
        documentFormattingProvider = false,
        documentRangeFormattingProvider = false
    },
    on_attach = function(client)
        -- Disable formatting capabilities
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
})


-- null_ls setup
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "vue", "typescript", "javascript" },
            -- This will use the prettier instance from your project
            prefer_local = "node_modules/.bin",
        })
    }
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.vue", "*.ts", "*.js"},
    callback = function()
        vim.lsp.buf.format({timeout = 2000})
    end,
})

-- ts_ls setup
lspconfig.ts_ls.setup({
    init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = typescriptPlugin,
            languages = {"javascript", "typescript", "vue"},
          },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "vue",
    },
    capabilities = capabilities,
        on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
})

-- elixirls setup
lspconfig.elixirls.setup({
    cmd = { "/Users/christiemolloy/lsp/elixir-ls/bin/language_server.sh" },
    capabilities = capabilities,
    on_attach = on_attach,
})

-- pylsp setup
lspconfig.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- gopls setup
lspconfig.gopls.setup({
    cmd = { "gopls" },
    capabilities = capabilities,
    on_attach = on_attach,
})

-- eslint setup
lspconfig.eslint.setup({
    settings = {
        format = { enable = false },
    },
    handlers = {
        ['window/showMessageRequest'] = function(_, result)
            return result.message:match('ENOENT') and vim.NIL or result
        end,
    },
    capabilities = {
        documentFormattingProvider = false,
        documentRangeFormattingProvider = false
    },
})

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})

