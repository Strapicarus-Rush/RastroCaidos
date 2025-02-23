--[[
 ███████╗████████╗██████╗  █████╗ ██████╗ ██╗ ██████╗ █████╗ ██████╗ ██╗   ██╗███████╗
 ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║   ██║██╔════╝
 ███████╗   ██║   ██████╔╝███████║██████╔╝██║██║     ███████║██████╔╝██║   ██║███████╗
 ╚════██║   ██║   ██╔═██╗ ██╔══██║██╔═══╝ ██║██║     ██╔══██║██╔═██╗ ██║   ██║╚════██║
 ███████║   ██║   ██║  ██╗██║  ██║██║     ██║╚██████╗██║  ██║██║  ██╗╚██████╔╝███████║
 ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ 
 
 File    : server.lua
 Version : 0.2.69

--]]
local Rastros = Rastros or {}
Rastros.maleOutfits = getAllOutfits(false);
Rastros.femaleOutfits = getAllOutfits(true);
RastrosModData = RastrosModData or {}
Rastros.tittle = "Rastro N. "
Rastros.transTitleKey = "IGUI_RASTROSCAIDOS_TITLE_"
Rastros.transBodyKey = "IGUI_RASTROSCAIDOS_BODY_"
local indexedCoords = false
local spawnIndex = {}

Rastros.cars = {
    firstResponder = {
        "Base.PickUpVanLightsPolice",
        "Base.CarLightsPolice",
        "Base.PickUpVanLightsFire",
        "Base.PickUpTruckLightsFire",
        "Base.CarLights",
        "Base.PickUpVanLights",
        "Base.PickUpTruckLights",
        "Base.VanAmbulance"
    },
    offRoad = {
        "Base.PickUpTruck",
        "Base.PickUpVan",
        "Base.SUV",
        "Base.OffRoad"
    },
    civilCar = {
        "Base.CarNormal",
        "Base.CarStationWagon",
        "Base.CarStationWagon2",
        "Base.VanSeats",
        "Base.Van",
        "Base.ModernCar",
        "Base.ModernCar02",
        "Base.CarLuxury",
        "Base.SportsCar",
        "Base.SmallCar",
        "Base.SmallCar02",
        "Base.CarTaxi",
        "Base.CarTaxi2"
    },
    other = {
        "Base.Van_LectroMax",
        "Base.StepVan_Heralds",
        "Base.VanRadio_3N",
        "Base.Van_KnoxDisti",
        "Base.Van_Transit",
        "Base.Van_MassGenFac",
        "Base.StepVan_Scarlet",
        "Base.VanSpecial",
        "Base.VanRadio",
        "Base.VanSpiffo",
        "Base.StepVanMail"
    }
}

Rastros.outfits = {
    firstResponder = {
        "FiremanFullSuit",
        "HazardSuit",
        "AmbulanceDriver",
        "Police",
        "PoliceRiot",
        "PoliceState",
        "Fireman",
        "Nurse",
        "Doctor",
        "HospitalPatient",
        "Pharmacist",
        "bullet",
        "Ranger"
    },
    camping = {
        "Camper",
        "Hunter",
        "Fisherman",
        "Survivalist",
        "Survivalist02",
        "Survivalist03",
        "TinFoilHat",
        "Duke"
    },
    militia = {
        "PrivateMilitia",
        "ArmyCamoDesert",
        "ArmyCamoGreen",
        "ArmyServiceUniform",
        "AirCrew",
        "ArmyInstructor",
        "Pharmacist",
        "HazardSuit",
        "bullet"

    },
    sport = {
        "BaseballFan_KY",
        "BaseballFan_Rangers",
        "BaseballFan_Z",
        "BaseballPlayer_Z",
        "BaseballPlayer_Rangers",
        "BaseballPlayer_KY",
        "Biker",
        "Bowling",
        "Cyclist",
        "FitnessInstructor",
        "Golfer"
    },
    restaurantStore = {
        "Chef",
        "Cook_Generic",
        "Cook_IceCream",
        "Cook_Spiffos",
        "Santa",
        "Security",
        "Sir_Twiggy",
        "Spiffo"

    },
    street = {
        "Classy",
        "DressLong",
        "DressNormal",
        "DressShort",
        "Fossoil",
        "Gas2Go",
        "Generic_Skirt",
        "Generic01",
        "Generic02",
        "Generic03",
        "Generic04",
        "Generic05",
        "GigaMart_Employee",
        "HospitalPatient",
        "Jackie_Jaye",
        "Joan",
        "Kate",
        "Kirsty_Kormick",
        "Party",
        "Punk",
        "PrisonGuard",
        "Priest",
        "Postal",
        "PokerDealer",
        "Bob"
    },
    farm = {
        "Farmer",
        "Redneck",
        "Rev_Peter_Watts",
        "Rocker"
    },
    house = {
        "Naked",
        "NakedVeil",
        "StripperNaked",
        "Mannequin2",
        "Bathrobe",
        "Bedroom",
        "StripperPink"
    }
}

