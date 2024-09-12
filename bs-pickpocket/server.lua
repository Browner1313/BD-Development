local QBCore = exports['qb-core']:GetCoreObject()

-- Event that handles giving an item when pickpocketing
RegisterNetEvent('bs-pickpocket:giveItem')
AddEventHandler('bs-pickpocket:giveItem', function(itemName)
    local src = source -- The player ID who triggered the event
    local xPlayer = QBCore.Functions.GetPlayer(src) -- Fetch the player object

    -- Check if the player has the required weapon (weapon_switchblade) to ensure they didn't bypass the client check
    local hasWeapon = false
    for _, item in pairs(xPlayer.PlayerData.items) do
        if item.name == 'weapon_switchblade' then
            hasWeapon = true
            break
        end
    end

    if hasWeapon then
        -- Validate if the player object exists and the itemName is valid
        if xPlayer and itemName then
            -- Convert itemName to lowercase to match how items are stored in QBCore
            local itemInfo = QBCore.Shared.Items[itemName:lower()]

            if itemInfo then
                -- Try adding the item to the player's inventory
                local success = xPlayer.Functions.AddItem(itemName, 1)
                if success then
                    -- Notify the player on successful item reception
                    TriggerClientEvent('QBCore:Notify', src, 'You successfully pickpocketed and received ' .. itemName .. '!', 'success')
                else
                    -- Notify the player if adding the item failed (inventory full or other reason)
                    TriggerClientEvent('QBCore:Notify', src, 'You couldn\'t pickpocket. Inventory full?', 'error')
                end
            else
                -- Notify if the item name is invalid in QBCore's shared items
                TriggerClientEvent('QBCore:Notify', src, 'Invalid item!', 'error')
                print("[bs-pickpocket] Invalid item: " .. itemName)
            end
        else
            -- Notify if something went wrong with the player or itemName
            print("[bs-pickpocket] Failed to fetch player or item.")
        end
    else
        -- Notify the player if they don't have the required weapon (this is an additional security check)
        TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the required weapon (Switchblade) to pickpocket!', 'error')
        print("[bs-pickpocket] Player without the required weapon tried to pickpocket.")
    end
end)
