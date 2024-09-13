local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = false
local lootedPeds = {}

local function HasRequiredItems()
  local playerPed = PlayerPedId()

  return HasPedGotWeapon(playerPed, GetHashKey('weapon_switchblade'), false)
end
