local addon = LibMapThemer

addon.zos_GetMapTileTexture = GetMapTileTexture
GetMapTileTexture = function(tileIndex)
   local tileTexture = addon.zos_GetMapTileTexture(tileIndex)
   local theme = addon:GetCurrentTheme()
   if (not theme) then return tileTexture end
   local map = theme:GetCurrentMap()
   if (not map) then return tileTexture end
   return map:GetTileByIndex(tileIndex) or tileTexture 
end
