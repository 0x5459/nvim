local present, lspconfig = pcall(require, 'lspconfig')

if not present then
  return
end

require 'ui.lsp'

local function on_attach(client, bufnr)
  local vim_version = vim.version()

  if vim_version.minor > 7 then
    -- nightly
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    -- stable
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
  require('keymaps').lsp_on_attach(client, bufnr)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}

local configs = {
  lua = {
    server_name = 'sumneko_lua',
    opts = {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = {
              [vim.fn.expand '$VIMRUNTIME/lua'] = true,
              [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    },
  },
  rust = {
    server_name = 'rust_analyzer',
    opts = {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {},
    },
  },
  go = {
    server_name = 'gopls',
    opts = {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {},
    },
  },
  java = {
    server_name = 'jdtls',
    opts = {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {},
    },
  },
  

}

for _, lang in ipairs(require('features').features().lsp) do
  local conf = configs[lang]
  if conf == nil then
    return
  end
  if lspconfig[conf.server_name] ~= nil then
    lspconfig[conf.server_name].setup(conf.opts)
  end
end
