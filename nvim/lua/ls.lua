-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')
-- Create a single autocommand group for LSP formatting
local lspFormattingGroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

-- Function to enable format on save
local on_attach = function(client, bufnr)
    print("LSP started.")  -- Debug message
    if client.server_capabilities.documentFormattingProvider then
        print("Formatting supported.")  -- Debug message
        vim.api.nvim_clear_autocmds({ group = lspFormattingGroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lspFormattingGroup,
            buffer = bufnr,
            callback = function()
                print("Formatting on save.")  -- Debug message
                vim.lsp.buf.format({ bufnr = bufnr })
            end
        })
    end
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'volar', 'tsserver', 'elixirls', 'pylsp', 'gopls', 'eslint' }
for _, lsp in ipairs(servers) do
    local config = {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    
    if lsp == "elixirls" then
        config.cmd = {"/Users/christiemolloy/lsp/elixir-ls/bin/language_server.sh"}
    elseif lsp == "gopls" then
        config.cmd = {"/Users/christiemolloy/go/bin/gopls"}
    elseif lsp == 'eslint' then
        config.settings = {
            format = {
                enable = true
            }
        }
        config.handlers = {
            ['window/showMessageRequest'] = function(_, result)
                return result.message:match('ENOENT') and vim.NIL or result
            end,
        }
        config.on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            on_attach(client, bufnr)
        end
    elseif lsp == "tsserver" then
        config.on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
            on_attach(client, bufnr)
        end
    end
    
    lspconfig[lsp].setup(config)
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
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
}
