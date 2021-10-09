--
-- Nokore is now built on foundation, so check foundation for the API.
--
local mod = foundation.new_module("nokore_prelude", "0.3.0")

mod.game = "nokore"
mod.is_prelude = true
mod.node_sounds = foundation.com.NodeSoundsRegistry:new()
