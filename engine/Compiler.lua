local addon = LibMapThemer
local pinType = "LibMapThemerBlob"
local layout =  { level = 30, size = 32, insetX = 4, insetY = 4, texture = "", minAreaSize=32, showsPinAndArea= true }
local blobManager = addon:GetBlobManager()


local function FullCopy(table, seen)
   seen = seen or {}
   if (not table) then return nil end
   if (seen[table]) then return seen[table] end
   local tableCopy
   if (type(table) == 'table') then
      tableCopy = {}
      seen[table] = tableCopy
      for key, value in next, table, nil do
         tableCopy[FullCopy(key, seen)] = FullCopy(value, seen)
      end
      setmetatable(tableCopy, FullCopy(getmetatable(table), seen))
   else tableCopy = table end
   return tableCopy 
end

local function Merge(original, merge)
   if (type(original) == 'table' and type(merge) == 'table') then
      for key, value in pairs(merge) do             
         local isValidTable = ((key ~= "data") and (key ~= "bounds"))
         if ((type(value) == 'table' and type(original[key] or false) == 'table') and isValidTable) then 
            Merge(original[key], value) 
         else
            original[key] = value
         end
      end
   end
   return original
end

local function CopyAndMerge(original, merge)
   return Merge(original, FullCopy(merge))
end

function CompileZone(theme, map, zoneId, zone)
   if (not theme or not map or not zoneId or not zone) then return end
   zone.IsEnabled = function(self) return map:IsEnabled() end
   zone.GetMapId = function(self) return map:GetMapId() end
   zone.GetZoneId = function(self) return zoneId end
   zone.GetMap = function(self) return map end
   zone.GetZoneName = function (self) return theme:GetMapNameById(zoneId) end
   zone.GetZoneRename = function (self, keepLineBreaks) 
      return theme:GetRename(self:GetZoneName(), not keepLineBreaks)
   end
   zone.GetFontName = function (self) return self.fontName or map:GetFontName() end
   zone.GetFontSize = function (self) return self.fontSize or map:GetFontSize() end
   zone.GetFontColor = function (self) return self.fontColor or map:GetFontColor() end
   zone.GetFullFont = function (self)
      return ("EsoUI/Common/Fonts/"..self:GetFontName() ..".otf |"..self:GetFontSize().."|thin-outline") 
   end

   --zone.HideZoneName = function (self) return self.hideZoneName end
   zone.IsShowingName = function (self) return (not self.hideName and (self.showName or map:IsShowingZoneNames())) end
   
   local blob = blobManager:CompileBlob(theme, zone, zone.blob)
   --local blob = blobManager:NewBlob(theme, zone, zone.blob)
   zone.GetBlob = function(self) return blob end
   zone.GetBounds = function (self) 
      if (not blob) then return end
      return blob:GetBounds() 
   end
   zone.GetTexture = function (self)
      if (not blob) then return nil end
      return blob:GetTextureFileName()
   end

   zone.Update = function (self)
      if (blob) then blob:Update() end
   end
end

function CompileAllZones(theme, map, zones)
   if (not theme or not map or not zones) then return end
   for zoneId, zone in pairs(zones) do
      CompileZone(theme, map, zoneId, zone)
   end
end

function CompileMap(theme, mapId, map)
   if (not theme or not mapId or not map) then return end

   map.GetTheme = function (self) return theme end

   map.GetMapId = function (self) return mapId end

   map.GetParentId = function (self) return map.parentID end

   map.IsEnabled = function (self) return (theme:IsEnabled() and mapId == addon:GetCurrentMapId()) end

   theme.GetMapNameById = function(self, mapId)
      if (type(mapId) == "string") then return mapId end
      return GetMapNameById(mapId)
   end

   map.GetAllPois = function (self) return self.pois end
   map.GetPoiById = function (self, poiId)
      local pois = self:GetAllPois()
      if (pois) then return pois[poiId] end
   end

   map.ShouldKeepOriginalBlobs = function (self) 
      return ((self.keepOriginalBlobs == true) or (self.zones == nil))
   end

   map.GetAllZones = function (self) return self.zones end
   map.GetZoneById = function (self, zoneId)
      local zones = self:GetAllZones()
      if (zones) then return zones[zoneId] end
   end

   map.GetMapName    = function (self) return theme:GetMapNameById(mapId) end
   map.GetMapRename  = function (self, keepLineBreaks) return theme:GetRename(self:GetMapName(), not keepLineBreaks) end

   map.GetFontName   = function (self) return self.fontName  or theme:GetFontName()  end
   map.GetFontSize   = function (self) return self.fontSize  or theme:GetFontName()  end
   map.GetFontColor  = function (self) return self.fontColor or theme:GetFontColor() end
   map.GetFullFont   = function (self) return ("EsoUI/Common/Fonts/"..self:GetFontName() ..".otf |"..self:GetFontSize().."|thin-outline") end

   map.GetTilePath   = function(self) return self.tilePath end
   map.GetTileByIndex= function (self, index)
      if (not index) then return nil end
      local tilePath = self:GetTilePath()
      if (tilePath) then return (tilePath..index..".dds") end
   end

   map.GetOverrideTileByIndex = function (self, index) 
       if (index and self.overrideTiles) then return self.overrideTiles[index] end
   end

   map.GetMaxZoom    = function (self) return self.maxZoom end
   
   --map.HideZoneNames = function (self) return self.hideZoneNames or theme:HideZoneNames() end
   map.IsShowingZoneNames = function (self) return (self.showZoneNames or theme:IsShowingZoneNames()) end
   map.SetZoneNameVisibility = function (self, visbility) self.showZoneNames = visbility end

   map.IsMapTamriel  = function (self) return mapId == 27 end
   map.IsMapAurbis   = function (self) return mapId == 439 end

   map.Update = function (self)
      local zones = self:GetAllZones()
      if (not zones) then return end
      for _, zone in pairs(zones) do zone:Update() end
   end

   CompileAllZones(theme, map, map:GetAllZones())
