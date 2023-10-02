LibMapThemer_PoiData = {
   name = "LibMapThemer_PoiData",
   maps = { },
}
local theme = LibMapThemer_PoiData
local maps = theme.maps

----------------------------------------------------------------------------------------------------------------------------------------
---- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel ----
----------------------------------------------------------------------------------------------------------------------------------------
---- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel -------- Tamriel ----
----------------------------------------------------------------------------------------------------------------------------------------
maps[27] = { pois = { }, }
local tamriel = maps[27]


-------------------------------------------------------------------------------------------------------------------------------------------------
---- Daggerfall Covenant -------- Daggerfall Covenant -------- Daggerfall Covenant -------- Daggerfall Covenant -------- Daggerfall Covenant ----
-------------------------------------------------------------------------------------------------------------------------------------------------

-----------------
-- Stros M'kai --
tamriel.pois[138] = { majorSettlement = true, guildShrine = true, }  -- Port Hunding Wayshrine 

-------------
-- Betnikh --
tamriel.pois[181] = { majorSettlement = true, guildShrine = true }   -- Stonetooth Wayshrine

---------------
-- Glenumbra --
tamriel.pois[1]   = { guildShrine = true, }                          -- Wyrd Tree Wayshrine
tamriel.pois[2]   = { majorSettlement = true, }                      -- Aldcroft Wayshrine 
tamriel.pois[6]   = { guildShrine = true, }                          -- Lionguard Redoubt Wayshrine
tamriel.pois[7]   = { majorSettlement = true, }                      -- Crosswyrch Wayshrine 
tamriel.pois[62]  = { majorSettlement = true, guildShrine = true }   -- Daggerfall Wayshrine 

----------------
-- Stormhaven --   
tamriel.pois[14]  = { majorSettlement = true, guildShrine = true, }  -- Koeglin Village Wayshrine 
tamriel.pois[15]  = { majorSettlement = true, }                      -- Alcaire Castle Wayshrine 
tamriel.pois[16]  = { guildShrine = true, }                          -- Firebrand Keep Wayshrine 
tamriel.pois[22]  = { majorSettlement = true, }                      -- Wind Keep Wayshrine 
tamriel.pois[56]  = { majorSettlement = true, guildShrine = true, }  -- Wayrest Wayshrine

----------------
-- Rivenspire --
tamriel.pois[9]   = { guildShrine = true }                           -- Oldgate Wayshrine
tamriel.pois[10]  = { majorSettlement = true, }                      -- Crestshade Wayshrine
tamriel.pois[55]  = { majorSettlement = true, guildShrine = true, }  -- Shornhelm Wayshrine
tamriel.pois[82]  = { majorSettlement = true, }                      -- Northpoint Wayshrine
tamriel.pois[84]  = { majorSettlement = true, guildShrine = true, }  -- Hoarfrost Downs Wayshrine

----------------
-- The Alik'r --
tamriel.pois[42]  = { guildShrine = true, }                          -- Morwha's Bounty Wayshrine
tamriel.pois[43]  = { majorSettlement = true, guildShrine = true, }  -- Sentinel Wayshrine
tamriel.pois[44]  = { majorSettlement = true, guildShrine = true, }  -- Bergama Wayshrine
tamriel.pois[46]  = { majorSettlement = true, }                      -- Satakalaam Wayshrine

---------------
-- Bangkorai --
tamriel.pois[33]  = { majorSettlement = true, } -- Evermore Wayshrine
tamriel.pois[36]  = { guildShrine = true, } -- Bangkorai Pass Wayshrine
tamriel.pois[38]  = { majorSettlement = true, guildShrine = true, } -- Hallin's Stand Wayshrine  
tamriel.pois[204] = { guildShrine = true, } -- Eastern Evermore Wayshrine

------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Aldmeri Dominion -------- Aldmeri Dominion -------- Aldmeri Dominion -------- Aldmeri Dominion -------- Aldmeri Dominion -------- Aldmeri Dominion ----
------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------
-- Khenarthi's Roost --
tamriel.pois[142] = { majorSettlement = true, } -- Mistral Wayshrine

