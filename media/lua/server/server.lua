--[[
 ███████╗████████╗██████╗  █████╗ ██████╗ ██╗ ██████╗ █████╗ ██████╗ ██╗   ██╗███████╗
 ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║   ██║██╔════╝
 ███████╗   ██║   ██████╔╝███████║██████╔╝██║██║     ███████║██████╔╝██║   ██║███████╗
 ╚════██║   ██║   ██╔═██╗ ██╔══██║██╔═══╝ ██║██║     ██╔══██║██╔═██╗ ██║   ██║╚════██║
 ███████║   ██║   ██║  ██╗██║  ██║██║     ██║╚██████╗██║  ██║██║  ██╗╚██████╔╝███████║
 ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ 
 
 File    : server.lua
 Version : 0.2.48

--]]
Rastros = Rastros or {}
Rastros.maleOutfits = getAllOutfits(false);
Rastros.femaleOutfits = getAllOutfits(true);
Rastros.Data = Rastros.Data  or {}

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
        "Base.Sportsbottle",
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

local getModData = function()
    if not ModData.exists("datosRastros") then
        Rastros.Data = ModData.create("datosRastros")
        Rastros.Data.deathCount = 0

        -- deerhead lake 
        Rastros.Data.deerhead = {
            indx = 1,
            note = { spawned = false, x = 4675, y = 8608 },
            veh1 = { spawned = false, x = 4657, y = 8616 },
            veh2 = { spawned = false, x = 4664, y = 8620 },
            veh3 = { spawned = false, x = 4671, y = 8623 },
            item1 = { spawned = false, x = 4672, y = 8612 },
            zomb1 = { spawned = false, x = 4670, y = 8636 }
        }
        
        -- camping shop West park
        Rastros.Data.campingwest = {
            indx = 2,
            note = { spawned = false, x = 3801, y = 8546 },
            veh1 = { spawned = false, x = 3788, y = 8563 },
            veh2 = { spawned = false, x = 3787, y = 8574 },
            veh3 = { spawned = false, x = 3773, y = 8574 },
            item1 = { spawned = false, x = 3808, y = 8555 },
            zomb1 = { spawned = false, x = 3790, y = 8540 }
        }
        -- -- Guns shop West park
        Rastros.Data.gunswest = {
            indx = 3,
            note = { spawned = false, x = 3804, y = 8509 },
            veh1 = { spawned = false, x = 3794, y = 8496 },
            veh2 = { spawned = false, x = 3780, y = 8490 },
            veh3 = { spawned = false, x = 3790, y = 8519 },
            item1 = { spawned = false, x = 3798, y = 8513 },
            item2 = { spawned = false, x = 3796, y = 8510 },
            item3 = { spawned = false, x = 3795, y = 8509 },
            item4 = { spawned = false, x = 3801, y = 8511 },
            zomb1 = { spawned = false, x = 3787, y = 8504 }
        }
        -- -- Ranger House west Doe Valley
        Rastros.Data.rangerhouse = {
            indx = 4,
            note = { spawned = false, x = 5580, y = 9720 },
            veh1 = { spawned = false, x = 5586, y = 9738 },
            veh2 = { spawned = false, x = 5618, y = 9739 },
            veh3 = { spawned = false, x = 5472, y = 9545 },
            item1 = { spawned = false, x = 5473, y = 9534 },
            item2 = { spawned = false, x = 5594, y = 9725 },
            zomb1 = { spawned = false, x = 5578, y = 9720 },
            zomb2 = { spawned = false, x = 5578, y = 9724 },
            zomb3 = { spawned = false, x = 5467, y = 9533 }
        }
        -- Militar surplus store West Doe valle
        Rastros.Data.militarsurplus = {
            indx = 5,
            note = { spawned = false, x = 5464, y = 9523 },
            veh1 = { spawned = false, x = 5416, y = 9546 },
            veh2 = { spawned = false, x = 5414, y = 9536 },
            veh3 = { spawned = false, x = 5482, y = 9599 },
            item1 = { spawned = false, x = 5408, y = 9535 },
            zomb1 = { spawned = false, x = 5420, y = 9540 }
        }
        -- West Riverside farm
        Rastros.Data.westriversidefarm = {
            indx = 6,
            note = { spawned = false, x = 4257, y = 5874 },
            veh1 = { spawned = false, x = 4248, y = 5861 },
            item1 = { spawned = false, x = 4257, y = 5875 },
            zomb1 = { spawned = false, x = 4258, y = 5881 }
        }
        
        Rastros.Data.tittle = "Rastro N. "
        Rastros.Data.transTitleKey = "IGUI_RASTROSCAIDOS_TITLE_"
        Rastros.Data.transBodyKey = "IGUI_RASTROSCAIDOS_BODY_"
        return Rastros.Data
    else
        Rastros.Data = ModData.get("datosRastros")
        return Rastros.Data
    end
