local features = require 'features'
local icons, terminal, lsp = features.icons, features.terminal, features.lsp

features.enable(icons, terminal, lsp { 'lua', 'rust', 'java', 'go' })

require 'core'
require('keymaps').general()
