local addon = LibMapThemer

addon.zos_GetMapMouseoverInfo = GetMapMouseoverInfo
GetMapMouseoverInfo = function(xN, yN)
   --local locationName, textureFile, widthN, heightN, locXN, locYN  = addon.zos_GetMapMouseoverInfo(xN, yN)
   local args = { addon.zos_GetMapMouseoverInfo(xN, yN) }

   local theme = addon:GetCurrentTheme()
   if (not theme) then return unpack(args) end
   args[1] = theme:GetRename(args[1], true)
   local map = theme:GetCurrentMap()
   
   if (not map) then return unpack(args) end

   if (not map:ShouldKeepOriginalBlobs()) then
      --addon:Print("MapId = "..map:GetMapId())
      ---[[
      args[1] = ""
      args[2] = ""
      --widthN, heightN
      args[3], args[4] = 0, 0
      --locXN, yN
      args[5], args[6] = 0, 0
      --]]
   end

   local zone = addon:GetSelectedZone()
   if (not zone) then return unpack(args) end
   
   args[1] = zone:GetZoneRename()
   args[2] = zone:GetTexture()
   local x, y, width, height = zone:GetBounds()
   if (x and y and width and height) then
      args[5],args[6],args[3],args[4] = x, y, width, height
   end
   --args[5],args[6],args[3],args[4] = zone:GetBounds()
   return unpack(args)
end
