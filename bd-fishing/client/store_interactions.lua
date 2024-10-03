RegisterNetEvent('bd-fishing:openStore')
AddEventHandler('bd-fishing:openStore', function()
    TriggerServerEvent('bd-fishing:openFishingGearShop')
end)

