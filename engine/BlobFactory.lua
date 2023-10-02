local addon = LibMapThemer
local BlobManagerClass = ZO_ObjectPool:Subclass()


local function CompileLabel(zone, blob, label)
   if (not blob or not label) then return end
   label:SetColor(1,1,1,1)
   label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
   blob.GetLabel     = function (self) return label end
   --label.GetFontName = function (self) return zone:GetFontName() end
   --label.GetFontSize = function (self) return zone:GetFontSize() end
   --label.GetColor    = function (self) return zone:GetFontColor() end
   --label.GetText     = function (self) return zone:GetZoneName() end
   --label.IsHidden    = function (self) return not zone:ShowZoneName() end
   label.Update      = function (self)
      self:SetHidden(not (zone:IsEnabled() and zone:IsShowingName()))
      self:SetText(zone:GetZoneRename(true))
   end
end

local function CompilePolygon(zone, blob, polygon)
   if (not zone or not blob or not polygon) then return end
   blob.GetPolygon = function (self) return polygon end
   --polygon.IsMouseEnabled = function (self) return not blob:IsHidden() end
   polygon.Update = function (self)
      self:SetMouseEnabled(true)
   end

   local data = blob:GetData()
   if (not data) then return end
   for _, point in pairs(data) do polygon:AddPoint(point.xN, point.yN) end

   polygon:SetHandler("OnMouseEnter", function (self)
      if (addon:IsInGamepadMode() or addon:IsRecordingPolygon()) then return end
      addon:SetSelectedZone(zone)
      ZO_WorldMap_MouseEnter()
   end)

   polygon:SetHandler("OnMouseExit", function (self)
      if (addon:IsInGamepadMode() or addon:IsRecordingPolygon()) then return end
      local selectedZone = addon:GetSelectedZone()
      if (selectedZone and selectedZone:GetZoneId() == zone:GetZoneId()) then
         addon:SetSelectedZone(nil)
      end
      ZO_WorldMap_MouseExit()
   end)

   local oldMouseX, oldMouseY
   polygon:SetHandler("OnMouseDown", function (self, button, ctrl, alt, shift)
      if (addon:IsInGamepadMode() or addon:IsRecordingPolygon()) then return end
      oldMouseX, oldMouseY = nil, nil
      if (button == MOUSE_BUTTON_INDEX_LEFT) then oldMouseX, oldMouseY = addon:GetWorldMapMouseCoordinates() end
      ZO_WorldMap_MouseDown(button, ctrl, alt, shift)
   end)

   polygon:SetHandler("OnMouseUp", function (self, button, upInside)
      if (addon:IsInGamepadMode() or addon:IsRecordingPolygon()) then return end
      ZO_WorldMap_MouseUp(nil, button, nil)
      if(upInside and button == MOUSE_BUTTON_INDEX_LEFT) then 
         if (oldMouseX ~= nil and oldMouseY ~= nil) then
            local dragAmount = 0
            local mouseX, mouseY = addon:GetWorldMapMouseCoordinates()
            local isWithinX = (mouseX <= oldMouseX+dragAmount and mouseX >= oldMouseX-dragAmount)
            local isWithinY = (mouseY <= oldMouseY+dragAmount and mouseY >= oldMouseY-dragAmount)
            if (isWithinX and isWithinY) then
               oldMouseX, oldMouseY = nil, nil
               local selectedZone = addon:GetSelectedZone()
               if (selectedZone and selectedZone:GetZoneId() == zone:GetZoneId()) then
                  --ZO_WorldMap_MouseUp(nil, button, upInside)
                  addon:NavigateToMap(zone:GetZoneId()) 
                  return
               end
            end
         end
      end
      ZO_WorldMap_MouseUp(nil, button, upInside)
   end)
end

function BlobManagerClass:CompileBlob(theme, zone, blobData)
   if (not theme or not zone or not blobData) then return end
   local map = zone:GetMap()
   local blobId = (theme:GetPrefix().."-"..map:GetMapName().."-"..zone:GetZoneName()) 
   local blob = self:AcquireObject(blobId)
   local bounds = blobData.bounds
   local offsets = blobData.offsets
   local data = blobData.data

   blob:SetTexture(blobData.textureFile)
   --CompileBounds(bounds, blob:GetTextureFileDimensions())
   --CompileBounds(offsets, 0)

   --blob:SetAlpha(0)   
   blob:SetColor(1,0,1,1,0.0)
   blob.GetData      = function (self) return data end
   blob.GetBlobId    = function (self) return blobId end
   blob.GetBounds    = function (self, verticalOffset) 
      verticalOffset = verticalOffset or 0
      local xN, yN, widthN, heightN = bounds.xN, bounds.yN, bounds.widthN, bounds.heightN
      if (not widthN or not heightN) then
         local w, h = blob:GetTextureFileDimensions()
         widthN =  w / 4096
         heightN = h / 4096
      end
      return xN, yN + verticalOffset, widthN, heightN
   end
   blob.GetOffsets   = function (self) 
      if (offsets == nil) then return 0, 0, 0, 0 end
      local xN, yN, widthN, heightN = offsets.xN, offsets.yN, offsets.widthN, offsets.heightN
      return xN or 0, yN or 0, widthN or 0, heightN or 0
   end
   blob.GetOffsetBounds =  function (self, verticalOffset)
      local xN, yN, widthN, heightN = self:GetBounds(verticalOffset)
      local oXN, oYN, oWN, oHN = self:GetOffsets()
      return xN + oXN, yN + oYN, widthN + oWN, heightN + oHN
   end
   blob.GetNormalizedBounds = function (self, width, height) 
      local xN, yN, widthN, heightN = blob:GetBounds()
      xN, yN = xN * width, yN * height
      widthN, heightN = widthN * width, heightN * height
      return xN, yN, widthN, heightN
   end
   blob.GetUIBounds = function (self)
      return self:GetNormalizedBounds(ZO_WorldMapContainer:GetDimensions())
   end

   --blob.GetTexture   = function (self) return blobData.textureFile end
   blob.GetTextureFileName = function (self) return blobData.textureFile end
   blob.Update = function (self)
      local xN, yN, widthN, heightN = self:GetUIBounds()
      self:SetSimpleAnchorParent(xN, yN)
      self:SetDimensions(widthN, heightN)
      self:SetHidden(not zone:IsEnabled())
      self:GetLabel():Update()
      self:GetPolygon():Update()
   end

   CompileLabel(zone, blob, blob:GetNamedChild("Label"))
   CompilePolygon(zone, blob, blob:GetNamedChild("Polygon"))
   return blob
end

function BlobManagerClass:New(parent)
   return ZO_ObjectPool.New(self, function (selfBlobManager)
      return ZO_ObjectPool_CreateNamedControl(
         "LibMapThemer_MapBlob", "LibMapThemer_MapBlobTemplate", 
         selfBlobManager, parent)
   end, ZO_ObjectPool_DefaultResetControl)
end

local blobManager = BlobManagerClass:New(ZO_WorldMapContainer)

function addon:GetBlobManager() return blobManager end