end

Rastros.choice = function(lst)
    if lst[1] ~= nil then
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
        if flag ~= nil then
            flag.spawned = true
        end
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
                            sq:AddWorldInventoryItem(bag, 0.6, 0.5, 0)
                        end
                        if data.ammo then
                            for j=1,10 do
                                local ammoItem = InventoryItemFactory.CreateItem(data.ammo)
                                sq:AddWorldInventoryItem(bag, 0.9, 0.8, 0)
                            end 
                        end
                        if data.magazine then
                            local magazineItem = InventoryItemFactory.CreateItem(data.magazine)
                            sq:AddWorldInventoryItem(bag, 0.2, 0.1, 0)
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

local spawnSpecialNote = function(sq, data)
    local note = InventoryItemFactory.CreateItem("RASTROSCAIDOS.SpecialNote")
    if note then
        local nam = Rastros.Data.tittle .. data.indx
        local ktit = Rastros.Data.transTitleKey .. data.indx
        local txt = Rastros.Data.transBodyKey .. data.indx
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

Rastros.vehicleSpawn = function (data, sq, type, randomKey, repaired)
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
        if repaired then
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
    local outfit = nil
    if type(outfits) == "string" then
        outfit = outfits
    else
        outfit = Rastros.choice(outfits)
    end
    local femaleChance = nil
    for i=1,quantity do
        
        if Rastros.maleOutfits:contains(outfit) and not Rastros.femaleOutfits:contains(outfit) then
            femaleChance = 0;
        end
        if Rastros.femaleOutfits:contains(outfit) and not Rastros.maleOutfits:contains(outfit) then
            femaleChance = 100;
        end
        local healtSel = Rastros.choice({minHealt, maxHealt})
        addZombiesInOutfit(x+2, y+2, 0, 1, outfit, femaleChance, false, true, false, false, healtSel)
    end
    data.spawned = true
end

