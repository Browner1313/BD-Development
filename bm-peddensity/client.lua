Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      -- Adjust the density of parked vehicles
      SetParkedVehicleDensityMultiplierThisFrame(5.0)
  end
end)