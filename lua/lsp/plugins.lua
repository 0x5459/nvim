local plugin = require('core.lib.plugin').register_plugin

plugin {
  'williamboman/nvim-lsp-installer',
  opt = true,
  setup = function()
    require('core.lib.lazyload').on_file_open 'nvim-lsp-installer'
  end,
}

plugin {
  'neovim/nvim-lspconfig',
  module = 'lspconfig',
  after = 'nvim-lsp-installer',
  config = function()
    require 'lsp.configs.lsp_installer'
    require 'lsp.configs.lspconfig'
  end,
}

plugin {
  'glepnir/lspsaga.nvim',
  branch = 'main',
  config = function()
    require 'lsp.configs.lspsaga'
  end
}


plugin {
  'nvim-lua/lsp-status.nvim',
}

plugin {
  'numToStr/Comment.nvim',
  event = 'BufRead',
  config = function()
    require 'lsp.configs.comment'
  end,
}

-- load luasnips + cmp related in insert mode only
plugin {
  'rafamadriz/friendly-snippets',
  module = 'cmp_nvim_lsp',
  event = 'InsertEnter',
}

plugin {
  'hrsh7th/nvim-cmp',
  after = 'friendly-snippets',
  config = require('lsp.configs.cmp').cmp,
}

plugin {
  'L3MON4D3/LuaSnip',
  wants = 'friendly-snippets',
  after = 'nvim-cmp',
  config = require('lsp.configs.cmp').luasnip,
}
plugin {
  'saadparwaiz1/cmp_luasnip',
  after = 'LuaSnip',
}

plugin {
  'hrsh7th/cmp-nvim-lua',
  after = 'cmp_luasnip',
}
plugin {
  'hrsh7th/cmp-nvim-lsp',
  after = 'cmp-nvim-lua',
}

plugin {
  'hrsh7th/cmp-buffer',
  after = 'cmp-nvim-lsp',
}

plugin {
  'hrsh7th/cmp-path',
  after = 'cmp-buffer',
}
