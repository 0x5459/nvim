local M = {}

local features = {
  icons = false,
  terminal = false,
  lsp = {},
}

function M.icons(feats)
  return function()
    feats.icons = true
  end
end

function M.terminal(feats)
  return function()
    feats.terminal = true
  end
end

function M.lsp(lsp)
  return function(feats)
    return function()
      feats.lsp = lsp
    end
  end
end

function M.add_lsp_support(lang)
  return function(feats)
    return function()
      table.insert(feats.lsp, lang)
    end
  end
end

function M.lsp_support(lang)
  for _, v in ipairs(M.features().lsp) do
    if v == lang then
      return true
    end
  end
  return false
end

function M.enable(...)
  for _, fn in ipairs { ... } do
    fn(features)()
  end
end

function M.features()
  return features
end

return M
