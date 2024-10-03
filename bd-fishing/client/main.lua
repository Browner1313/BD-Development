local QBCore = exports['qb-core']:GetCoreObject()


local function spawnFishingGearNPC()
    local pedModel = GetHashKey(Config.FishingGearNPC.pedModel)
    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(100)
    end

    local coords = Config.FishingGearNPC.coords
    local npc = CreatePed(4, pedModel, coords.x, coords.y, coords.z, coords.w, false, true)

    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)  
    SetPedFleeAttributes(npc, 0, false)  
    SetPedCombatAttributes(npc, 46, true)
    
    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                type = "client",
                event = "fishing:openStore",  
                icon = "fas fa-shopping-cart",
                label = "Open Fishing Gear Store",
            }
        },
        distance = 2.5  
    })
end


local function spawnBoatRentalNPC()
    local pedModel = GetHashKey(Config.BoatRentalNPC.pedModel)
    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(100)
    end

    local coords = Config.BoatRentalNPC.coords
    local npc = CreatePed(4, pedModel, coords.x, coords.y, coords.z, coords.w, false, true)

    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)  
    SetPedFleeAttributes(npc, 0, false)
    SetPedCombatAttributes(npc, 46, true)

    
    local animation = Config.BoatRentalNPC.animation
    TaskStartScenarioInPlace(npc, animation.scenario, 0, animation.loop)


    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                type = "client",
                event = "fishing:checkBoatProgression",  
                icon = "fas fa-anchor",
                label = "Talk to Angler",
            }
        },
        distance = 2.5  
    })
end


AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        spawnFishingGearNPC()
        spawnBoatRentalNPC()
    end
end)
