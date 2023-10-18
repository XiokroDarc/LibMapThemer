local addon = LibMapThemer
local BlobManagerClass = ZO_ObjectPool:Subclass()


-------------------------
--- Polygon Compiling ---
-------------------------
local function CompilePolygon(zone, polygon)

   polygon.Update = function (self)
      --TODO update function
      -- needed to prevent nil calls
   end

   if (not polygon or not zone or not zone.data) then return end

   -- fill polygon with data
   for _, point in pairs(zone.data) do polygon:AddPoint(point.xN, point.yN) end

   -- set handlers
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

   polygon:SetMouseEnabled(true)
end

-----------------------
--- Label Compiling ---
-----------------------
local function CompileLabel(zone, label)
   if (not zone) then return end
   
   label.Update = function (self)
      self:SetHidden(not (zone:IsEnabled() and zone:IsNameVisible()))
      self:SetText(zone:GetZoneRename(true, addon:GetOptions().storyIndexes))
      self:SetFont(zone:GetFontInfo())
      self:SetColor(zone:GetFontColorUnpacked())
   end

   if (not label) then return end

   --TODO add color and orientation to update
   label:SetColor(1,1,1,1)
   label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
end

-----------------------
--- Blob Compiling ---
-----------------------
function BlobManagerClass:CompileBlob(theme, map, zone)
   if (not theme or not map or not zone) then return nil end

   local blobId = (theme:GetName().."-"..map:GetMapName().."-"..zone:GetZoneName())
   local blob = self:AcquireObject(blobId)

   -- info --
   blob.GetId = function (self) return blobId end
   blob:SetTexture(zone.textureFile)
   blob.GetHitboxData = function (self) return zone.data end

   if (not zone.bounds) then zone.bounds = { } end
   
   local bounds = zone.bounds

   blob.GetBounds = function (self, verticalOffset) 
      if (not bounds.widthN or not bounds.heightN) then
         local width, height = blob:GetTextureFileDimensions()
         bounds.widthN, bounds.heightN =  width / 4096, height / 4096
      end
      return bounds.xN, bounds.yN + (verticalOffset or 0), bounds.widthN, bounds.heightN
   end

   blob.GetNormalizedBounds = function (self, width, height) 
      local xN, yN, widthN, heightN = blob:GetBounds()
      xN, yN = xN * width, yN * height
      widthN, heightN = widthN * width, heightN * height
      return xN, yN, widthN, heightN
   end

   blob.GetOffsets = function (self) 
      local offsets = zone.offsets
      if (offsets == nil) then return 0, 0, 0, 0 end
      return offsets.xN or 0, offsets.yN or 0, offsets.widthN or 0, offsets.heightN or 0
   end

   blob.GetOffsetBounds =  function (self, verticalOffset)
      local xN, yN, widthN, heightN = self:GetBounds(verticalOffset)
      local oXN, oYN, oWN, oHN = self:GetOffsets()
      return xN + oXN, yN + oYN, widthN + oWN, heightN + oHN
   end

   blob.GetUIBounds = function (self)
      return self:GetNormalizedBounds(ZO_WorldMapContainer:GetDimensions())
   end


   local label = blob:GetNamedChild("Label")
   blob.GetLabel = function (self) return label end
   CompileLabel(zone, label)

   local polygon = blob:GetNamedChild("Polygon")
   blob.GetPolygon = function (self) return polygon end
   CompilePolygon(zone, polygon)

   blob.Update = function (self)
      local xN, yN, widthN, heightN = self:GetUIBounds()
      self:SetSimpleAnchorParent(xN, yN)
      self:SetDimensions(widthN, heightN)
      self:SetHidden(not zone:IsEnabled())
      self:GetLabel():Update()
      local polygon = self:GetPolygon()
      polygon:Update()
   end

   blob:SetColor(1, 0,1,1,0) -- clears the color
   return blob
end

BlobManagerClass.New = function (self, parent)
   return ZO_ObjectPool.New(self, function (blobContainer)
      return ZO_ObjectPool_CreateNamedControl(
         "LibMapThemer_MapBlob", 
         "LibMapThemer_MapBlobTemplate",
         blobContainer, parent)
   end, ZO_ObjectPool_DefaultResetControl)
end

local blobManager = BlobManagerClass:New(ZO_WorldMapContainer)

function addon:GetBlobManager() return blobManager end