Rastros.item = {
    cannedfood = {
        "Base.CannedFruitCocktail",
        "Base.CannedCornedBeef",
        "Base.CannedPeaches",
        "Base.CannedPineapple"
    },
    medicalequip ={
        "Base.Scissors",
        "Base.Scalpel",
        "Base.SutureNeedle",
        "Base.SutureNeedleHolder",
        "Base.Tweezers"
    },
    pharma = {
        "Base.Antibiotics",
        "Base.Pills",
        "Base.PillsBeta",
        "Base.PillsAntiDep",
        "Base.Cigarettes",
        "Base.PillsVitamins"
    },
    desinfectants = {
        "Base.AlcoholBandage",
        "Base.AlcoholRippedSheets",
        "Base.AlcoholWipes",
        "Base.AlcoholedCottonBalls",
        "Base.Disinfectant",
    },
    bandages = {
        "Base.Bandaid",
        "Base.Bandage",
        "Base.CottonBalls",
        "Base.AlcoholRippedSheets",
        "Base.AlcoholBandage",
        "Base.Splint"
    },
    tool = {
        "Base.BallPeenHammer",
        "Base.GardenSaw",
        "Base.Axe",
        "Base.Saw",
        "Base.Sledgehammer",
        "Base.Hammer",
        "Base.Crowbar",
        "Base.AxeStone",
        "Base.HammerStone",
        "Base.PickAxe",
        "Base.Sledgehammer2",
        "Base.WoodAxe",
        "Base.HandFork",
        "Base.Screwdriver",
        "Base.HandScythe",
        "Base.PickAxeHandle",
        "Base.Machete",
        "Base.ClubHammer",
        "Base.PipeWrench",
        "Base.MetalPipe"
    },
    oneHandedWeapon = {
        "Base.HuntingKnife",
        "Base.FlintKnife",
        "Base.KitchenKnife"
    },
    twoHandedWeapon = {
        "Base.Katana",
        "Base.BaseballBat",
        "Base.BaseballBatNails"
    },
    bag = {
        "Base.Bag_SurvivorBag",
        "Base.Bag_Military",
        "Base.Bag_ALICEpack",
        "Base.Bag_MedicalBag",
        "Base.Bag_BigHikingBag",
        "Base.Bag_ALICEpack_Army",
        "Base.Bag_ToolBag"
    },
    water = {
        "Base.WaterBottle",
        "Base.PopBottle",
        "Base.JuiceBox"
    },

}

Rastros.fireArm = {
    oneHanded = {
        Pistol = {
            item = "Base.Pistol",
            box = "Base.Bullets9mmBox",
            ammo = "Base.Bullets9mm",
            magazine = "Base.9mmClip"
        },
        Pistol2 = {
            item = "Base.Pistol2",
            box = "Base.Bullets45Box",
            ammo = "Base.Bullets45",
            magazine = "Base.45Clip"
        },
        Pistol3 = {
            item = "Base.Pistol3",
            box = "Base.Bullets44Box",
            ammo = "Base.Bullets44",
            magazine = "Base.44Clip"
        },
        Revolver = {
            item = "Base.Revolver",
            box = "Base.Bullets45Box",
            ammo = "Base.Bullets45"
        },
        Revolver_Long = {
            item = "Base.Revolver_Long",
            box = "Base.Bullets44Box",
            ammo = "Base.Bullets44"
        },
        Revolver_Short = {
            item = "Base.Revolver_Short",
            box = "Base.Bullets38Box",
            ammo = "Base.Bullets38"
        }
    },
    twoHanded = {
        VarmintRifle = {
            item = "Base.VarmintRifle",
            box = "Base.223Box",
            ammo = "Base.223Bullets"
        },
        HuntingRifle = {
            item = "Base.HuntingRifle",
            box = "Base.308Box",
            ammo = "Base.308Bullets",
            magazine = "Base.308Clip"
        },
        Shotgun = {
            item = "Base.Shotgun",
            box = "Base.ShotgunShellsBox",
            ammo = "Base.ShotgunShells"
        },
        DoubleBarrelShotgun = {
            item = "Base.DoubleBarrelShotgun",
            box = "Base.ShotgunShellsBox",
            ammo = "Base.ShotgunShells"
        },
        DoubleBarrelShotgunSawnoff = {
            item = "Base.DoubleBarrelShotgunSawnoff",
            box = "Base.ShotgunShellsBox",
            ammo = "Base.ShotgunShells"
        },
        ShotgunSawnoff = {
            item = "Base.ShotgunSawnoff",
            box = "Base.ShotgunShellsBox",
            ammo = "Base.ShotgunShells"
        },
        AssaultRifle = {
            item = "Base.AssaultRifle",
            box = "Base.556Box",
            ammo = "Base.556Bullets",
            magazine = "Base.556Clip"
        },
        AssaultRifle2 = {
            item = "Base.AssaultRifle2",
            box = "Base.556Box",
            ammo = "Base.308Bullets",
            magazine = "Base.M14Clip"
        },   
    }
}

