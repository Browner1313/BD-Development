local QBCore = exports['qb-core']:GetCoreObject()

-- In server/main.lua
QBCore.Functions.CreateCallback('bd-fishing:getPlayerXP', function(source, cb)
  local playerId = source
  -- Retrieve XP from database
  local xp = 0  -- Placeholder for actual database retrieval logic
  cb(xp)
end)





