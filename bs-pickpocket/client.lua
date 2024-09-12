local QBCore = exports['qb-core']:GetCoreObject()

-- Function to check if the player has the required weapon
local function HasRequiredWeapon()
    local playerPed = PlayerPedId()

    -- Check if the player has the specific weapon (weapon_switchblade)
    return HasPedGotWeapon(playerPed, GetHashKey('weapon_switchblade'), false)
end

-- Function to position and freeze the ped in front of the player, facing away
local function PositionAndFreezePed(ped)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local forwardVector = GetEntityForwardVector(playerPed)
    local pedPosition = playerCoords + forwardVector * 1.0 -- Position the ped 1 meter in front of the player

    -- Set the ped's position directly in front of the player
    SetEntityCoords(ped, pedPosition.x, pedPosition.y, pedPosition.z, false, false, false, true)

    -- Ensure the ped is facing the opposite direction from the player
    local playerHeading = GetEntityHeading(playerPed)
    local oppositeHeading = (playerHeading + 180.0) % 360.0 -- Opposite direction of the player
    SetEntityHeading(ped, oppositeHeading)

    -- Freeze the ped
    TaskStandStill(ped, 5000) -- Freezes the ped for 5 seconds
end

-- Function to play the mechanic emote for the player
local function PlayPickpocketEmote()
    local playerPed = PlayerPedId()
    local animDict = "mini@repair" -- Animation dictionary
    local animName = "fixing_a_player" -- Animation name

    -- Load the animation dictionary
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(10)
    end

    -- Play the emote
    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, 5000, 1, 0, false, false, false)

    -- Wait for the emote to finish
    Citizen.Wait(5000)

    -- Clear the animation after the duration
    ClearPedTasks(playerPed)
end

-- Function to handle interaction with ped
local function InteractWithPed(ped)
    print("Attempting to interact with ped: ", ped)

    -- Position and freeze the ped in front of the player, facing away
    PositionAndFreezePed(ped)

    -- Play the pickpocket emote for 5 seconds
    PlayPickpocketEmote()

    -- After the emote is done, trigger the server event to give the item
    TriggerServerEvent('bs-pickpocket:giveItem', 'item_name_here') -- Replace 'item_name_here' with the actual item
    Notify("You have interacted with the ped and received an item.", "success")
end

-- Notify function
local function Notify(text, type)
    QBCore.Functions.Notify(text, type)
end

-- Function to enumerate all peds
function EnumeratePeds()
    local peds = {}
    local pedHandle, ped = FindFirstPed()
    local found = true

    while found do
        if ped ~= PlayerPedId() and DoesEntityExist(ped) and not IsPedAPlayer(ped) then
            table.insert(peds, ped)
            print("Ped found: ", ped) -- Print each ped found
        end
        found, ped = FindNextPed(pedHandle)
    end

    EndFindPed(pedHandle)
    print("Total peds enumerated: ", #peds)
    return peds
end

-- Function to add qb-target on peds if player has the required weapon
local function AddTargetToPeds()
    local peds = EnumeratePeds()

    for _, ped in pairs(peds) do
        if IsPedHuman(ped) then
            -- Check if the player has the required weapon (weapon_switchblade)
            if HasRequiredWeapon() then
                -- Add qb-target options to the ped
                exports['qb-target']:AddTargetEntity(ped, {
                    options = {
                        {
                            type = "client",
                            event = "test:interact",
                            icon = "fas fa-hand-paper",
                            label = "Pickpocket",  -- Set label to "Pickpocket"
                            action = function()
                                InteractWithPed(ped)
                            end
                        }
                    },
                    distance = 2.0  -- Set interaction distance to 2 meters
                })
                print("Added qb-target to ped: ", ped)
            else
                print("Player does not have the required weapon (weapon_switchblade). Skipping third eye option.")
            end
        end
    end
end

-- Setup qb-target for peds when resource starts
Citizen.CreateThread(function()
    Citizen.Wait(1000) -- Delay to ensure all resources are loaded

    while true do
        AddTargetToPeds()  -- Call function to add target to peds if player has the weapon
        Citizen.Wait(5000) -- Check every 5 seconds to add targets to new peds
    end
end)

-- Register event for interaction
RegisterNetEvent('test:interact')
AddEventHandler('test:interact', function()
    QBCore.Functions.Notify("Test interaction triggered!", "success")
end)
