local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = false
local lootedPeds = {} -- Table to keep track of looted peds

-- Function to handle debug prints
function DebugPrint(message)
    if Config.Debug then
        print("[DEBUG] " .. message)
    end
end

function PlayPickpocketEmote()
    local playerPed = PlayerPedId()
    local animDict = "anim@heists@prison_heiststation@heels"
    local animName = "pickup_bus_schedule"
    local animDuration = 5000  -- Duration in milliseconds

    RequestAnimDict(animDict)
    DebugPrint("Requesting animation dictionary...")  -- Debug

    local timeOut = 100  -- Increased timeout for slower systems
    while not HasAnimDictLoaded(animDict) and timeOut > 0 do
        Wait(10)
        timeOut = timeOut - 1
    end

    if HasAnimDictLoaded(animDict) then
        DebugPrint("Animation dictionary loaded, playing animation...")  -- Debug
        TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, animDuration, 1, 0, false, false, false)
    else
        DebugPrint("Failed to load animation dictionary: " .. animDict)
    end
end

function InteractWithPed(ped)
    DebugPrint("Attempting to interact with a ped...")

    -- Check if the ped's model is blacklisted
    local pedModel = GetEntityModel(ped)
    for _, blacklistedModel in ipairs(Config.BlacklistedPeds) do
        if pedModel == GetHashKey(blacklistedModel) then
            DebugPrint("Attempted to pickpocket a blacklisted ped: " .. blacklistedModel)
            return -- Do nothing if the ped is blacklisted
        end
    end

    -- Check if the ped has already been looted
    if lootedPeds[ped] then
        QBCore.Functions.Notify(Config.Messages.Looted, "error")
        return
    end

    -- Check if the ped is dead
    if IsPedDeadOrDying(ped, true) then
        QBCore.Functions.Notify(Config.Messages.NotAble, "error")
        return
    end

    -- Check if the ped is on the ground (ragdoll state)
    if IsPedRagdoll(ped) then
        QBCore.Functions.Notify(Config.Messages.NotAble, "error")
        return
    end

    -- Check if the ped is still (not moving)
    if not IsPedStill(ped) then
        QBCore.Functions.Notify(Config.Messages.Moving, "error")
        return
    end

    -- Start the animation here before the progress bar begins
    DebugPrint("Starting pickpocket animation while progress bar is active...")
    PlayPickpocketEmote()  -- Play the animation

    QBCore.Functions.Progressbar("pickpocket", "Pickpocketing...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        -- Progress bar completion callback
        DebugPrint("Progressbar completed, processing the result...")

        -- Give item based on ped type
        if IsFatPed(ped) then
            local randomFoodItem = GetRandomFatPedItem()
            TriggerServerEvent('bs-pickpocket:giveItem', randomFoodItem)  -- Send the item to the server
            QBCore.Functions.Notify(Config.Messages.Lunch, "success")
        else
            -- Trigger the event with no item to get a random reward
            TriggerServerEvent('bs-pickpocket:giveItem', nil)  -- nil indicates random reward
        end

        -- Mark the ped as looted
        lootedPeds[ped] = true
        cooldown = true
        Citizen.SetTimeout(10000, function() cooldown = false end)

        -- Make the ped run away after being pickpocketed
        MakePedFlee(ped)

        -- Trigger a police alert after the ped flees
        CheckForPoliceAndAlert()

        DebugPrint("Interaction with ped complete")

        -- Clear animation after the progress is done
        ClearPedTasks(PlayerPedId())
    end, function()
        -- Progress bar cancel callback
        QBCore.Functions.Notify(Config.Messages.Cancelled, "error")

        -- Clear animation when progress bar is canceled
        ClearPedTasks(PlayerPedId())
    end)
end

-- Function to make the ped run away after being pickpocketed
function MakePedFlee(ped)
    DebugPrint("Making ped flee...")
    local playerPed = PlayerPedId()
    TaskSmartFleePed(ped, playerPed, 100.0, -1, false, false) -- 100.0 is the distance, -1 is the duration (indefinitely)
end

-- Checking if a ped is a "fat" ped
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

-- Get a random item for "fat" peds
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
            -- Check if the ped's model is blacklisted
            local pedModel = GetEntityModel(ped)
            local isBlacklisted = false
            for _, blacklistedModel in ipairs(Config.BlacklistedPeds) do
                if pedModel == GetHashKey(blacklistedModel) then
                    isBlacklisted = true
                    break
                end
            end

            -- Only add interaction if the ped is not blacklisted and hasn't been looted
            if not isBlacklisted and not lootedPeds[ped] then
                -- Add ox_target interaction
                exports.ox_target:addEntity(ped, {
                    {
                        name = "pickpocket_ped",  -- Give a unique name to the interaction
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

-- Thread to continuously add interaction targets to peds
CreateThread(function()
    while true do
        AddTargetToPeds()
        Wait(5000) -- Adjust or configure the delay as needed
    end
end)
