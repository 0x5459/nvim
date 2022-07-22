local plugin = require('core.lib.plugin').register_plugin
local configs = require 'colors.configs'

plugin {
  'nvim-lualine/lualine.nvim',
  config = configs.lualine,
}

plugin {
  'folke/tokyonight.nvim',
  config = configs.tokyonight,
}
