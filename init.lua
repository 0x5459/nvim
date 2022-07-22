local features = require 'features'
local icons, terminal = features.icons, features.terminal

features.enable(icons, terminal)
require 'core'
require 'keymaps'