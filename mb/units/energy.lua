local Unit = require "mb.units.base.unit"
local Type = require "mb.units.base.type"

local Prefix = require "mb.units.prefix"
local Time = require "mb.units.time"

--- Energy units.
local Energy = Type.new()

Energy:register_base(Unit.BASE ~ "FE") -- Define Forge Energy as a base unit.
Energy:register(Energy["FE"] .. "RF") -- Red Flux.
Energy:register(Energy["FE"] * 2.5 .. "J") -- Mekanism joule.
Energy:register(Energy["FE"] * 0.25 .. "EU") -- Energy Unit.
-- Define other energy units with respect to FE instead of J.
Energy:register(Energy["FE"] .. "Ws") -- Watt-second.
Energy:register(Energy["Ws"] / Time["s"]:get_multiplier() * Time["h"]:get_multiplier() .. "Wh") -- Watt-hour.
Energy:register(Energy["FE"] * 0.239 .. "cal") -- Calorie.
Energy:register(Energy["FE"] * 6.242e18 .. "eV") -- Electronvolt.

--- Apply prefxes to the unit.
---@param unit string
---@param prefixes string[]
local function apply_prefixes(unit, prefixes)
  for _, prefix in ipairs(prefixes) do
    Energy:register(Prefix[prefix] * Energy[unit])
  end
end

apply_prefixes("FE", {"k", "M", "G", "T"})
apply_prefixes("EU", {"Ki", "Mi", "Gi", "Ti"})
apply_prefixes("Wh", {"k", "M", "G", "T"})

return Energy
