fx_version 'cerulean'  
game 'gta5'           

author 'Browner Development'
description 'Realistic Fishing System'
version '1.0.0'


shared_scripts {
    'config/config.lua',
    'locales/en.lua'  
}


client_scripts {
    'client/main.lua',
    'client/store_interactions.lua',
    'client/progression.lua'
}


server_scripts {
    'server/main.lua'
}

-- Required dependencies 
 dependency 'oxmysql'

-- Additional meta files if needed
files {
}


lua54 'yes'
