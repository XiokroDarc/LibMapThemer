LibMapThemer_ZoneData = {
   name = "LibMapThemer_ZoneData",
   maps = { },
}
local theme = LibMapThemer_ZoneData
local maps = theme.maps

----------------------------------------------------------------------------------------------------------------------------------------
---- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel ----
----------------------------------------------------------------------------------------------------------------------------------------
---- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel ----
----------------------------------------------------------------------------------------------------------------------------------------
maps[27] = {
   zones = { },
}

local tamriel = maps[27]

-------------------------------------------------------------------------------------------------------------------------------------------------
---- Daggerfall Covenant -------- Daggerfall Covenant -------- Daggerfall Covenant -------- Daggerfall Covenant -------- Daggerfall Covenant ----
-------------------------------------------------------------------------------------------------------------------------------------------------

-----------------
-- Stros M'kai --
tamriel.zones[201]  = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-stros.dds",
      bounds = { xN = 0.1487, yN = 0.5339, widthN = 0.0215, heightN = 0.0205, },
   },
}

tamriel.zones[201]  = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-stros.dds",
      bounds = { xN = 0.1487, yN = 0.5339, widthN = 0.0215, heightN = 0.0205, },
   },
}

-------------
-- Betnikh --
tamriel.zones[227]  = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-betnikh.dds",
      bounds = { xN = 0.0697, yN = 0.4248, widthN = 0.0220, heightN = 0.0234, },
   },
}

---------------
-- Glenumbra --
tamriel.zones[1]  = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-glenumbra.dds",
      bounds = { xN = 0.0413, yN = 0.2687, widthN = 0.1167, heightN = 0.1509, },
   },
}

----------------
-- Stormhaven --
tamriel.zones[12] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-stormhaven.dds",
      bounds = { xN = 0.1539, yN = 0.2713, widthN = 0.124, heightN = 0.0767, },
   },
}

----------------
-- Rivenspire --
tamriel.zones[10] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-rivenspire.dds",
      bounds = { xN = 0.1226, yN = 0.1926, widthN = 0.105, heightN = 0.0918, },
   },
}

----------------
-- The Alik'r --
tamriel.zones[30] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-alikr.dds",
      bounds = { xN = 0.1139, yN = 0.3426, widthN = 0.1436, heightN = 0.0947, },
   },
}

---------------
-- Bangkorai --
tamriel.zones[20] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-bangkorai.dds",
      bounds = { xN = 0.25, yN = 0.2674, widthN = 0.0869, heightN = 0.1289, },
   },
}

------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Aldmeri Dominion -------- Aldmeri Dominion -------- Aldmeri Dominion -------- Aldmeri Dominion -------- Aldmeri Dominion -------- Aldmeri Dominion ----
------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------
-- Khenarthi's Roost --
tamriel.zones[258] = {
   hideName = true,
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-khenarthis.dds",
      bounds = { xN = 0.4916, yN = 0.7839, widthN = 0.0244, heightN = 0.0283, },
   },
}

-------------
-- Auridon --
tamriel.zones[143] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-auridon.dds",
      bounds = { xN = 0.1574, yN = 0.5948, widthN = 0.1167, heightN = 0.1602, },
   },
}

---------------
-- Grahtwood --
tamriel.zones[9] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-grahtwood.dds",
      bounds = { xN = 0.3713, yN = 0.6713, widthN = 0.1143, heightN = 0.1265, },
   },
}

----------------
-- Greenshade --
tamriel.zones[300] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-greenshade.dds",
      bounds = { xN = 0.2765, yN = 0.64, widthN = 0.1025, heightN = 0.1104, },
   },
}

-----------------
-- Malabal Tor --
tamriel.zones[22] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-malabaltor.dds",
      bounds = { xN = 0.3, yN = 0.5674, widthN = 0.1221, heightN = 0.1099, },
   },
}

