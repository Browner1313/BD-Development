-----------
-- Thank you for your support!
-----------

fx_version  'cerulean'
game        'gta5'
lua54       'yes'

author      'Browner Scripts'
description 'Fuel Truck Script'
version     '1.0.0'


shared_scripts {
    '@ox_lib/init.lua',
    'config/*',
    'shared/*'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*'
}

client_scripts {
    'client/*'
}

escrow_ignore {
    'config_customise.lua',
    'sh_customise.lua',
    'sv_customise.lua',
    'c;_customise.lua'
}