--
-- Nokore is now built on foundation, so check foundation for the API.
--
local mod = foundation.new_module("nokore_prelude", "0.3.0")

mod.game = "nokore"
mod.is_prelude = true
mod.node_sounds = foundation.com.NodeSoundsRegistry:new("nokore_prelude:node_sounds_registry")

-- @namespace nokore
nokore = rawget(_G, "nokore") or {}
nokore.VERSION = assert(mod.VERSION)
-- @alias node_sounds = nokore_prelude.node_sounds
nokore.node_sounds = mod.node_sounds

-- register the "default" node sound set, usually just empty
nokore.node_sounds:register_new("default", {})

nokore.node_sounds:register_new("metal", {})
