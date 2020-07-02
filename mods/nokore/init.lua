--
--
--
nokore = rawget(_G, "nokore") or {}

--
-- Creates or retrieves an existing mod's module
-- The modpath is automatically set on call
--
-- @spec nokore.new_module(name: String, default: Table) :: Table
function nokore.new_module(name, default)
  local mod = rawget(_G, name) or default
  mod._is_nokore_module = true
  mod.modpath = minetest.get_modpath(minetest.get_current_modname())
  rawset(_G, name, mod)
  return mod
end

--
-- Determines if specified module exists
--
-- @spec nokore.is_module_present(name: String) :: Boolean
function nokore.is_module_present(name)
  return type(rawget(_G, name)) == "table"
end

-- Bootstrap itself
new_module("nokore", nokore)

dofile(nokore.modpath .. "/node_sounds.lua")
