local QBCore = exports['qb-core']:GetCoreObject()

-- Define the possible rewards and their probabilities for non-fat peds
local rewards = {
    {item = 'money', amount = 5,  probability = 10}, 
    {item = 'money', amount = 10, probability = 10}, 
    {item = 'money', amount = 15, probability = 10}, 
    {item = 'money', amount = 20, probability = 10}, 
    {item = 'money', amount = 25, probability = 10}, 
    {item = 'money', amount = 30, probability = 10},
    {item = 'money', amount = 35, probability = 10},
    {item = 'money', amount = 40, probability = 10},
    {item = 'weed_skunk_joint', amount = 1, probability = 15},
    {item = 'gold_watch',        amount = 1, probability = 5}
}

-- Function to get a random reward based on probabilities for non-fat peds
local function getRandomReward()
    local randomNumber = math.random(100)
    local cumulativeProbability = 0

    for _, reward in ipairs(rewards) do
        cumulativeProbability = cumulativeProbability + reward.probability
        if randomNumber <= cumulativeProbability then
            return reward
        end
    end

    return nil -- Default case, should never reach here if probabilities sum to 100
end

-- Event that handles giving an item when pickpocketing
RegisterNetEvent('bs-pickpocket:giveItem')
AddEventHandler('bs-pickpocket:giveItem', function(item)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer then
        -- If a specific item is provided (for fat peds)
        if item then
            local itemInfo = QBCore.Shared.Items[item:lower()]
            if itemInfo then
                local success = xPlayer.Functions.AddItem(item, 1)
                if success then
                    TriggerClientEvent('QBCore:Notify', src, 'You have successfully pickpocketed and got ' .. item .. '!', 'success')
                else
                    TriggerClientEvent('QBCore:Notify', src, 'You couldn\'t pickpocket. Inventory full?', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'Invalid item!', 'error')
                print("[bs-pickpocket] Invalid item: " .. item)
            end
        else
            -- If no item is specified, it's a non-fat ped, and give random reward
            local reward = getRandomReward()

            if reward then
                if reward.item == 'money' then
                    xPlayer.Functions.AddMoney('cash', reward.amount)
                    TriggerClientEvent('QBCore:Notify', src, 'You have successfully pickpocketed someone and got $' .. reward.amount .. '!', 'success')
                else
                    local itemInfo = QBCore.Shared.Items[reward.item:lower()]
                    if itemInfo then
                        local success = xPlayer.Functions.AddItem(reward.item, reward.amount)
                        if success then
                            TriggerClientEvent('QBCore:Notify', src, 'You have successfully pickpocketed someone and got a ' .. reward.item .. '!', 'success')
                        else
                            TriggerClientEvent('QBCore:Notify', src, 'You couldn\'t pickpocket. Inventory full?', 'error')
                        end
                    else
                        TriggerClientEvent('QBCore:Notify', src, 'Invalid item!', 'error')
                        print("[bs-pickpocket] Invalid item: " .. reward.item)
                    end
                end
            else
                print("[bs-pickpocket] No reward could be determined.")
            end
        end
    else
        print("[bs-pickpocket] Failed to fetch player.")
    end
end)
