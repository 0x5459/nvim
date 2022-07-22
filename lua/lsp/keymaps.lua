local keymap = require 'core.lib.keymap'
local opts = keymap.opts
local nmap = keymap.nmap
local noremap, desc, silent, buffer = keymap.noremap, keymap.desc, keymap.silent, keymap.buffer

keymap.register(function()
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  nmap('<leader>e', vim.diagnostic.open_float, opts(noremap, silent))
  nmap('[d', vim.diagnostic.goto_prev, opts(noremap, silent))
  nmap(']d', vim.diagnostic.goto_next, opts(noremap, silent))
  nmap('<leader>q', vim.diagnostic.setloclist, opts(noremap, silent))

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = opts(noremap, silent, buffer(bufnr))
    nmap('gD', vim.lsp.buf.declaration, bufopts)
    nmap('gd', vim.lsp.buf.definition, bufopts)
    nmap('K', vim.lsp.buf.hover, bufopts)
    nmap('gi', vim.lsp.buf.implementation, bufopts)
    nmap('<C-k>', vim.lsp.buf.signature_help, bufopts)
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    nmap('<leader>D', vim.lsp.buf.type_definition, bufopts)
    nmap('<leader>rn', vim.lsp.buf.rename, bufopts)
    nmap('<leader>ca', vim.lsp.buf.code_action, bufopts)
    nmap('gr', vim.lsp.buf.references, bufopts)
    nmap('<leader>f', vim.lsp.buf.formatting, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }
  -- require('lspconfig')['pyright'].setup {
  --   on_attach = on_attach,
  --   flags = lsp_flags,
  -- }
end)
