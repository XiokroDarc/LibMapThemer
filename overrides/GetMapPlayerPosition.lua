local addon = LibMapThemer

--------------------------------------------------------------------------------
-- Player repositioning
--------------------------------------------------------------------------------
-- Overrides the players placement on the map to be with our custom blobs
addon.zos_GetMapPlayerPosition = GetMapPlayerPosition
GetMapPlayerPosition = function(unitTag)
   --local normalizedX, normalizedY, direction, isShownInCurrentMap = addon.zos_GetMapPlayerPosition(unitTag)
   local args = { addon.zos_GetMapPlayerPosition(unitTag) }
   if (addon.IsIconRepositioningEnabled()) then
      local zoneID, _, _, _ = GetUnitRawWorldPosition(unitTag)
      local playerMapId = GetMapIdByZoneId(zoneID)

      --For some reason normalizing cyrodiil freaks out the player position, 
      --this does not seem to happen with the other maps
      if (playerMapId and playerMapId ~= 0 and playerMapId ~= 16) then
         local theme = addon:GetCurrentTheme()
         if (not theme) then return unpack(args) end
         local map = theme:GetMapById(playerMapId)
         if (not map) then map = theme:GetCurrentMap() end
         if (not map) then return unpack(args) end
         args[1], args[2] = addon:GetFixedGlobalCoordinates(playerMapId, args[1], args[2])
         if (playerMapId == 108) then args[4] = true end -- show player in eyeva
      end
   end
   return unpack(args)
end