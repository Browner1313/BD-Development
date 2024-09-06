local QBCore = exports['qb-core']:GetCoreObject()

-- Define spawn points with coordinates and names
local spawnPoints = {
  [1] = { x = 100, y = 200, z = 21, name = 'Fantastic Plaza' },
  [2] = { x = 300, y = 400, z = 22, name = 'Pacific Bank' },
  [3] = { x = 500, y = 600, z = 23, name = 'Mirror Park' },
  [4] = { x = 700, y = 800, z = 24, name = 'Sandy Motel' },
  [5] = { x = 900, y = 1000, z = 25, name = 'Paleto Bay' },
  [6] = { x = 1100, y = 1200, z = 26, name = 'MRPD' },
}

-- Handle choosing a spawn point from the client
RegisterNetEvent('bs-spawn:server:chooseSpawn')
AddEventHandler('bs-spawn:server:chooseSpawn', function(spawnPointIndex)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)

  if Player then
    -- Check if the spawn point index exists
    local spawnPoint = spawnPoints[spawnPointIndex]
    if spawnPoint then
      -- Trigger client event to spawn player at the chosen location
      TriggerClientEvent('bs-spawn:client:spawnPlayer', src, spawnPoint)
    else
      print('Invalid spawn point index: ' .. spawnPointIndex)
    end
  end
end)

-- Store the last known player location when they disconnect
AddEventHandler('playerDropped', function(reason)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)

  if Player then
    -- Ensure player ped is valid
    local ped = GetPlayerPed(src)
    if ped then
      local coords = GetEntityCoords(ped)
      -- Trigger event to save last location
      TriggerEvent('bs-spawn:setLastLocation', src, coords)
    end
  end
end)

-- Event to handle setting the last location of a player
RegisterNetEvent('bs-spawn:setLastLocation')
AddEventHandler('bs-spawn:setLastLocation', function(playerId, coords)
  -- Store the last known location (you may want to save this to a database)
  -- For demonstration, we'll use a simple table. Replace with database handling if needed.
  local lastLocations = lastLocations or {}
  lastLocations[playerId] = coords
  print('Last location saved for player ' .. playerId)
end)
