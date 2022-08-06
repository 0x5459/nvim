local plugin = require('core.lib.plugin').register_plugin

plugin {
  'kyazdani42/nvim-web-devicons',
  module = 'nvim-web-devicons',
  config = function()
    require 'ui.configs.devicons'
  end,
  disable = not require('features').features().icons,
}

plugin{
  'glepnir/galaxyline.nvim',
  branch = 'main',
  config = function()
    require('ui.configs.galaxyline')
  end,
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
}

plugin {
  'ellisonleao/gruvbox.nvim',
  config = function()
    require 'ui.configs.gruvbox'
  end,
}

plugin {
  'rcarriga/nvim-notify',

  config = function()
    require 'ui.configs.notify'
  end,
  -- requires = { 'nvim-telescope/telescope.nvim' },
}

plugin {
  'akinsho/bufferline.nvim',
  config = function()
    require('ui.configs.bufferline').setup()
  end,
  tag = 'v2.*',
  event = 'BufWinEnter',
}

plugin {
  'nvim-telescope/telescope.nvim',
  requires = { { 'nvim-lua/plenary.nvim' } },
  config = function()
    require 'ui.configs.telescope'
  end,
}

plugin {
  'goolord/alpha-nvim',
  config = function()
    require('ui.configs.alpha').setup()
  end,
}

plugin {
  'akinsho/toggleterm.nvim',
  tag = 'v2.*',
  event = 'BufWinEnter',
  config = function()
    require('ui.configs.terminal').setup()
  end,
  disable = not require('features').features().terminal,
}

plugin {
  'kyazdani42/nvim-tree.lua',
  ft = 'alpha',
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
  config = function()
    require 'ui.configs.nvimtree'
  end,
}

plugin {
  'lewis6991/gitsigns.nvim',
  setup = function()
    require('core.lib.lazyload').gitsigns()
  end,
  config = function()
    require('gitsigns').setup()
  end,
}

plugin {
  'iamcco/markdown-preview.nvim',
  run = function() vim.fn["mkdp#util#install"]() end,
}

-- Only load whichkey after all the gui
plugin {
  'folke/which-key.nvim',
  module = 'which-key',
  config = function()
    require 'ui.configs.whichkey'
  end,
}
