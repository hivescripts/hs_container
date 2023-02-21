math.randomseed(os.time())

local ESX
if ServerConfig.ESXType then
    ESX = exports['es_extended']:getSharedObject()
else
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

local Keys = {}

CreateThread(function()
    for _, row in pairs(MySQL.query.await('SELECT * FROM container_keys')) do
        Keys[row.id] = row.key
    end
end)

RegisterCommand('keygen', function(source, args)
    if source ~= 0 then return end -- only allow console

    local count = tonumber(args[1] or 1)
    CreateThread(function()
        local keys = {}
        for i = 1, count do
            table.insert(keys, generateKey())
        end
        KeyGenLog(keys)
    end)
end)

local AllowedForWin = {}

RegisterNetEvent('hs_container:requestKey', function(key)
    local Ped = GetPlayerPed(source)
    local Pos = GetEntityCoords(Ped)
    local _source = source

    local Near = false
    for _, Location in pairs(Config.Locations) do
        local Distance = #(Pos - Location)
        if Distance < 5.0 then
            Near = true
            break
        end
    end

    if not Near then
        LogCheater(_source, 'hs_container:requestKey')
        DropPlayer(_source, ServerConfig.Strings.cheatMessage)
    end

    local index = -1
    for id, k in pairs(Keys) do
        if k == key then
            index = id
            break
        end
    end

    TriggerClientEvent('hs_container:keyResponse', _source, index ~= -1)

    if index ~= -1 then
        MySQL.execute.await('DELETE FROM container_keys WHERE id = ?', {
            index
        })
        Keys[index] = nil
        AllowedForWin[_source] = true
        LogKeyUse(_source, key)
    end
end)

function generateKey()
    local key
    while true do
        key = generateSequence()
        if not table.contains(Keys, key) then
            break
        end
    end

    local id = MySQL.insert.await('INSERT INTO container_keys (`key`) VALUES (?)', {
        key
    })

    Keys[id] = key

    return key
end

exports('generateKey', function()
    return generateKey()
end)

RegisterNetEvent('hs_container:won', function(reward, plate)
    local _source = source

    local Ped = GetPlayerPed(source)
    local Pos = GetEntityCoords(Ped)

    local Near = false
    for _, Location in pairs(Config.Locations) do
        local Distance = #(Pos - Location)
        if Distance < 5.0 then
            Near = true
            break
        end
    end

    if not Near or not AllowedForWin[_source] then
        LogCheater(_source, 'hs_container:won')
        DropPlayer(source, ServerConfig.Strings.cheatMessage)
    end

    AllowedForWin[_source] = nil

    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.insert.await('INSERT INTO owned_vehicles (owner, `stored`, plate, vehicle) VALUES (?, ?, ?, ?)', {
        xPlayer.identifier,
        1,
        plate,
        json.encode({
            model = reward.hash, plate = plate
        }),
	})

    TriggerClientEvent('hs_container:vehicleSuccess', _source, reward.label, plate)
    LogWonCar(_source, reward.label, plate)
    LogCommunityMessage(_source, reward.label)
end)

AddEventHandler('playerDropped', function()
    AllowedForWin[source] = nil
end)