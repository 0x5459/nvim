local M = {}

M.set_keymap = function(mode, k, target, opts)
  local wk_present, wk = pcall(require, 'which-key')
  vim.keymap.set(mode, k, target, opts)

  if wk_present and opts.desc ~= nil and opts.desc ~= '' then
    wk.register({ [k] = { opts.desc } })
  else
  end
end

function M.cmd(cmd)
  return '<cmd>' .. cmd .. '<CR>'
end

function M.remap(opt)
  return function()
    opt.remap = true
    opt.noremap = false
  end
end

function M.noremap(opt)
  return function()
    opt.noremap = true
    opt.remap = false
  end
end

function M.wait(opt)
  return function()
    opt.nowait = false
  end
end

function M.nowait(opt)
  return function()
    opt.nowait = true
  end
end

function M.silent(opt)
  return function()
    opt.silent = true
  end
end

function M.nosilent(opt)
  return function()
    opt.silent = false
  end
end

function M.script(opt)
  return function()
    opt.silent = true
  end
end

function M.noscript(opt)
  return function()
    opt.nosilent = false
  end
end

function M.expr(opt)
  return function()
    opt.expr = true
  end
end

function M.noexpr(opt)
  return function()
    opt.expr = false
  end
end

function M.desc(desc)
  return function(opt)
    return function()
      opt.desc = desc
    end
  end
end

function M.unique(opt)
  return function()
    opt.unique = true
  end
end

function M.nounique(opt)
  return function()
    opt.unique = true
  end
end

function M.buffer(bufnr)
  return function(opt)
    return function()
      opt.buffer = bufnr
    end
  end
end

function M.opts(...)
  local args = { ... }
  local opts = {}

  if #args == 0 then
    return opts
  end

  for _, arg in pairs(args) do
    -- String arg will be treated as keymap descrition
    if type(arg) == 'string' then
      opts.desc = arg
    else
      arg(opts)()
    end
  end
  return opts
end

function M.map(mode)
  local function inner(key, target, opts)
    if type(key) ~= 'table' then
      inner({ key }, target, opts)
      return
    end
    for _, k in ipairs(key) do
      M.set_keymap(mode, k, target, opts)
    end
  end
  return inner
end

M.nmap = M.map 'n'
M.imap = M.map 'i'
M.cmap = M.map 'c'
M.vmap = M.map 'v'
M.xmap = M.map 'x'
M.tmap = M.map 't'

return M
