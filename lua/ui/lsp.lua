local icons = require 'ui.icons'

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = icons.lspkind[kind] or kind
end

for name, icon in pairs(icons.diagnostic_sign) do
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

vim.diagnostic.config {
  virtual_text = {
    prefix = '',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
  focusable = false,
  relative = 'cursor',
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
  if msg:match 'exit code' then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

-- Borders for LspInfo winodw
local win = require 'lspconfig.ui.windows'
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'single'
  return opts
end