local onLoadGridSquare = function(sq)

    if not Rastros.Data.deerhead then return end
    local x, y = sq:getX(), sq:getY()

    -- # 1 --- Deerhead lake park Ranger station
    if Rastros.Data.deerhead.note.spawned == false then
        if x == Rastros.Data.deerhead.note.x and y == Rastros.Data.deerhead.note.y then
            spawnSpecialNote(sq, Rastros.Data.deerhead)
            return
        end
    end
    if Rastros.Data.deerhead.zomb1.spawned == false then
        if x == Rastros.Data.deerhead.zomb1.x and y == Rastros.Data.deerhead.zomb1.y then
            Rastros.spawnZombies(x, y, Rastros.outfits.firstResponder, 6, 40, 80, Rastros.Data.deerhead.zomb1)
            return
        end
    end
    if Rastros.Data.deerhead.item1.spawned == false then
        if x == Rastros.Data.deerhead.item1.x and y == Rastros.Data.deerhead.item1.y then
            local itemlst = {Rastros.item.tool, Rastros.fireArm.oneHanded}
            Rastros.spawnItems(sq, Rastros.Data.deerhead.item1, 3, itemlst, false, true, 3)
            return
        end
    end
    if Rastros.Data.deerhead.veh1.spawned == false then
        if x == Rastros.Data.deerhead.veh1.x and y == Rastros.Data.deerhead.veh1.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.deerhead.veh1, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.deerhead.veh2.spawned == false then
        if x == Rastros.Data.deerhead.veh2.x and y == Rastros.Data.deerhead.veh2.y then
            local carTypeSel= Rastros.choice(Rastros.cars.offRoad)
            Rastros.vehicleSpawn(Rastros.Data.deerhead.veh2, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.deerhead.veh3.spawned == false then
        if x == Rastros.Data.deerhead.veh3.x and y == Rastros.Data.deerhead.veh3.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.deerhead.veh3, sq, carTypeSel)
            return
        end
    end
    -- --- 

    -- # 2 --- Camping store west park
    if Rastros.Data.campingwest.note.spawned == false then
        if x == Rastros.Data.campingwest.note.x and y == Rastros.Data.campingwest.note.y then
            spawnSpecialNote(sq, Rastros.Data.campingwest)
            return
        end
    end
    if Rastros.Data.campingwest.zomb1.spawned == false then
        if x == Rastros.Data.campingwest.zomb1.x and y == Rastros.Data.campingwest.zomb1.y then
            Rastros.spawnZombies(x, y, Rastros.outfits.firstResponder, 8, 40, 80, Rastros.Data.campingwest.zomb1 )
            return
        end
    end
    if Rastros.Data.campingwest.veh1.spawned == false then
        if x == Rastros.Data.campingwest.veh1.x and y == Rastros.Data.campingwest.veh1.y then
            local carTypeSel= Rastros.choice(Rastros.cars.offRoad)
            Rastros.vehicleSpawn(Rastros.Data.campingwest.veh1, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.campingwest.veh2.spawned == false then
        if x == Rastros.Data.campingwest.veh2.x and y == Rastros.Data.campingwest.veh2.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.campingwest.veh2, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.campingwest.veh3.spawned == false then
        if x == Rastros.Data.campingwest.veh3.x and y == Rastros.Data.campingwest.veh3.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.campingwest.veh3, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.campingwest.item1.spawned == false then
        if x == Rastros.Data.campingwest.item1.x and y == Rastros.Data.campingwest.item1.y then
            local itemlst = {Rastros.item.oneHandedWeapon, Rastros.fireArm.oneHanded}
            Rastros.spawnItems(sq, Rastros.Data.campingwest.item1, 2, itemlst, false, true, 1)
            return
        end
    end
    -- -- ---

    -- -- # 3 --- Gun store west park Rastros.Data.gunswest
    if Rastros.Data.gunswest.note.spawned == false then
        if x == Rastros.Data.gunswest.note.x and y == Rastros.Data.gunswest.note.y then
            spawnSpecialNote(sq, Rastros.Data.gunswest)
            return
        end
    end
    if Rastros.Data.gunswest.zomb1.spawned == false then
        if x == Rastros.Data.gunswest.zomb1.x and y == Rastros.Data.gunswest.zomb1.y then
            Rastros.spawnZombies(x, y, Rastros.outfits.firstResponder, 8, 40, 80, Rastros.Data.gunswest.zomb1 )
            return
        end
    end
    if Rastros.Data.gunswest.veh1.spawned == false then
        if x == Rastros.Data.gunswest.veh1.x and y == Rastros.Data.gunswest.veh1.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.gunswest.veh1, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.gunswest.veh2.spawned == false then
        if x == Rastros.Data.gunswest.veh2.x and y == Rastros.Data.gunswest.veh2.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.gunswest.veh2, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.gunswest.veh3.spawned == false then
        if x == Rastros.Data.gunswest.veh3.x and y == Rastros.Data.gunswest.veh3.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.gunswest.veh3, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.gunswest.item1.spawned == false then
        if x == Rastros.Data.gunswest.item1.x and y == Rastros.Data.gunswest.item1.y then
            local itemlst = {Rastros.fireArm.oneHanded, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}
            Rastros.spawnItems(sq, Rastros.Data.gunswest.item1, 1, itemlst, true, false)
            return
        end
    end
    if Rastros.Data.gunswest.item2.spawned == false then
        if x == Rastros.Data.gunswest.item2.x and y == Rastros.Data.gunswest.item2.y then
            local itemlst = {Rastros.fireArm.oneHanded, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}
            Rastros.spawnItems(sq, Rastros.Data.gunswest.item2, 1, itemlst, true, false)
            return
        end
    end
    if Rastros.Data.gunswest.item3.spawned == false then
        if x == Rastros.Data.gunswest.item3.x and y == Rastros.Data.gunswest.item3.y then
            local itemlst = {Rastros.fireArm.oneHanded, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}
            Rastros.spawnItems(sq, Rastros.Data.gunswest.item3, 1, itemlst, true, false)
            return
        end
    end
    if Rastros.Data.gunswest.item4.spawned == false then
        if x == Rastros.Data.gunswest.item4.x and y == Rastros.Data.gunswest.item4.y then
            local itemlst = {Rastros.fireArm.oneHanded, Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}
            Rastros.spawnItems(sq, Rastros.Data.gunswest.item4, 1, itemlst, true, false)
            return
        end
    end
    -- ---
    
    -- # 4 --- Ranger house Doe valley
    if Rastros.Data.rangerhouse.note.spawned == false then
        if x == Rastros.Data.rangerhouse.note.x and y == Rastros.Data.rangerhouse.note.y then
            spawnSpecialNote(sq, Rastros.Data.rangerhouse)
            return
        end
    end
    if Rastros.Data.rangerhouse.zomb1.spawned == false then
        if x == Rastros.Data.rangerhouse.zomb1.x and y == Rastros.Data.rangerhouse.zomb1.y then
            Rastros.spawnZombies(x, y, "Ranger", 2, 40, 80, Rastros.Data.rangerhouse.zomb1 )
            return
        end
    end
    if Rastros.Data.rangerhouse.zomb2.spawned == false then
        if x == Rastros.Data.rangerhouse.zomb2.x and y == Rastros.Data.rangerhouse.zomb2.y then
            Rastros.spawnZombies(x, y, "Ranger", 2, 40, 80, Rastros.Data.rangerhouse.zomb2 )
            return
        end
    end
    if Rastros.Data.rangerhouse.zomb3.spawned == false then
        if x == Rastros.Data.rangerhouse.zomb3.x and y == Rastros.Data.rangerhouse.zomb3.y then
            Rastros.spawnZombies(x, y, Rastros.outfits.firstResponder, 10, 40, 80, Rastros.Data.rangerhouse.zomb3 )
            return
        end
    end
    if Rastros.Data.rangerhouse.veh1.spawned == false then
        if x == Rastros.Data.rangerhouse.veh1.x and y == Rastros.Data.rangerhouse.veh1.y then
            local carTypeSel= Rastros.choice(Rastros.cars.offRoad)
            Rastros.vehicleSpawn(Rastros.Data.rangerhouse.veh1, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.rangerhouse.veh2.spawned == false then
        if x == Rastros.Data.rangerhouse.veh2.x and y == Rastros.Data.rangerhouse.veh2.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.rangerhouse.veh2, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.rangerhouse.veh3.spawned == false then
        if x == Rastros.Data.rangerhouse.veh3.x and y == Rastros.Data.rangerhouse.veh3.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.rangerhouse.veh3, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.rangerhouse.item1.spawned == false then
        if x == Rastros.Data.rangerhouse.item1.x and y == Rastros.Data.rangerhouse.item1.y then
            local itemlst = {Rastros.item.bandages, Rastros.item.pharma, Rastros.item.medicalequip}
            Rastros.spawnItems(sq, Rastros.Data.rangerhouse.item1, 2, itemlst, false, true, 1)
            return
        end
    end
    if Rastros.Data.rangerhouse.item2.spawned == false then
        if x == Rastros.Data.rangerhouse.item2.x and y == Rastros.Data.rangerhouse.item2.y then
            local itemlst = {Rastros.fireArm.twoHanded, Rastros.item.oneHandedWeapon}
            Rastros.spawnItems(sq, Rastros.Data.rangerhouse.item2, 2, itemlst, false, true, 1)
            return
        end
    end
    -- -- ---

    -- # 5 --- Militar surplus store West Doe valle
    if Rastros.Data.militarsurplus.note.spawned == false then
        if x == Rastros.Data.militarsurplus.note.x and y == Rastros.Data.militarsurplus.note.y then
            spawnSpecialNote(sq, Rastros.Data.militarsurplus)
            return
        end
    end
    if Rastros.Data.militarsurplus.zomb1.spawned == false then
        if x == Rastros.Data.militarsurplus.zomb1.x and y == Rastros.Data.militarsurplus.zomb1.y then
            Rastros.spawnZombies(x, y, Rastros.outfits.firstResponder, 6, 40, 80, Rastros.Data.militarsurplus.zomb1)
            return
        end
    end
    if Rastros.Data.militarsurplus.item1.spawned == false then
        if x == Rastros.Data.militarsurplus.item1.x and y == Rastros.Data.militarsurplus.item1.y then
            local itemlst = {Rastros.item.tool, Rastros.fireArm.oneHanded}
            Rastros.spawnItems(sq, Rastros.Data.militarsurplus.item1, 3, itemlst, false, true, 3)
            return
        end
    end
    if Rastros.Data.militarsurplus.veh1.spawned == false then
        if x == Rastros.Data.militarsurplus.veh1.x and y == Rastros.Data.militarsurplus.veh1.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.militarsurplus.veh1, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.militarsurplus.veh2.spawned == false then
        if x == Rastros.Data.militarsurplus.veh2.x and y == Rastros.Data.militarsurplus.veh2.y then
            local carTypeSel= Rastros.choice(Rastros.cars.offRoad)
            Rastros.vehicleSpawn(Rastros.Data.militarsurplus.veh2, sq, carTypeSel)
            return
        end
    end
    if Rastros.Data.militarsurplus.veh3.spawned == false then
        if x == Rastros.Data.militarsurplus.veh3.x and y == Rastros.Data.militarsurplus.veh3.y then
            local carTypeSel= Rastros.choice(Rastros.cars.firstResponder)
            Rastros.vehicleSpawn(Rastros.Data.militarsurplus.veh3, sq, carTypeSel)
            return
        end
    end
    -- ---
        
    -- # 6 --- West Riverside farm
    if Rastros.Data.westriversidefarm.note.spawned == false then
        if x == Rastros.Data.westriversidefarm.note.x and y == Rastros.Data.westriversidefarm.note.y then
            spawnSpecialNote(sq, Rastros.Data.westriversidefarm)
            return
        end
    end
    if Rastros.Data.westriversidefarm.zomb1.spawned == false then
        if x == Rastros.Data.westriversidefarm.zomb1.x and y == Rastros.Data.westriversidefarm.zomb1.y then
            Rastros.spawnZombies(x, y, Rastros.outfits.camping, 2, 40, 80, Rastros.Data.westriversidefarm.zomb1)
            return
        end
    end
    if Rastros.Data.westriversidefarm.item1.spawned == false then
        if x == Rastros.Data.westriversidefarm.item1.x and y == Rastros.Data.westriversidefarm.item1.y then
            local itemlst = {Rastros.item.water, Rastros.item.cannedfood}
            Rastros.spawnItems(sq, Rastros.Data.westriversidefarm.item1, 3, itemlst, false, true, 1)
            return
        end
    end
    if Rastros.Data.westriversidefarm.veh1.spawned == false then
        if x == Rastros.Data.westriversidefarm.veh1.x and y == Rastros.Data.westriversidefarm.veh1.y then
            local carTypeSel= Rastros.choice(Rastros.cars.offRoad)
            Rastros.vehicleSpawn(Rastros.Data.westriversidefarm.veh1, sq, carTypeSel, false, false)
            return
        end
    end
    -- ---
end

local initData = function()
    Rastros.Data = getModData()
end

-- function CloneIsoPlayer(originalCharacter)
--     -- Create a new temporary IsoPlayer at the same position as the original player
--     local tempPlayer = IsoPlayer.new(nil, nil, originalCharacter:getX(), originalCharacter:getY(), originalCharacter:getZ())
--     -- Copy relevant properties from the original player to the temporary player
--     -- tempPlayer:setForname(originalCharacter:getForname())
--     -- tempPlayer:setSurname(originalCharacter:getSurname())
--     tempPlayer:setGhostMode(true) -- Ensure the temp player is not interactable
--     tempPlayer:setGodMod(true)    -- Ensure the temp player cannot die
--     tempPlayer:setPrimaryHandItem(originalCharacter:getPrimaryHandItem())
--     tempPlayer:setSecondaryHandItem(originalCharacter:getSecondaryHandItem())
--     tempPlayer:setSceneCulled(false)
--     tempPlayer:setNPC(true)

--     -- You can copy more properties as needed, depending on what you need for the Hit function

--     return tempPlayer
-- end

-- public static IsoDeadBody createRandomDeadBody(IsoGridSquare square,
-- IsoDirections directions,
-- int int1,
-- int int2,
-- java.lang.String string)

-- Rastros.onCreatePlayer = function()
--     -- local spawnX, spawnY, spawnZ = 4171, 7840, 0
--     -- local p = getPlayer()
--     -- print("player creation")
--     -- p:setPosition(spawnX, spawnY, 0)
--     print("server ----- onCreatePlayer")
--     local p = getPlayer()
--     local gen = p:isFemale() and "_F" or "_M"
--     local txKey = "IGUI_RASTROSCAIDOS_ALIVE" .. gen
--     local tx = getText(txKey)
--     print(tx)
--     if tx and tx ~= "" then
--         p:Say(tx)
--     else
--         print("Error: Traducción no encontrada para la clave: " .. txKey)
--     end
-- end

-- function OnTick()
--     -- if isClient() then return end
--     for playerIndex=0, getNumActivePlayers()-1 do
--         local player = getSpecificPlayer(playerIndex);
--         if player and not player:isDead() then
--             CheckPlayerVehicle(player);
--         end
--     end
-- end

-- function CheckPlayerVehicle(player)
--     local vehicle = player.getVehicle and player:getVehicle() or nil
--     if vehicle == nil or not vehicle:isDriver(player) then return end

--     local partCount = vehicle:getPartCount();
--     for i=0, partCount-1 do
--         local part = vehicle:getPartByIndex(i);
--         local partHP = part:getCondition();
        
--         if (partHP < 100) then
--             part:setCondition(100);
--             partHP = part:getCondition();
--             print(part:getId() .. " current hp " .. partHP);
--         end
--     end
-- end

-- Events.OnTick.Add(OnTick);


-- Rastros.serverStats = function()
--     local players = getOnlinePlayers()
--     local zombieCount = getTotalZombies()
--     local rd = Rastros.getModData()

--     -- Crear el contenido del archivo en texto plano
--     local data = "Players: " .. #players ..
--                  "\nZombies: " .. zombieCount ..
--                  "\nTime: " .. getGameTime():getWorldAgeHours() ..
--                  "\nDeaths: " .. (rd.deathCount or 0) .. "\n"

--     print("Trying to create file serverStats.txt")

--     -- Usar la API de archivos de Project Zomboid
--     local file = getFileWriter(rd.MOD_ID ,"serverStats.txt", true, false) 
--     if file then
--         file:write(data) -- Escribir los datos en el archivo
--         file:close() -- Cerrar el archivo
--         print("File serverStats.txt created successfully")
--     else
--         print("Error: Could not create file serverStats.txt")
--     end
-- end

-- Rastros.serverStats = function()
--     local players = getOnlinePlayers()
--     local zombieCount = getTotalZombies()
--     local rd = Rastros.getModData()
--     local currentTime = getGameTime():getWorldAgeHours()

--     print("Trying to create file serverStats.txt")

--     -- Abrir el archivo para escritura usando getModFileWriter:
--     local file = getModFileWriter(rd.MOD_ID, "serverStats.txt", true, false)
--     if file then
--         file:write("Players: " .. #players .. "\r\n")
--         file:write("Zombies: " .. zombieCount .. "\r\n")
--         file:write("Time: " .. currentTime .. "\r\n")
--         file:write("Deaths: " .. (rd.deathCount or 0) .. "\r\n")
--         file:close()
--         print("File serverStats.txt created successfully")
--     else
--         print("Error: Could not create file serverStats.txt")
--     end
-- end

-- public static void disconnectPlayer(IsoPlayer player, UdpConnection connection)

-- void kick(UdpConnection connection,String description,String reason)

-- static UdpConnection getConnectionFromPlayer(IsoPlayer player)

-- SpawnOrigin(int int1, int int2, int int3, int int4)

--Events.OnServerStart.Add(onServerStart)
-- Events.OnGameBoot.Add(Rastros.setSpawn)
Events.OnGameStart.Add(initData)
-- Events.OnGameStart.Add(onCreatePlayer)
Events.LoadGridsquare.Add(onLoadGridSquare)
-- Events.OnConnected.Add(serverStats)
-- Events.OnDisconnect.Add(serverStats)