local addon = LibMapThemer
local chat = (LibChatMessage and LibChatMessage(addon:GetName(), "LMT"))

addon.Print = function (self, message) if (chat) then chat:Print(message) end end
--------------------------------------
-- Requires DebugChat to be enabled --
SLASH_COMMANDS["/print_mapid"] = function() addon:Print("Current MapId = "..addon:GetCurrentMapId()) end

SLASH_COMMANDS["/print_mouseover"] =  function ()
   local mouseX, mouseY = addon:GetWorldMapMouseCoordinates()
   local locationName, textureFile, widthN, heightN, locXN, locYN = GetMapMouseoverInfo(mouseX, mouseY)
   local x, y = string.format("%.04f", locXN), string.format("%.04f", locYN)
   local w, h = string.format("%.04f", widthN), string.format("%.04f", heightN)
   addon:Print("LocationName = "..locationName.."\nTextureFile = "..textureFile.."\nBounds = { "..x..", "..y..", "..w..", "..h.." }")
end

SLASH_COMMANDS["/print_maplist"] = function ()
   local maps = addon:GetAllMaps()
   if (not maps) then return end
   local mapList = "MapCount = "..#maps.."\n"
   for mapId, map in pairs(maps) do mapList = mapList..(mapId.." : "..map:GetMapName()).."\n" end
   addon:Print(mapList)
end
 
SLASH_COMMANDS["/print_zonelist"] = function (mapId)
   local map = addon:GetMapById(addon:ParseIntArgs(mapId))
   if (not map) then return end
   local zones = map:GetAllZones()
   if (not zones) then return end
   local zonesList = "ZoneCount = "..#zones.."\n"
   for zoneId, zone in pairs(zones) do zonesList = zonesList..(zoneId.." : "..zone:GetZoneName()).."\n" end
   addon:Print(zonesList)
end
