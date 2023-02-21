CreateThread(function()
    if not Config.Blip.Enabled then return end

    for _, Location in pairs(Config.Locations) do
        -- blips
        local Blip = AddBlipForCoord(Location)
        SetBlipSprite(Blip, Config.Blip.Id)
        SetBlipColour(Blip, Config.Blip.Color)
        SetBlipScale(Blip, Config.Blip.Scale)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.Blip.Name)
        EndTextCommandSetBlipName(Blip)
    end
end)

function DisplayHelpText(string)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

local Showroom = false

CreateThread(function()
    Wait(2000) -- wait for nui to load
    SendNUIMessage({
        action = 'localeStrings',
        data = Locale.Strings.UI
    })
end)

CreateThread(function()
    InitCam()

    while true do
        local Sleep = 1000

        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)

        if not Showroom then
            for _, Location in pairs(Config.Locations) do
                local Distance = #(Coords - Location)
                if Config.Marker.Enabled and Config.Marker.DrawDistance >= Distance then
                    DrawMarker(Config.Marker.Type, Location, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.Scale.x, Config.Marker.Scale.y, Config.Marker.Scale.z, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, false, false, 2, Config.Marker.Rotate, nil, nil, false)
                    Sleep = 0
                end
                if Distance <= 0.8 then
                    DisplayHelpText(Locale.Strings.openAction)
                    if IsControlJustReleased(0, 38) then
                        OpenNui(0)
                    end
                end
            end
        end

        Wait(Sleep)
    end
end)

local Cam
function InitCam()
    if Cam and DoesCamExist(Cam) then return end

    Cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(Cam, Config.ShowRoom.position)

    -- disable cam
    SetCamActive(Cam, false)
end

local Vehicle
local Plate
function StartShowroom()
    -- choose random vehicle
    local Reward = Config.Rewards[math.random(1, #Config.Rewards)]
    local Model = Reward.hash

    local MaxLoad = GetGameTimer() + 10000
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Wait(0)

        if GetGameTimer() > MaxLoad then
            VehicleNotFound(Reward.label)
            return
        end
    end

    Showroom = true
    FreezeEntityPosition(PlayerPedId(), true)

    -- spawn vehicle
    Vehicle = CreateVehicle(Model, Config.ShowRoom.position, 0.0, false, false)
    SetVehicleOnGroundProperly(Vehicle)
    SetVehicleNumberPlateText(Vehicle, Locale.Strings.showroomPlate)

    -- set camera
    SetFocusPosAndVel(Config.ShowRoom.position, 0.0, 0.0, 0.0)
    SetCamActive(Cam, true)
    RenderScriptCams(true, false, 0, true, true)

    DoScreenFadeIn(1000)

    local Rot = 0.0

    local Until = GetGameTimer() + 10000
    while true do
        Wait(0)

        if GetGameTimer() > Until then
            break
        end

        DisableAllControlActions(0)

        HideHudAndRadarThisFrame()

        -- let camera spin around vehicle with distance of 5.0
        Rot = Rot + 0.01
        local X = Config.ShowRoom.position.x + math.cos(Rot) * 5.0
        local Y = Config.ShowRoom.position.y + math.sin(Rot) * 5.0
        local Z = Config.ShowRoom.position.z + 1.0
        SetCamCoord(Cam, X, Y, Z)

        PointCamAtCoord(Cam, Config.ShowRoom.position)
    end

    -- delete vehicle
    DeleteEntity(Vehicle)
    Vehicle = nil

    -- reset camera
    RenderScriptCams(false, false, 0, true, true)
    SetCamActive(Cam, false)
    ClearFocus()

    FreezeEntityPosition(PlayerPedId(), false)
    Showroom = false

    Plate = exports.esx_vehicleshop:GeneratePlate()
    TriggerServerEvent('hs_container:won', Reward, Plate)
end

RegisterNetEvent('hs_container:vehicleSuccess', function(label, plate)
    OpenNui(1)
    SendNUIMessage({
        action = 'setVehicleName',
        data = label
    })
    SendNUIMessage({
        action = 'setVehiclePlate',
        data = plate
    })
end)

function VehicleNotFound(label)
    print('Vehicle not found: ' .. label)
    -- you may include your own error handling here
end

-- nui
function OpenNui(type)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'navigate',
        data = type
    })
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
end

local ValidationPromise = promise.new()
local Valid = false

RegisterNUICallback('validateKey', function(data, cb)
    local Key = data.key
    TriggerServerEvent('hs_container:requestKey', Key)

    Citizen.Await(ValidationPromise)
    ValidationPromise = promise.new()

    cb({ valid = Valid })
end)

RegisterNetEvent('hs_container:keyResponse', function(valid)
    Valid = valid
    ValidationPromise:resolve()
end)

RegisterNUICallback('prepareShowroom', function()
    DoScreenFadeOut(500)
    StartShowroom()
end)

RegisterNUICallback('hideFrame', function()
    SetNuiFocus(false, false)
end)