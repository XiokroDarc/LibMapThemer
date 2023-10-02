local addon = LibMapThemer

SLASH_COMMANDS["/navigate"] = function (args)
   local mapId = addon:ParseIntArgs(args)
   addon:NavigateToMap(mapId)
end