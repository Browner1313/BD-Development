local QBCore = exports['qb-core']:GetCoreObject()

-- Function to check if a player has the required item
local function HasRequiredItem(playerId, itemName)
  local itemList = exports['qs-inventory']:GetItemList()
  local hasItem = false

  for _, item in pairs(itemList) do
    if item.name == itemName then
      local Player = QBCore.Functions.GetPlayer(playerId)
      if Player then
        hasItem = Player.Functions.GetItemByName(itemName) ~= nil
        break
      end
    end
  end

  return hasItem
end

RegisterNetEvent('bs-pickpocket:server:checkItem')
AddEventHandler('bs-pickpocket:server:checkItem', function()
  local src = source

  -- Check if the player has the required item
  local hasItem = HasRequiredItem(src, 'lockpick') -- Replace 'lockpick' with your required item name

  -- Notify the client if they can or cannot pickpocket
  TriggerClientEvent('bs-pickpocket:client:canPickpocket', src, hasItem)
end)

RegisterNetEvent('bs-pickpocket:server:attemptPickpocket')
AddEventHandler('bs-pickpocket:server:attemptPickpocket', function(targetPed)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)

  -- Define pickpocketing success chance
  local successChance = 0.5 -- 50% chance, adjust as needed
  local success = math.random() < successChance

  if success then
    -- Define possible rewards
    local rewards = { 'money', 'casinochips', 'painkillers' } -- Add your item names here
    local reward = rewards[math.random(#rewards)]

    -- Logic for successful pickpocketing
    if reward == 'cash' then
      Player.Functions.AddMoney('cash', 100) -- Adjust amount as needed
      TriggerClientEvent('bs-pickpocket:client:pickpocketSuccess', src, 'cash')
    else
      -- Give item to player
      Player.Functions.AddItem(reward, 1)
      TriggerClientEvent('bs-pickpocket:client:pickpocketSuccess', src, reward)
    end
  else
    -- Logic for failure
    TriggerClientEvent('bs-pickpocket:client:pickpocketFailed', src)
  end
end)
