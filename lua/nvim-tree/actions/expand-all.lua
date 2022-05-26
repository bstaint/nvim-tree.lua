local core = require "nvim-tree.core"
local renderer = require "nvim-tree.renderer"

local M = {}

local function expand(node)
  node.open = true
  if #node.nodes == 0 then
    core.get_explorer():expand(node)
  end
end

local function iterate(parent)
  if parent.parent and parent.nodes and not parent.open then
    expand(parent)
  end

  for _, node in pairs(parent.nodes) do
    if node.nodes and not node.open then
      expand(node)
    end

    if node.open then
      iterate(node)
    end
  end
end

function M.fn(base_node)
  local node = base_node.nodes and base_node or core.get_explorer()
  iterate(node)
  renderer.draw()
end

return M
