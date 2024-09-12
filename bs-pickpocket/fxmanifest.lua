fx_version 'cerulean'
game 'gta5'

author 'BS Scripts'
description 'Petty Crime script'
version '1.0.0'

-- List of server scripts
server_scripts {
  'server.lua',
  'config.lua'
}

-- List of client scripts
client_scripts {
  'client.lua',
  'config.lua'
}

-- Dependencies
dependencies {
  'qb-core',
  'qb-target',
  'qs-inventory'
}
