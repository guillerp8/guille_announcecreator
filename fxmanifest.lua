fx_version "cerulean"

game "gta5"

version "1.0.0"

author "guillerp#1928"

description "https://discord.gg/eBpmkW6e5j"

client_scripts {
    "config.lua",
    "client/client.lua",
}

ui_page "ui/index.html"

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "config.lua",
    "webhook.lua",
    "server/server.lua",
}

files {
    "ui/index.html",
    "ui/script.js",
    "ui/style.css",
    "ui/srcs/*.png",
    "ui/srcs/*.otf",
    "ui/srcs/*.ttf",
}