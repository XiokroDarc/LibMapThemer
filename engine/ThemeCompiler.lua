local addon = LibMapThemer
local blobManager = addon:GetBlobManager()
local originalFunctions = { }

local function FontInfo(fontName, fontSize)
   return ("EsoUI/Common/Fonts/"..fontName ..".otf |"..fontSize.."|soft-shadow-thick") 
end

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

local function MergeDependencies(dependencies)
   if (not dependencies or type(dependencies) ~= "table") then return nil end
   local mergedDependencies = { }
   for _, dependency in pairs(dependencies) do
      local subDependencies = MergeDependencies(dependency.dependencies)
      if (subDependencies) then 
         mergedDependencies = CopyAndMerge(mergedDependencies, subDependencies) 
      end
      mergedDependencies = CopyAndMerge(mergedDependencies, dependency)
   end
   return mergedDependencies
end

-----------------------
--- Zone Compiling ---
-----------------------
local function CompileZone(theme, map, zoneId, zone)
   if (not theme or not map or not zoneId or not zone) then return end

   -- info
   zone.GetTheme  = function (self) return theme end
   zone.GetMap    = function (self) return map end
   zone.IsEnabled = function (self) return map:IsEnabled() end
   zone.IsNameVisible = function (self) return (map:AreNamesVisible() and not self.nameHidden) or self.nameVisible end
   zone.SetNameVisibility = function (self, visible) 
      self.nameHidden = not visible
      self.nameVisible = visible
   end

   -- ids
   zone.GetMapId  = function (self) return map:GetMapId() end
   zone.GetZoneId = function (self) return zoneId end

   -- naming
   zone.GetZoneName = function(self) 
      if (type(zoneId) == "string") then return zoneId end
      return GetMapNameById(zoneId)
   end

   zone.GetZoneRename = function (self, ...)
      return theme:GetRename(self:GetZoneName(), ...)
   end

   -- fonts
   zone.GetFontName    = function (self) return (self.fontName or map:GetFontName()) end
   zone.SetFontName    = function (self, fontName) self.fontName = fontName end
   zone.GetFontSize    = function (self) return (self.fontSize or map:GetFontSize()) end
   zone.SetFontSize    = function (self, fontSize) self.fontSize = fontSize end
   zone.GetFontInfo    = function (self) return FontInfo(self:GetFontName(), self:GetFontSize()) end

   zone.GetFontColor   = function (self) return (self.fontColor or map:GetFontColor()) end
   zone.SetFontColor   = function (self, red,green,blue,alpha) self.fontColor = { r = red, g = green, b = blue, a = alpha } end
   zone.GetFontColorUnpacked = function (self)
      local fc = self:GetFontColor()
      return fc.r, fc.g, fc.b, fc.a
   end

   -- blobs
   zone.blob = blobManager:CompileBlob(theme, map, zone)
   zone.GetBlob = function (self) return zone.blob end

   -- updates
   zone.Update = function (self) self:GetBlob():Update() end
end

local function CompileAllZones(theme, map)
   if (not theme or not map) then return end
   for zoneId, zone in pairs(map.zones) do
      CompileZone(theme, map, zoneId, zone)
   end
end

