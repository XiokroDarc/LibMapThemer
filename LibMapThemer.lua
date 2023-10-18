LibMapThemer = { }
local name, addon = "LibMapThemer", LibMapThemer

addon.TAMRIEL_VERTICAL_OFFSET = -0.14000000059605 

local version, build = "23.10.15", 2310160405
local savedVarsFileName = name.."Vars"
local title, author, description, options
local allThemes, allThemeChoices = { }, { }
local fonts = { 
   "Univers57",
   "Univers67",
   "FTN47",
   "FTN57",
   "FTN87",
   "ProseAntiquePSMT",
   "HandWritten_Bold",
   "TrajanPro-Regular",
}

local fontSwitch = {
   [27] = 26, [29] = 28, [31] = 30, [33] = 32, [35] = 34,
   [37] = 36, [38] = 36, [39] = 40, [41] = 40, [42] = 40,
   [43] = 40, [44] = 40, [45] = 48, [46] = 48, [47] = 48,
   [49] = 48, [50] = 54, [51] = 54, [52] = 54, [53] = 54, 
}

local defaults = {
   currentTheme = "None (Default)",
   fontName = "ProseAntiquePSMT",
   fontColor = { r = 1, g = 1, b = 1, a = 1, },
   fontSize = 18,
   storyIndexes = false,
   pois = {
      showAll = false,
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

---------------------------------------------------------------------
--- Local Functions ------ Local Functions ------ Local Functions ---
---------------------------------------------------------------------
local function DoesThemeHaveDependency(theme, dependencyName)
   local dependencies = theme.dependencies
   for _, dependency in pairs(dependencies) do
      if (dependency.name == dependencyName) then
         return true
      end
   end
   return false
end

local function LoadInfo()
   local numAddons = GetAddOnManager():GetNumAddOns()
   for i = 1, numAddons do 
      local n, t, a, d = GetAddOnManager():GetAddOnInfo(i)
      if (n == name) then
         title, author, description = t, a, d
         break 
      end
   end
end LoadInfo() -- call instantly to get the data

------------------------------------------------------
--- Addon Info ------ Addon Info ------ Addon Info ---
------------------------------------------------------
function addon:GetName() return name end

function addon:GetTitle() return title end

function addon:GetAuthor() return author end

function addon:GetVersion() return version end

function addon:GetDescription() return description end

function addon:GetOptions() 
   if (not options) then 
      -- guarrentees options are always loaded whenever it is first needed
      options = ZO_SavedVars:NewAccountWide(savedVarsFileName, build, nil, defaults) 
   end
   return options 
end

EVENT_MANAGER:RegisterForEvent(addon:GetName(), EVENT_ADD_ON_LOADED, function (_, addonName)
   if (addonName ~= addon:GetName()) then return end
   EVENT_MANAGER:UnregisterForEvent(addonName, EVENT_ADD_ON_LOADED)
   addon:SetCurrentThemeByName(addon:GetOptions().currentTheme)
end)

------------------------------------------------------
--- Theme Info ------ Theme Info ------ Theme Info ---
------------------------------------------------------
function addon:GetThemeChoices() return allThemeChoices end

function addon:GetAllThemes() return allThemes end

function addon:GetTheme(themeName) return allThemes[themeName] end

function addon:GetCurrentThemeName() return self:GetOptions().currentTheme end

function addon:GetCurrentTheme() return self:GetTheme(self:GetCurrentThemeName()) end

function addon:SetCurrentThemeByName(themeName)
   if (self:GetTheme(themeName)) then 
      self:GetOptions().currentTheme = themeName 
   end
   -- reset all themes to insure everything is cleared
   for _, theme in pairs(allThemes) do theme:Reset() end
end

function addon:SetCurrentTheme(theme) self:SetCurrentThemeByName(theme:GetName()) end

function addon:GetThemesWithDependency(dependencyName)
   local themes = { }
   for themeName, theme in pairs(allThemes) do
      if ((themeName == dependencyName or theme.name == dependencyName) or DoesThemeHaveDependency(theme, dependencyName)) then
         table.insert(themes, themeName)
      end
   end
   return themes
end

function addon:GetCurrentMap()
   local theme = self:GetCurrentTheme()
   if (theme) then return theme:GetCurrentMap() end
end

---------------------------------------------------------
--- Theme Utils ------ Theme Utils ------ Theme Utils ---
---------------------------------------------------------
function addon:LoadTheme(theme)
   local compiledTheme = self:CreateCompiledTheme(theme)
   if (compiledTheme) then 
      local themeName = compiledTheme:GetName()
      if (not allThemes[themeName]) then
         table.insert(allThemeChoices, themeName)
         allThemes[themeName] = compiledTheme
      end
   end
   return compiledTheme
end

function addon:ParseIntArgs(args)
   local arguments = { }
   for token in string.gmatch(args, "[^%s]+") do
      table.insert(arguments, tonumber(token))
   end
   return unpack(arguments)
end

function addon:CreateRename(renames, name, rename, faction, storyIndex)
   renames[name] = function (keepLineBreaks, zoneNumbers)
      local nameRename = name

      if (rename) then nameRename = rename end

      if (not keepLineBreaks) then nameRename = nameRename:gsub("\n", "") end
      
      if (faction and storyIndex and zoneNumbers) then
         -- This fixes any zone rename that uses a line break for placement
         if (nameRename:sub(-1) == '\n') then nameRename = nameRename:sub(1,#nameRename-1) end
         --nameRename = string.gsub(nameRename, "\n", "")
         nameRename = nameRename.."\n"..faction.."#"..storyIndex
      end

      return nameRename
   end
end

function addon:ClampFont(fontSize)
   local newSize = fontSwitch[fontSize]
   return newSize or fontSize
end

function addon:GetValidFonts()
   return fonts
end

-------------------------
--- Dummy Declaration ---
-------------------------
function addon:IsRecordingPolygon() return false end

function addon:Print(message) end