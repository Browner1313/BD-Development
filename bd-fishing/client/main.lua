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
                event = "fishing:openFishingGearStore",
                icon = "fas fa-shopping-cart",
                label = "Buy Fishing Gear",
            }
        },
        distance = 2.5  
    })
end




RegisterNetEvent('bd-fishing:openFishingGearStore')
AddEventHandler('bd-fishing:openFishingGearStore', function()
TriggerEvent('ox:openInventory', 'shop', 'FishingGearNPC')
    print("Attempting to open the Fishing Gear Shop...")
end)





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
    SetPedDefaultComponentVariation(npc)  
    TaskStartScenarioInPlace(npc, "WORLD_HUMAN_CLIPBOARD", 0, true)  


    -- Set up qb-target for the Boat Rental store
    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                type = "client",
                event = "fishing:checkBoatProgression",  
                icon = "fas fa-anchor",
                label = "Talk to Angler",
            }
        },
        distance = 2.5  -- Interaction distance
    })
end

-- Event to open the Fishing Gear Shop
RegisterNetEvent('fishing:openFishingGearStore')
AddEventHandler('fishing:openFishingGearStore', function()
    print("Attempting to open the Fishing Gear Shop...")
    exports.ox_inventory:openInventory('shop', { id = 'fishing_gear_shop' })
end)


RegisterNetEvent('fishing:checkBoatProgression')
AddEventHandler('fishing:checkBoatProgression', function()
    QBCore.Functions.TriggerCallback('bd-fishing:getPlayerXP', function(xp)
        if xp >= Config.BoatRentalNPC.requiredXP then
            -- Player has enough XP, open the Boat Rental store
            exports.ox_inventory:openInventory('shop', { type = 'General', id = 2 })  
        else
            -- Not enough XP, notify the player
            QBCore.Functions.Notify("Were not meant to talk yet.", "error")
        end
    end)
end)


Citizen.CreateThread(function()
    spawnFishingGearNPC()
    spawnBoatRentalNPC()  
end)