local QBCore = exports['qb-core']:GetCoreObject()
local lastLocation = nil

-- Open the spawn menu
RegisterNetEvent('bs-spawn:openMenu')
AddEventHandler('bs-spawn:openMenu', function()
  -- Markers data with actual coordinates
  local markers = {
    { class = 'fantastic_plaza', x = 100,  y = 200,  z = 30, name = 'Fantastic Plaza' },
    { class = 'pacific_bank',    x = 300,  y = 400,  z = 30, name = 'Pacific Bank' },
    { class = 'mirror_park',     x = 500,  y = 600,  z = 30, name = 'Mirror Park' },
    { class = 'sandy',           x = 700,  y = 800,  z = 30, name = 'Sandy Motel' },
    { class = 'paleto',          x = 900,  y = 1000, z = 30, name = 'Paleto Bay' },
    { class = 'policedp',        x = 1100, y = 1200, z = 30, name = 'MRPD' },
  }

  -- Set up time cycle and open the NUI spawn menu
  SetTimecycleModifier('hud_def_blur') -- optional for UI blur effect
  SendNUIMessage({
    action = 'display',
    markers = markers
  })
  SetNuiFocus(true, true) -- Allow NUI to have focus (mouse/keyboard)
end)

-- Client-side spawn after choosing a location
RegisterNetEvent('bs-spawn:client:spawnPlayer')
AddEventHandler('bs-spawn:client:spawnPlayer', function(spawnPoint)
  -- Reset the player location
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)

  -- Set player's position at the chosen spawn point
  SetEntityCoords(PlayerPedId(), spawnPoint.x, spawnPoint.y, spawnPoint.z, false, false, false, true)
  DoScreenFadeIn(1000)

  -- Reset UI and cleanup
  SetTimecycleModifier('default')
  SetNuiFocus(false, false)
end)

-- NUI Callback for choosing a spawn
RegisterNUICallback('chooseSpawn', function(data, cb)
  local spawnPointIndex = tonumber(data.location)
  TriggerServerEvent('bs-spawn:server:chooseSpawn', spawnPointIndex) -- Notify server
  cb('ok')
end)

-- NUI Callback for closing the menu
RegisterNUICallback('closeMenu', function(data, cb)
  SetNuiFocus(false, false)
  SetTimecycleModifier('default')
  cb('ok')
end)

-- Set last location for the player
RegisterNetEvent('bs-spawn:setLastLocation')
AddEventHandler('bs-spawn:setLastLocation', function(location)
  lastLocation = location
end)
