local addon = LibMapThemer


function addon:IsRecordingPolygon() return false end

function addon:Print(message) end

function addon:ParseIntArgs(args)
   local arguments = { }
   for token in string.gmatch(args, "[^%s]+") do
      table.insert(arguments, tonumber(token))
   end
   return unpack(arguments)
end