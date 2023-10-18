local LMT = LibMapThemer -- Easy access to LibMapThemer

-----------------------------
--- ExampleTheme Template ---
-----------------------------
ExampleTheme = {
   name = "ExampleTheme",
   --prefix = "ExampleTheme", -- leave nil if folder name is same as name, otherwise use folder name
   author = "ThemeAuthor",    -- Easy access to theme author name
   version = "1.0.0",         -- Easy access to theme version
   dependencies = { ExampleDependency1, ExampleDependency2, }, -- list in order of priority
   renames = { },    -- Any map rename
   overrides = { },  -- Any function override, (safe wrap around)
   maps = { },       -- Any map that the theme alters
}
local theme = ExampleTheme    -- Easy identifier, DO NOT MAKE GLOBAL AS IT WILL CAUSE CONFLICTS
local prefix = theme.prefix   -- prefix for installation folder

-----------------------------
--- ExampleRename Template ---
-----------------------------
local renames = theme.renames -- Easy identifier, DO NOT MAKE GLOBAL AS IT WILL CAUSE CONFLICTS
renames["Example Zone Name"] = "Example Zone Rename"  --Pretty sure this is language dependent

---------------------------------
--- ExampleOverride Template  ---
---------------------------------
local overrides = theme.overrides
overrides["ExampleOverrideFn"] = function(selfTheme, args, ...)
   -- Override methods will always have at least 2 arguments

   -- The first is the theme in which the function is from.

   -- The second is the unmodified args that the original function returns

   -- The last is "..." which is a placeholder for any arguments that 
   -- the function requires, besides "self"
   
   -- you can keep "..." as long as you either turn it into a table
   -- or split it somewhere inside the function like below
   local params = {...}
   -- or
   local param1, param2 = ...
   -- You can also replace "..." with the parameters directly in the function declaration

   -- It is best practice to return args no matter what
   -- The wrapper should still maintain any changes to the
   -- args despite if nil is return.
   -- Returning anything that is not "args" may/probably will 
   -- result in a crash.
   -- If you don't know what you're doing, return args
   return args
end

---------------------------------
--- ExampleMap Template  ---
---------------------------------
local maps = theme.maps -- Easy identifier, DO NOT MAKE GLOBAL AS IT WILL CAUSE CONFLICTS
local mapId = 1234 -- mapId of the map you wish to edit, can be found with /print_mapid, with the map open
maps[mapId] = { 
   zones = { },  -- ZoneBlob table
   pois = { },   -- PoI override table
   maxZoom = 6, -- Custom Max Zoom for the map (map break player icons)
}
local tamriel = maps[mapId] -- Easy identifier, DO NOT MAKE GLOBAL AS IT WILL CAUSE CONFLICTS

---------------------------------
--- ExampleZone Template  ---
---------------------------------
local zoneId = 1234 -- mapId of the zone map you wish to edit, can be found with /print_mapid, with the zone map open
tamriel.zones[zoneId] = {
   nameHidden = false,  -- the name of the zone will be displayed by default if the map has them enabled
   nameVisible = true,  -- this will hide any zones you wish not to display if that option is enabled
   
   -- Texture for the blob to use on the map, providing none will show nothing when hovering
   textureFile = prefix.."path/to/textureFile.dds",
   -- Bounds for the blob to be within on the map,
   -- this does not have to be a perfect square or be the same size as the texture
   -- Bounds reshapes where the POIs are places on the map,
   -- You can squish and stretch the POI to any degree
   -- but keeping it square will keep it it proportion to the zone map
   bounds = { xN = 0.0200, yN = 0.0200, widthN = 0.7999, heightN = 0.7999 },
   data = { 
      -- Mouse over bounds use to determine if mouse is within the bounds of the blob
      -- this is relative to the bounds of the blob and will distort to fit the bounds
      -- 0.0000 = Left/Top
      -- 1.0000 = Right/Bottom

      -- in order for data to be probably made, you must have
      -- at least 3 points to make a 2d polygon.
      -- Points must be places in clockwise/counterclockwise order
      -- failure to do so will result in wonky mouseovers

      -- you can easily create data by creating a blob without any and
      -- running the command /start_debugrecord mapId zoneId
      -- where mapId is equal to the map where the blob will be
      -- and zoneId is equal to where the blob will send you to
      
      -- example /start_debugrecord 27 16
      -- this will allow you to create data points for the
      -- cyrodiil zone on the tamriel map
      -- The tamriel map must be open for you to record points
      -- The points will be constrained to the bounds

      { xN = 0.0101, yN = 0.0011, },
      { xN = 0.0301, yN = 0.0081, },
      { xN = 0.0601, yN = 0.0031, },
      -- For near pixel perfect accuracy, especially in higher resolutions
      -- Use 4-6 decimal points, anymore is seen as redundant
      -- You can probably get away with 3 for a 1080p monitor, but for anything
      -- 1440p and higher, i would recommend 4
   },
}

-- local compiled = LMT:CreateCompiledTheme(ExampleTheme) -- Compile method
-- LMT:LoadTheme(ExampleTheme)                            -- Load method
-- LMT:LoadCompiledTheme(ExampleTheme)                    -- Load method

-- you are able to list the avalible functions for compiled themes via the
-- /print_theme_functions /print_map_functions /print_zone_functions