local themeName = "LibMapThemer_DataMerge"

_G[themeName] = {
   name = themeName,
   prefix = "LibMapThemer",
   dependencies = { LibMapThemer_OverrideData, LibMapThemer_RenameData, LibMapThemer_PoiData },
}