end

function CompileAllMaps(theme, maps)
   if (not theme or not maps) then return end
   for mapId, map in pairs(maps) do
      CompileMap(theme, mapId, map)
   end
end

function CompileTheme(theme)
   if (not theme or not theme.name) then return nil end
   if (not theme.prexfix) then theme.prexfix = theme.name end
   
   theme.GetName           = function (self) return self.name end
   theme.GetPrefix         = function (self) return self.prexfix end
   theme.GetDependencies   = function (self) return self.dependencies end
   theme.IsEnabled = function (self) 
      return self:GetName() == addon:GetCurrentThemeName()
   end

   theme.GetRenameList  = function (self) return self.renames end
   theme.GetRename      = function (self, name, removeLineBreaks) 
      local renames = self:GetRenameList()
      if (not renames) then return name end
      local rename = renames[name] or name
      if (removeLineBreaks) then rename = string.gsub(rename, "\n", "") end
      return rename
   end

   theme.GetFontName = function (self) return self.fontName or addon:GetOptions().fontName end
   theme.GetFontSize = function (self) return self.fontSize or addon:GetOptions().fontSize end
   theme.GetFontColor  = function (self) return self.fontColor or addon:GetOptions().fontColor end
   theme.GetFullFont = function (self)
      return ("EsoUI/Common/Fonts/"..self:GetFontName() ..".otf |"..self:GetFontSize().."|thin-outline") 
   end

   theme.IsShowingZoneNames = function (self) return self.showZoneNames end
   theme.SetZoneNameVisibility = function (self, visbility) self.showZoneNames = visbility end

   theme.GetAllMaps = function (self) return self.maps end
   theme.GetMapById = function (self, mapId)
      local maps = self:GetAllMaps()
      if (maps) then return maps[mapId] end
   end
   
   theme.GetCurrentMap = function (self) return self:GetMapById(addon:GetCurrentMapId()) end

   theme.ResetCustomZoom = function (self)
      local map, zoom = self:GetCurrentMap(), nil
      if (map) then zoom = map:GetMaxZoom() end
      addon:SetCustomZoom(zoom)
   end
   
   theme.Update = function (self)
      local maps = self:GetAllMaps()
      if (not maps) then return end
      for _, map in pairs(maps) do map:Update() end
      self:ResetCustomZoom()   
   end

   theme.Reset = function (self)
      self:Update()
      addon:RecalculateMapMeasurements()
   end

   theme.UpdateCurrentMap = function (self)
      local map = self:GetCurrentMap()
      if (not map) then return end
      map:Update()
   end

   CompileAllMaps(theme, theme:GetAllMaps())
end

local function GetDependencies(dependencies)
   if (not dependencies or type(dependencies) ~= "table") then return nil end
   local compileDependencies = { }
   for _, dependency in pairs(dependencies) do
      local subDependencies = GetDependencies(dependency.dependencies)
      if (subDependencies) then 
         compileDependencies = CopyAndMerge(compileDependencies, subDependencies) 
      end
      compileDependencies = CopyAndMerge(compileDependencies, dependency)
   end
   return compileDependencies
end

function addon:CreateCompiledTheme(theme)
   if (not theme) then return end
   local compiledTheme = { }
   local dependencies = GetDependencies(theme.dependencies)
   compiledTheme = CopyAndMerge(compiledTheme, dependencies)
   compiledTheme = CopyAndMerge(compiledTheme, theme)
   CompileTheme(compiledTheme)
   return compiledTheme
end

local function OnPinCreate(self) addon:UpdateCurrentTheme() end

local function OnPinUpdate(self) addon:UpdateCurrentMap() end

ZO_WorldMap_AddCustomPin(pinType, OnPinCreate, OnPinUpdate, layout)
ZO_WorldMap_SetCustomPinEnabled(_G[pinType], true)
SecurePostHook(ZO_WorldMap_GetPanAndZoom(), "SetCurrentNormalizedZoomInternal", OnPinUpdate)

