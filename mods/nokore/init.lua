--
-- NoKore
--
-- This is the core module of NoKore, it only provides registration helpers
-- and module creation.
nokore = rawget(_G, "nokore") or {}

local nokore_module = {}

function nokore_module:register_node(name, entry)
  return minetest.register_node(self._name .. ":" .. name, entry)
end

function nokore_module:register_craftitem(name, entry)
  return minetest.register_craftitem(self._name .. ":" .. name, entry)
end

function nokore_module:register_tool(name, entry)
  return minetest.register_tool(self._name .. ":" .. name, entry)
end

--
-- Creates or retrieves an existing mod's module
-- The modpath is automatically set on call
--
-- @spec nokore.new_module(name: String, default: Table) :: Table
function nokore.new_module(name, version, default)
  local mod = rawget(_G, name) or default or {}
  mod._name = name
  mod._is_nokore_module = true
  mod.VERSION = version
  mod.S = minetest.get_translator(name)
  mod.modpath = minetest.get_modpath(minetest.get_current_modname())
  rawset(_G, name, mod)
  setmetatable(mod, { __index = nokore_module })
  print("New NoKore Module: " .. mod._name .. " " .. mod.VERSION)
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
      return nokore.version:test(value.VERSION, optional_version)
    else
      return true
    end
  end
  return false
end

-- Bootstrap itself
nokore.new_module("nokore", "0.1.0", nokore)

nokore.self_test = true

dofile(nokore.modpath .. "/version.lua")
dofile(nokore.modpath .. "/node_sounds.lua")
dofile(nokore.modpath .. "/schematic_helpers.lua")

if nokore.self_test then
  assert(nokore.is_module_present("nokore"), "expected nokore itself to be present")
  assert(nokore.is_module_present("nokore", "0.1.0"), "expected it's match to match")
end
