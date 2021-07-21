RegisterNetEvent('qb-printer:client:UseDocument')
AddEventHandler('qb-printer:client:UseDocument', function(ItemData)
    local ped = PlayerPedId()
    local DocumentUrl = ItemData.info.url ~= nil and ItemData.info.url or false
    SendNUIMessage({
        action = "open",
        url = DocumentUrl
    })
    SetNuiFocus(true, false)
end)

RegisterNetEvent('qb-printer:client:SpawnPrinter')
AddEventHandler('qb-printer:client:SpawnPrinter', function(ItemData)
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = GetHashKey('prop_printer_01')
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    obj = CreateObject(model, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(obj)
    SetModelAsNoLongerNeeded(model)
    SetEntityAsMissionEntity(obj)
end)

RegisterNUICallback('SaveDocument', function(data)
    if data.url ~= nil then
        TriggerServerEvent('qb-printer:server:SaveDocument', data.url)
    end
end)

RegisterNUICallback('CloseDocument', function()
    SetNuiFocus(false, false)
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        local PrinterObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.5, GetHashKey('prop_printer_01'), false, false, false)

        if PrinterObject ~= 0 then
            local PrinterCoords = GetEntityCoords(PrinterObject)
            DrawText3Ds(PrinterCoords.x, PrinterCoords.y, PrinterCoords.z, Config.Text)
            if IsControlJustPressed(0, Config.Key) then
                SendNUIMessage({
                    action = "start"
                })
                SetNuiFocus(true, true)
            end
        else
            Citizen.Wait(1000)
        end

        Citizen.Wait(3)
    end
end)