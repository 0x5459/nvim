local M = {}

local features = {
  icons = false,
  terminal = false,
}

function M.icons(feats)
  return function()
    feats.icons = true
  end
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