-----------------------
--- Map Compiling ---
-----------------------
local function CompileMap(theme, mapId, map)
   if (not theme or not mapId or not map) then return end
   -- info
   map.GetTheme         = function (self) return theme end
   map.GetMapId         = function (self) return mapId end
   map.GetParentMapId   = function (self) return self.parentMapId end
   map.GetMaxZoom       = function (self) return self.maxZoom end
   map.IsCurrentMap     = function (self) return mapId == addon:GetCurrentMapId() end
   map.IsEnabled        = function (self) return (theme:IsEnabled() and map:IsCurrentMap()) end
   map.IsMapTamriel     = function (self) return mapId == 27 end
   map.IsMapAurbis      = function (self) return mapId == 439 end
   map.AreNamesVisible  = function (self) return (theme:AreNamesVisible() and not self.namesHidden) or self.namesVisible end
   map.SetNameVisibility = function (self, visible) 
      self.namesHidden = not visible
      self.namesVisible = visible
   end

   -- naming
   map.GetMapName       = function(self) 
      if (type(mapId) == "string") then return mapId end
      return GetMapNameById(mapId)
   end

   map.GetMapRename = function (self, ...)
      return theme:GetRename(self:GetMapName(), ...)
   end
   
   -- fonts
   map.GetFontName    = function (self) return (self.fontName or theme:GetFontName()) end
   map.SetFontName    = function (self, fontName) self.fontName = fontName end
   map.GetFontSize    = function (self) return (self.fontSize or theme:GetFontSize()) end
   map.SetFontSize    = function (self, fontSize) self.fontSize = fontSize end
   map.GetFontColor   = function (self) return (self.fontColor or theme:GetFontColor()) end
   map.SetFontColor   = function (self, fontColor) self.fontColor = fontColor end
   map.GetFontInfo    = function (self) return FontInfo(self:GetFontName(), self:GetFontSize()) end
  
   -- pois
   map.GetAllPois = function (self) return self.pois end
   map.GetPoiById = function (self, poiId) return self:GetAllPois()[poiId] end
   if (not map:GetAllPois()) then map.pois = { } end

   -- zones
   map.IsDefaultZonesDisabled  = function (self) return self.disableDefaultZones == true end
   map.SetDefaultZonesDisabled = function (self, disabled) self.disableDefaultZones = disabled end
   map.GetAllZones = function (self) return self.zones end
   map.GetZoneById = function (self, zoneId) return self:GetAllZones()[zoneId] end
   map:SetDefaultZonesDisabled(true)
   if (not map:GetAllZones()) then
      map.zones = { }
      map:SetDefaultZonesDisabled(false)
   end

   map.IsZoneNamesDisabled = function (self) return (self.disableZoneNames or theme:IsZoneNamesDisabled()) end
   map.SetZoneNamesDisabled = function (self, visbility) self.disableZoneNames = visbility end

   -- tiles
   map.GetAllOverrides = function (self) return self.overrides end
   map.GetTilePath     = function (self) return self.tilePath end
   map.GetTileByIndex  = function (self, index)
      if (index) then 
         local override = self:GetAllOverrides()[index]
         local tilePath = self:GetTilePath()
         if (tilePath) then tilePath = (tilePath..index..".dds") end
         return override or tilePath
      end
   end
   if (not map:GetAllOverrides()) then map.overrides = { } end

   -- update
   map.Update = function (self) 
      local zones = self:GetAllZones()
      for _, zone in pairs(zones) do zone:Update() end
   end

   CompileAllZones(theme, map)
end

local function CompileAllMaps(theme)
   local maps = theme:GetAllMaps()
   for mapId, map in pairs(maps) do
      CompileMap(theme, mapId, map)
   end
end


--------------------------
--- Override Compiling ---
--------------------------
function addon:GetZosFunction(functionName)
   return originalFunctions[functionName]
end

local function HookZosFunction(functionName)
   -- keeps a backup of the original zos function
   if (not originalFunctions[functionName]) then 

      originalFunctions[functionName] = _G[functionName]
      local _GFunction = originalFunctions[functionName]


      --- Hook function for zos functions
      --- this is a safe override which should*
      --- fallback to the original function.
      
      --- This allows for themes to use different
      --- functions and not have them interfere 
      --- with other themes.
      _G[functionName] = function (...)
         local output   = { _GFunction(...) }
         ---[[ 
         local theme = addon:GetCurrentTheme()
         if (theme) then
            local fn = theme:GetOverride(functionName)
            if (fn) then
               local override = fn(theme, output, ...)
               if (override) then
                  return unpack(override)
               end
            end
         end
         --]]
         return unpack(output)
      end

   end
end

local function CompileOverrides(theme)
   local overrides = theme:GetOverrides()
   for functionName, _ in pairs(overrides) do
      HookZosFunction(functionName)
   end
end

