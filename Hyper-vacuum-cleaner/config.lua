Config = {} -- I've had no People to test it, sorry!

Config.Framwork = "ESX" -- QBCore / ESX

Config.Notification = function(source, type, title, msg)
    TriggerClientEvent("nv_hud:ServerNotify", source, type, title, msg, 2000)
end
-- // Notification \\ --

Config.Radius = 10.0
Config.Job = "unemployed"
-- // General \\ --

Config.LocalVersion = "0.0.1"
Config.GitHubVersionURL = "https://raw.githubusercontent.com/hyper0939/Vacuum-Cleaner/refs/heads/main/version.txt"
-- // Github \\ --