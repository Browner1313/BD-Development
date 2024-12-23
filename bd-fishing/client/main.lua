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

    -- Add ox_target interaction for Fishing Gear NPC
    exports.ox_target:addEntity(npc, {
        {
            name = "fishing_gear_shop",
            icon = "fas fa-shopping-cart",
            label = "Open Fishing Shop",
            canInteract = function(entity)
                print("Interacting with Fishing Gear NPC")  -- Debug print
                return true
            end,
            onSelect = function()
                print("Triggering fishing store event")  -- Debug print
                TriggerEvent('bd-fishing:openFishingStore')  -- Call the event to open the Fishing Gear Shop
            end
        }
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
    SetPedDefaultComponentVariation(npc)
    TaskStartScenarioInPlace(npc, "WORLD_HUMAN_CLIPBOARD", 0, true)

    -- Add ox_target interaction for Boat Rental NPC
    exports.ox_target:addEntity(npc, {
        {
            name = "boat_rental_shop",
            icon = "fas fa-anchor",
            label = "Talk to Boat Rental",
            canInteract = function(entity)
                print("Interacting with Boat Rental NPC")  -- Debug print
                return true
            end,
            onSelect = function()
                print("Triggering boat rental event")  -- Debug print
                TriggerEvent('fishing:checkBoatProgression')  -- Call the event to check progression for the Boat Rental NPC
            end
        }
    })
end

-- Event to open the Fishing Gear Shop
RegisterNetEvent('bd-fishing:openFishingStore')
AddEventHandler('bd-fishing:openFishingStore', function()
    print("Attempting to open the Fishing Gear Shop...")
    exports.ox_inventory:openInventory('shop', { id = 'fishing_gear_shop' })
end)

-- Event to check Boat Rental progression
RegisterNetEvent('fishing:checkBoatProgression')
AddEventHandler('fishing:checkBoatProgression', function()
    QBCore.Functions.TriggerCallback('bd-fishing:getPlayerXP', function(xp)
        if xp >= Config.BoatRentalNPC.requiredXP then
            print("Player has enough XP, opening Boat Rental Shop...")  -- Debug print
            exports.ox_inventory:openInventory('shop', { type = 'General', id = 2 })
        else
            print("Player does not have enough XP for Boat Rental...")  -- Debug print
            QBCore.Functions.Notify("We're not meant to talk yet.", "error")
        end
    end)
end)

-- Spawning both NPCs
Citizen.CreateThread(function()
    spawnFishingGearNPC()
    spawnBoatRentalNPC()
end)
