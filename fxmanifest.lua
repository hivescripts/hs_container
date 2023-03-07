fx_version 'cerulean'
game 'gta5'

author 'HiveScripts'
description 'Contaíner script for FiveM'
version '1.0.0'

ui_page 'web/dist/index.html'
files {
    'web/dist/**/*',
}

shared_scripts {
    'locale/ignore.lua',
    'locale/en.lua',
    'locale/de.lua',
    'locale/locale.lua'
}

client_scripts {
    'config/cl_config.lua',
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/cl_config.lua',
    'config/sv_config.lua',
    'server/utils.lua',
    'server/*.lua'
}

server_exports {
    'generateKey'
}

depencencies {
    'oxmysql'
}