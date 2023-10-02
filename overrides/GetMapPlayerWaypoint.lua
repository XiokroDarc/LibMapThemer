
local addon = LibMapThemer
local GPS, LZ, LMP = LibGPS3, LibZone, LibMapPing

local lastMapId, viewedTamrielMap
addon.zos_WorldMap_UpdateMap = ZO_WorldMap_UpdateMap
ZO_WorldMap_UpdateMap = function ()
   local args = { addon.zos_WorldMap_UpdateMap() }
   local currentMapId = addon:GetCurrentMapId()
   if (not viewedTamrielMap) then
      if (currentMapId == 27) then viewedTamrielMap = true
      else lastMapId = currentMapId end
   end
   return unpack(args)
end

addon.zos_GetMapPlayerWaypoint = GetMapPlayerWaypoint
GetMapPlayerWaypoint = function()
   local args = { addon.zos_GetMapPlayerWaypoint() }
   if (not addon:IsWaypointPlaced()) then return unpack(args) end
   if (addon:GetCurrentMapId() == 27) then return nil end
   return unpack(args)
end

--[[
if (not addon:IsIconRepositioningEnabled() or not addon:IsWaypointPlaced()) then return unpack(args) end

local lastWaypointMapID, lastWaypointXN, lastWaypointYN, lastLocalXN, lastLocalYN

local function GetFixedLocalCoordinates(mapId, vanillaLocalNX, vanillaLocalNY)
   if (not lastWaypointXN or not lastWaypointYN) then return end
   local measurement = GPS:GetMapMeasurementByMapId(mapId)
   if (not measurement) then return vanillaLocalNX, vanillaLocalNY end
   local moddedLocalNX, moddedLocalNY = measurement:ToLocal(lastWaypointXN, lastWaypointYN)
   if (LMP:IsPositionOnMap(moddedLocalNX, moddedLocalNY)) then
      return moddedLocalNX, moddedLocalNY
   else
      return vanillaLocalNX, vanillaLocalNY
   end
end

--]]