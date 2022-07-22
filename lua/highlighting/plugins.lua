local plugin = require('core.lib.plugin').register_plugin
local configs = require 'highlighting.configs'

plugin {
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('nvim-treesitter.install').update { with_sync = true }
  end,
  setup = function()
    require('core.lib.lazyload').on_file_open 'nvim-treesitter'
  end,
  config = configs.nvim_treesitter,
}

plugin { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