--------------------
-- Reaper's March --
tamriel.zones[256] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-reapersmarch.dds",
      bounds = { xN = 0.4090, yN = 0.5465, widthN = 0.1006, heightN = 0.1309, },
   },
}

------------------------------------------------------------------------------------------------------------------------------------------------
---- Ebonheart Pact -------- Ebonheart Pact -------- Ebonheart Pact -------- Ebonheart Pact -------- Ebonheart Pact -------- Ebonheart Pact ----
------------------------------------------------------------------------------------------------------------------------------------------------

--------------------
-- Bleakrock Isle --
--tamriel.pois[172] = { majorSettlement = true, guildShrine = true } -- Bleakrock Isle Wayshrine

---------------
-- Bal Foyen --
tamriel.zones[75] = {
   hideName = true,
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-balfoyen.dds",
      bounds = { xN = 0.794, yN = 0.4288, widthN = 0.0322, heightN = 0.0322, },
   },
}

----------------
-- Stonefalls --
tamriel.zones[7] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-stonefalls.dds",
      bounds = { xN = 0.6616, yN = 0.38, widthN = 0.1445, heightN = 0.1133, },
   },
}

-------------
-- Deshaan --
tamriel.zones[13] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-deshaan.dds",
      bounds = { xN = 0.6961, yN = 0.46, widthN = 0.1538, heightN = 0.0791, },
   },
}

---------------
-- Shadowfen --
tamriel.zones[26] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-shadowfen.dds",
      bounds = { xN = 0.6963, yN = 0.5313, widthN = 0.1138, heightN = 0.0962, },
   },
}

---------------
-- Eastmarch --
tamriel.zones[61] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-eastmarch.dds",
      bounds = { xN = 0.5699, yN = 0.2451, widthN = 0.1289, heightN = 0.0922, },
   }
}

--------------
-- The Rift --
tamriel.zones[125] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-therift.dds",
      bounds = { xN = 0.5387, yN = 0.3225, widthN = 0.1533, heightN = 0.0937, },
   },
}

------------------------------
-- Norg-Tzel / Swamp Island --
tamriel.zones[1552] = {
   hideName = true,
   blob = {
      textureFile = "/art/maps/tutorial/ui_maps_swampisland_blob.dds",
      bounds = { xN = 0.7991, yN = 0.7919, widthN = 0.0156, heightN = 0.0156, },
   },
}


------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn ----
------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------
-- Craglorn --
tamriel.zones[1126] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-craglorn.dds",
      bounds = { xN = 0.3237, yN = 0.3140, widthN = 0.1763, heightN = 0.1187, },
   },
}

----------------------------------------------------------------------------------------------------------------------------------------------------------
---- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP ----
----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------
-- Cyrodiil --

tamriel.zones[16] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-cyrodiil.dds",
      bounds = {  xN = 0.4513, yN = 0.3574 , widthN = 0.2461, heightN = 0.2461, },
   },
}

----------------------------------------------------------------------------------------------------------------------------------------------------------
---- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC ----
----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------
-- Wrothgar --
tamriel.zones[667] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-wrothgar.dds",
      bounds = { xN = 0.184, yN = 0.186, widthN = 0.1401, heightN = 0.1157, },
   },
}

------------------------------------------------------------------------------------------------------------------------------------------------------
---- Theives Guild DLC / Dark Brotherhood DLC -------- Theives Guild DLC / Dark Brotherhood DLC -------- Theives Guild DLC / Dark Brotherhood DLC ----
------------------------------------------------------------------------------------------------------------------------------------------------------

----------------
-- Hew's Bane --
tamriel.zones[994] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel-hewsbane.dds",
      bounds = { xN = 0.202, yN = 0.486, widthN = 0.062, heightN = 0.0562, },
   },
}

----------------
-- Gold Coast --


