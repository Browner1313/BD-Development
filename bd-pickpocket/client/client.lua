local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = false
local lootedPeds = {} 


function DebugPrint(message)
    if Config.Debug then
        print("[DEBUG] " .. message)
    end
end

function PlayPickpocketEmote()
    local playerPed = PlayerPedId()
    local animDict = "anim@heists@prison_heiststation@heels"
    local animName = "pickup_bus_schedule"
    local animDuration = 5000  

    RequestAnimDict(animDict)
    DebugPrint("Requesting animation dictionary...")  

    local timeOut = 100  
    while not HasAnimDictLoaded(animDict) and timeOut > 0 do
        Wait(10)
        timeOut = timeOut - 1
    end

    if HasAnimDictLoaded(animDict) then
        DebugPrint("Animation dictionary loaded, playing animation...")  
        TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, animDuration, 1, 0, false, false, false)
    else
        DebugPrint("Failed to load animation dictionary: " .. animDict)
    end
end

function InteractWithPed(ped)
    DebugPrint("Attempting to interact with a ped...")

    
    local pedModel = GetEntityModel(ped)
    for _, blacklistedModel in ipairs(Config.BlacklistedPeds) do
        if pedModel == GetHashKey(blacklistedModel) then
            DebugPrint("Attempted to pickpocket a blacklisted ped: " .. blacklistedModel)
            return 
        end
    end

    
    if lootedPeds[ped] then
        QBCore.Functions.Notify(Config.Messages.Looted, "error")
        return
    end

    
    if IsPedDeadOrDying(ped, true) then
        QBCore.Functions.Notify(Config.Messages.NotAble, "error")
        return
    end

    
    if IsPedRagdoll(ped) then
        QBCore.Functions.Notify(Config.Messages.NotAble, "error")
        return
    end

    
    if not IsPedStill(ped) then
        QBCore.Functions.Notify(Config.Messages.Moving, "error")
        return
    end

    
    DebugPrint("Starting pickpocket animation while progress bar is active...")
    PlayPickpocketEmote()  

    QBCore.Functions.Progressbar("pickpocket", "Pickpocketing...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        
        DebugPrint("Progressbar completed, processing the result...")

       
        if IsFatPed(ped) then
            local randomFoodItem = GetRandomFatPedItem()
            TriggerServerEvent('bs-pickpocket:giveItem', randomFoodItem)  
            QBCore.Functions.Notify(Config.Messages.Lunch, "success")
        else
            
            TriggerServerEvent('bs-pickpocket:giveItem', nil) 
        end

        
        lootedPeds[ped] = true
        cooldown = true
        Citizen.SetTimeout(10000, function() cooldown = false end)

       
        MakePedFlee(ped)

        
        CheckForPoliceAndAlert()

        DebugPrint("Interaction with ped complete")

        
        ClearPedTasks(PlayerPedId())
    end, function()
        
        QBCore.Functions.Notify(Config.Messages.Cancelled, "error")

       
        ClearPedTasks(PlayerPedId())
    end)
end


function MakePedFlee(ped)
    DebugPrint("Making ped flee...")
    local playerPed = PlayerPedId()
    TaskSmartFleePed(ped, playerPed, 100.0, -1, false, false) 
end


function IsFatPed(ped)
    local pedModel = GetEntityModel(ped)
    for _, model in ipairs(Config.FatPeds) do
        if pedModel == GetHashKey(model) then
            DebugPrint("Detected a fat ped")
            return true
        end
    end
    return false
end

function GetRandomFatPedItem()
    local randomIndex = math.random(#Config.FatPedItems)
    return Config.FatPedItems[randomIndex]
end

-- Function to enumerate all peds
function EnumeratePeds()
    local peds = {}
    local pedHandle, ped = FindFirstPed()
    local found = true

    while found do
        if ped ~= PlayerPedId() and DoesEntityExist(ped) and not IsPedAPlayer(ped) then
            table.insert(peds, ped)
        end
        found, ped = FindNextPed(pedHandle)
    end

    EndFindPed(pedHandle)
    return peds
end

-- Adding interaction targets to peds
function AddTargetToPeds()
    local peds = EnumeratePeds()
    for _, ped in pairs(peds) do
        if IsPedHuman(ped) and IsPedStill(ped) and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped)) < 2.0 then
            local pedModel = GetEntityModel(ped)
            local isBlacklisted = false
            for _, blacklistedModel in ipairs(Config.BlacklistedPeds) do
                if pedModel == GetHashKey(blacklistedModel) then
                    isBlacklisted = true
                    break
                end
            end

            
            if not isBlacklisted and not lootedPeds[ped] then
                exports.ox_target:addEntity(ped, {
                    {
                        name = "pickpocket_ped",  
                        icon = "fas fa-hand-paper",
                        label = "Pickpocket",
                        canInteract = function(entity)
                            return not cooldown
                        end,
                        onSelect = function()
                            if not cooldown then
                                InteractWithPed(ped)
                            else
                                QBCore.Functions.Notify(Config.Messages.Break, "error")
                            end
                        end
                    }
                })
            end
        end
    end
end


CreateThread(function()
    while true do
        AddTargetToPeds()
        Wait(5000) 
    end
end)