-------------
-- Auridon --
tamriel.pois[121] = { majorSettlement = true, guildShrine = true, }  -- Skywatch Wayshrine
tamriel.pois[175] = { majorSettlement = true, guildShrine = true, }  -- Firsthold Wayshrine  
tamriel.pois[176] = { majorSettlement = true, }                      -- Mathiisen Wayshrine
tamriel.pois[177] = { majorSettlement = true, guildShrine = true, }  -- Vulkhel Guard Wayshrine

---------------
-- Grahtwood --
tamriel.pois[164] = { majorSettlement = true, }                      -- Gilvardale Wayshrine
tamriel.pois[165] = { majorSettlement = true, }                      -- Haven Wayshrine
tamriel.pois[166] = { majorSettlement = true, }                      -- Redfur Trading Post Wayshrine
tamriel.pois[167] = { majorSettlement = true, guildShrine = true, }  -- Southpoint Wayshrine
tamriel.pois[168] = { majorSettlement = true, guildShrine = true, }  -- Cormount Wayshrine
tamriel.pois[214] = { majorSettlement = true, guildShrine = true, }  -- Elden Root Wayshrine

----------------
-- Greenshade --
tamriel.pois[143] = { majorSettlement = true, guildShrine = true, }  -- Marbruk Wayshrine
tamriel.pois[147] = { majorSettlement = true, guildShrine = true, }  -- Greenheart Wayshrine
tamriel.pois[151] = { majorSettlement = true, guildShrine = true, }  -- Verrant Morass Wayshrine
tamriel.pois[152] = { majorSettlement = true, }                      -- Woodhearth Wayshrine

-----------------
-- Malabal Tor --
tamriel.pois[100] = { majorSettlement = true, }                      -- Vulkwasten Wayshrine
tamriel.pois[101] = { guildShrine = true, }                          -- Dra'bul Wayshrine
tamriel.pois[102] = { majorSettlement = true, }                      -- Vely Harbour Wayshrine
tamriel.pois[106] = { majorSettlement = true, guildShrine = true, } -- Baandari Trading Post Wayshrine    name = "Baandari Trading Post Wayshrine", 
tamriel.pois[107] = { majorSettlement = true, guildShrine = true, }  -- Valeguard Wayshrine

--------------------
-- Reaper's March --
tamriel.pois[158] = { majorSettlement = true, }                      -- Arenthia Wayshrine
tamriel.pois[144] = { majorSettlement = true, guildShrine = true, }  -- Vinedusk Wayshrine
tamriel.pois[159] = { majorSettlement = true, guildShrine = true, }  -- Dune Wayshrine
tamriel.pois[162] = { majorSettlement = true, guildShrine = true, }  -- Rawl'kha Wayshrine
tamriel.pois[163] = { majorSettlement = true, }                      -- S'ren-ja Wayshrine

------------------------------------------------------------------------------------------------------------------------------------------------
---- Ebonheart Pact -------- Ebonheart Pact -------- Ebonheart Pact -------- Ebonheart Pact -------- Ebonheart Pact -------- Ebonheart Pact ----
------------------------------------------------------------------------------------------------------------------------------------------------

--------------------
-- Bleakrock Isle --
tamriel.pois[172] = { majorSettlement = true, guildShrine = true } -- Bleakrock Isle Wayshrine

---------------
-- Bal Foyen --
tamriel.pois[173] = { majorSettlement = true, guildShrine = true, } -- Dhalmora Wayshrine

----------------
-- Stonefalls --
tamriel.pois[65] = { majorSettlement = true, guildShrine = true } -- Davon's Watch Wayshrine
tamriel.pois[67] = { majorSettlement = true, guildShrine = true } -- Ebonheart Wayshrine
tamriel.pois[76] = { majorSettlement = true, guildShrine = true } -- Kragenmoor Wayshrine

