require('lualine').setup {
  options = {
    icons_enabled = require('features').features().icons,
    theme = 'auto',
  },
  extensions = { "nvim-tree" }
}
