nokore.schematic_helpers = {}

-- It's like the same schematic format, but the data is down bottom up
-- that is y,z,x.
-- While minetest's schematics expect z,y,x
function nokore.schematic_helpers.from_y_slices(schematic)
  local result = {}
  result.size = schematic.size
  result.data = {}
  result.yslice_prob = schematic.yslice_prob

  local source_layer_size = result.size.z * result.size.x
  local target_layer_size = result.size.y * result.size.x

  for index,value in ipairs(schematic.data) do
    local i = index - 1
    local y = math.floor(i / source_layer_size)
    local x = i % result.size.x
    local z = math.floor(i / result.size.x) % result.size.z

    local new_index = target_layer_size * z + y * result.size.x + x

    result.data[1 + new_index] = value
  end

  assert(#result.data == #schematic.data, "data size mismatch")

  return result
end
