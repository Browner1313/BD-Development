-- makes sure the menu will open when called
RegisterNetEvent('HP-Spawn:OpenMenu')
AddEventHandler('HP-Spawn:OpenMenu', function()
    SetTimecycleModifier('hud_def_blur')
    SetNUIMessage({ action = 'display' })
    SetNuiFocus(true, true)
end)

local spawns = {
    ['airport'] = vector4(-1042.27, -2745.47, 21.36, 331.02),
    ['paleto'] = vector4(144.96, 6643.39, 31.54, 194.51),
    ['pink'] = vector4(327.45, -205.99, 54.09, 160.56),
    ['harmony'] = vector4(1122.46, 2654.38, 38.0, 0.08)
}

RegisterNUICallback('spawn', function(data)
    local Spawn_Name = data.location
    print(Spawn_Name)     -- delete later
    local Spawn_Location = spawns[Spawn_Name]
    print(Spawn_Location) -- delete later
    CameraPosition(Spawn_Location.x, Spawn_Location.y, Spawn_Location.z)
end)

function CameraPosition(x, y, z)
    local pos = { x = x, y = y, z = z }
    SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
    DoScreenFadeIn(500)
    SetTimecycleModifier('defualt')
    SetNuiFocus(false, false)
    Wait(500)
    local cam_2 = CreatCamWithParams('DEFAULT_SCRIPTED_CAMERS', 561.3, 301.3, 63.0, 0.0, 0.0, 0.0, 90.0)
    PointCamAtCoord(cam_2, pos.x, pos.y, pos.z + 200)
    SetCamActiveWithInterp(cam_2, cam, 900, true, true)
    Wait(900)
    local cam = CreatCamWithParams("Default_Scripted_Camera", pos.x, pos.y, pos.z + 200, 0.0, 0.0, 0.0, 90.0)
    PointCamAtCoord(cam, pos.x, pos.y, pos.z + 2)
    SetCamActiveWithInterp(cam, cam_2, 3700, true, true)
    Wait(3700)
    RenderScriptCams(false, true, 500, true, true) -- test with back 2 false
    FreezeEntityPosition(GetPlayerPed(-1), false)
    DoScreenFadeOut(500)
    Wait(500)
    DoScreenFadeIn(1000)
    SetCamActive(cam, false)
    DestoryCam(cam, true)
    DisplayHUD(true)
    DisplayRadar(true)
end
