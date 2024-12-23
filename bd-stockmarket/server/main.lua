local stockPrices = {}

Citizen.CreateThread(function ()
    for _, company in ipairs(Config.Companies) do
        stockPrices[company.abbreviation] = {
            name = company.name,
            sector = company.sector,
            price = company.basePrice,
            volatility = company.volatility
        }
    end

    while true do 
        for abbreviation, stock in pairs(stockPrices) do
            local change = math.random(-5, 5) * stock.volatility
            stock.price = math.max(1, stock.price + change)
        end 
        TriggerClientEvent('stockmarket:updatePrices', -1 , stockprices)
        Citizen.Wait(60000)
    end
end)

RegisterNetEvent('stockmarket:getPrices')
AddEventHandler('stockmarket:getPrices', function()
    local _source = source
    TriggerClientEvent('stockmarket:receivePrices', _source, stockPrices)
end)
