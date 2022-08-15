local keymap = require 'core.lib.keymap'
local cmd, opts, group = keymap.cmd, keymap.opts, keymap.group
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
  map { 'n', 'v', 'i' } ('∆', '<A-j>', opts(remap, desc '  Fix <A-j> mapping on MacOS'))
  map { 'n', 'v', 'i' } ('˚', '<A-k>', opts(remap, desc '  Fix <A-k> mapping on MacOS'))
  vmap('<', '<gv', opts(noremap, desc '  Better indent'))
  vmap('>', '>gv', opts(noremap, desc '  Better indent'))
  vmap('~', '~gv', opts(noremap, desc 'Aa Better toggle case in visual mode'))

  imap('<C-h>', '<Left>', opts(noremap, desc '  move left'))
  imap('<C-l>', '<Right>', opts(noremap, desc '  move right'))
  imap('<C-j>', '<Down>', opts(noremap, desc '  move down'))
  imap('<C-k>', '<Up>', opts(noremap, desc '  move up'))

  imap({ 'jk', 'jj' }, '<ESC>', opts(noremap, desc '[Esc]  Goto Normal mode'))
  nmap('<leader>h', cmd 'nohlsearch', opts(noremap, desc 'No Highlight'))

  nmap('<leader>o', 'o<ESC>', opts(noremap, desc 'insert a newline without leaving normal mode'))

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
  map { 'i', 'n' } ('<C-s>', '<cmd> w <CR>', opts(noremap, desc '﬚  save file'))
  nmap({ '<C-q>', '<leader>q' }, cmd 'q', opts(noremap, desc 'Quit vim'))

  -- Packer keymaps
  group('<leader>p', '+ Packer')
  nmap('<leader>pu', cmd 'PackerUpdate', opts(noremap, silent, desc '  Run PackerUpdate'))
  nmap('<leader>pi', cmd 'PackerInstall', opts(noremap, silent, desc '  Run PackerInstall'))
  nmap('<leader>pc', cmd 'PackerCompile', opts(noremap, desc '  Run PackerCompile'))
  nmap('<leader>ps', cmd 'PackerSync', opts(noremap, silent, desc 'מּ  Run PackerSync'))

  -- buf stuff
  group('<leader>b', '+ Buffer')
  nmap('<leader>bn', cmd 'enew', opts(noremap, silent, desc 'New buffer'))
  nmap('<TAB>', cmd 'BufferLineCycleNext', opts(noremap, silent, desc '  goto prev tab'))
  nmap('<S-Tab>', cmd 'BufferLineCyclePrev', opts(noremap, silent, desc '  goto next tab'))
  nmap('<leader>bl', cmd 'BufferLineMoveNext', opts(noremap, silent, desc 'move tab to next'))
  nmap('<leader>bh', cmd 'BufferLineMovePrev', opts(noremap, silent, desc 'move tab to prev'))
  nmap('<leader>bL', cmd 'BufferLineCloseRight', opts(noremap, silent, desc 'Close all to the Right'))
  nmap('<leader>bH', cmd 'BufferLineCloseLeft', opts(noremap, silent, desc 'Close all to the left'))
  nmap('<leader>bj', cmd 'BufferLinePick', opts(noremap, silent, desc 'Jump'))
  nmap('<leader>bx', cmd 'BufferLinePickClose', opts(noremap, silent, desc 'Pick which buffer to close'))
  nmap('<leader>bD', cmd 'BufferLineSortByDirectory', opts(noremap, silent, desc 'Sort by directory'))
  nmap('<leader>bE', cmd 'BufferLineSortByExtension', opts(noremap, silent, desc 'Sort by language'))
  -- Tab switch buffer
  nmap('L', cmd 'BufferLineCycleNext', opts(noremap, desc '  Goto next buffer'))
  nmap('H', cmd 'BufferLineCyclePrev', opts(noremap, desc '  Goto prev buffer'))
  nmap({ '<C-x>', '<leader>bd' }, cmd 'bdelete', opts(noremap, silent, desc 'Close buffer'))

  -- Telescope
  group('<leader>f', '+ Telescope')
  nmap('<leader>ff', cmd 'Telescope find_files', opts(noremap, desc '  find files'))
  nmap(
    '<leader>fa',
    cmd 'Telescope find_files follow=true no_ignore=true hidden=true',
    opts(noremap, desc '  find all')
  )
  nmap('<leader>fg', cmd 'Telescope live_grep', opts(noremap, desc '  live grep'))
  nmap('<leader>fb', cmd 'Telescope buffers', opts(noremap, desc '  find buffers'))
  nmap('<leader>fh', cmd 'Telescope help_tags', opts(noremap, desc '  help page'))
  nmap('<leader>fo', cmd 'Telescope oldfiles', opts(noremap, desc '  find oldfiles'))
  nmap('<leader>fk', cmd 'Telescope keymaps', opts(noremap, desc '  show keys'))
  nmap({ '<c-G>', '<leader>fp' }, function()
    vim.notify(vim.fn.expand('%:p'), vim.log.levels.INFO, {
      title = 'Current file path',
    })

  end, opts(noremap, desc 'Show current file path'))

  -- git
  group('<leader>g', '+ Git')

  nmap('<leader>gj', function() require('gitsigns').next_hunk() end, opts(noremap, desc 'Next Hunk'))
  nmap('<leader>gk', function() require('gitsigns').prev_hunk() end, opts(noremap, desc 'Prev Hunk'))
  nmap('<leader>gl', function() require('gitsigns').blame_line() end, opts(noremap, desc 'Blame'))
  nmap('<leader>gp', function() require('gitsigns').preview_hunk() end, opts(noremap, desc 'Preview Hunk'))
  nmap('<leader>gr', function() require('gitsigns').reset_hunk() end, opts(noremap, desc 'Reset Hunk'))
  nmap('<leader>gR', function() require('gitsigns').reset_buffer() end, opts(noremap, desc 'Reset buffer'))
  nmap('<leader>gS', function() require('gitsigns').stage_hunk() end, opts(noremap, desc 'Stage Hunk'))
  nmap('<leader>gU', function() require('gitsigns').undo_stage_hunk() end, opts(noremap, desc 'Undo Stage Hunk'))
  nmap('<leader>gs', cmd 'Telescope git_status', opts(noremap, desc 'Open changed file'))
  nmap('<leader>gb', cmd 'Telescope git_branches', opts(noremap, desc 'Checkout branch'))
  nmap('<leader>gc', cmd 'Telescope git_commits', opts(noremap, desc 'Checkout commit'))
  nmap('<leader>gC', cmd 'Telescope git_bcommits', opts(noremap, desc 'Checkout commit(for current file)'))
  nmap('<leader>gd', cmd 'Gitsigns diffthis HEAD', opts(noremap, desc 'Git diff'))
  nmap('<leader>gD', function() require('gitsigns').diffthis('~') end, opts(noremap, desc 'Git diff'))
  nmap('<leader>gg', function()
    require("lspsaga.floaterm").open_float_terminal("lazygit")
  end, opts(noremap, desc 'lazygit'))
  tmap('<leader>gg', function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true))
    require("lspsaga.floaterm").close_float_terminal()
  end, opts(noremap, desc 'lazygit'))

  -- toggle comment in both modes
  nmap('<leader>/', function()
    -- require('Comment.api').toggle_current_linewise()
    require('Comment.api').toggle.linewise.current(nil, {})
  end, opts(noremap, desc '蘒 toggle comment'))
  vmap(
    '<leader>/',
     "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode(), {})<CR>",
     opts(noremap, desc '蘒 toggle comment')
  )

  -- nvimtree
  nmap('<leader>e', cmd 'NvimTreeToggle', opts(noremap, desc '  toggle nvimtree'))
  -- nmap('<leader>e', cmd 'NvimTreeFocus', opts(noremap, desc '  focus nvimtree'))

  -- termial
  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*',
    callback = function()
      tmap('<esc>', [[<C-\><C-n>]], opts(noremap, buffer(0)))
      tmap('jk', [[<C-\><C-n>]], opts(noremap, buffer(0)))
      tmap('<C-h>', [[<C-\><C-n><C-W>h]], opts(noremap, buffer(0)))
      tmap('<C-j>', [[<C-\><C-n><C-W>j]], opts(noremap, buffer(0)))
      tmap('<C-k>', [[<C-\><C-n><C-W>k]], opts(noremap, buffer(0)))
      tmap('<C-l>', [[<C-\><C-n><C-W>l]], opts(noremap, buffer(0)))
    end,
    desc = 'Mappings for navigation with a terminal',
  })

  vim.api.nvim_create_autocmd('TermEnter', {
    pattern = 'term://*toggleterm#*',
    callback = function()
      tmap('<c-t>', cmd 'exe v:count1 . "ToggleTerm"', opts(noremap))
    end,
    desc = 'Mappings for navigation with a terminal',
  })
  map { 'i', 'n' } ('<C-t>', cmd 'exe v:count1 . "ToggleTerm"', opts(noremap, desc 'open termial'))

  -- lsp stuff
  group('<leader>l', '+ lsp')
  -- nmap('<leader>le', vim.diagnostic.open_float, opts(noremap, desc 'Hover diagnostics'))
  nmap('<leader>le', require("lspsaga.diagnostic").show_line_diagnostics, opts(noremap, desc 'Hover diagnostics'))
  nmap('[e', require("lspsaga.diagnostic").goto_prev, opts(noremap, desc 'Previous diagnostic'))
  nmap(']e', require("lspsaga.diagnostic").goto_next, opts(noremap, desc 'Next diagnostic'))
  nmap('[E', function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, opts(noremap, desc 'Previous diagnostic'))
  nmap(']E', function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, opts(noremap, desc 'Next diagnostic'))
  nmap('<leader>lq', vim.diagnostic.setloclist, opts(noremap, desc 'Open diagnastic loclist'))

  -- markdown
  group('<leader>m', 'markdown')
  nmap('<leader>mp', cmd 'MarkdownPreviewToggle', opts(noremap, desc 'Markdown preview'))
