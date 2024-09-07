local characters = {}
local selectedCharacter = nil

RegisterNetEvent('bs-multicharacter:openMenu')
AddEventHandler('bs-multicharacter:openMenu', function(chars)
    characters = chars
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'openMenu',
        characters = characters
    })
end)

RegisterNUICallback('selectedCharacter', function (data, cb)
    selectedCharacter = data.character
    SetNuiFocus(false, false)
    TriggerServerEvent('bs-multicharacter:selectCharacter', selectedCharacter)
    cb('ok')
end)