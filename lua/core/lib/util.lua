local uv, fn, validate = vim.loop, vim.fn, vim.validate

local M = {}

M.is_windows = uv.os_uname().version:match 'Windows'

function M.sep()
  if M.is_windows then
    return '\\'
  else
    return '/'
  end
end

---Join path segments that were passed as input
---@return string
function M.join_paths(paths)
  local result = table.concat(paths, M.sep())
  return result
end

local get_dir_fn = function(catename, envname)
  validate {
    catename = { catename, 'string' },
    envname = { envname, 'string', true },
  }
  envname = envname ~= nil or 'NVIM_' .. string.upper(catename) .. 'DIR'
  return function()
    local nvim_dir = os.getenv(envname)
    if not nvim_dir then
      return fn.stdpath(catename)
    end
  end
end

local path_fn = function(catename, envname)
  validate {
    catename = { catename, 'string' },
  }
  local get_dir = get_dir_fn(catename, envname)
  local ensured_subpath = {}
  local function inner(dir, dontmake)
    validate {
      dirs = { dir, { 'table', 'string' } },
      filename = { dontmake, 'string', true },
    }
    if type(dir) == 'table' then
      dontmake = dir.dontmake or dontmake
      dir.dontmake = nil
      return inner(M.join_paths(dir), dontmake)
    end
    local fullpath = M.join_paths { get_dir(), dir }
    if ensured_subpath[dir] == nil then
      os.execute('mkdir -p ' .. fullpath)
      ensured_subpath[dir] = true
    end
    return M.join_paths { fullpath, dontmake }
  end
  return inner
end

M.cache_path = path_fn 'cache'
M.data_path = path_fn 'data'

function M.modname(fullname)
  validate {
    fullname = { fullname, 'string' },
  }
  return fullname:match(M.sep() .. '([^' .. M.sep() .. ']+)%.lua')
end

function M.is_available_mod(modname)
  if package.loaded[modname] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(modname)
      if type(loader) == 'function' then
        package.preload[modname] = loader
        return true
      end
    end
    return false
  end
end

return M
