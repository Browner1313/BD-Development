Config = {}

Config.FrameWork = 'qb' -- Options are QB or ESX
Config.Target = 'ox' -- Options are ox or qb
Config.Notify = 'qb'

Config.StartJobLoc = { x = -321.45, y = -1545.23, z = 31.02 } -- Mail Depot
Config.DeliveryRadius = 2000 -- Max distance for delivery locations
Config.MaxJobSlots = 5

Config.Levels = {
    [1] = { name = "Trainee", pay = 50, vehicle = "bicycle", maxDeliveries = 5 },
    [2] = { name = "Courier", pay = 100, vehicle = "scooter", maxDeliveries = 7 },
    [3] = { name = "Advanced Courier", pay = 150, vehicle = "van", maxDeliveries = 10 },
    [4] = { name = "Specialist Courier", pay = 250, vehicle = "truck", maxDeliveries = 12 }
}

Config.DeliveryPoints = {
    { type = "mailbox", coords = { x = -305.32, y = -1492.34, z = 30.0 } },
    { type = "mailbox", coords = { x = -250.12, y = -1520.45, z = 30.0 } },
    { type = "doorstep", coords = { x = -230.45, y = -1450.76, z = 30.0 } },
    { type = "doorstep", coords = { x = -200.15, y = -1405.23, z = 30.0 } }
}

