--
-- Classless version of YATM's NodeSoundRegistry
--
-- Works exactly the same, except it's a singleton now.
--
local function table_merge(...)
  local result = {}
  for _,t in ipairs({...}) do
    for key,value in pairs(t) do
      result[key] = value
    end
  end
  return result
end

nokore.node_sounds = {
  registered = {}
}

function nokore.node_sounds:clear()
  self.registered = {}
end

-- @type SoundSet :: {
--   extends = [name: String, ...],
--   sounds = NodeSounds -- see minetest's node sound thingy
-- }

--
-- Register a base node sound set
--
-- @spec :register(name: String, SoundSet) :: self
function nokore.node_sounds:register(name, sound_set)
  self.registered[name] = {
    extends = sound_set.extends or {},
    sounds = sound_set.sounds or {},
  }

  return self
end

--
-- Retrieve a soundset by name
--
-- @spec :get(name: String) :: SoundSet |nil
function nokore.node_sounds:get(name)
  return self.registered[name]
end

--
-- Retrieve a soundset by name
-- Will error if the soundset does not exist
--
-- @spec :fetch(name: String!) :: SoundSet
function nokore.node_sounds:fetch(name)
  local sound_set = self:get(name)
  if sound_set then
    return sound_set
  else
    error("expected sound_set name='" .. name .. "' to exist")
  end
end

--
-- Build a node sounds table by name and optionally a custom soundset over it.
--
-- @spec :build(name: String!, sound_set: SoundSet | nil) :: NodeSounds
function nokore.node_sounds:build(name, sound_set)
  sound_set = sound_set or {}
  sound_set.extends = sound_set.extends or {}
  sound_set.sounds = sound_set.sounds or {}

  local super_sound_set = self:fetch(name)
  local base = self:_build_sound_set(super_sound_set)
  local top = self:_build_sound_set(sound_set)

  return table_merge(base, top)
end

function nokore.node_sounds:_build_sound_set(sound_set)
  local base = {}

  for _, mixin_name in ipairs(sound_set.extends) do
    base = table_merge(base, self:build(mixin_name))
  end

  return base
end
