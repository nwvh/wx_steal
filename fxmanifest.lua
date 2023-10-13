fx_version 'cerulean'
game 'gta5'
version '1.0.0'
author 'wx / woox'
description 'Simple player target option to search the player'
lua54 'yes'
client_scripts {
    'client/*.lua',
}
server_script 'server/server.lua'
shared_scripts {
    '@ox_lib/init.lua',
    'configs/*.lua'
}
