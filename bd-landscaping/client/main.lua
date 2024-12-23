local spawnedNPC = nil

local function spawnYardwordnpc()
  local npcModel = GetHashKey(Config.NPC.model)
  
  RequestModel(npcModel)
  while not HasModelLoaded(npcModel) do
    Wait(10)
  end

  spawnedNPC = CreatePed(4, npcModel, Config.NPC.location.x, Config.NPC.location.y, Config.NPC.location.z, Config.NPC.heading, false, false)
  SetEntityInvincible(spawnedNPC, true)
  FreezeEntityPosition(spawnedNPC, true)
  SetBlockingOfNonTemporaryEvents(spawnedNPC, true)
  SetEntityAsMissionEntity(spawnedNPC, true, true)
  TaskStartScenarioInPlace(spawnedNPC, "WORLD_HUMAN_CLIPBOARD", 0, true)
end

CreateThread(function()
  spawnYardwordnpc()
end)

exports.ox_target:addLocalEntity(spawnedNPC, {
  {
      name = 'clock_in_yardwork',
      label = 'Clock In for Yardwork',
      icon = 'fa-leaf',
      onSelect = function()
          spawnTruckAndEquipment() 
      end
  }
})

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() == resourceName then
    spawnYardwordnpc() 
  end
end)
