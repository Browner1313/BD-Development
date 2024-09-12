local QBCore = exports['qb-core']:GetCoreObject()
local isPickpocketing = false

-- Function to initialize the pickpocket target zone
function InitializePickpocketTargets()
  local npcs = GetAllNPCs()   -- Function to retrieve all NPCs in your scene

  for _, npc in pairs(npcs) do
    exports['qb-target']:AddTargetEntity(npc, {
      options = {
        {
          type = "client",
          event = "bs-pickpocket:client:startPickpocketing",
          icon = "fas fa-hand-paper",
          label = "Pickpocket"
        }
      },
      distance = 2.5       -- Adjust distance as needed
    })
  end
end

-- Call this function when initializing your script or during runtime
InitializePickpocketTargets()

-- Function to check if the player has the required item
function HasRequiredItem(itemName, callback)
  local hasItem = exports['qs-inventory']:HasItem(itemName)   -- Make sure this matches the actual export from qs-inventory
  callback(hasItem)
end

RegisterNetEvent('bs-pickpocket:client:startPickpocketing')
AddEventHandler('bs-pickpocket:client:startPickpocketing', function(targetPed)
  if isPickpocketing then
    QBCore.Functions.Notify("You are already pickpocketing!", "error")
    return
  end

  -- Check if the player has the required item
  HasRequiredItem('lockpick', function(canPickpocket)
    if canPickpocket then
      isPickpocketing = true

      -- Play animation (customize as needed)
      TaskPlayAnim(PlayerPedId(), 'missheistfb', 'pickpocket', 8.0, -8.0, 5000, 0, 0, false, false, false)

      -- Simulate time taken for pickpocketing
      Citizen.Wait(5000)

      -- Trigger server event to handle pickpocketing logic
      TriggerServerEvent('bs-pickpocket:server:attemptPickpocket', targetPed)
      isPickpocketing = false
    else
      QBCore.Functions.Notify("You don't have the required item to pickpocket!", "error")
    end
  end)
end)

-- Function to handle pickpocketing success or failure
function HandlePickpocketingOutcome(success, item)
  if success then
    -- Logic for successful pickpocketing
    QBCore.Functions.Notify('You successfully pickpocketed a ' .. item)
  else
    -- Logic for failure
    QBCore.Functions.Notify('You were caught trying to pickpocket!')
  end
end

RegisterNetEvent('bs-pickpocket:client:pickpocketSuccess')
AddEventHandler('bs-pickpocket:client:pickpocketSuccess', function(item)
  HandlePickpocketingOutcome(true, item)
end)

RegisterNetEvent('bs-pickpocket:client:pickpocketFailed')
AddEventHandler('bs-pickpocket:client:pickpocketFailed', function()
  HandlePickpocketingOutcome(false)
end)

-- Example function to get all NPCs
function GetAllNPCs()
  local npcs = {}
  for ped in EnumeratePeds() do
    if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
      table.insert(npcs, ped)
    end
  end
  return npcs
end

-- Enumerator function to get all peds (locals)
function EnumeratePeds()
  return coroutine.wrap(function()
    local ped = FindFirstPed()
    if not ped then return end

    local success
    repeat
      coroutine.yield(ped)
      success, ped = FindNextPed(ped)
    until not success

    EndFindPed()
  end)
end
