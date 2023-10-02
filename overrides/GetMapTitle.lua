local addon = LibMapThemer
-------------------------------------------------------------------------------
-- Zone name functions
-------------------------------------------------------------------------------
-- Override ESO's zone names with custom ones.
addon.zos_GetMapTitle = ZO_WorldMap_GetMapTitle
ZO_WorldMap_GetMapTitle = function()
   local title = addon.zos_GetMapTitle()
   local theme = addon:GetCurrentTheme()
   if (not theme) then return title end
   return theme:GetRename(title, true)
end

