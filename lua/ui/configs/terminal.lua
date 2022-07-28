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
  execs = {
    { 'lazygit', '<leader>gg', 'LazyGit', 'float' },
  },
}