-------------
-- Deshaan --
tamriel.pois[24] = { majorSettlement = true, }                    -- West Narsis Wayshrine
tamriel.pois[25] = { guildShrine = true, }                        -- Muth Gnaar Hills Wayshrine
tamriel.pois[28] = { majorSettlement = true, guildShrine = true } -- Mournhold Wayshrine
tamriel.pois[29] = { guildShrine = true, }                        -- Tal'Deic Grounds Wayshrine
tamriel.pois[79] = { majorSettlement = true, }                    -- Selfora Wayshrine

---------------
-- Shadowfen --
tamriel.pois[48] = { majorSettlement = true, guildShrine = true, }   -- Stormhold Wayshrine
tamriel.pois[50] = { majorSettlement = true, }                       -- Alten Corimont Wayshrine 
tamriel.pois[52] = { guildShrine = true, }                           -- Hissmir Wayshrine 
tamriel.pois[78] = { guildShrine = true, }                           -- Venomous Fens Wayshrine 

---------------
-- Eastmarch --
tamriel.pois[87] = { majorSettlement = true, guildShrine = true } -- Windhelm Wayshrine
tamriel.pois[88] = { majorSettlement = true, }                    -- Fort Morvunskar Wayshrine
tamriel.pois[90] = { guildShrine = true, }                        -- Voljar Meadery Wayshrine
tamriel.pois[92] = { majorSettlement = true, guildShrine = true } -- Fort Amol Wayshrine

--------------
-- The Rift --
tamriel.pois[114] = { majorSettlement = true, guildShrine = true }   -- Fallowstone Hall Wayshrine 
tamriel.pois[118] = { majorSettlement = true, guildShrine = true }   -- Nimalten Wayshrine
tamriel.pois[116] = { majorSettlement = true, }                      -- Geirmund's Hall Wayshrine 
tamriel.pois[109] = { majorSettlement = true, guildShrine = true }   -- Riften Wayshrine
tamriel.pois[110] = { guildShrine = true, }                          -- Skald's Retreat Wayshrine


----------------------------------------------------------------------------------------------------------------------------------------------------------
---- guildShrines -------- guildShrines -------- guildShrines -------- guildShrines -------- guildShrines -------- guildShrines -------- guildShrines ----
----------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------
-- Earth Forge --
tamriel.pois[221] = { disabled = true, majorSettlement = true, }

------------
-- Eyevea --
tamriel.pois[215] = { disabled = true, majorSettlement = true, } -- Eyevea Wayshrine

------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn -------- Craglorn ----
------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------
-- Craglorn --
tamriel.pois[220] = { majorSettlement = true, guildShrine = true, }  -- Belkarth Wayshrine 
tamriel.pois[229] = { majorSettlement = true, }                      -- Elinhir Wayshrine 
tamriel.pois[233] = { majorSettlement = true, }                      -- Dragonstar Wayshrine 
tamriel.pois[270] = { groupArena = true, }                           -- Dragonstar Arena

----------------------------------------------------------------------------------------------------------------------------------------------------------
---- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP -------- Cyrodiil PvP ----
----------------------------------------------------------------------------------------------------------------------------------------------------------
maps[16] = { pois = { }, }
local cyrodiil = maps[16]
--------------
-- Cyrodiil --
cyrodiil.pois[201] = { name = "Western Elsweyr Gate Wayshrine",      majorSettlement = true, } -- Western Elsweyr Wayshrine
cyrodiil.pois[200] = { name = "Eastern Elsweyr Gate Wayshrine",      majorSettlement = true, } -- Eastern Elsweyr Wayshrine
cyrodiil.pois[202] = { name = "Northern Morrowind Gate Wayshrine",   majorSettlement = true, } -- Northern Morrowind Wayshrine
cyrodiil.pois[203] = { name = "Southern Morrowind Gate Wayshrine",   majorSettlement = true, } -- Southern Morrowind Wayshrine
cyrodiil.pois[170] = { name = "Northern Hammerfell Gate Wayshrine",  majorSettlement = true, } -- Northern Hammerfell Wayshrine
cyrodiil.pois[199] = { name = "Southern Hammerfell Gate Wayshrine",  majorSettlement = true, } -- Southern Hammerfell Wayshrine
tamriel.pois[200] = cyrodiil.pois[200] tamriel.pois[201] = cyrodiil.pois[201] 
tamriel.pois[202] = cyrodiil.pois[202] tamriel.pois[203] = cyrodiil.pois[203] 
tamriel.pois[170] = cyrodiil.pois[170] tamriel.pois[199] = cyrodiil.pois[199]


