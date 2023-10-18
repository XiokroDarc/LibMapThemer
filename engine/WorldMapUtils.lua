local addon = LibMapThemer
local GPS, LZ, LMP = LibGPS3, LibZone, LibMapPing
local selectedZone

local pinType = "LibMapThemerBlob"

local pinLayout =  { 
   level = 30,
   size = 32,
   insetX = 4,
   insetY = 4,
   texture = "",
   minAreaSize = 32,
   showsPinAndArea = true
}

function addon:GetCurrentMapId() return GetCurrentMapId() end

------------------
--- Navigation ---
------------------
function addon:NavigateToMap(mapId)
   if (mapId == nil) then return false end
   SetMapToMapId(mapId)
   GPS:SetPlayerChoseCurrentMap()
   CALLBACK_MANAGER:FireCallbacks("OnWorldMapChanged")
   ZO_WorldMap_GetPanAndZoom():SetCurrentNormalizedZoom(0)
   return true
end

function addon:NavigateToZone(zone) if (zone) then self:NavigateToMap(zone:GetZoneId()) end end

function addon:NavigateToSelectedZone() self:NavigateToZone(self:GetSelectedZone()) end

function addon:SetSelectedZone(zone) selectedZone = zone end

function addon:GetSelectedZone() return selectedZone end

-----------------------
--- World Map Hooks ---
-----------------------

local function OnPinCreate(self) 
   local theme = addon:GetCurrentTheme()
   if (theme) then theme:Update() end
end

local function OnPinUpdate(self) 
   local map = addon:GetCurrentMap()
   if (map) then map:Update() end
end

ZO_WorldMap_AddCustomPin(pinType, OnPinCreate, OnPinUpdate, pinLayout)

ZO_WorldMap_SetCustomPinEnabled(_G[pinType], true)

SecurePostHook(ZO_WorldMap_GetPanAndZoom(), "SetCurrentNormalizedZoomInternal", OnPinUpdate)

ZO_PreHook("ProcessMapClick", function(xN, yN)
   local map = addon:GetCurrentMap()
   if (map and map:IsDefaultZonesDisabled()) then return true end
   if (addon:IsInGamepadMode()) then addon:NavigateToSelectedZone() return true end
end)
  
ZO_PreHook("ZO_WorldMap_MouseUp", function(self, mouseButton, upInside)
   local map = addon:GetCurrentMap()
   if (not map) then return end
   if (mouseButton == MOUSE_BUTTON_INDEX_RIGHT and upInside) then
      if (map.parentId) then
         addon:SetSelectedZone(nil)
         addon:NavigateToMap(map.parentId)
         return true
      end
   end
end)

CALLBACK_MANAGER:RegisterCallback("OnWorldMapShown", function (self) addon:SetSelectedZone(nil) end)

EVENT_MANAGER:RegisterForUpdate("OnMapUpdate", 0, function (self)
   if (ZO_WorldMap:IsHidden()) then return end
   
   local map = addon:GetCurrentMap()
   if (not map) then return end

   local selectedZone = addon:GetSelectedZone()
   if (not selectedZone and addon:IsInGamepadMode()) then
      local zones = map:GetAllZones()
      for _, zone in pairs(zones) do
         local polygon = zone:GetBlob():GetPolygon()
         if (polygon) then
            if (polygon:IsPointInside(addon:GetMouseCoordinates())) then
               addon:SetSelectedZone(zone)
               break
            end
         end
      end
   elseif (selectedZone) then
      local polygon = selectedZone:GetBlob():GetPolygon()
      if (polygon and not polygon:IsPointInside(addon:GetMouseCoordinates())) then
         addon:SetSelectedZone(nil)
      end
   end
end)

--------------------------
--- Zoom Customization ---
--------------------------
function addon:SetCustomMaxZoom(maxZoom)
   ZO_WorldMap_ClearCustomZoomLevels()
   if (self:IsInGamepadMode() or not maxZoom) then return end
   ZO_WorldMap_SetCustomZoomLevels(1, maxZoom) 
end

------------------------
--- Map Measurements ---
------------------------
function addon:GetWorldMapOffsets() return math.floor(WorldMapContainer:GetLeft()), math.floor(WorldMapContainer:GetTop()) end

function addon:RecalculateMapMeasurements() GPS:ClearMapMeasurements() GPS:CalculateMapMeasurement() end

