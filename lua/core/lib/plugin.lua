local fn, uv, api, validate = vim.fn, vim.loop, vim.api, vim.validate
local log, split, tbl_extend, cmd = vim.log, vim.split, vim.tbl_extend, vim.cmd

local util = require 'core.lib.util'

local in_headless = #api.nvim_list_uis() == 0

local M = {}

local packer = nil
local first_install_packer = false

local function plugin_short_name(plugin_spec)
  if type(plugin_spec) == 'string' then
    return plugin_short_name { plugin_spec }
  end
  validate {
    plugin_spec = { plugin_spec, 'table' },
  }

  local path = fn.expand(plugin_spec[1])
  if plugin_spec.as and not fn.empty(plugin_spec.as) then
    return plugin_spec.as, path
  end
  local name_segments = split(fn.trim(path, '/\\', 2), util.sep())
  local name = name_segments[#name_segments]
  return name, path
end

local packer_init_opts = {
  package_root = util.data_path { 'site', 'pack' },
  compile_path = util.data_path({ 'site', 'lua' }, 'packer_compiled.lua'),
  snapshot_path = util.cache_path 'snapshots',
  compile_on_sync = true,
  git = {
    clone_timeout = 120,
  },
  display = {
    open_fn = function()
      return require('packer.util').float {
        border = 'rounded',
      }
    end,
  },
}

local function init_ensure_packer(opts)
  if packer ~= nil then
    return packer
  end
  opts = opts or {}

  packer_init_opts = tbl_extend('force', packer_init_opts, opts)

  local install_path = packer_init_opts.install_path
    or util.join_paths { packer_init_opts.package_root, 'packer', 'start', 'packer.nvim' }

  -- TODO remove this
  os.execute('mkdir -p' .. install_path)

  if fn.isdirectory(install_path) == 0 then
    api.nvim_command('!git clone --depth=1 https://github.com/wbthomason/packer.nvim ' .. install_path)
    first_install_packer = true
  end

  packer_init_opts.install_path = nil

  if in_headless then
    packer_init_opts.display = nil
  end

  cmd 'packadd packer.nvim'
  packer = require 'packer'
  packer.init(packer_init_opts)
  packer.reset()
  return packer
end

function M.init(opts)
  init_ensure_packer(opts)
end

local plugins = {}
function M.register_plugin(plugin)
  table.insert(plugins, plugin)
end

local function load_compiled(done)
  if fn.filereadable(packer_init_opts.compile_path) == 1 then
    local compiled_modname = util.modname(packer_init_opts.compile_path)
    require(compiled_modname)
  elseif not first_install_packer then
    packer.compile()
  end

  local PackerHooks = api.nvim_create_augroup('PackerHooks', {})
  -- See: https://github.com/wbthomason/packer.nvim#user-autocommands
  api.nvim_create_autocmd('User', {
    pattern = 'PackerCompileDone',
    callback = function()
      vim.notify('Packer compile done!', log.levels.INFO, {
        title = 'Packer',
      })
      if type(done) == 'function' then
        done()
      end
    end,
    group = PackerHooks,
  })
end

function M.load_plugins(done)
  local packer = init_ensure_packer {} -- initialize by default opts if it is not initialized
  local use = packer.use

  -- let packer manage itself
  use 'wbthomason/packer.nvim'

  for _, plugin in ipairs(plugins) do
    use(plugin)
  end

  if first_install_packer then
    packer.sync()
  end

  load_compiled(done)
end

function M.has_plugin(plugin_name)
  return packer_plugins[plugin_name] and packer_plugins[plugin_name].loaded
end

return M
