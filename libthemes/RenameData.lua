local addon = LibMapThemer
local themeName = "LibMapThemer_RenameData"

_G[themeName] = {
   name = themeName,
   prefix = "LibMapThemer",
   renames = { },
}
local theme = _G[themeName]
local renames = theme.renames

function CreateRename(name, rename, faction, storyIndex) addon:CreateRename(renames, name, rename, faction, storyIndex) end

--- Daggerfall ---
CreateRename("Stros M'Kai", nil, "DC", 1)
CreateRename("Betnikh", nil, "DC", 2)
CreateRename("Glenumbra", nil, "DC", 3)
CreateRename("Stormhaven", nil, "DC", 4)
CreateRename("Rivenspire", "\nRivenspire", "DC", 5)
CreateRename("Alik'r Desert", "The Alik'r Desert", "DC", 6)
CreateRename("Bangkorai", nil, "DC", 7)


--- Ebonheart ---
CreateRename("Bleakrock Isle", nil, "EP", 1)
CreateRename("Bal Foyen", "Bal \nFoyen", "EP", 2)
CreateRename("Stonefalls", "\nStonefalls", "EP", 3)
CreateRename("Deshaan", nil, "EP", 4)
CreateRename("Shadowfen", nil, "EP", 5)
CreateRename("Eastmarch", "\nEastmarch", "EP", 6)
CreateRename("The Rift", "The Rift\n", "EP", 7)


--- Aldmeri ---
CreateRename("Khenarthi's Roost", nil, "AD", 1)
CreateRename("Auridon", nil, "AD", 2)
CreateRename("Grahtwood", "Grahtwood\n", "AD", 3)
CreateRename("Greenshade", nil, "AD", 4)
CreateRename("Malabal Tor", "\nMalabal Tor", "AD", 5)
CreateRename("Reaper's March", "Reaper's \nMarch", "AD", 6)


renames["Cyrodiil"]                 = "Cyrodiil\n"
renames["Northern Elsweyr"]         = "Northern \nElsweyr"
renames["Southern Elsweyr"]         = "Southern \nElsweyr"
renames["Galen and Y'ffelon"]       = "Galen & \nY'ffelon"
renames["Telvanni Peninsula"]       = "Telvanni \nPeninsula"
renames["High Isle and Amenos"]     = "High Isle & \nAmenos"
renames["Northern High Rock Gate"]  = "Northern Hammerfell Gate"
renames["Southern High Rock Gate"]  = "Southern Hammerfell Gate"
renames["Gold Coast"]               = "The Gold Coast"