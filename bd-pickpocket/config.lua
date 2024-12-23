Config = {}

-- Debugging
Config.Debug = true

-- List of "fat" ped models
Config.FatPeds = {
    -- Male Fat Peds
    "a_m_m_fatlatin_01", "a_m_m_fatlatin_02", "a_m_m_fatblack_01",
    "a_m_m_fatwhite_01", "ig_chengsr", "ig_fatc", "cs_fatc",
    "a_m_m_tourist_01", "a_m_m_afriamer_01", "a_m_y_downtown_01",
    "a_m_m_polynesian_01",

    -- Female Fat Peds
    "a_f_m_fatbla_01", "a_f_m_fatcult_01", "a_f_m_fatwhite_01",
    "a_f_m_downtown_01",

    -- Miscellaneous
    "s_m_m_gentransport"
}

-- List of food items given when pickpocketing fat peds
Config.FatPedItems = {
    "crisps", "cpizzaslice", "papizzaslice", "frenchfries"
}

Config.BlacklistedPeds = {
    'a_m_m_eastsa_01',
    's_m_m_doctor_01',
    'a_f_o_soucent_02',
    'a_m_y_epsilon_01',
    'a_m_m_eastsa_02',
    'a_m_y_business_03',
    'a_m_y_musclbeac_01',
    'mp_m_boatstaff_01'
}

-- Rewards for non-fat peds
Config.Rewards = {
    {item = 'money', amount = 5,  probability = 10}, 
    {item = 'money', amount = 10, probability = 10}, 
    {item = 'money', amount = 15, probability = 10}, 
    {item = 'money', amount = 20, probability = 10}, 
    {item = 'money', amount = 25, probability = 10}, 
    {item = 'money', amount = 30, probability = 10},
    {item = 'money', amount = 35, probability = 10},
    {item = 'money', amount = 40, probability = 10},
    {item = 'weed_skunk_joint', amount = 1, probability = 15},
    {item = 'gold_watch',        amount = 1, probability = 5}
}

-- Notify messages
Config.Messages = {
    Looted = "Go away punk, you have taken everything I had!",
    Moving = "This person is moving too fast to pickpocket!",
    Lunch = "Whyyyyy Thats my lunch!!",
    Cancelled = "Pickpocket attempt cancelled",
    Break = "Maybe you should take a break",
    TestTrigger = "Test interaction triggered!",
    NotAble = "The person is not in a state to be pickpocketed."
}


