local themeName = "LibMapThemer_RenameData"

_G[themeName] = {
   name = themeName,
   prefix = "LibMapThemer",
   renames = { },
}
local theme = _G[themeName]
local renames = theme.renames


--- Daggerfall ---
renames["Rivenspire"] = "Rivenspire"
renames["Alik'r Desert"] = "The Alik'r Desert"

--[[

--- Ebonheart ---
renames["Bal Foyen"] = "Bal \nFoyen"
renames["Stonefalls"] = "\nStonefalls"
renames["Eastmarch"] = "\nEastmarch"
renames["The Rift"] = "The Rift\n"

--]]

--- Aldmeri ---
renames["Reaper's March"] = "Reaper's \nMarch"


renames["Northern Elsweyr"]         = "Northern \nElsweyr"
renames["Southern Elsweyr"]         = "Southern \nElsweyr"
renames["Galen and Y'ffelon"]       = "Galen & \nY'ffelon"
renames["Telvanni Peninsula"]       = "Telvanni \nPeninsula"
renames["High Isle and Amenos"]     = "High Isle & \nAmenos"
renames["Northern High Rock Gate"]  = "Northern Hammerfell Gate"
renames["Southern High Rock Gate"]  = "Southern Hammerfell Gate"
renames["Gold Coast"]               = "The Gold Coast"