-----------------------
--- Theme Compiling ---
-----------------------
local function CompileTheme(theme)
   if (not theme) then return end
   if (not theme.prefix) then theme.prefix = theme.name end

   -- info
   theme.GetName     = function (self) return self.name end
   theme.GetAuthor   = function (self) return self.author end
   theme.GetVersion  = function (self) return self.version end
   theme.GetPrefix   = function (self) return self.prefix end
   theme.GetOptions  = function (self) return addon:GetOptions() end
   theme.IsEnabled   = function (self) return self:GetName() == self:GetOptions().currentTheme end
   theme.AreNamesVisible = function (self) return (self.namesVisible or not self.namesHidden) end
   theme.SetNameVisibility = function (self, visible) 
      self.namesHidden = not visible
      self.namesVisible = visible
   end

   -- dependencies
   theme.dependencies = theme.dependencies or { }
   theme.GetAllDependencies       = function(self) return self.dependencies end
   theme.GetMergedDependencies   = function (self) return MergeDependencies(self:GetDependencyList()) end
   
   
   theme.GetOverrides   = function (self) return self.overrides end
   theme.GetOverride    = function (self, functionName) return self:GetOverrides()[functionName] end
   theme.CallOverride   = function (self, functionName, ...) 
      local fn = self:GetOverride(functionName)
      if (fn) then return fn(self, ...) end 
   end
   if (not theme:GetOverrides()) then theme.overrides = { } end

   -- fonts
   theme.GetFontName    = function (self) return (self.fontName or self:GetOptions().fontName) end
   theme.SetFontName    = function (self, fontName) self.fontName = fontName end
   theme.GetFontSize    = function (self) return (self.fontSize or self:GetOptions().fontSize) end
   theme.SetFontSize    = function (self, fontSize) self.fontSize = fontSize end
   theme.GetFontColor   = function (self) return (self.fontColor or self:GetOptions().fontColor) end
   theme.SetFontColor   = function (self, fontColor) self.fontColor = fontColor end
   theme.GetFontInfo    = function (self) return FontInfo(self:GetFontName(), self:GetFontSize()) end

   -- renames
   theme.renames = theme.renames or { }
   theme.IsRenamesDisabled    = function (self) return (self.disableRenames or self:GetOptions().disableRenames) end
   theme.SetRenamesDisabled   = function (self, disabled) self.disableRenames = disabled end
   theme.GetAllRenames  = function (self) return self.renames end
   theme.GetRename      = function (self, name, ...) 
      if (not self:IsRenamesDisabled()) then 
         local rename = self:GetAllRenames()[name]
         if (type(rename) == 'function') then rename = rename(...) end
         if (type(rename) == 'string') then return rename end
      end
      return name
   end

   -- maps/zones
   theme.GetAllMaps = function (self) return self.maps end
   theme.GetMapById = function (self, mapId) return self:GetAllMaps()[mapId] end
   if (not theme:GetAllMaps()) then theme.maps = { } end

   theme.GetZoneFromMapById = function (self, mapId, zoneId) 
      local map = self:GetMapById(mapId)
      if (map) then return map:GetZoneById(zoneId) end
   end

   theme.GetMapNameById = function (self, mapId)
      local map = self:GetMapById(mapId)
      if (map) then
         return map:GetMapName()
      end
   end

   theme.GetMapRenameById = function (self, mapId, keepLineBreaks)
      local map = self:GetMapById(mapId)
      if (map) then return map:GetMapRename(keepLineBreaks) end
   end

   -- current maps/zones
   theme.GetCurrentMap = function (self) 
      return self:GetMapById(addon:GetCurrentMapId()) 
   end

   theme.GetZoneByIdFromCurrentMap = function (self, zoneId) 
      local map = self:GetCurrentMap()
      if (map) then return map:GetZoneById(zoneId) end
   end

   -- current maps/zones
   theme.GetCurrentMapName = function (self) 
      return self:GetMapNameById(addon:GetCurrentMapId()) 
   end

   -- updates
   theme.UpdateZoom = function (self)
      local map, maxZoom = self:GetCurrentMap(), nil
      if (map) then maxZoom = map:GetMaxZoom() end
      addon:SetCustomMaxZoom(maxZoom)
   end

   theme.Update = function (self)
      local maps = self:GetAllMaps()
      for _, map in pairs(maps) do map:Update() end
      self:UpdateZoom()
   end

   theme.UpdateCurrentMap = function (self)
      local map = self:GetCurrentMap()
      if (map) then map:Update() end
   end

   theme.RecalculateMapMeasurements = function (self)
      self:Update()
      addon:RecalculateMapMeasurements()
   end

   theme.Reset = function (self) self:RecalculateMapMeasurements() end

   CompileOverrides(theme)
   CompileAllMaps(theme)
end

function addon:CreateCompiledTheme(theme)
   if (not theme) then return end
   local compiled = { }
   local dependencies = MergeDependencies(theme.dependencies)
   compiled = CopyAndMerge(CopyAndMerge(compiled, dependencies), theme)
   CompileTheme(compiled)
   return compiled
end


--- Used to fix GetFixedGlobalCoordinates with calling GetUniversallyNormalizedMapInfo
HookZosFunction("GetUniversallyNormalizedMapInfo")
