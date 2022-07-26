local defaults = {
  active = false,
  on_config_done = nil,
  opts = {
    ---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
    stages = 'slide',

    ---@usage Function called when a new window is opened, use for changing win settings/config
    on_open = nil,

    ---@usage Function called when a window is closed
    on_close = nil,

    ---@usage timeout for notifications in ms, default 5000
    timeout = 5000,

    -- Render function for notifications. See notify-render()
    render = 'default',

    ---@usage highlight behind the window for stages that change opacity
    background_colour = 'Normal',

    ---@usage minimum width for notification windows
    minimum_width = 50,

    ---@usage Icons for the different levels
    icons = {
      ERROR = '',
      WARN = '',
      INFO = '',
      DEBUG = '',
      TRACE = '✎',
    },
  },
  on_open = function(win)
    vim.api.nvim_win_set_option(win, 'wrap', true)
  end
}

-- function M.config()
--   lvim.builtin.notify = vim.tbl_deep_extend('force', defaults, lvim.builtin.notify or {})
-- end

if #vim.api.nvim_list_uis() == 0 then
  -- no need to configure notifications in headless
  return
end

local opts = defaults
local notify = require 'notify'

notify.setup(opts)
vim.notify = notify

-- Log:configure_notifications(notify)
