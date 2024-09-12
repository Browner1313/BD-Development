fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'

-- Define dependencies
dependencies {
  'qs-inventory',
  'ox_lib',
}

-- Define client and server scripts
client_script {
  'client/*.lua',
}

server_script {
  'server/*.lua',
}

-- Shared scripts
shared_scripts {
  'config/*.lua',
}

-- Ignore files for escrow
escrow_ignore {
  'config/*.lua',
  'client/*.lua',
  'server/*.lua',
}
