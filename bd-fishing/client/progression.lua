RegisterNetEvent('bd-bd-fishing:checkBoatProgression')
AddEventHandler('bd-fishing:checkBoatProgression', function()
    -- Request the player's XP from the server
    TriggerServerEvent('bd-fishing:getPlayerXP')
end)

RegisterNetEvent('bd-fishing:sendPlayerXP')
AddEventHandler('bd-fishing:sendPlayerXP', function(playerXP)
    local requiredXP = Config.BoatRentalNPC.requiredXP

    if playerXP >= requiredXP then
        -- Trigger server-side event to open the boat rental shop
        TriggerServerEvent('bd-fishing:openBoatRentalShop')
    else
        -- Notify the player they don't have enough XP
        TriggerEvent('QBCore:Notify', "You can't talk to him until you're a real angler.", 'error')
    end
end)
