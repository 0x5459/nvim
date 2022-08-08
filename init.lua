local features = require 'features'
local icons, terminal, lsp = features.icons, features.terminal, features.lsp

features.enable(icons, terminal, lsp { 'lua', 'rust', 'go', 'java', 'ocaml' })

require 'core'
require('keymaps').general()