end

M.lsp_on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('gD', vim.lsp.buf.declaration, opts(noremap, buffer(bufnr), desc 'Goto declaration'))
  nmap('gd', vim.lsp.buf.definition, opts(noremap, buffer(bufnr), desc 'Goto definition'))
  nmap('<leader>ld', require("lspsaga.definition").preview_definition,
    opts(noremap, buffer(bufnr), desc 'Show definition'))
  -- nmap('K', vim.lsp.buf.hover, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('K', require("lspsaga.hover").render_hover_doc, opts(noremap, buffer(bufnr), desc 'Show hover'))
  nmap('<C-f>', function()
    require('lspsaga.action').smart_scroll_with_saga(1)
  end, opts(noremap))
  nmap('<C-b>', function()
    require('lspsaga.action').smart_scroll_with_saga(-1)
  end, opts(noremap))
  nmap('gi', vim.lsp.buf.implementation, opts(noremap, buffer(bufnr), desc 'Goto implementation'))
  -- nmap('gs', vim.lsp.buf.signature_help, opts(noremap, buffer(bufnr), desc 'Show signature_help'))
  nmap('gs', require('lspsaga.signaturehelp').signature_help,
    opts(noremap, buffer(bufnr), desc 'Show signature_help'))
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, opts(noremap, buffer(bufnr), desc 'Add workspace folder'))
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, opts(noremap, buffer(bufnr), desc 'Remove workspace folder'))
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts(noremap, buffer(bufnr), desc 'Show hover'))
  -- nmap('<leader>lr', vim.lsp.buf.rename, opts(noremap, buffer(bufnr), desc 'Rname Symbol'))
  nmap('<leader>lr', require("lspsaga.rename").lsp_rename, opts(noremap, buffer(bufnr), desc 'Rname Symbol'))
  -- nmap('<leader>la', vim.lsp.buf.code_action, opts(noremap, buffer(bufnr), desc 'Code Action'))
  nmap('<leader>la', require("lspsaga.codeaction").code_action, opts(noremap, buffer(bufnr), desc 'Code Action'))
  vmap('<leader>la', function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    require('lspsaga.codeaction').range_code_action()
  end, opts(noremap, buffer(bufnr), desc 'Code Action'))

  nmap('gr', vim.lsp.buf.references, opts(noremap, buffer(bufnr), desc 'Goto references'))
  -- nmap('<leader>lf', vim.lsp.buf.formatting, opts(noremap, buffer(bufnr), desc 'reformat code'))
  nmap('<leader>lf', function()
    vim.lsp.buf.format { async = true }
  end, opts(noremap, buffer(bufnr), desc 'reformat code'))
  nmap('gh', require("lspsaga.finder").lsp_finder, opts(noremap, desc 'lspsaga finder'))
  nmap('<leader>lo', cmd 'LSoutlineToggle', opts(noremap, desc 'Show outline'))
end

return M
