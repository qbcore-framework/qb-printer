fx_version 'bodacious'
game 'gta5'
author 'QBCore Framework Community'

description 'QB-Printer'
version '1.0.1'

ui_page "html/index.html"

shared_scripts {
    '@qb-core/import.lua',
    'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    '*.lua',
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/*.png',
}