

--- First declare a name, this is how  your theme will be identified by
--- LibMapThemer and other themes alike 
local themeName = "ExampleThemeName"


--- Any theme/dependency/patch can be called Or initialized by accessing it via the
--- global _G[""] table.

--- This method is preferred over writing out the theme name, as this will allow spaces
--- and other characters not allowed in standard variable declaration
_G[themeName] = {
   name = themeName,

   --- What is the addon folder name
   prefix = "AddonFolderName",
   
   --- both dependencies and patches are able to used to edit your theme
   --- this can drastically change how your theme operates depending on
   --- what you're planning on doing
   dependencies = { DependencyTheme, },
   patches = { _G["PatchTheme"] },

   --- This allows for maps/zones to be renamed to whatever you want
   renames = { 
      ["Name"] = "Rename",
   },

   --- function overrides that a theme can control, it is preferred to stick with
   --- zos functions, and none that any patch or dependency also overrides, as
   --- overrides to those functions will be wiped
   overrides = {

      --- It is preferred you declare functions
      --- outside of this table for better formatting.
      --- this is as simple as doing 
--[[
   local theme = { overrides = { } }
   local overrides = theme.overrides
   overrides[""] = function(self, output){ return output }
--]]
      --- for simplicity will will declare an example one here


      --- First we declare the name and set it to a function

      --- the first 2 parameters are always going to be there and cannot be changed. 
      
      --- The first is a self reference to your compiled theme. This 
      --- is so you can still use other functions within your theme.

      --- The second is the output of the original function, unaltered
      --- you should return this at the end of every function as it will
      --- be the same output you will need for the function to work correctly.
      --- This is a table and must be indexed to atleast [1] since that is where
      --- lua begins counting

      ["ExampleZosFunction"] = function (self, output, ...)
         local params = { ... }
         local param1, param2, param3 = ...
         --- Some functions have arguments for them
         --- they can either be ignored or used, lua will throw out
         --- any unused variables and it will not affect the base
         --- function.

         --- These arguments can be declared via '...' in the functions
         --- declaration or with individual names.

         --- this will show you the '...' method as it is universal to
         --- any function

         --- depending on the function, it could return nil, or 1 variable, 
         --- or multiple so be careful with what you override. They will be 
         --- in the sequential order to the original function outputs.
         return output
      end

   },
   --- MapIds and ZoneIds are the same as in they both point to the same map. 
   --- So a map of 27 will only work when the tamriel map is open, while a 
   --- map with a zone id of 27 will point you to tamriel when its clicked.
   maps = { 


      --- 27 is tamriel's world map, this will probably be the most common
      --- map that needs to be altered, so we will use this as example.
      [27] = {
         tilePath = "Addon/tiles/tamriel/Tamriel_",



         zones = {
            


            --- this is Glenumbra
            [1] = { 

            }

         },


      },


   },


   
}