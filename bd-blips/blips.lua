local blips = {
    {
      title = "FM Sanitation",
      coords = vector4(-321.14, -1546.18, 31.02, 348.27), 
      sprite = 318,
      color = 25,
      scale = 0.8, 
      display = 4, 
    },
    {
      title = "Silly Senders",
      coords = vector4(-232.73, -915.29, 32.31, 333.99),
      sprite = 280,
      color = 38,
      scale = 0.8,
      display = 4
    },
    {
      title = "Loot Lovers",
      coords = vector4(168.21, -2222.54, 7.24, 300.28),
      sprite = 586,
      color = 5,
      scale = 0.8,
      display = 4,
    },
    {
      title = "Window Cleaning",
      coords = vector4(-1243.86, -1240.6, 11.03, 244.31),
      sprite = 402,
      color = 3,
      scale = 0.8,
      display = 4
    },
}


CreateThread(function ()
  for _, blipInfo in pairs(blips) do
    local blip = AddBlipForCoord(blipInfo.coords.x, blipInfo.coords.y, blipInfo.coords.z)

    SetBlipSprite(blip, blipInfo.sprite)
    SetBlipDisplay(blip, blipInfo.display)
    SetBlipScale(blip, blipInfo.scale)
    SetBlipColour(blip, blipInfo.color)

    BeginTextCommandSetBlipName("STRING") 
    AddTextComponentString(blipInfo.title) 
    EndTextCommandSetBlipName(blip)
  end
end)