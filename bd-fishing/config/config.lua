Config = {}

Config.Framework = ''
Config.Inventory = ''
Config.Target = 'qb'

Config.FishingGearNPC = {
  coords = vector4(-3412.05, 964.2, 7.35, 273.76),
  heading = 150.0,
  pedModel = 'a_m_y_musclbeac_01',
  storeItems = { 
    {'fishingrod', price = 50}, 
    {'fishingbait', price = 10}, 
    {'cooler', price = 100}
  }
}

Config.BoatRentalNPC = {
  coords = vector4(-3423.2, 981.67, 7.35, 82.82),
  heading = 200.0,
  pedModel = 'mp_m_boatstaff_01',
  rentalItems = {},
  requiredXP = 800,
  animation = {
    scenario = "amb@world_human_leaning@male@wall@back@foot_up@idle_a",
    loop = true
  }
}

Config.FishTiers = {
  common = {
    { name = 'catfish', xp= 5, image ='images/common/catfish.png' },
    { name = 'fish', xp= 5, image ='images/common/fish.png' },
    { name = 'fish2', xp= 5, image ='images/common/fish2.png' },
    { name = 'salmon', xp= 5, image ='images/common/salmon.png' },
  },
  rare = {
    { name = 'mahimahi', xp = 12, image = 'images/rare/mahimahi.png' },
    { name = 'redfish', xp = 12, image = 'images/rare/redfish.png' },
    { name = 'stringray', xp = 8, image = 'images/rare/stringray.png' },
    { name = 'stripedbass', xp = 10, image = 'images/rare/stripedbass.png' },
    { name = 'wahoo', xp = 13, image = 'images/rare/wahoo.png' }
  },
  legendary = {
    { name = 'blackmarlin', xp = 100, image = 'images/legendary/blackmarlin.png' },
    { name = 'makishark', xp = 120, image = 'images/legendary/makishark.png' }
 }
}

Config.ProgressionTiers = {
  [1] = {
    xpNeeded = 100, 
    unlockItems = { 'advanced_reel' },
},
  [2] = {
    xpNeeded = 300, 
    unlockItems = { 'deep_sea_rod' },
},
  [3] = {
    xpNeeded = 1000, 
    unlockBoats = { { name = 'tug', displayName = 'Deep Sea Boat', price = 3000 } }
 }
}

Config.IntitialXP = 0