function addon:GetFixedGlobalCoordinates(mapId, vanillaGlobalNX, vanillaGlobalNY)
   local measurement = GPS:GetMapMeasurementByMapId(mapId)
   if (not measurement) then return vanillaGlobalNX, vanillaGlobalNY end

   local zos_GetUniversallyNormalizedMapInfo = addon:GetZosFunction("GetUniversallyNormalizedMapInfo")
   local nOffsetX, nOffsetY, nWidth, nHeight = zos_GetUniversallyNormalizedMapInfo(mapId)
   
   local vanillaLocalNX = (vanillaGlobalNX - nOffsetX) / nWidth
   local vanillaLocalNY = (vanillaGlobalNY -(nOffsetY - addon.TAMRIEL_VERTICAL_OFFSET)) / nHeight 

   --addon:Print(vanillaLocalNX..", "..vanillaLocalNY)
   local x, y = measurement:ToGlobal(vanillaLocalNX, vanillaLocalNY)

   --local x, y = vanillaLocalNX, vanillaLocalNY
   return x, y
end

----------------------------
--- Get Parent Functions ---
----------------------------
function addon:GetParentZoneId(zoneId)
   local parentZoneID = GetParentZoneId(zoneId)
   if (self:IsGeoParentEnabled() and LZ:GetGeographicalParentMapId(zoneId)) then parentZoneID = LZ:GetGeographicalParentMapId(zoneId) end
   return parentZoneID 
end

function addon:GetParentMapId(mapID)
   if (not mapID) then return end
   local parentID
   if (self:IsGeoParentEnabled()) then    
      parentID = LZ:GetGeographicalParentMapId(mapID)
   else
      local _, _, _, zoneIndex, _ = GetMapInfoById(mapID)
      parentID = self:GetParentZoneId(GetZoneId(zoneIndex))
   end

   if (parentID) then
      local theme = self:GetCurrentTheme()
      if (not theme or parentID == 0) then return mapID end
      local map = theme:GetMapById(mapID)
      if (map and map:GetParentMapId()) then return mapID end
   end
   return parentID
end

-------------------------------
--- Mouse/Gamepad Functions ---
-------------------------------
function addon:GetMouseCoordinates() if (self:IsInGamepadMode()) then return ZO_WorldMapScroll:GetCenter() else return GetUIMousePosition() end end

function addon:GetNormalizeCoordinates(x, y, xN, yN, widthN, heightN)
   local normalizedMouseX = math.floor((((x - xN) / widthN) * 10000) + 0.5)/10000
   local normalizedMouseY = math.floor((((y - yN) / heightN) * 10000) + 0.5)/10000
   return normalizedMouseX, normalizedMouseY 
end

function addon:GetNormalizeMouse(xN, yN, widthN, heightN)
   local x, y = self:GetMouseCoordinates()
   return self:GetNormalizeCoordinates(x, y, xN, yN, widthN, heightN)
end

function addon:GetWorldMapMouseCoordinates()
   local left, top = ZO_WorldMapContainer:GetLeft(), ZO_WorldMapContainer:GetTop()
   local width, height = ZO_WorldMapContainer:GetDimensions()
   return self:GetNormalizeMouse(left, top, width, height)
end


------------------------------
--- Misc Boolean Functions ---
------------------------------
function addon:IsGeoParentEnabled() return (LZ and LZ["GetGeographicalParentMapId"]) end

function addon:IsIconRepositioningEnabled() return (GPS["GetMapMeasurementByMapId"] ~= nil) end

function addon:IsWaypointPlaced() return LMP:HasMapPing(MAP_PIN_TYPE_PLAYER_WAYPOINT, "waypoint") end

function addon:IsInGamepadMode() return (IsInGamepadPreferredMode() and not ZO_WorldMapCenterPoint:IsHidden()) end

function addon:IsMouseWithinMapWindow()
   local mouseOverControl = WINDOW_MANAGER:GetMouseOverControl()
   return (not WorldMapContainer:IsHidden() and (mouseOverControl == WorldMapContainer or mouseOverControl:GetParent() == WorldMapContainer))
end

function addon:IsWorldMapActive() return ((not WorldMapContainer:IsHidden() and WorldMapContainer:GetAlpha() == 1) or ZO_WorldMap_IsWorldMapShowing()) end

function addon:InWorldMap() return (self:IsWorldMapActive() and self:IsMouseWithinMapWindow()) end


