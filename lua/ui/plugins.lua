local plugin = require('core.lib.plugin').register_plugin

plugin {
  'kyazdani42/nvim-web-devicons',
  module = 'nvim-web-devicons',
  config = function()
    require 'ui.configs.devicons'
  end,
  disable = not require('features').features().icons,
}

plugin {
  'nvim-lualine/lualine.nvim',
  config = function()
    require 'ui.configs.lualine'
  end,
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
    require 'ui.configs.terminal'
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

-- Only load whichkey after all the gui
plugin {
  'folke/which-key.nvim',
  module = 'which-key',
  config = function()
    require 'ui.configs.whichkey'
  end,
}

