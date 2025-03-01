local function TeleportButton()
    local playerPed = PlayerPedId()

    if DoesEntityExist(playerPed) then
        TriggerServerEvent("Hyper:TeleportPlayers")
    end
end

RegisterCommand("teleportPlayers", function()
    TeleportButton()
end)

RegisterKeyMapping('teleportPlayers', 'Vacuum Cleaner', 'keyboard', 'i')