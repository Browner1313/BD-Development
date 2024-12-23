local QBCore = exports['qb-core']:GetCoreObject()

-- Debug function
function DebugPrint(message)
    if Config.Debug then
        print("[DEBUG] " .. message)
    end
end

-- Function to get a random reward based on probabilities for non-fat peds
function getRandomReward()
    local randomNumber = math.random(100)
    local cumulativeProbability = 0

    for _, reward in ipairs(Config.Rewards) do
        cumulativeProbability = cumulativeProbability + reward.probability
        if randomNumber <= cumulativeProbability then
            DebugPrint("Reward selected: " .. reward.item .. " x" .. reward.amount)
            return reward
        end
    end

    DebugPrint("No reward determined - check probability settings.")
    return nil
end

-- Event that handles giving an item when pickpocketing
RegisterNetEvent('bs-pickpocket:giveItem')
AddEventHandler('bs-pickpocket:giveItem', function(item)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer then
        if item then
            local itemInfo = QBCore.Shared.Items[item:lower()]
            if itemInfo then
                local success = xPlayer.Functions.AddItem(item, 1)
                if success then
                    TriggerClientEvent('QBCore:Notify', src, 'You have successfully pickpocketed and got ' .. item .. '!', 'success')
                    DebugPrint("Item given: " .. item)
                else
                    TriggerClientEvent('QBCore:Notify', src, 'You couldn\'t pickpocket. Inventory full?', 'error')
                    DebugPrint("Failed to add item - Inventory full: " .. item)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'Invalid item!', 'error')
                DebugPrint("Invalid item: " .. item)
            end
        else
            local reward = getRandomReward()

            if reward then
                if reward.item == 'money' then
                    xPlayer.Functions.AddMoney('cash', reward.amount)
                    TriggerClientEvent('QBCore:Notify', src, 'You have successfully pickpocketed someone and got $' .. reward.amount .. '!', 'success')
                    DebugPrint("Money given: $" .. reward.amount)
                else
                    local itemInfo = QBCore.Shared.Items[reward.item:lower()]
                    if itemInfo then
                        local success = xPlayer.Functions.AddItem(reward.item, reward.amount)
                        if success then
                            TriggerClientEvent('QBCore:Notify', src, 'You have successfully pickpocketed someone and got a ' .. reward.item .. '!', 'success')
                            DebugPrint("Item given: " .. reward.item)
                        else
                            TriggerClientEvent('QBCore:Notify', src, 'You couldn\'t pickpocket. Inventory full?', 'error')
                            DebugPrint("Failed to add item - Inventory full: " .. reward.item)
                        end
                    else
                        TriggerClientEvent('QBCore:Notify', src, 'Invalid item!', 'error')
                        DebugPrint("Invalid item: " .. reward.item)
                    end
                end
            else
                DebugPrint("No reward could be determined.")
            end
        end
    else
        DebugPrint("Failed to fetch player.")
    end
end)
