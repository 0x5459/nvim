local M = {}

function M.nvim_treesitter()
  local present, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
  if not present then
    return
  end

  -- -- See: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
  -- vim.api.nvim_command 'set foldmethod=expr'
  -- vim.api.nvim_command 'set foldexpr=nvim_treesitter#foldexpr()'


  treesitter_configs.setup {
    -- A list of parser names, or "all"
    ensure_installed = { 'lua' },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { 'javascript' },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { 'c', 'rust' },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
    },
  }
end

return M
