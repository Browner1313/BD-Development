local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateCallback('bd-fishing:getPlayerXP', function(source, cb)
  local playerId = source
  
  local xp = 0  
  cb(xp)
end)





