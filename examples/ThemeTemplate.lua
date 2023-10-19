
local themeName = "ExampleThemeName"

_G[themeName] = {
   name = themeName,
   prefix = "AddonFolderName",
   dependencies = { },
   patches = { },
   overrides = { },
   renames = { },
   maps = { },
}
local theme = _G[themeName]
local prefix = theme.prefix
local overrides = theme.overrides
local renames = theme.renames
local maps = theme.maps


---[[ Rename Template
renames[""] = ""
--]]


---[[ Override Function Template
overrides[""] = function (selfTheme, output, ...)
   local params = { ... }
   local param1, param2, param3 = ...
   return output
end
--]]



---[[ Map Template (Tamriel)
maps[27] = {
   --maxZoom = 6, 
   pois = { }, 
   zones = { },
}
local tamriel = maps[27]
--]]



---[[ Poi Template
tamriel.pois[1] = {  majorSettlement = true, guildShrine = false, xN = 0.0000, yN = 0.0000, disabled = false, }
--]]



---[[ Zone Template (Cyrodiil)
tamriel.zones[16] = {
   --faction = "",  Typically only needed for base game zones
   --storyIndex = 0,
   textureFile = prefix.."/texture/in/addon/folder.dds",
   bounds = { xN = 0.0000, yN = 0.0000, widthN = 0.0000, heightN = 0.0000 },
   offsets = { xN = 0.0000, yN = 0.0000, widthN = 0.0000, heightN = 0.0000 },
   hitbox = { 
      { xN = 1.0000, yN = 0.0000, }, 
      { xN = 1.0000, yN = 1.0000, }, 
      { xN = 0.0000, yN = 1.0000, }, 
   },
}
--]]