----------------------------------------------------------------------------------------------------------------------------------------------------------
---- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC -------- Orsinium DLC ----
----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------
-- Wrothgar --
tamriel.pois[250] = { soloArena = true, }                            -- Maelstrom Arena
tamriel.pois[244] = { majorSettlement = true, guildShrine = true, }  -- Orsinium Wayshrine 
tamriel.pois[237] = { majorSettlement = true, guildShrine = true, }  -- Shatul Wayshrine 

------------------------------------------------------------------------------------------------------------------------------------------------------
---- Theives Guild DLC / Dark Brotherhood DLC -------- Theives Guild DLC / Dark Brotherhood DLC -------- Theives Guild DLC / Dark Brotherhood DLC ----
------------------------------------------------------------------------------------------------------------------------------------------------------

----------------
-- Hew's Bane --
tamriel.pois[255] = { majorSettlement = true, guildShrine = true, } -- Abah's Landing Wayshrine

----------------
-- Gold Coast --
tamriel.pois[251] = { majorSettlement = true, guildShrine = true, }  -- Anvil Wayshrine
tamriel.pois[252] = { majorSettlement = true, }                      -- Kvatch Wayshrine

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC -------- Morrowind DLC ----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------
-- Vvardenfell --
tamriel.pois[272] = { majorSettlement = true, }                      -- Seyda Neen Wayshrine 
tamriel.pois[273] = { majorSettlement = true, }                      -- Gnisis Wayshrine
tamriel.pois[274] = { majorSettlement = true, }                      -- Ald'ruhn Wayshrine
tamriel.pois[275] = { majorSettlement = true, guildShrine = true }   -- Balmora Wayshrine
tamriel.pois[276] = { majorSettlement = true, }                      -- Suran Wayshrine
tamriel.pois[277] = { majorSettlement = true, }                      -- Molag Mar Wayshrine 
tamriel.pois[278] = { majorSettlement = true, }                      -- Tel Branora Wayshrine
tamriel.pois[280] = { majorSettlement = true, }                      -- Tel Mora Wayshrine
tamriel.pois[281] = { majorSettlement = true, guildShrine = true }   -- Sadrith Mora Wayshrine 
tamriel.pois[284] = { majorSettlement = true, guildShrine = true }   -- Vivec City Wayshrine 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Summerset DLC -------- Summerset DLC -------- Summerset DLC -------- Summerset DLC -------- Summerset DLC -------- Summerset DLC -------- Summerset DLC ----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

---------------
-- Summerset --
tamriel.pois[350] = { majorSettlement = true, guildShrine = true, }  -- Shimmerene Wayshrine 
tamriel.pois[354] = { majorSettlement = true, }                      -- Ebon Stadmont Wayshrine
tamriel.pois[355] = { majorSettlement = true, guildShrine = true, }  -- Alinor Wayshrine
tamriel.pois[356] = { majorSettlement = true, guildShrine = true, }  -- Lilandril Wayshrine
tamriel.pois[365] = { majorSettlement = true, }                      -- Sunhold Wayshrine
tamriel.pois[373] = { xN = 0.236, yN = 0.862, }                      -- Grand Psijic Villa Wayshrine

