local M = {}
--
-- local lazygit = require('toggleterm.terminal').Terminal:new {
--   cmd = 'lazygit',
--   dir = 'git_dir',
--   direction = 'float',
--   float_opts = {
--     border = 'double',
--   },
--   -- function to run on opening the terminal
--   on_open = function(term)
--     vim.cmd 'startinsert!'
--     vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
--   end,
--   -- function to run on closing the terminal
--   on_close = function(_)
--     vim.cmd 'Closing terminal'
--   end,
-- }
--
-- function M.lazygit_toggle()
--   lazygit:toggle()
-- end
--
function M.setup()
  require('toggleterm').setup {
    on_config_done = nil,
    -- size can be a number or function which is passed the current terminal
    size = 20,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = 'horizontal',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      border = 'curved',
      -- width = <value>,
      -- height = <value>,
      winblend = 0,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
  }
end

return M
