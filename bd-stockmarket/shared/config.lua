Config = {}

Config.Companies = {
    -- Technology
    { name = "CodeCore Inc.", abbreviation = "CCOR", sector = "Technology", basePrice = 120, volatility = 1.5 },
    { name = "ByteForge Solutions", abbreviation = "BYTF", sector = "Technology", basePrice = 110, volatility = 1.4 },
    { name = "QuantumArc Systems", abbreviation = "QARC", sector = "Technology", basePrice = 150, volatility = 1.6 },
    { name = "PixelPeak Industries", abbreviation = "PXPK", sector = "Technology", basePrice = 90, volatility = 1.3 },
    { name = "DataHive Technologies", abbreviation = "DHIV", sector = "Technology", basePrice = 130, volatility = 1.5 },

    -- Energy
    { name = "SolarVibe Renewables", abbreviation = "SVRB", sector = "Energy", basePrice = 80, volatility = 1.2 },
    { name = "EonFlare Energy", abbreviation = "EFLR", sector = "Energy", basePrice = 95, volatility = 1.3 },
    { name = "FusionStream Power", abbreviation = "FSPW", sector = "Energy", basePrice = 100, volatility = 1.4 },
    { name = "EcoPulse Oil & Gas", abbreviation = "ECPL", sector = "Energy", basePrice = 75, volatility = 1.2 },
    { name = "Lumeo Power Corp", abbreviation = "LUMO", sector = "Energy", basePrice = 85, volatility = 1.3 },

    -- Healthcare
    { name = "MediSphere Biotech", abbreviation = "MSBT", sector = "Healthcare", basePrice = 150, volatility = 1.7 },
    { name = "VitalCore Pharmaceuticals", abbreviation = "VCRP", sector = "Healthcare", basePrice = 140, volatility = 1.6 },
    { name = "NeuroAxis Labs", abbreviation = "NRAX", sector = "Healthcare", basePrice = 160, volatility = 1.8 },
    { name = "PulsePoint Medical", abbreviation = "PLPM", sector = "Healthcare", basePrice = 120, volatility = 1.4 },
    { name = "Genova Therapeutics", abbreviation = "GNTH", sector = "Healthcare", basePrice = 130, volatility = 1.5 },

    -- Finance
    { name = "VaultEdge Holdings", abbreviation = "VLED", sector = "Finance", basePrice = 100, volatility = 1.3 },
    { name = "EquiRise Capital", abbreviation = "EQRC", sector = "Finance", basePrice = 110, volatility = 1.4 },
    { name = "GoldenBridge Bank", abbreviation = "GBBK", sector = "Finance", basePrice = 90, volatility = 1.2 },
    { name = "CrestPoint Investments", abbreviation = "CPTI", sector = "Finance", basePrice = 105, volatility = 1.3 },
    { name = "SecureVest Funds", abbreviation = "SVST", sector = "Finance", basePrice = 95, volatility = 1.2 },

    -- Consumer Goods
    { name = "FreshFold Organics", abbreviation = "FFOD", sector = "Consumer Goods", basePrice = 80, volatility = 1.1 },
    { name = "GearGrid Apparel", abbreviation = "GGRD", sector = "Consumer Goods", basePrice = 85, volatility = 1.2 },
    { name = "BrewBloom Beverages", abbreviation = "BBBV", sector = "Consumer Goods", basePrice = 75, volatility = 1.1 },
    { name = "SparkCrest Electronics", abbreviation = "SPCT", sector = "Consumer Goods", basePrice = 95, volatility = 1.3 },
    { name = "TerraCharm Foods", abbreviation = "TCHF", sector = "Consumer Goods", basePrice = 70, volatility = 1.0 },

    -- Industrial
    { name = "IronForge Manufacturing", abbreviation = "IRFM", sector = "Industrial", basePrice = 120, volatility = 1.5 },
    { name = "SkyHorizon Aerospace", abbreviation = "SKHZ", sector = "Industrial", basePrice = 150, volatility = 1.6 },
    { name = "BuildWell Industries", abbreviation = "BLWI", sector = "Industrial", basePrice = 140, volatility = 1.4 },
    { name = "CoreSteel Construction", abbreviation = "CSTE", sector = "Industrial", basePrice = 100, volatility = 1.3 },
    { name = "TitanEdge Equipment", abbreviation = "TEDG", sector = "Industrial", basePrice = 110, volatility = 1.4 },

    -- Entertainment
    { name = "SceneSphere Studios", abbreviation = "SCSP", sector = "Entertainment", basePrice = 90, volatility = 1.2 },
    { name = "PlayPulse Interactive", abbreviation = "PPIA", sector = "Entertainment", basePrice = 85, volatility = 1.1 },
    { name = "ChimeTunes Media", abbreviation = "CHTM", sector = "Entertainment", basePrice = 80, volatility = 1.1 },
    { name = "NextWave Entertainment", abbreviation = "NWVE", sector = "Entertainment", basePrice = 100, volatility = 1.3 },
    { name = "VisionDeck Productions", abbreviation = "VDPK", sector = "Entertainment", basePrice = 95, volatility = 1.2 },

    -- Retail
    { name = "StyleMaven Fashion", abbreviation = "SMVN", sector = "Retail", basePrice = 75, volatility = 1.1 },
    { name = "QuickCart Markets", abbreviation = "QCRT", sector = "Retail", basePrice = 80, volatility = 1.2 },
    { name = "UrbanNest Decor", abbreviation = "UNST", sector = "Retail", basePrice = 70, volatility = 1.0 },
    { name = "PeakTrend Sportswear", abbreviation = "PTRS", sector = "Retail", basePrice = 85, volatility = 1.2 },
    { name = "BrightSquare Stores", abbreviation = "BRSQ", sector = "Retail", basePrice = 95, volatility = 1.3 },

    -- Real Estate
    { name = "HavenRise Properties", abbreviation = "HRSP", sector = "Real Estate", basePrice = 110, volatility = 1.4 },
    { name = "MetroEdge Realty", abbreviation = "MTED", sector = "Real Estate", basePrice = 115, volatility = 1.5 },
    { name = "VistaPoint Developments", abbreviation = "VSPD", sector = "Real Estate", basePrice = 120, volatility = 1.6 },
    { name = "LandAxis Ventures", abbreviation = "LAXV", sector = "Real Estate", basePrice = 100, volatility = 1.3 },
    { name = "UrbanGrid Estates", abbreviation = "UGES", sector = "Real Estate", basePrice = 105, volatility = 1.3 },

    -- Transportation
    { name = "SwiftPath Logistics", abbreviation = "SWPL", sector = "Transportation", basePrice = 90, volatility = 1.2 },
    { name = "AeroLift Airlines", abbreviation = "ALFT", sector = "Transportation", basePrice = 100, volatility = 1.3 },
    { name = "TrackLine Railways", abbreviation = "TLRY", sector = "Transportation", basePrice = 85, volatility = 1.1 },
    { name = "CruiseSphere Shipping", abbreviation = "CSSP", sector = "Transportation", basePrice = 95, volatility = 1.2 },
    { name = "RapidMove Transit", abbreviation = "RMVT", sector = "Transportation", basePrice = 80, volatility = 1.0 },

    -- Utilities
    { name = "BrightSpark Utilities", abbreviation = "BSUT", sector = "Utilities", basePrice = 100, volatility = 1.3 },
    { name = "EcoPure Waterworks", abbreviation = "EPWW", sector = "Utilities", basePrice = 95, volatility = 1.2 },
    { name = "PowerPulse Energy", abbreviation = "PPLS", sector = "Utilities", basePrice = 90, volatility = 1.1 },
    { name = "GridFlow Electric", abbreviation = "GDFL", sector = "Utilities", basePrice = 85, volatility = 1.2 },
    { name = "LumeLine Gas Co.", abbreviation = "LLGC", sector = "Utilities", basePrice = 80, volatility = 1.1 }
}
