local players = {}

RegisterNetEvent('bs-multicharacter:selectCharacter')
AddEventHandler('bs-multicharacter:selectCharacter', function(character)
    local source = source
    player[source] = character
    -- Loads the charater data from the database and set it for the player
end)

AddEventHandler('playerConnecting', function (name, setCallback, deferrals)
    local source = source

    local characters = getCharactersForPlayer(source)
    TriggerClientEvent('bs-multicharacter', source, characters)
end)

function getCharactersForPlayer(playerId)

    return {
        { id = 1, name = "Character One"},
        { id = 2, name = "Character Two"}
    }
end