local Type = require "mb.units.base.type"

local Energy = require "mb.units.energy"
local Time = require "mb.units.time"

--- Power units.
local Power = Type.new()

--- Units cross product.
---@param a string[] Energy units.
---@param b string[] Time units.
local function cross_product(a, b)
  for _, energy in ipairs(a) do
    for _, time in ipairs(b) do
      Power:register(Energy[energy] / Time[time])
    end
  end
end

Power:register_base(Energy["base"] / Time["base"])
cross_product({"FE", "kFE", "MFE", "GFE", "TFE"}, {"t", "s", "min", "h", "d"})
cross_product({"J", "EU", "KiEU", "MiEU", "GiEU", "TiEU", "RF"}, {"t"})
-- Define Watt as FE/s instead of J/s as FE is the standard unit.
Power:register(Power["FE/s"] .. "W")
Power:register(Power["W"] / 745.7 .. "hp")

return Power