Rastros.getModData = function()
    if not ModData.exists("datosRastros") then
        RastrosModData = ModData.create("datosRastros")

        -- deerhead lake 
        RastrosModData.deerhead = {
            indx = 1,
            note = { spawned = false, x = 4675, y = 8608 },
            veh1 = { spawned = false, x = 4657, y = 8616, type = "firstResponder", key = false, repair = true },
            veh2 = { spawned = false, x = 4664, y = 8620, type = "firstResponder", key = false, repair = true },
            veh3 = { spawned = false, x = 4671, y = 8623, type = "firstResponder", key = false, repair = true },
            item1 = { spawned = false, x = 4672, y = 8612, type = {Rastros.item.tool, Rastros.fireArm.oneHanded}, quantity = 3, inbag = true, bags = 3, separate = false },
            zomb1 = { spawned = false, x = 4670, y = 8636, type = "firstResponder", quantity = 6 }
        }
        
        -- camping shop West park
        RastrosModData.campingwest = {
            indx = 2,
            note = { spawned = false, x = 3801, y = 8546 },
            veh1 = { spawned = false, x = 3788, y = 8563, type = "firstResponder", key= true, repair = false },
            veh2 = { spawned = false, x = 3787, y = 8574, type = "firstResponder", key= false, repair = true },
            veh3 = { spawned = false, x = 3773, y = 8574, type = "firstResponder", key= true, repair = false },
            item1 = { spawned = false, x = 3808, y = 8555, type = {Rastros.item.oneHandedWeapon, Rastros.item.water}, quantity = 2, inbag = true, bags = 2, separate = true },
            zomb1 = { spawned = false, x = 3790, y = 8540, type = "firstResponder", quantity = 8 }
        }
        -- -- Guns shop West park
        RastrosModData.gunswest = {
            indx = 3,
            note = { spawned = false, x = 3804, y = 8509 },
            veh1 = { spawned = false, x = 3794, y = 8496, type = "firstResponder", key = true, repair = false },
            veh2 = { spawned = false, x = 3780, y = 8490, type = "firstResponder", key = false, repair = true },
            veh3 = { spawned = false, x = 3790, y = 8519, type = "firstResponder", key = false, repair = false },
            item1 = { spawned = false, x = 3798, y = 8513, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            item2 = { spawned = false, x = 3796, y = 8510, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            item3 = { spawned = false, x = 3795, y = 8509, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            item4 = { spawned = false, x = 3801, y = 8511, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            zomb1 = { spawned = false, x = 3787, y = 8504, type = "firstResponder", quantity = 10 }
        }
        -- -- Ranger House west Doe Valley
        RastrosModData.rangerhouse = {
            indx = 4,
            note = { spawned = false, x = 5580, y = 9720 },
            veh1 = { spawned = false, x = 5586, y = 9738, type = "firstResponder", key= false, repair = true },
            veh2 = { spawned = false, x = 5618, y = 9739, type = "firstResponder", key= true, repair = true },
            veh3 = { spawned = false, x = 5472, y = 9545, type = "firstResponder", key= false, repair = false },
            item1 = { spawned = false, x = 5473, y = 9534, type = {Rastros.item.tool, Rastros.fireArm.oneHanded}, quantity = 2, inbag = true, bags = 1, separate = false },
            item2 = { spawned = false, x = 5594, y = 9725, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 2, inbag = true, bags = 1, separate = false },
            zomb1 = { spawned = false, x = 5578, y = 9720 , type = "firstResponder", quantity = 4},
            zomb2 = { spawned = false, x = 5578, y = 9724 , type = "firstResponder", quantity = 4},
            zomb3 = { spawned = false, x = 5467, y = 9533, type = "firstResponder", quantity = 4 }
        }
        -- Militar surplus store West Doe valle
        RastrosModData.militarsurplus = {
            indx = 5,
            note = { spawned = false, x = 5464, y = 9523 },
            veh1 = { spawned = false, x = 5416, y = 9546, type = "militia", key= true, repair = true },
            veh2 = { spawned = false, x = 5414, y = 9536, type = "militia", key= false, repair = true },
            veh3 = { spawned = false, x = 5482, y = 9599, type = "firstResponder", key= true, repair = true },
            item1 = { spawned = false, x = 5408, y = 9535, type = {Rastros.item.tool, Rastros.fireArm.twoHanded, Rastros.item.twoHandedWeapon, Rastros.item.oneHandedWeapon }, quantity = 3, inbag = true, bags = 2, separate = true },
            zomb1 = { spawned = false, x = 5420, y = 9540, type = "militia", quantity = 6 }
        }
        -- West Riverside farm
        RastrosModData.westriversidefarm = {
            indx = 6,
            note = { spawned = false, x = 4257, y = 5874 },
            veh1 = { spawned = false, x = 4248, y = 5861, type = "offRoad", key= false, repair = true },
            item1 = { spawned = false, x = 4257, y = 5875, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 1, inbag = true, bags = 3, separate = false },
            zomb1 = { spawned = false, x = 4258, y = 5881, type = "camping", quantity = 3 }
        }
        -- Nort east Doe Valley Militar Quarters
        RastrosModData.militarquarters = {
            indx = 7,
            note = { spawned = false, x = 7447, y = 7960 },
            veh1 = { spawned = false, x = 7456, y = 7961, type = "firstResponder", key= false, repair = true },
            veh2 = { spawned = false, x = 7461, y = 7961, type = "firstResponder", key= false, repair = true },
            veh3 = { spawned = false, x = 7464, y = 7969, type = "offRoad", key= false, repair = true },
            veh4 = { spawned = false, x = 7468, y = 7962, type = "offRoad", key= false, repair = true },
            veh5 = { spawned = false, x = 7464, y = 7953, type = "offRoad", key= false, repair = true },
            item1 = { spawned = false, x = 7440, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item2 = { spawned = false, x = 7442, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item3 = { spawned = false, x = 7444, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item4 = { spawned = false, x = 7446, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item5 = { spawned = false, x = 7448, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item6 = { spawned = false, x = 7450, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item7 = { spawned = false, x = 7452, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item8 = { spawned = false, x = 7454, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item9 = { spawned = false, x = 7456, y = 7955, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}, quantity = 2, inbag = true, bags = 3, separate = false },
            item10 = { spawned = false, x = 7435, y = 7958, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            item11 = { spawned = false, x = 7437, y = 7962, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            item12 = { spawned = false, x = 7442, y = 7959, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            item13 = { spawned = false, x = 7451, y = 7963, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            item14 = { spawned = false, x = 7451, y = 7959, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            item15 = { spawned = false, x = 7456, y = 7961, type = {Rastros.fireArm.twoHanded}, quantity = 1, inbag = false, bags = 0, separate = true },
            zomb1 = { spawned = false, x = 7429, y = 7950, type = "militia", quantity = 8 },
            zomb2 = { spawned = false, x = 7429, y = 7967, type = "militia", quantity = 8 },
            zomb3 = { spawned = false, x = 7445, y = 7976, type = "militia", quantity = 4 },
            zomb4 = { spawned = false, x = 7459, y = 7974, type = "militia", quantity = 4 },
            zomb5 = { spawned = false, x = 7461, y = 7949, type = "militia", quantity = 4 },
            zomb6 = { spawned = false, x = 7445, y = 7940, type = "militia", quantity = 4 },
            zomb7 = { spawned = false, x = 7430, y = 7942, type = "militia", quantity = 8 }
        }
        -- Riverside police station
        RastrosModData.riversidepolicestation = {
            indx = 8,
            note = { spawned = false, x = 6079, y = 5261 },
            veh1 = { spawned = false, x = 6093, y = 5275, type = "firstResponder", key= false, repair = true },
            veh2 = { spawned = false, x = 6085, y = 5271, type = "firstResponder", key= false, repair = true },
            item1 = { spawned = false, x = 6079, y = 5262, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 2, inbag = true, bags = 3, separate = false },
            zomb1 = { spawned = false, x = 6087, y = 5261, type = "firstResponder", quantity = 10 }
        }
        -- Rosewood police station
        RastrosModData.rosewoodpolicestation = {
            indx = 8,
            note = { spawned = false, x = 8071, y = 11727 },
            veh1 = { spawned = false, x = 8083, y = 11725, type = "firstResponder", key= false, repair = true },
            item1 = { spawned = false, x = 8072, y = 11727, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 1, inbag = true, bags = 3, separate = false },
            zomb1 = { spawned = false, x = 8064, y = 11722, type = "firstResponder", quantity = 11 }
        }
        -- Knox Militar apartments
        RastrosModData.knoxapartments = {
            indx = 7,
            note = { spawned = false, x = 10079, y = 12629 },
            veh1 = { spawned = false, x = 10082, y = 12643, type = "firstResponder", key= false, repair = true },
            item1 = { spawned = false, x = 10080, y = 12639, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 1, inbag = true, bags = 3, separate = false },
            zomb1 = { spawned = false, x = 10071, y = 12628, type = "militia", quantity = 11 }
        }
        -- Muldraugh police station
        RastrosModData.muldraughpolicestation = {
            indx = 9,
            note = { spawned = false, x = 10634, y = 10412 },
            veh1 = { spawned = false, x = 10646, y = 10418, type = "firstResponder", key= false, repair = true },
            item1 = { spawned = false, x = 10638, y = 10408, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 1, inbag = true, bags = 3, separate = false },
            zomb1 = { spawned = false, x = 10634, y = 10402, type = "firstResponder", quantity = 11 }
        }
        -- West Point police station
        RastrosModData.westpointpolicestation = {
            indx = 8,
            note = { spawned = false, x = 11900, y = 6949 },
            veh1 = { spawned = false, x = 11905, y = 6959, type = "firstResponder", key= false, repair = true },
            veh2 = { spawned = false, x = 11915, y = 6932, type = "firstResponder", key= false, repair = true },
            item1 = { spawned = false, x = 11906, y = 6952, type = {Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 1, inbag = true, bags = 3, separate = false },
            zomb1 = { spawned = false, x = 11904, y = 6934, type = "firstResponder", quantity = 11 }
        }
        -- trains station south
        RastrosModData.trainsouth = {
            indx = 10,
            note = { spawned = false, x = 11602, y = 10221 },
            veh1 = { spawned = false, x = 11602, y = 10233, type = "firstResponder", key= false, repair = true },
            item1 = { spawned = false, x = 11604, y = 10221, type = {Rastros.item.twoHandedWeapon, Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 1, inbag = true, bags = 3, separate = false },
            item2 = { spawned = false, x = 11608, y = 10230, type = {Rastros.fireArm.twoHanded, Rastros.item.twoHandedWeapon}, quantity = 1, inbag = false, bags = 0, separate = true },
            item3 = { spawned = false, x = 11606, y = 10225, type = {Rastros.fireArm.twoHanded, Rastros.item.twoHandedWeapon}, quantity = 1, inbag = false, bags = 0, separate = true },
            zomb1 = { spawned = false, x = 10634, y = 10402, type = "militia", quantity = 11 }
        }
        -- trains station west
        RastrosModData.trainwesth = {
            indx = 10,
            note = { spawned = false, x = 11545, y = 9746 },
            veh1 = { spawned = false, x = 11543, y = 9745, type = "firstResponder", key= false, repair = true },
            item1 = { spawned = false, x = 11545, y = 9747, type = {Rastros.item.twoHandedWeapon, Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 1, inbag = true, bags = 3, separate = false },
            item2 = { spawned = false, x = 11545, y = 9744, type = {Rastros.fireArm.twoHanded, Rastros.item.twoHandedWeapon}, quantity = 1, inbag = false, bags = 0, separate = true },
            item3 = { spawned = false, x = 11547, y = 9749, type = {Rastros.fireArm.twoHanded, Rastros.item.twoHandedWeapon}, quantity = 1, inbag = false, bags = 0, separate = true },
            zomb1 = { spawned = false, x = 11549, y = 9746, type = "militia", quantity = 11 }
        }
        -- trains station center
        RastrosModData.traincenter = {
            indx = 11,
            note = { spawned = false, x = 11709, y = 9931 },
            veh1 = { spawned = false, x = 11699, y = 9979, type = "civilCar", key= true, repair = false },
            veh2 = { spawned = false, x = 11682, y = 9979, type = "firstResponder", key= true, repair = false },
            veh3 = { spawned = false, x = 11669, y = 9979, type = "firstResponder", key= false, repair = true },
            veh4 = { spawned = false, x = 11708, y = 9965, type = "offRoad", key= true, repair = false },
            item1 = { spawned = false, x = 11709, y = 9940, type = {Rastros.item.twoHandedWeapon, Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 3, inbag = true, bags = 1, separate = false },
            item2 = { spawned = false, x = 11709, y = 9932, type = {Rastros.item.twoHandedWeapon, Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 3, inbag = true, bags = 1, separate = false },
            item3 = { spawned = false, x = 11709, y = 9922, type = {Rastros.item.twoHandedWeapon, Rastros.item.cannedfood, Rastros.item.water, Rastros.item.pharma, Rastros.item.medicalequip}, quantity = 3, inbag = true, bags = 1, separate = false },
            zomb1 = { spawned = false, x = 11682, y = 9966, type = "militia", quantity = 11 }
        }
        -- Army check point
        RastrosModData.armycheckpoint = {
            indx = 12,
            note = { spawned = false, x = 12467, y = 4271 },
            veh1 = { spawned = false, x = 12472, y = 4258, type = "firstResponder", key= true, repair = false },
            veh2 = { spawned = false, x = 12474, y = 4291, type = "firstResponder", key= true, repair = false },
            zomb1 = { spawned = false, x = 12457, y = 4266, type = "militia", quantity = 15 }
        }
        -- Pccs
        RastrosModData.pccs = {
            indx = 13,
            note = { spawned = false, x = 15000, y = 3450 },
            veh1 = { spawned = false, x = 14972, y = 3460, type = "firstResponder", key= true, repair = false },
            veh2 = { spawned = false, x = 14971, y = 3450, type = "firstResponder", key= true, repair = false },
            veh3 = { spawned = false, x = 14970, y = 3441, type = "firstResponder", key= true, repair = false },
            zomb1 = { spawned = false, x = 14973, y = 3461, type = "militia", quantity = 15 },
            zomb2 = { spawned = false, x = 14972, y = 3452, type = "militia", quantity = 15 },
            zomb3 = { spawned = false, x = 14974, y = 3460, type = "militia", quantity = 15 },
            zomb4 = { spawned = false, x = 15002, y = 3450, type = "militia", quantity = 15 }
        }

        return RastrosModData
    else
        RastrosModData = ModData.get("datosRastros")
        return RastrosModData
    end
end

Rastros.choice = function(lst)
    --gen a random so it gets initialiset? avoid same number generate always? do not know whats going on, seems like always return the same number.
    local _ = ZombRand(100)
    if lst[1] ~= nil and type(lst) == table then
        local sel = ZombRand(#lst) + 1
        return lst[sel]
    end
    local keys = {}
    for key in pairs(lst) do

        table.insert(keys, key)
    end
    local randomKey = keys[ZombRand(#keys) + 1]
    return lst[randomKey]
end

Rastros.flipCoin = function()
    local sel = ZombRand(2) + 1
    if sel == 2 then
        return true
    end
    return false
end

Rastros.spawnItems = function(sq, flag, quantity, items, separate, inbag, bags)
    if type(items) == "string" then
        if inbag then
            local bag = InventoryItemFactory.CreateItem(Rastros.choice(Rastros.item.bag))
            local inventory = bag:getInventory()
            for q = 1, quantity do
                local newItem = InventoryItemFactory.CreateItem(items)
                inventory:AddItem(newItem)
            end
            sq:AddWorldInventoryItem(bag, 0.1, 0.2, 0)
        else
            for q = 1, quantity do
                local newItem = InventoryItemFactory.CreateItem(items)
                sq:AddWorldInventoryItem(newItem, 0.4, 0.5, 0)
            end
        end
        flag.spawned = true
        return
    end
    if separate then
        for i = 1, #items do
            local group = items[i]
            if group[1] ~= nil then
                if inbag then
                    local bag = InventoryItemFactory.CreateItem(Rastros.choice(Rastros.item.bag))
                    local inventory = bag:getInventory()
                    for q = 1, quantity do
                        local newItem = InventoryItemFactory.CreateItem(Rastros.choice(group))
                        inventory:AddItem(newItem)
                    end
                    sq:AddWorldInventoryItem(bag, 0.5, 0.5, 0)
                else
                    for q = 1, quantity do
                        local posX = 0.1 * q
                        local posY = 0.2 * q
                        local newItem = InventoryItemFactory.CreateItem(Rastros.choice(group))
                        sq:AddWorldInventoryItem(newItem, posX, posY, 0)
                    end
                end
            else
                if inbag then
                    local bag = InventoryItemFactory.CreateItem(Rastros.choice(Rastros.item.bag))
                    local inventory = bag:getInventory()
                    local data = Rastros.choice(group)
                    local newItem = InventoryItemFactory.CreateItem(data.item)
                    inventory:AddItem(newItem)
                    for q = 1, quantity do
                        if data.box then
                            local boxItem = InventoryItemFactory.CreateItem(data.box)
                            inventory:AddItem(boxItem)
                        end
                        if data.ammo then
                            for j=1,10 do
                                local ammoItem = InventoryItemFactory.CreateItem(data.ammo)
                                inventory:AddItem(ammoItem)
                            end 
                        end
                        if data.magazine then
                            local magazineItem = InventoryItemFactory.CreateItem(data.magazine)
                            inventory:AddItem(magazineItem)
                        end
                    end
                    sq:AddWorldInventoryItem(bag, 0.7, 0.8, 0)
                else
                    local data = Rastros.choice(group)
                    local newItem = InventoryItemFactory.CreateItem(data.item)
                    sq:AddWorldInventoryItem(newItem, 0.3, 0.2, 0)
                    for q = 1, quantity do
                        if data.box then
                            local boxItem = InventoryItemFactory.CreateItem(data.box)
                            sq:AddWorldInventoryItem(boxItem, 0.6, 0.5, 0)
                        end
                        if data.ammo then
                            for j=1,10 do
                                local ammoItem = InventoryItemFactory.CreateItem(data.ammo)
                                sq:AddWorldInventoryItem(ammoItem, 0.9, 0.8, 0)
                            end 
                        end
                        if data.magazine then
                            local magazineItem = InventoryItemFactory.CreateItem(data.magazine)
                            sq:AddWorldInventoryItem(magazineItem, 0.2, 0.1, 0)
                        end
                    end
                end 
            end
        end
    else
        if inbag then
            for i = 1, bags do
                local posX = 0.1 * i
                local posY = 0.2 * i
                local bag = InventoryItemFactory.CreateItem(Rastros.choice(Rastros.item.bag))
                local inventory = bag:getInventory()
                for j=1, #items do
                    local group = items[j]
                    if group[1] ~= nil then
                        for q = 1, quantity do
                            local newItem = InventoryItemFactory.CreateItem(Rastros.choice(group))
                            inventory:AddItem(newItem)
                        end
                    else
                        local data = Rastros.choice(group)
                        local newItem = InventoryItemFactory.CreateItem(data.item)
                        inventory:AddItem(newItem)
                        for q = 1, quantity do
                            if data.box then
                                local boxItem = InventoryItemFactory.CreateItem(data.box)
                                boxItem:setCurrentAmmoCount(boxItem:getMaxAmmo())
                                inventory:AddItem(boxItem)
                            end
                            if data.magazine then
                                local magazineItem = InventoryItemFactory.CreateItem(data.magazine)
                                magazineItem:setCurrentAmmoCount(magazineItem:getMaxAmmo())
                                inventory:AddItem(magazineItem)
                            elseif data.ammo then
                                for k=1,10 do
                                    local ammoItem = InventoryItemFactory.CreateItem(data.ammo)
                                    inventory:AddItem(ammoItem)
                                end 
                            end
                        end
                    end
                end
                sq:AddWorldInventoryItem(bag, posX, posY, 0)
            end
        else
            for i = 1, #items do
                local group = items[i]
                if group[1] ~= nil then
                    for q = 1, quantity do
                        local posX = 0.1 * i
                        local posY = 0.2 * i
                        local newItem = InventoryItemFactory.CreateItem(Rastros.choice(group))
                        sq:AddWorldInventoryItem(newItem, posX, posY, 0)
                    end
                else
                    local data = Rastros.choice(group)
                    local newItem = InventoryItemFactory.CreateItem(data.item)
                    sq:AddWorldInventoryItem(newItem, 0.4, 0.5, 0)
                    for q = 1, quantity do
                        local posX = 0.1 * i
                        local posY = 0.2 * i
                        if data.box then
                            local boxItem = InventoryItemFactory.CreateItem(data.box)
                            boxItem:setCurrentAmmoCount(boxItem:getMaxAmmo())
                            sq:AddWorldInventoryItem(boxItem, posX, posY, 0)
                        end
                        if data.magazine then
                            local magazineItem = InventoryItemFactory.CreateItem(data.magazine)
                            magazineItem:setCurrentAmmoCount(magazineItem:getMaxAmmo())
                            sq:AddWorldInventoryItem(magazineItem, posX, posY, 0)
                        elseif data.ammo then
                            for j=1,10 do
                                local ammoItem = InventoryItemFactory.CreateItem(data.ammo)
                                sq:AddWorldInventoryItem(ammoItem, posX, posY, 0)
                            end 
                        end
                    end
                end
            end
        end
    end
    flag.spawned = true
end

Rastros.spawnSpecialNote = function(sq, data)
    local note = InventoryItemFactory.CreateItem("RASTROSCAIDOS.SpecialNote")
    if note then
        local nam = Rastros.tittle .. data.indx
        local ktit = Rastros.transTitleKey .. data.indx
        local txt = Rastros.transBodyKey .. data.indx
        local tittle = nam .. " " .. getText(ktit)
        local body = getText(txt)
        note:setName(tittle)
        note:addPage(1, body)
        note:setLockedBy("Strapicarus")
        sq:AddWorldInventoryItem(note, 0.5, 0.5, 0)
        data.note.spawned = true
    else
        print("Error: Not created SpecialNote.")
    end
end

Rastros.vehicleSpawn = function (data, sq, type, randomKey, repair)
    if sq then
        local vehicle = addVehicleDebug(type, IsoDirections.getRandom(), nil, sq)
        local carKey = vehicle:createVehicleKey()
        if vehicle and carKey then
            if randomKey then
                vehicle:addKeyToWorld()
            else
                vehicle:putKeyToWorld(sq)
            end
        end
        if repair then
            vehicle:repair()
            local cond = (20 + ZombRand(8)) / 10
            vehicle:setGeneralPartCondition(cond, 80)
        end
        if vehicle:hasLightbar() then
            vehicle:setLightbarLightsMode(2)
            if Rastros.flipCoin() then
                vehicle:setLightbarSirenMode(2)
            end
        end
        data.spawned = true
    else
        print("ERROR: No Square to spawn Vehicle.................")
    end
end

Rastros.spawnZombies = function(x, y , outfits, quantity, minHealt, maxHealt, data)
    local femaleChance = nil
    if type(outfits) == "string" then
        for i=1,quantity do
            if Rastros.maleOutfits:contains(outfits) and not Rastros.femaleOutfits:contains(outfits) then
                femaleChance = 0;
            end
            if Rastros.femaleOutfits:contains(outfits) and not Rastros.maleOutfits:contains(outfits) then
                femaleChance = 100;
            end
            local healtSel = Rastros.choice({minHealt, maxHealt})
            addZombiesInOutfit(x+2, y+2, 0, 1, outfits, femaleChance, false, true, false, false, healtSel)
        end
        data.spawned = true
        return
    else
        for i=1, quantity do
            local outfit = outfit or Rastros.choice(outfits)
            if Rastros.maleOutfits:contains(outfit) and not Rastros.femaleOutfits:contains(outfit) then
                femaleChance = 0;
            end
            if Rastros.femaleOutfits:contains(outfit) and not Rastros.maleOutfits:contains(outfit) then
                femaleChance = 100;
            end
            local healtSel = Rastros.choice({minHealt, maxHealt})
            addZombiesInOutfit(x, y, 0, 1, outfit, femaleChance, false, false, false, false, healtSel)
        end
        data.spawned = true
    end
end

Rastros.indexSpawnPoints = function()
    for locName, locData in pairs(RastrosModData) do
        if type(locData) == "table" then
            for key, spawn in pairs(locData) do
                if key ~= "indx" and type(spawn) == "table" and spawn.x and spawn.y then
                    local coordKey = spawn.x .. "_" .. spawn.y
                    spawnIndex[coordKey] = { location = locData, key = key }
                end
            end
        end
    end
    indexedCoords = true
end

Rastros.onLoadGridSquare = function(sq)

    if not RastrosModData.deerhead then return end
    if not indexedCoords then Rastros.indexSpawnPoints() end
    local x, y = sq:getX(), sq:getY()
    local coordKey = x .. "_" .. y
    local entry = spawnIndex[coordKey]
    if not entry then 
        return 
    end

    local locData = entry.location
    local spawnData = locData[entry.key]
    if spawnData.spawned then
        return
    end

    if entry.key == "note" then
        Rastros.spawnSpecialNote(sq, locData)
    elseif entry.key:find("veh") then
        local carlst = Rastros.cars[spawnData.type]
        local carTypeSel = Rastros.choice(carlst)
        Rastros.vehicleSpawn(spawnData, sq, carTypeSel)
        spawnData.spawned = true
    elseif entry.key:find("item") then
        local itemlst = spawnData.type
        Rastros.spawnItems(sq, spawnData, spawnData.quantity, itemlst, spawnData.separate, spawnData.inbag, spawnData.bags)
        spawnData.spawned = true
    elseif entry.key:find("zomb") then
        local outfits = Rastros.outfits[spawnData.type]
        Rastros.spawnZombies(x, y, outfits, spawnData.quantity, 40, 80, spawnData)
        spawnData.spawned = true
    end
    return
end

Rastros.initData = function()
    RastrosModData = Rastros.getModData()
end

Events.OnGameStart.Add(Rastros.initData)
Events.LoadGridsquare.Add(Rastros.onLoadGridSquare)