Config = {}
Config.PrinterModels = {
    {model = 'prop_printer_02'},
    {model = 'prop_printer_01'},
    {model = 'v_res_printer'},
}

-- Events
RegisterNetEvent('qb-printer:client:UseDocument', function(ItemData)
    local DocumentUrl = ItemData.info.url ~= nil and ItemData.info.url or false
    SendNUIMessage({
        action = "open",
        url = DocumentUrl
    })
    SetNuiFocus(true, false)
end)

RegisterNetEvent('qb-printer:client:SpawnPrinter', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = `prop_printer_01`
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    local obj = CreateObject(model, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(obj)
    SetModelAsNoLongerNeeded(model)
    SetEntityAsMissionEntity(obj)
end)

RegisterNetEvent("qb-printer:use")
AddEventHandler('qb-printer:use', function()
    SendNUIMessage({
        action = "start"
    })
    SetNuiFocus(true, true)
end)

-- Threads
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        for k, v in pairs(Config.PrinterModels) do
            local PrinterObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.5, GetHashKey(v.model), false, false, false)
            if PrinterObject ~= 0 then
                local PrinterCoords = GetEntityCoords(PrinterObject)
                exports['qb-target']:AddBoxZone("Printer", PrinterCoords, 0.4, 0.4, { name="Printer", heading = 0, debugPoly=false, minZ=PrinterCoords.z, maxZ=PrinterCoords.z+0.4 }, 
                    { options = { { event = "qb-printer:use", icon = "fas fa-cash-register", label = "Printer" }, },
                    distance = 3.0
                })
            else
                Wait(1000)
            end
        end
        Wait(3)
    end
end)

-- NUI

RegisterNUICallback('SaveDocument', function(data, cb)
    if data.url then
        TriggerServerEvent('qb-printer:server:SaveDocument', data.url)
    end
    cb('ok')
end)

RegisterNUICallback('CloseDocument', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Command
RegisterCommand('useprinter', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local PrinterObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.5, `prop_printer_01`, false, false, false)
    if PrinterObject ~= 0 then
        SendNUIMessage({
            action = "start"
        })
        SetNuiFocus(true, true)
    end
end)