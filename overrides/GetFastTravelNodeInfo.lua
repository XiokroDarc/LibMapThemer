local addon = LibMapThemer

--TODO cleanup code

local poi_group_house_owned = "/esoui/art/icons/poi/poi_group_house_owned.dds"
local poi_group_house_unowned = "/esoui/art/icons/poi/poi_group_house_unowned.dds"

local POI_TYPE_SOLO_ARENA = 12345689
local POI_TYPE_GROUP_ARENA = 987654321

local poiTypeSwitch = {
   [POI_TYPE_ACHIEVEMENT] = function ()
      return addon:GetOptions().pois.trials
   end,

   [POI_TYPE_GROUP_DUNGEON] = function ()
      return addon:GetOptions().pois.dungeons
   end,

   [POI_TYPE_HOUSE] = function (_, icon)
      if (not icon) then return nil end
      local poiOptions = addon:GetOptions().pois
      if (icon == poi_group_house_owned) then
         return poiOptions.ownedHouses
      elseif (icon == poi_group_house_unowned) then
         return poiOptions.unownedHouses
      end
   end,
   
   [POI_TYPE_WAYSHRINE] = function (poi)
      if (not poi) then return false end
      local poiOptions = addon:GetOptions().pois
      local showMajor = (poi.majorSettlement and poiOptions.majorSettlements)
      local showGuild = (poi.guildShrine and poiOptions.guildShrines)
      return (showMajor or showGuild)
   end,

   [POI_TYPE_SOLO_ARENA] = function ()
      return addon:GetOptions().pois.soloArenas
   end,

   [POI_TYPE_GROUP_ARENA] = function ()
      return addon:GetOptions().pois.groupArenas
   end,
}

addon.zos_GetFastTravelNodeInfo = GetFastTravelNodeInfo    
GetFastTravelNodeInfo = function(nodeIndex)
   --known, name, normalizedX, normalizedY, icon, glowIcon, poiType, isLocatedInCurrentMap, linkedCollectibleIsLocked
   local args = { addon.zos_GetFastTravelNodeInfo(nodeIndex) }

   local poiOptions = addon:GetOptions().pois
   if (not poiOptions) then return unpack(args) end

   if (poiOptions.disableGlow) then args[6] = nil end
   
   local theme = addon:GetCurrentTheme()
   if (not theme) then return unpack(args) end

   local map = theme:GetCurrentMap()
   if (not map) then return unpack(args) end

   local repositioned = nil

   local poi = map:GetPoiById(nodeIndex)
   if (poi) then 
      if (poi.name) then args[2] = poi.name end
      if (poi.disable) then args[8] = false end
      if (poi.enable) then args[8] = true end
      if (poi.xN and poi.yN) then
         args[3] = poi.xN
         args[4] = poi.yN
         repositioned = true
      end
   end

   if (not poiOptions.showAll) then
      args[8] = false
      local groupOrSolo
      if (poi) then
         if (poi.soloArena) then args[8] = poiTypeSwitch[POI_TYPE_SOLO_ARENA]() end
         if (poi.groupArena) then args[8] = poiTypeSwitch[POI_TYPE_GROUP_ARENA]() end
         groupOrSolo = poi.groupArena or poi.soloArena
      end
      local showPoi = poiTypeSwitch[args[7]]
      if (showPoi and not groupOrSolo) then 
         args[8] = showPoi(poi, args[5]) 
      end
   end

   if (args[8] and map:IsMapTamriel()) then
      if ((poi and not repositioned) or not poi) then
         local zoneIndex, poiIndex = GetFastTravelNodePOIIndicies(nodeIndex)
         local parentId = addon:GetParentMapId(GetMapIdByZoneId(GetZoneId(zoneIndex)))
         local globalXN, globalYN = GetPOIMapInfo(zoneIndex, poiIndex)
         args[3], args[4] = addon:GetFixedGlobalCoordinates(parentId, globalXN, globalYN)
         args[3] = args[3] or 0
         args[4] = args[4] or 0
      end
   end

   return unpack(args)
end