--------------
-- Murkmire --
tamriel.pois[374] = { majorSettlement = true, guildShrine = true, }  -- Lilmoth Wayshrine
tamriel.pois[375] = { majorSettlement = true, }                      -- Bright-Throat Wayshrine 
tamriel.pois[376] = { majorSettlement = true, }                      -- Dead-Water Wayshrine 
tamriel.pois[378] = { groupArena = true, }                           -- Blackrose Prison

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC -------- Elsweyr DLC ----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------
-- Northern Elsweyr --                 -- Northern Elsweyr 
tamriel.pois[381] = { majorSettlement = true, }                      -- Riverhold Wayshrine Wayshrine
tamriel.pois[382] = { majorSettlement = true, guildShrine = true, }  -- Rimmen Wayshrine
tamriel.pois[383] = { majorSettlement = true, }                      -- The Stitches Wayshrine 
tamriel.pois[387] = { majorSettlement = true, }                      -- Hakoshae Wayshrine

----------------------
-- Southern Elsweyr --
--renames["Southern Elsweyr"] = "Southern \nElsweyr"                   -- Southern Elsweyr 
tamriel.pois[402] = { majorSettlement = true, guildShrine = true, }  -- Senchal Wayshrine
tamriel.pois[405] = { majorSettlement = true, }                      -- Black Heights Wayshrine

--------------
-- Tideholm --
tamriel.pois[407] = { majorSettlement = true, }                      -- Dragonguard Sanctum Wayshrine

----------------------------------------------------------------------------------------------------------------------------------------------------------
---- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC -------- Greymoor DLC ----
----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------
-- Western Skyrim --
tamriel.pois[421] = { majorSettlement = true, guildShrine = true }   -- Solitude Wayshrine
tamriel.pois[416] = { majorSettlement = true, }                      -- Morthal Wayshrine
tamriel.pois[417] = { majorSettlement = true, }                      -- Morkazgur Wayshrine
tamriel.pois[418] = { majorSettlement = true, }                      -- Dragonbridge Wayshrine
tamriel.pois[419] = { majorSettlement = true, }                      -- Southern Watch Wayshrine

---------------
-- The Reach --
tamriel.pois[445] = { majorSettlement = true, }                      -- Karthwasten Wayshrine
tamriel.pois[449] = { majorSettlement = true, guildShrine = true }   -- Markarth Wayshrine
tamriel.pois[457] = { soloArena = true, }                            -- Vateshran Hollows

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC -------- Blackwood DLC ----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

---------------
-- Blackwood --
tamriel.pois[483] = { majorSettlement = true, } -- Hutan-Tzel Wayshrine
tamriel.pois[459] = { majorSettlement = true, } -- Gideon Wayshrine 
tamriel.pois[464] = { majorSettlement = true, } -- Stonewastes Wayshrine
tamriel.pois[458] = { majorSettlement = true, guildShrine = true } -- Leyawiin Wayshrine

--------------------------------------------------------------------------------------------------------------------------------------------------------
---- High Isle DLC / Firesong DLC -------- High Isle DLC / Firesong DLC -------- High Isle DLC / Firesong DLC -------- High Isle DLC / Firesong DLC ----
--------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------
-- High Isle and Amenos --
tamriel.pois[513] = { majorSettlement = true, guildShrine = true, } -- Gonfalon Square Wayshrine
tamriel.pois[508] = { majorSettlement = true, } -- Amenos Station

------------------------
-- Galen and Y'ffelon --
tamriel.pois[529] = { majorSettlement = true, guildShrine = true, } -- Vastyr Wayshrine

----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC -------- Necrom DLC ----
----------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------
-- Telvanni Peninsula --
tamriel.pois[536] = { majorSettlement = true, guildShrine = true, }  -- Necrom Wayshrine
tamriel.pois[538] = { majorSettlement = true, }                      -- Ald Isra Wayshrine
tamriel.pois[554] = { majorSettlement = true, }                      -- Alavelis Wayshrine