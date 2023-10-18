local addon = LibMapThemer

local debugPolygon


local function ResetRecordWindow()
   LibMapThemer_Polycode:SetText("")
end

local function ShowRecordWindow()
   LibMapThemer_RecordPolygonWindow:SetHidden(false)
   ResetRecordWindow()
end

local function HideRecordWindow()
   LibMapThemer_RecordPolygonWindow:SetHidden(true)
   ResetRecordWindow()
end

local xNEquals, yNEquals, newLine = "   { xN = ", ", yN = ", ", },\n"
local function AddPointToPolycode(xN, yN)
   local polygonCode = LibMapThemer_Polycode:GetText()
   local mouseXN = string.format("%.04f", xN)
   local mouseYN = string.format("%.04f", yN)
   polygonCode = polygonCode..xNEquals..mouseXN..yNEquals..mouseYN..newLine
   LibMapThemer_Polycode:SetText(polygonCode)
end

--TODO: add customizations
local function AttachDebugToZone(mapId, zoneId) 
   if (not mapId) then return end
   local map, zone
   if (not zoneId) then
      map = addon:GetCurrentMap()
      zone = map:GetZoneById(mapId)   
   else
      map = addon:GetMapById(mapId)
      zone = map:GetZoneById(zoneId)   
   end

   if (not zone) then return end
   local blob = zone:GetBlob() 
   if (not blob) then return end
   
   addon:Print("Creating DebugPoly for "..zone:GetZoneName()..", mapId: "..zone:GetMapId()..", mapId: "..zone:GetZoneId())
   
   debugPolygon = blob:GetNamedChild("DebugPoly")
   debugPolygon:AddPoint(0.0, 0.0) debugPolygon:AddPoint(1.0, 0.0)
   debugPolygon:AddPoint(1.0, 1.0) debugPolygon:AddPoint(0.0, 1.0)
   debugPolygon:SetCenterColor(0, 1, 1, 0.3)
   
   debugPolygon:SetHandler("OnMouseUp", function (control, button, upInside)
      if(upInside and button == MOUSE_BUTTON_INDEX_LEFT) then 
         local xN, yN = blob:GetLeft(), blob:GetTop() 
         local widthN, heightN = blob:GetDimensions()
         local mouseXN, mouseYN = addon:GetNormalizeMouse(xN, yN, widthN, heightN)
         AddPointToPolycode(mouseXN, mouseYN)
      end
   end)

   debugPolygon:SetMouseEnabled(true)
   debugPolygon:SetHidden(false)
end

local function DetachDebug()
   if (not debugPolygon) then return end
   debugPolygon:ClearPoints()
   debugPolygon:SetMouseEnabled(false)
   debugPolygon:SetHidden(true)
   debugPolygon = nil
end

local function StartRecord(args)
   DetachDebug()
   AttachDebugToZone(addon:ParseIntArgs(args))
   ShowRecordWindow()
end

local function StopRecord()
   DetachDebug()
   HideRecordWindow()
end

addon.IsRecordingPolygon = function (self) return (debugPolygon ~= nil) end

SLASH_COMMANDS["/start_debugrecord"] = StartRecord

SLASH_COMMANDS["/stop_debugrecord"] = StopRecord


