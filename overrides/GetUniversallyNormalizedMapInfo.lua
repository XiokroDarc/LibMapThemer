local addon = LibMapThemer


addon.zos_GetUniversallyNormalizedMapInfo = GetUniversallyNormalizedMapInfo
GetUniversallyNormalizedMapInfo = function(zoneId)
   -- local normalizedOffsetX, normalizedOffsetY, normalizedWidth, normalizedHeight = 
   local args = { addon.zos_GetUniversallyNormalizedMapInfo(zoneId) }
   if (addon:IsIconRepositioningEnabled()) then
      local theme = addon:GetCurrentTheme()
      if (not theme) then return unpack(args) end

      local map = theme:GetMapById(27)
      if (not map) then return unpack(args) end
      local zone = map:GetZoneById(zoneId)
      if (not zone) then return unpack(args) end
      local blob = zone:GetBlob()
      if (not blob) then return unpack(args) end
      --return normalizedOffsetX, normalizedOffsetY, normalizedWidth, normalizedHeight end
      if (blob) then return blob:GetOffsetBounds(addon.TAMRIEL_VERTICAL_OFFSET) end
   end

   return unpack(args)
end
