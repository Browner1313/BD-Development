function text(content)
    SetTextFont(1)
    SetTextProportional(0)
    SetTextScale(1.9,1.9)
    SetTextEntry("STRING")
    AddTextComponentString(content)
    DrawText(0.9, 0.7)
end

Citizen.CreateThread(function()

        while true do
            Citizen.Wait(2)
            local speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1),false))*2.2369
            -- Check if the ped is in a vehilce 
            if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
                text(math.floor(speed))
            end
        end
end)