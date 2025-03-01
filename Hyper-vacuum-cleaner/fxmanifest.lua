fx_version("cerulean")
games { "gta5" }

author "Hyper"
version "0.0.1"

client_script {
    "back-end/client-side.lua"
}

server_script {
    "back-end/server-side.lua"
}

shared_script {
    "@es_extended/imports.lua",
    "config.lua"
}