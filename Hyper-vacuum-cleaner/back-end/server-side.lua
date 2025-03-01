local QBCore, ESX = nil, nil

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if Config.Framwork == "QBCore" then
            QBCore = exports["qb-core"]:GetCoreObject()
            Wait(10)
            print("QBCore Found!")
        elseif Config.Framwork == "ESX" then
            while ESX == nil do
                ESX = exports["es_extended"]:getSharedObject()
                Wait(10)
                print("ESX Found!")
            end
        end
    end
end)

local function GetPlayerData(playerId)
    if Config.Framwork == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player then
            return {
                source = playerId,
                job = Player.PlayerData.job.name,
                getJob = function() return {name = Player.PlayerData.job.name} end
            }
        elseif Config.Framwork == "ESX" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer then
                return xPlayer
            end
        end
    end
    return nil
end

local function GetAllPlayers()
    if Config.Framwork == "QBCore" then
        return QBCore.Functions.GetPlayers()
    elseif Config.Framwork == "ESX" then
        return ESX.GetPlayers()
    end
    return {}
end

-- Main Code
RegisterNetEvent("Hyper:TeleportPlayers")
AddEventHandler("Hyper:TeleportPlayers", function()
    local source = source
    local xPlayer = GetPlayerData(source)

    if xPlayer and xPlayer.getJob().name == Config.Job then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        local players = GetAllPlayers()
        local teleportedCount = 0

        for _, playerId in ipairs(players) do
            playerId = tonumber(playerId)
            if tonumber(playerId) ~= tonumber(source) then
                local targetPed = GetPlayerPed(playerId)
                local targetCoords = GetEntityCoords(targetPed)
                local distance = #(playerCoords - targetCoords)

                if distance <= Config.Radius then
                    SetEntityCoords(targetPed, playerCoords.x, playerCoords.y, playerCoords.z)
                    teleportedCount = teleportedCount + 1
                    Config.Notification(playerId, "Info", "Teleportiert", "Du wurdest teleportiert!")
                end
            end
        end
        
        if teleportedCount > 0 then
            Config.Notification(source, "Success", "Teleport", teleportedCount .. " Spieler wurden zu dir Teleportiert.")
        else
            Config.Notification(source, "Error", "Teleport", "Keine Spieler in der Nähe gefunden!")
        end
    else
        Config.Notification(source, "Info", "Teleport", "Du hast nicht die Berechtigung dafür!")
    end
end)
-- Main Code

local function CheckForUpdates()
    PerformHttpRequest(Config.GitHubVersionURL, function(statusCode, response, headers)
        if statusCode == 200 then
            local githubVersion = response:match("^%s*(.-)%s*$")

            if githubVersion and githubVersion ~= Config.LocalVersion then
                print("^3[Update-Checker]^0 There is a new version: ^2" .. githubVersion .. "^0 (current: ^1" .. Config.LocalVersion .. "^0)")
                print("^3[Update-Checker]^0 Download the new version from GitHub: https://github.com/hyper0939/Vacuum-Cleaner/tree/main")
            else
                print("^3[Update-Checker]^0 The script is up to date (Version: ^2" .. Config.LocalVersion .. "^0)")
            end
        else
            print("^1[Update-Checker]^0 Failed to get GitHub version. Status code: " .. statusCode)
        end
    end, "GET")
end

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CheckForUpdates()
    end
end)
-- Github Checker