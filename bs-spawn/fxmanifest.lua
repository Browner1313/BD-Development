fx_version 'cerulean'
game 'gta5'

name 'spawn-selector'
description 'A resource to select spawn locations'
author 'Your Name'
version '1.0.0'

client_scripts {
  'client/main.lua'
}

server_scripts {
  'server/main.lua'
}

ui_page 'html/index.html'

files {
  'web/index.html',
  'web/style.css',
  'web/script.js',
  'web/spawnmenu.png' -- Replace with your actual image file path
}
