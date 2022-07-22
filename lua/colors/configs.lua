local M = {}

function M.lualine()
  local present, lualine = pcall(require, 'lualine')

  if not present then
    return
  end
  
  lualine.setup {
    options = {
      icons_enabled = true,
      theme = 'tokyonight',
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = false,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

function M.tokyonight()
  vim.cmd [[colorscheme tokyonight]]
end

return M
