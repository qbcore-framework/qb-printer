QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

-- Code

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
    SetNuiFocus(true, true)
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        local PrinterObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 50.0, GetHashKey("v_med_cor_photocopy"), false, false, false)

        if PrinterObject ~= 0 then
            local PrinterCoords = GetEntityCoords(PrinterObject)
            DrawText3Ds(PrinterCoords.x, PrinterCoords.y, PrinterCoords.z, '~g~E~w~ - To Use Printer')
            if IsControlJustPressed(0, 38) then
                SendNUIMessage({
                    action = "start"
                })
            end
        else
            Citizen.Wait(1000)
        end

        Citizen.Wait(3)
    end
end)