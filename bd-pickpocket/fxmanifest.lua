fx_version 'cerulean'
game 'gta5'

author 'Browner Development'
description 'Petty Crime script'
version '1.0.0'

shared_script 'config.lua' -- This makes the Config available to all other scripts
client_scripts {
    'client/client.lua',
}
server_script 'server/server.lua'
