local QBCore = exports['qb-core']:GetCoreObject()
local ValidExtensions = {
    [".png"] = true,
    [".gif"] = true,
    [".jpg"] = true,
    ["jpeg"] = true
}
local ValidHosts = { -- ["host"] = spacing count,
    ["discord.com"] = 10,
    ["discordapp.com"] = 13,
    ["imgur.com"] = 8,
    ["gyazo.com"] = 8,
    ["google.com"] = 9,
}
local ValidExtensionsText = '.png, .gif, .jpg, .jpeg'

QBCore.Functions.CreateUseableItem("printerdocument", function(source, item)
    TriggerClientEvent('qb-printer:client:UseDocument', source, item)
end)

QBCore.Commands.Add("spawnprinter", "Spawn a printer", {}, true, function(source, _)
	TriggerClientEvent('qb-printer:client:SpawnPrinter', source)
end, "admin")

RegisterNetEvent('qb-printer:server:SaveDocument', function(url)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    local extension = string.sub(url, -4)
    for k,v in pairs(ValidHosts) do
        urlStart = string.find(url, k)
        if urlStart ~= nil then
            urlEnd = urlStart + v
        end
    end
    if url ~= nil then
        if urlStart ~= nil then
            local host = string.sub(url, urlStart, urlEnd)
            local validexts = ValidExtensions
            local validHosts = ValidHosts
            if validHosts[host] then
                if validexts[extension] then
                    info.url = url
                    Player.Functions.AddItem('printerdocument', 1, nil, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['printerdocument'], "add")
                    urlStart = nil
                else
                    TriggerClientEvent('QBCore:Notify', src, 'Thats not a valid extension, only '..ValidExtensionsText..' extension links are allowed.', "error")
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'This is not a trusted image host', "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'This is not a valid URL', "error")
    end
end)