LibMapThemer = { }
local name, addon = "LibMapThemer", LibMapThemer

addon.TAMRIEL_VERTICAL_OFFSET = -0.14000000059605 -- why does this need to exist, nobody knows

local version, build = "23.10.01", 231001
local savedVarsFileName = name.."Vars"
local title, author, description
local options, selectedZone
local allThemes, allThemeChoices = { }, { }

local defaults = {
   currentTheme = "None (Default)",
   fontName = "HandWritten_Bold",
   fontSize = 18,
   pois = {
      showAll = true,
      disableGlow = false,
      majorsettlements = false,
      guildshrines = false,
      ownedHouses = false,
      unownedHouses = false,
      trials = false,
      dungeons = false,
      groupArenas = false,
      soloArenas = false,
   },
}

function addon:GetName()         return name end

function addon:GetTitle()        return title end

function addon:GetAuthor()       return author end

function addon:GetDescription()  return description end

function addon:GetVersion()      return version end

local function LoadInfo()
   local numAddons = GetAddOnManager():GetNumAddOns()
   for i = 1, numAddons do 
      local n, t, a, d = GetAddOnManager():GetAddOnInfo(i)
      if (n == name) then
         title = t
         author = a
         description = d
         return 
      end
   end
end LoadInfo() 

function addon:GetOptions() 
   if (not options) then options = ZO_SavedVars:NewAccountWide(savedVarsFileName, build, nil, defaults) end
   return options 
end

function addon:LoadTheme(theme)
   local compiledTheme = self:CreateCompiledTheme(theme)
   if (not compiledTheme) then return end
   local themeName = compiledTheme:GetName()
   if (not allThemes[themeName]) then
      table.insert(allThemeChoices, themeName)
      allThemes[themeName] = compiledTheme
   end
   return compiledTheme
end

function addon:LoadThemePack(theme) addon:LoadTheme(theme) end

function addon:GetAllThemes() return allThemes end

function addon:GetTheme(themeName) return allThemes[themeName] end

function addon:SetCurrentThemeByName(themeName)
   if (self:GetTheme(themeName)) then self:GetOptions().currentTheme = themeName end
   for _, theme in pairs(allThemes) do theme:Reset() end
end

function addon:SetCurrentTheme(theme) self:SetCurrentThemeByName(theme:GetName()) end

function addon:GetCurrentTheme() return self:GetTheme(self:GetOptions().currentTheme) end

function addon:GetCurrentThemeName() return self:GetOptions().currentTheme end

function addon:GetThemeChoices() return allThemeChoices end

local function DoesThemeHaveDependency(theme, dependencyName)
   local dependencies = theme:GetDependencies()
   for _, dependency in pairs(dependencies) do
      if (dependency.name == dependencyName) then
         return true
      end
   end
   return false
end

function addon:GetThemesWithDependency(dependencyName)
   local themes = { }
   for themeName, theme in pairs(allThemes) do
      if (themeName == dependencyName or DoesThemeHaveDependency(theme, dependencyName)) then
         table.insert(themes, themeName)
      end
   end
   --table.insert(themes, themeName)
   return themes
end

function addon:SetSelectedZone(zone) selectedZone = zone end

function addon:GetSelectedZone() return selectedZone end

function addon:GetCurrentMapId() return GetCurrentMapId() end

function addon:GetAllMaps()
   local theme = self:GetCurrentTheme()
   if (theme) then return theme:GetAllMaps() end
end

function addon:GetMapById(mapId)
   local theme = self:GetCurrentTheme()
   if (theme) then return theme:GetMapById(mapId) end
end

function addon:GetZoneFromMapById(mapId, zoneId)
local map = self:GetMapById(mapId)
if (map) then return map:GetZoneById(zoneId) end
end

function addon:GetCurrentMap()
   local theme = self:GetCurrentTheme()
   if (theme) then return theme:GetCurrentMap() end
end

function addon:UpdateCurrentMap()
   local map = self:GetCurrentMap()
   if (map) then map:Update() end
end

function addon:UpdateCurrentTheme()
   local theme = self:GetCurrentTheme()
   if (theme) then theme:Update() end
end

function addon:ResetCurrentTheme()
   local theme = self:GetCurrentTheme()
   if (theme) then theme:Reset() end
end

EVENT_MANAGER:RegisterForEvent(addon:GetName(), EVENT_ADD_ON_LOADED, function (_, addonName)
   if (addonName ~= addon:GetName()) then return end
   EVENT_MANAGER:UnregisterForEvent(addonName, EVENT_ADD_ON_LOADED)
   LibMapThemer:SetCurrentThemeByName(addon:GetOptions().currentTheme)
end)