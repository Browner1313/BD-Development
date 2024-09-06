Config = {}

-- Enable or disable debug mode (true or false)
Config.Debug = false


-- Set to false if you dont want to use last location
Config.UseLastLocation = true

-- Spawn Locations
Config.Locations = {
  ["fantasic_plaza"] = {
    coords = vector4(291.79, -1078.66, 29.4, 263.63),
    location = "fantasic_plaza",
    label = "Fantastic Plaza"
  },

  ["pacific_bank"] = {
    coords = vector4(228.4, 218.61, 105.55, 78.04),
    location = "pacific_bank",
    label = "Pacific Bank",
  },

  ["mirror_park"] = {
    coords = vector4(1008.57, -764.89, 57.88, 269.27),
    location = "mirror_park",
    label = "Mirror Park",
  },

  ["sandy"] = {
    coords = vector4(1495.09, 3574.25, 35.3, 16.26),
    location = "sandy",
    label = "Sandy Motel"
  },

  ["paleto"] = {
    coords = vector4(106.93, 6607.61, 31.79, 239.18),
    location = "paleto",
    label = "Paleto Bay",
  },

  ["policedp"] = {
    -- coords = vector4(428.23, -984.28, 29.76, 3.5),
    coords = vector4(477.68, -976.48, 27.98, 1.8),
    location = "policedp",
    label = "Police Department",
    restricted = true,
    job = "police"
  },
}
