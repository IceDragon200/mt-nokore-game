--
--
--
nokore = rawget(_G, "nokore") or {}

--
-- Creates or retrieves an existing mod's module
-- The modpath is automatically set on call
--
-- @spec nokore.new_module(name: String, default: Table) :: Table
function nokore.new_module(name, version, default)
  local mod = rawget(_G, name) or default
  mod._is_nokore_module = true
  mod.version = version
  mod.modpath = minetest.get_modpath(minetest.get_current_modname())
  rawset(_G, name, mod)
  return mod
end

--
-- Determines if specified module exists
--
-- @spec nokore.is_module_present(name: String, optional_version: String) :: Boolean
function nokore.is_module_present(name, optional_version)
  local value = rawget(_G, name)

  if type(value) == "table" then
    if optional_version then
      return nokore.version:test(value.version, optional_version)
    else
      return true
    end
  end
  return false
end

-- Bootstrap itself
new_module("nokore", "0.1.0", nokore)

nokore.self_test = true

dofile(nokore.modpath .. "/version.lua")
dofile(nokore.modpath .. "/node_sounds.lua")

if nokore.self_test then
  assert(nokore.is_module_present("nokore"), "expected nokore itself to be present")
  assert(nokore.is_module_present("nokore", "0.1.0"), "expected it's match to match")
end
