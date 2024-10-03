
-- Register the Fishing Gear Shop with ox_inventory
CreateThread(function()
  local shopItems = Config.FishingGearNPC.storeItems

  -- Register the shop on the server-side
  exports.ox_inventory:RegisterShop('fishinggear', {
      name = "Fishing Gear Store",
      inventory = shopItems,
      type = 'shop',
      currency = 'money',  
  })
end)

-- Register the Boat Rental Shop with ox_inventory
CreateThread(function()
  local rentalItems = Config.BoatRentalNPC.rentalItems

  exports.ox_inventory:RegisterShop('boatrental', {
      name = "Boat Rental",
      inventory = rentalItems,
      type = 'shop',
      currency = 'money',  
  })
end)


-- Event to open the Fishing Gear Shop
RegisterServerEvent('bd-fishing:openFishingGearShop')
AddEventHandler('bd-fishing:openFishingGearShop', function()
    local src = source
    -- Open the Fishing Gear shop for the player
    TriggerClientEvent('ox_inventory:openShop', src, 'fishinggear')
end)

-- Event to open the Boat Rental Shop
RegisterServerEvent('bd-fishing:openBoatRentalShop')
AddEventHandler('bd-fishing:openBoatRentalShop', function()
    local src = source
    -- Open the Boat Rental shop for the player
    TriggerClientEvent('ox_inventory:openShop', src, 'boatrental')
end)

