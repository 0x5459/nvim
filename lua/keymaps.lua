local keymap = require 'core.lib.keymap'
local cmd, opts = keymap.cmd, keymap.opts
local map, nmap, imap, vmap, xmap, tmap = keymap.map, keymap.nmap, keymap.imap, keymap.vmap, keymap.xmap, keymap.tmap
local remap, noremap, desc, silent, buffer = keymap.remap, keymap.noremap, keymap.desc, keymap.silent, keymap.buffer

local M = {}

-- Use space as leader key
vim.g.mapleader = ' '

--                                                           *map-table*
-- Mode           | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang | ~
-- Command        +------+-----+-----+-----+-----+-----+------+------+
-- [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
-- n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
-- [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
-- i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
-- c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
-- v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
-- x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
-- s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
-- o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
-- t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
-- l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
M.general = function()
  -- Alternatively to allow using alt in macOS without enabling “Use Option as Meta key”
  map { 'n', 'v', 'i' }('∆', '<A-j>', opts(remap, desc '  Fix <A-j> mapping on MacOS'))
  map { 'n', 'v', 'i' }('˚', '<A-k>', opts(remap, desc '  Fix <A-k> mapping on MacOS'))
  vmap('<', '<gv', opts(noremap, desc '  Better indent'))
  vmap('>', '>gv', opts(noremap, desc '  Better indent'))
  vmap('~', '~gv', opts(noremap, desc 'Aa Better toggle case in visual mode'))

  imap('<C-h>', '<Left>', opts(noremap, desc '  move left'))
  imap('<C-l>', '<Right>', opts(noremap, desc '  move right'))
  imap('<C-j>', '<Down>', opts(noremap, desc '  move down'))
  imap('<C-k>', '<Up>', opts(noremap, desc '  move up'))

  imap({ 'jk', 'kj', 'jj' }, '<ESC>', opts(noremap, desc '[Esc]  Goto Normal mode'))

  imap('<A-j>', '<Esc>:move .+1<CR>==gi', opts(noremap, desc '  Move current line up'))
  imap('<A-k>', '<Esc>:move .-2<CR>==gi', opts(noremap, desc '  Move current line down'))
  nmap('<A-j>', ':m .+1<CR>==', opts(noremap, desc '  Move current line up'))
  nmap('<A-k>', ':m .-2<CR>==', opts(noremap, desc '  Move current line down'))
  xmap({ 'J', '<A-j>' }, ":m '>+1<CR>gv-gv", opts(noremap, desc '  Move current line/block up in visual mode'))
  xmap({ 'K', '<A-k>' }, ":m '<-2<CR>gv-gv", opts(noremap, desc '  Move current line/block down in visual mode'))

  -- go to  beginning and end
  imap('<C-b>', '<ESC>^i', opts(noremap, desc '論 beginning of line'))
  imap('<C-e>', '<End>', opts(noremap, desc '壟 end of line'))

  -- navigate within insert mode
  imap('<C-h>', '<Left>', opts(noremap, desc '  move left'))
  imap('<C-l>', '<Right>', opts(noremap, desc ' move right'))
  imap('<C-j>', '<Down>', opts(noremap, desc ' move up'))
  imap('<C-k>', '<Up>', opts(noremap, desc ' move down'))

  -- window
  nmap('<C-h>', '<C-w>h', opts(noremap, desc ' Goto left window'))
  nmap('<C-l>', '<C-w>l', opts(noremap, desc ' Goto right window'))
  nmap('<C-j>', '<C-w>j', opts(noremap, desc ' Goto up window'))
  nmap('<C-k>', '<C-w>k', opts(noremap, desc ' Goto down window'))

  -- save
  map { 'i', 'n' }('<C-s>', '<cmd> w <CR>', opts(noremap, desc '﬚  save file'))

  -- Packer keymaps
  nmap('<leader>pu', cmd 'PackerUpdate', opts(noremap, silent, desc '  Run PackerUpdate'))
  nmap('<leader>pi', cmd 'PackerInstall', opts(noremap, silent, desc '  Run PackerInstall'))
  nmap('<leader>pc', cmd 'PackerCompile', opts(noremap, desc '  Run PackerCompile'))
  nmap('<leader>ps', cmd 'PackerSync', opts(noremap, silent, desc 'מּ  Run PackerSync'))

  nmap('<TAB>', cmd 'BufferLineCycleNext', opts(noremap, silent, desc '  goto prev tab'))
  nmap('<S-Tab>', cmd 'BufferLineCyclePrev', opts(noremap, silent, desc '  goto next tab'))

  nmap('[b', cmd 'BufferLineMoveNext', opts(noremap, silent, desc ''))
  nmap(']b', cmd 'BufferLineMovePrev', opts(noremap, silent, desc ''))

  -- -- Tab switch buffer
  nmap('<S-l>', cmd 'BufferLineCycleNext', opts(noremap, desc '  Goto next buffer'))
  nmap('<S-h>', cmd 'BufferLineCyclePrev', opts(noremap, desc '  Goto prev buffer'))

  nmap('<C-w>', cmd 'bdelete', opts(noremap, silent, desc 'Close buffer'))
  nmap('<C-S-w>', cmd 'bdelete!', opts(noremap, silent, desc 'Force close buffer'))
  nmap({ '<C-q>' }, cmd 'q', opts(noremap, desc 'Quit vim'))
  nmap({ '<C-S-q>' }, cmd 'q!', opts(noremap, desc 'Force quit vim'))

  -- Telescope
  nmap('<leader>ff', cmd 'Telescope find_files', opts(noremap, desc '  find files'))
  nmap(
    '<leader>fa',
    cmd 'Telescope find_files follow=true no_ignore=true hidden=true',
    opts(noremap, desc '  find all')
  )
  nmap('<leader>fg', cmd 'Telescope live_grep', opts(noremap, desc '   live grep'))
  nmap('<leader>fb', cmd 'Telescope buffers', opts(noremap, desc '  find buffers'))
  nmap('<leader>fh', cmd 'Telescope help_tags', opts(noremap, desc '  help page'))
  nmap('<leader>fo', cmd 'Telescope oldfiles', opts(noremap, desc '   find oldfiles'))
  nmap('<leader>fk', cmd 'Telescope keymaps', opts(noremap, desc '   show keys'))

  -- nvimtree
  nmap('<C-n>', cmd 'NvimTreeToggle', opts(noremap, desc '   toggle nvimtree'))
  nmap('<leader>e', cmd 'NvimTreeFocus', opts(noremap, desc '   focus nvimtree'))

  -- termial
  tmap('<esc>', [[<C-\><C-n>]], opts(noremap, buffer(0)))
  tmap('jk', [[<C-\><C-n>]], opts(noremap, buffer(0)))
  tmap('<C-h>', [[<C-\><C-n><C-W>h]], opts(noremap, buffer(0)))
  tmap('<C-j>', [[<C-\><C-n><C-W>j]], opts(noremap, buffer(0)))
  tmap('<C-k>', [[<C-\><C-n><C-W>k]], opts(noremap, buffer(0)))
  tmap('<C-l>', [[<C-\><C-n><C-W>l]], opts(noremap, buffer(0)))

  -- lsp stuff
  nmap('<leader>e', vim.diagnostic.open_float, opts(noremap))
  nmap('<leader>e', vim.diagnostic.open_float, opts(noremap))
  nmap('[d', vim.diagnostic.goto_prev, opts(noremap))
  nmap(']d', vim.diagnostic.goto_next, opts(noremap))
  nmap('<leader>q', vim.diagnostic.setloclist, opts(noremap))
end

M.lsp_on_attach = function(client, bufnr)
  -- nmap('K', vim.lsp.buf.hover, opts(noremap, sli, desc 'Show hover'))
  -- nmap('gD', vim.lsp.buf.declaration, opts(noremap, desc 'Goto definition'))
  -- nmap('gr', vim.lsp.buf.references, opts(noremap, desc 'Goto references'))
  -- nmap('gi', vim.lsp.buf.implementation, opts(noremap, desc 'Goto implementation'))
  -- nmap('gs', vim.lsp.buf.signature_help, opts(noremap, desc 'Show signature_help'))
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('gD', vim.lsp.buf.declaration, opts(noremap, buffer(bufnr), desc 'Goto declaration'))
  nmap('gd', vim.lsp.buf.definition, opts(noremap, buffer(bufnr), desc 'Goto definition'))
  nmap('K', vim.lsp.buf.hover, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('gi', vim.lsp.buf.implementation, opts(noremap, buffer(bufnr), desc 'Goto implementation'))
  nmap('gs', vim.lsp.buf.signature_help, opts(noremap, buffer(bufnr), desc 'Show signature_help'))
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('<leader>D', vim.lsp.buf.type_definition, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('<leader>rn', vim.lsp.buf.rename, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('<leader>ca', vim.lsp.buf.code_action, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('gr', vim.lsp.buf.references, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('<leader>lf', vim.lsp.buf.formatting, opts(noremap, buffer(bufnr), desc 'Show hover'))
end

return M
