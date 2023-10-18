local addon = LibMapThemer
local themeName = "LibMapThemer_OverrideData"

_G[themeName] = {
   name = themeName,
   prefix = "LibMapThemer",
   overrides = { }
}
local theme = _G[themeName]
local overrides = theme.overrides

-------------------------------------------------------------------------------
---- GetMapTitle  -------- GetMapTitle  -------- GetMapTitle  -------- GetMapTitle  --------
-------------------------------------------------------------------------------
-- Override ESO's zone names with custom ones.
overrides["ZO_WorldMap_GetMapTitle"] = function (self, output)
   output[1] = self:GetRename(output[1])
   return output
end

-------------------------------------------------------------------------------
---- GetMapTileTexture  -------- GetMapTileTexture  -------- GetMapTileTexture  -------- GetMapTileTexture  --------
-------------------------------------------------------------------------------
overrides["GetMapTileTexture"] = function (self, output, tileIndex)
   local map = self:GetCurrentMap()
   if (map) then output[1] = map:GetTileByIndex(tileIndex) or output[1] end
   return output 
end

-------------------------------------------------------------------------------
---- GetMapPlayerWaypoint  -------- GetMapPlayerWaypoint  -------- GetMapPlayerWaypoint  -------- GetMapPlayerWaypoint  --------
-------------------------------------------------------------------------------
overrides["GetMapPlayerWaypoint"] = function(self, output)
   if (addon:IsWaypointPlaced() and addon:GetCurrentMapId() == 27) then output[1] = nil output[2] = nil end
   return output
end

---------------------------------------------------------------------------------------------
---- GetMapPlayerPosition  -------- GetMapPlayerPosition  -------- GetMapPlayerPosition  ----
---------------------------------------------------------------------------------------------
overrides["GetMapPlayerPosition"] = function(self, output, unitTag)
   --local normalizedX, normalizedY, direction, isShownInCurrentMap = addon.zos_GetMapPlayerPosition(unitTag)
   if (addon:IsIconRepositioningEnabled()) then
      local zoneID, _, _, _ = GetUnitRawWorldPosition(unitTag)
      local playerMapId = GetMapIdByZoneId(zoneID)

      --For some reason normalizing cyrodiil freaks out the player position, 
      --this does not seem to happen with the other maps
      if (playerMapId and playerMapId ~= 0 and playerMapId ~= 16) then
         local map = self:GetMapById(playerMapId)
         if (not map) then map = self:GetCurrentMap() end
         if (not map) then return output end
         output[1], output[2] = addon:GetFixedGlobalCoordinates(playerMapId, output[1], output[2])
         if (playerMapId == 108) then output[4] = true end -- show player in eyeva
      end
   end
   return output
end

----------------------------------------------------------------------------------------------------------------------------------------
---- GetFastTravelNodeInfo -------- GetFastTravelNodeInfo -------- GetFastTravelNodeInfo -------- GetFastTravelNodeInfo --------  --------  --------  --------  ----
----------------------------------------------------------------------------------------------------------------------------------------
local poi_group_house_owned   = "/esoui/art/icons/poi/poi_group_house_owned.dds"
local poi_group_house_unowned = "/esoui/art/icons/poi/poi_group_house_unowned.dds"

overrides["GetFastTravelNodeInfo"] = function (self, output, nodeIndex)
   --known, name, normalizedX, normalizedY, icon, glowIcon, poiType, isLocatedInCurrentMap
   local poiOptions = addon:GetOptions().pois
   if (not poiOptions) then return output end

   if (poiOptions.disableGlow) then output[6] = nil end
   
   local map = self:GetCurrentMap()
   if (not map) then return output end

   local repositioned = nil

   local poi = map:GetPoiById(nodeIndex)
   if (poi) then 
      if (poi.name) then output[2] = poi.name end
      if (poi.disable) then output[8] = false end
      if (poi.enable) then output[8] = true end
      if (poi.xN and poi.yN) then
         output[3] = poi.xN
         output[4] = poi.yN
         repositioned = true
      end
   end

   if (not poiOptions.showAll) then
      -- output[8] : isLocatedInCurrentMap
      output[8] = false
      local groupOrSolo
      if (poi) then
         if (poi.soloArena) then output[8] = addon:GetOptions().pois.soloArenas end
         if (poi.groupArena) then output[8] = addon:GetOptions().pois.groupArenas end
         groupOrSolo = poi.groupArena or poi.soloArena
      end
      if (not groupOrSolo) then
         -- output[7] : poiType
         if (output[7] == POI_TYPE_ACHIEVEMENT)   then output[8] = addon:GetOptions().pois.trials end
         if (output[7] == POI_TYPE_GROUP_DUNGEON) then output[8] = addon:GetOptions().pois.dungeons end
         if (output[7] == POI_TYPE_HOUSE) then
            -- output[5] : icon
            if (output[5] == poi_group_house_owned) then output[8] = addon:GetOptions().pois.ownedHouses end
            if (output[5] == poi_group_house_unowned) then output[8] = addon:GetOptions().pois.unownedHouses end
         end
         if (output[7] == POI_TYPE_WAYSHRINE and poi) then
            output[8] = ((poi.guildShrine and addon:GetOptions().pois.guildShrines) or 
                     (poi.majorSettlement and addon:GetOptions().pois.majorSettlements))
         end
      end
   end

   if (output[8] and map:IsMapTamriel()) then
      if ((poi and not repositioned) or not poi) then
         local zoneIndex, poiIndex = GetFastTravelNodePOIIndicies(nodeIndex)
         local parentId = addon:GetParentMapId(GetMapIdByZoneId(GetZoneId(zoneIndex)))
         local globalXN, globalYN = GetPOIMapInfo(zoneIndex, poiIndex)
         output[3],  output[4] = addon:GetFixedGlobalCoordinates(parentId, globalXN, globalYN)
      end
   end

   return output
end

-------------------------------------------------------------------------------
---- GetMapMouseoverInfo  -------- GetMapMouseoverInfo  -------- GetMapMouseoverInfo  -------- GetMapMouseoverInfo  --------
-------------------------------------------------------------------------------
overrides["GetUniversallyNormalizedMapInfo"] = function(self, output, zoneId)
   -- local normalizedOffsetX, normalizedOffsetY, normalizedWidth, normalizedHeight = 
   if (addon:IsIconRepositioningEnabled()) then
      local zone = self:GetZoneFromMapById(27, zoneId)
      if (zone) then 
         local blob = zone:GetBlob()
         local x, y, width, height = blob:GetOffsetBounds(addon.TAMRIEL_VERTICAL_OFFSET)
         if (x and y and width and height) then
            output[1], output[2], output[3], output[4] = x, y, width, height
         end
      end
   end
   return output
end

------------------------------
---- GetMapMouseoverInfo  ----
------------------------------
overrides["GetMapMouseoverInfo"] = function (self, output)
   --locationName, textureFile, widthN, heightN, locXN, locYN
   local map = self:GetCurrentMap()
   if (map and map:IsDefaultZonesDisabled()) then
      --locationName, textureFile
      output[1], output[2] = "", ""
      --widthN, heightN, locXN, locYN
      output[3], output[4], output[5], output[6] = 0, 0, 0, 0
   end

   output[1] = self:GetRename(output[1])

   local zone = addon:GetSelectedZone()
   if (zone) then 
      local blob = zone:GetBlob()
      output[1] = zone:GetZoneRename()
      output[2] = blob:GetTextureFileName()
      local x, y, width, height = blob:GetBounds()
      if (x and y and width and height) then 
         output[5],output[6],output[3],output[4] = x, y, width, height 
      end
   end
   
   return output
end