tamriel.zones[1006] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel_goldcoast.dds",
      bounds = { xN = 0.3020, yN = 0.518, widthN = 0.0854, heightN = 0.0918, },
   },
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC ----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------
-- Vvardenfell --
tamriel.zones[1060] = {
   blob = {
      textureFile = "/art/maps/tamriel/tamriel_vvardenfell.dds",
      bounds = { xN = 0.6978, yN = 0.2309, widthN = 0.1489, heightN = 0.1611, },
   },
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Summerset DLC -------- Summerset DLC -------- Summerset DLC -------- Summerset DLC -------- Summerset DLC -------- Summerset DLC -------- Summerset DLC ----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

---------------
-- Summerset --


tamriel.zones[1349] = {
   blob = {
      textureFile = "/art/maps/tamriel/ui_maps_summerset2_tamriel_blob.dds",
      bounds = { xN = 0.0163, yN = 0.63, widthN = 0.1807, heightN = 0.1924, },
   },
}

--------------
-- Murkmire --
tamriel.zones[1484] = {
   blob = {
      textureFile = "/art/maps/tamriel/ui_maps_murkmire_tamriel_blob.dds",
      bounds = { xN = 0.6812, yN = 0.72, widthN = 0.1045, heightN = 0.0928, },
   },
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC ----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------
-- Northern Elsweyr --


tamriel.zones[1555] = {
   blob = {
      textureFile = "/art/maps/tamriel/ui_maps_elswyer_blob.dds",
      bounds = { xN = 0.4445, yN = 0.5845, widthN = 0.1514, heightN = 0.1187, },
   },
}

----------------------
-- Southern Elsweyr --

tamriel.zones[1654] = {
   blob = {
      textureFile = "/art/maps/tamriel/ui_maps_southernelswyer_blob.dds",
      bounds = { xN = 0.4977, yN = 0.6966, widthN = 0.1265, heightN = 0.1152, },
   },
}

----------------------------------------------------------------------------------------------------------------------------------------------------------
---- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC ----
----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------
-- Western Skyrim --
tamriel.zones[1719] = {
   blob = {
      textureFile = "/art/maps/skyrim/ui_maps_skyrim_blob2.dds",
      bounds = { xN = 0.3411, yN = 0.1834, widthN = 0.1513, heightN = 0.1025, },
   },
}

---------------
-- The Reach --
tamriel.zones[1814] = {
   blob = {
      textureFile = "/art/maps/reach/ui_maps_reachzone.dds",
      bounds = { xN = 0.3261, yN = 0.2444, widthN = 0.0996, heightN = 0.0854, },
   },
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC ----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

---------------
-- Blackwood --
tamriel.zones[1887] = {
   blob = {
      textureFile = "/art/maps/tamriel/ui_maps_blackwood_blob.dds",
      bounds = { xN = 0.5835, yN = 0.6003, widthN = 0.1309, heightN = 0.1611, },
   },
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
---- High Isle DLC / Firesong DLC -------- High Isle DLC / Firesong DLC -------- High Isle DLC / Firesong DLC -------- High Isle DLC / Firesong DLC ----
--------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------
-- High Isle and Amenos --
tamriel.zones[2114] = {
   blob = {
      textureFile = "/art/maps/tamriel/ui_maps_systres_blob.dds",
      bounds = { xN = 0.049, yN = 0.5664, widthN = 0.0415, heightN = 0.0444, },
   },
}

------------------------
-- Galen and Y'ffelon --
tamriel.zones[2212] = { 
   hideName = true, 
   blob = {
      textureFile = "/art/maps/tamriel/ui_maps_galenblob.dds",
      --0.022949219
      bounds = { xN = 0.0438, yN = 0.5542, widthN = 0.019, heightN = 0.0195, },
   },
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC ----
----------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------
-- Telvanni Peninsula --
tamriel.zones[2274] = {
   blob = {
      textureFile = "/art/maps/tamriel/ui_maps_telvanni_blob.dds",
      bounds = { xN = 0.78124, yN = 0.35627, widthN = 0.17529, heightN = 0.1455, },
   },
}