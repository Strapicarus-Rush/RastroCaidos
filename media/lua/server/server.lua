--[[
 ███████╗████████╗██████╗  █████╗ ██████╗ ██╗ ██████╗ █████╗ ██████╗ ██╗   ██╗███████╗
 ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║   ██║██╔════╝
 ███████╗   ██║   ██████╔╝███████║██████╔╝██║██║     ███████║██████╔╝██║   ██║███████╗
 ╚════██║   ██║   ██╔═██╗ ██╔══██║██╔═══╝ ██║██║     ██╔══██║██╔═██╗ ██║   ██║╚════██║
 ███████║   ██║   ██║  ██╗██║  ██║██║     ██║╚██████╗██║  ██║██║  ██╗╚██████╔╝███████║
 ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ 
 
 File    : server.lua
 Version : 0.2.25

--]]
local RastrosCaidosModS = {}

RastrosCaidosModS.rastrosData = {}

RastrosCaidosModS.getModData = function()
    if not ModData.exists("datosRastros") then
        print("Loading... RastrosCaidos Data")
        RastrosCaidosModS.rastrosData = ModData.create("datosRastros")
        RastrosCaidosModS.rastrosData.MOD_ID = "RASTROSCAIDOS"
        RastrosCaidosModS.rastrosData.MOD_NAME = "Rastros de los caidos"
        RastrosCaidosModS.rastrosData.MOD_VERSION = "0.1.6"
        RastrosCaidosModS.rastrosData.MOD_AUTHOR = "Strapicarus"
        RastrosCaidosModS.rastrosData.MOD_DESCRIPTION = "Pequeña historia dejada en rastros por los que ya no están."
        RastrosCaidosModS.rastrosData.deathCount = 0
        -- dearhead lake 
        RastrosCaidosModS.rastrosData.n1_spwnd = false
        RastrosCaidosModS.rastrosData.n1_veh1 = false
        RastrosCaidosModS.rastrosData.n1_veh2 = false
        RastrosCaidosModS.rastrosData.n1_veh3 = false
        RastrosCaidosModS.rastrosData.n1_item1 = false
        -- RastrosCaidosModS.rastrosData.n1_zombies = false
        -- camping shop West park
        RastrosCaidosModS.rastrosData.n2_spwnd = false
        RastrosCaidosModS.rastrosData.n2_veh1 = false
        RastrosCaidosModS.rastrosData.n2_veh2 = false
        RastrosCaidosModS.rastrosData.n2_item = false
        RastrosCaidosModS.rastrosData.n2_zombies1 = false
        -- Guns shop West park
        RastrosCaidosModS.rastrosData.n3_spwnd = false
        RastrosCaidosModS.rastrosData.n3_veh1 = false
        RastrosCaidosModS.rastrosData.n3_veh2 = false
        RastrosCaidosModS.rastrosData.n3_item = false
        RastrosCaidosModS.rastrosData.n3_zombies1 = false
        -- Ranger House Doe Valley
        RastrosCaidosModS.rastrosData.n4_spwnd = false
        RastrosCaidosModS.rastrosData.n4_veh1 = false
        RastrosCaidosModS.rastrosData.n4_veh2 = false
        RastrosCaidosModS.rastrosData.n4_item = false
        RastrosCaidosModS.rastrosData.n4_zombies1 = false
        
        RastrosCaidosModS.rastrosData.tittle = "Rastro N. "
        RastrosCaidosModS.rastrosData.ktittle = "IGUI_RASTROSCAIDOS_TITLE_"
        RastrosCaidosModS.rastrosData.text = "IGUI_RASTROSCAIDOS_BODY_"
        return RastrosCaidosModS.rastrosData
    else
        RastrosCaidosModS.rastrosData = ModData.get("datosRastros")
        return RastrosCaidosModS.rastrosData
    end
end

RastrosCaidosModS.spawnItems = function(sq, rd)
    local bag = InventoryItemFactory.CreateItem("Base.Bag_Military")
    if bag then
        -- Add loot inside the item
        local inventory = bag:getInventory()
        local axe = InventoryItemFactory.CreateItem("Base.Axe")
        inventory:AddItem(axe)
        -- inventory:AddItem("Base.Bandage")
        -- inventory:AddItem("Base.CannedBeans")
        sq:AddWorldInventoryItem(bag, 0, 0, 0)
    end
end

RastrosCaidosModS.spawnSpecialNote = function(sq, rd, n)
    local nota = InventoryItemFactory.CreateItem("RASTROSCAIDOS.SpecialNote")
    if nota then
        local ktit = rd.ktittle .. n
        local nam = rd.tittle .. n
        local txt = rd.text .. n
        local tittle = nam .. " " .. getText(ktit)
        local body = getText(txt)
        nota:setName(tittle)
        nota:addPage(1, body)
        nota:setLockedBy("Admin")
        sq:AddWorldInventoryItem(nota, 0.5, 0.5, 0)
        RastrosCaidosModS.spawnItems(sq, rd)
        
    else
        print("Error: No se pudo crear el objeto SpecialNote.")
    end
    if n == 2 then
        local sledgehammer = InventoryItemFactory.CreateItem("Base.Sledgehammer")
        if sledgehammer then
            sq:AddWorldInventoryItem(sledgehammer, 0.6, 0.6, 0)
        end
    end
    if n == 3 then
        local m16 = InventoryItemFactory.CreateItem("Base.AssaultRifle")
        if m16 then
            sq:AddWorldInventoryItem(m16, 0.4, 0.4, 0)
            local magazine1 = InventoryItemFactory.CreateItem("Base.556Clip")
            local magazine2 = InventoryItemFactory.CreateItem("Base.556Clip")
            local magazine3 = InventoryItemFactory.CreateItem("Base.556Clip")
            local magazine4 = InventoryItemFactory.CreateItem("Base.556Clip")
            if magazine1  then
                magazine1:setCurrentAmmoCount(magazine1:getMaxAmmo())
                magazine2:setCurrentAmmoCount(magazine2:getMaxAmmo())
                magazine3:setCurrentAmmoCount(magazine3:getMaxAmmo())
                magazine4:setCurrentAmmoCount(magazine4:getMaxAmmo())
                
                sq:AddWorldInventoryItem(magazine1, 0.7, 0.7, 0)
                sq:AddWorldInventoryItem(magazine2, 0.8, 0.6, 0)
                sq:AddWorldInventoryItem(magazine3, 0.9, 0.8, 0)
                sq:AddWorldInventoryItem(magazine4, 0.9, 0.8, 0)
            else
                print("Error: No se pudo crear el ítem 'Base.556Clip'.")
            end

        else
            print("Error: No se pudo crear el ítem 'Base.AssaultRifle'.")
        end
    end
end

-- local carOpts = {"Base.PickUpTruck", "Base.PickUpVan", "Base.VanSeats"}
-- local args = {type=BanditUtils.Choice(carOpts), x=spawnPoint.x-ym*3, y=spawnPoint.y-xm*3, engine=true, lights=true, lightbar=true}
RastrosCaidosModS.vehicleSpawn = function (sq, randomKey, type, direction)
    -- IsoDirections.getRandom(), IsoDirections.N, IsoDirections.S, IsoDirections.E, IsoDirections.W, IsoDirections.NE
    -- "Base.VanAmbulance" | "Base.CarLights" "Base.PickUpVanLights" "Base.PickUpTruckLights" | 
    -- "Base.PickUpVanLightsPolice" "Base.CarLightsPolice" | "Base.PickUpVanMccoy" "Base.PickUpTruckMccoy" "Base.VanSpecial"

    -- local square = getCell():getGridSquare(args.x, args.y, 0)
    if sq then
        direction = direction or IsoDirections.getRandom()
        local vehicle = addVehicleDebug(type, direction, nil, sq)
        if vehicle then
            vehicle:repair()
            -- local iugsrandom= ZombRand(4)+1
            if randomKey then
                local sel = ZombRand(3) + 1
                vehicle:setHotwired(false)
                local carKey = vehicle:createVehicleKey()
                print("CREATED KEYCAR -----" .. carKey)
                vehicle:trySpawnKey()
                local currentKey = vehicle:getCurrentKey()
                print("CURRENT CARKEY ------" .. currentKey)
                if sel == 3 then
                    print("KEY ON INGNITION")
                    vehicle:putKeyInIgnition(carKey)
                    vehicle:setKeysInIgnition(true)
                    vehicle:trySpawnKey()
                elseif sel == 2 then
                    print("KEY ON World")
                    vehicle:addKeyToWorld()
                    vehicle:putKeyToWorld(sq)
                    vehicle:trySpawnKey()
                elseif sel == 1 then
                    print("KEY ON SQUARE")
                    vehicle:addKeyToWorld()
                    -- vehicle:addKeyToSquare(sq)
                    vehicle:putKeyToWorld(sq)
                    vehicle:trySpawnKey()
                end
            end
            local testKey = vehicle:getCurrentKey()
            local x = testKey.containerX
            local y = testKey.containerY
            print("KEY SPAWNED ----------------" .. x .. " - " .. y)

            print(vehicle:getKeySpawned())
            if not vehicle:getKeySpawned() then
                print("KEY HOTWIRE")
                vehicle:setHotwired(true)
            end
            -- if iugsrandom == 1 then
            --     vehicle:addKeyToGloveBox()
            -- elseif iugsrandom == 2 then
            --     vehicle:setHotwired(true)
            -- elseif iugsrandom == 3 then
            --     vehicle:addKeyToSquare(sq)
            -- else
            --     vehicle:addKeyToWorld()
            local cond = (20 + ZombRand(8)) / 10
            vehicle:setGeneralPartCondition(cond, 80)
        end
    else
        print("ERROR: No Square to spawn Vehicle.................")
    end

end

RastrosCaidosModS.spawnZombies = function(x, y , outfits, quanty, minHealt, maxHealt)
    -- HazardSuit, Hobbo, HospitalPatient, 
    -- Police, PoliceState, PoliceRiot, PrivateMilitia, Ranger, AmbulanceDriver,
    -- Survivalist,  Camper, Hunter, Fisherman, Gas2Go, Generic01-05,
    -- AirCrew, ArmyCamoDesert, ArmyCamoGreen,  Fireman,  ShellSuit_Black-blue-green-pink 
    local femaleChance = nil
    local maleOutfits = getAllOutfits(false);
    local femaleOutfits = getAllOutfits(true);
    for i=1,quanty do
        local outfitfSel = ZombRand(1, #outfits)
        local outfit = outfits[outfitfSel]
        if maleOutfits:contains(outfit) and not femaleOutfits:contains(outfit) then
            femaleChance = 0;
        end
        if femaleOutfits:contains(outfit) and not maleOutfits:contains(outfit) then
            femaleChance = 100;
        end
        local healtSel = ZombRand(minHealt, maxHealt)
        addZombiesInOutfit(x+2, y+2, 0, 1, outfit, femaleChance, false, true, false, false, healtSel)
    end
    
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

RastrosCaidosModS.onLoadGridSquare = function(sq)

    local x, y = sq:getX(), sq:getY()
    local rd = RastrosCaidosModS.getModData()

    local xP1, yP1 = 4672, 8612 -- Deerhead lake Ranger station
    local xP2, yP2 = 3805, 8548 -- Camping store west Deo Valley
    local xP3, yP3 = 3807, 8513 -- Guns store west Doe Valley
    local xP4, yP4 = 5579, 9720 -- Ranger House Doe Valley



    -- # 1 --- Deerhead lake park Ranger station
    if x == xP1 and y == yP1 and rd.n1_spwnd == false then
        RastrosCaidosModS.spawnSpecialNote(sq, rd, 1)
        rd.n1_spwnd = true
        return
    end
    if x == 4659 and y == 8616 and rd.n1_veh1 == false then
        local carTypeOpt = {"Base.PickUpVanLightsPolice","Base.CarLights", "Base.PickUpVanLights", "Base.PickUpTruckLights", "Base.PickUpTruck"}
        local carTypeSel1= carTypeOpt[ZombRand(#carTypeOpt)+1]
        RastrosCaidosModS.vehicleSpawn(sq, true, carTypeSel1)
        rd.n1_veh1 = true
    end
    if x == 4664 and y == 8616 and rd.n1_veh2 == false then
        local carTypeOpt = {"Base.CarLights", "Base.PickUpVanLights", "Base.PickUpTruckLights", "Base.PickUpTruck"}
        local carTypeSel2= carTypeOpt[ZombRand(#carTypeOpt)+1]
        RastrosCaidosModS.vehicleSpawn(sq, true, carTypeSel2)
        rd.n1_veh2 = true
    end
    if x == 4669 and y == 8616 and rd.n1_veh3 == false then
        local carTypeOpt = {"Base.CarLights", "Base.PickUpVanLights", "Base.PickUpTruckLights", "Base.PickUpTruck"}
        local carTypeSel2= carTypeOpt[ZombRand(#carTypeOpt)+1]
        RastrosCaidosModS.vehicleSpawn(sq, true, carTypeSel2)
        rd.n1_veh3 = true
    end
    -- --- 

    -- # 2 --- Camping store west park
    if x == xP2 and y == yP2 and rd.n2_spwnd == false then
        RastrosCaidosModS.spawnSpecialNote(sq, rd,  2)
        rd.n2_spwnd = true
        return
    end
    if x == 3790 and y == 8550 and rd.n2_zombies1 == false then
        local outfits = { "HazardSuit", "Hobbo", "Ranger", "AmbulanceDriver", "Camper", "Hunter", "Fisherman", "HospitalPatient"}
        RastrosCaidosModS.spawnZombies(3788, 8548, outfits, 11, 40, 80)
        rd.n2_zombies1 = true
    end
    if x == 3788 and y == 8548 and rd.n2_veh1 == false then
         RastrosCaidosModS.vehicleSpawn(sq, true, "Base.VanAmbulance")
         rd.n2_veh1 = true
    end
    if x == 3775 and y == 8546 and rd.n2_veh2 == false then
         RastrosCaidosModS.vehicleSpawn(sq, true, "Base.PickUpVanLightsPolice")
         rd.n2_veh2 = true
    end
    -- ---

    -- # 3 --- Gun store west park
    if x == xP3 and y == yP3 and rd.n3_spwnd == false then
        RastrosCaidosModS.spawnSpecialNote(sq, rd, 3)
        rd.n3_spwnd = true
        return
    end
    if x == 3796 and y == 8494 and rd.n3_veh1 == false then
         RastrosCaidosModS.vehicleSpawn(sq, true, "Base.PickUpVanLightsPolice")
         rd.n3_veh1 = true
    end
    if x == 3791 and y == 8498 and rd.n3_veh2 == false then
         RastrosCaidosModS.vehicleSpawn(sq, true, "Base.VanSpecial")
         rd.n3_veh2 = true
    end
    if x == 3799 and y == 8489 and rd.n3_zombies1 == false then
        local outfits = { "HazardSuit", "PrivateMilitia", "PoliceRiot" }
        RastrosCaidosModS.spawnZombies(3788, 8548, outfits, 11, 40, 80)
        rd.n3_zombies1 = true
    end
    -- ---

    -- # 4 --- Ranger House Doe Valley
    if x == xP4 and y == yP4 and rd.n4_spwnd == false then
        RastrosCaidosModS.spawnSpecialNote(sq, rd, 4)
        rd.n4_spwnd = true
        return
    end
    -- ---
end

RastrosCaidosModS.info = function()
    local rastrosData = RastrosCaidosModS.getModData()
    print("Mod Loaded: " .. rastrosData.MOD_NAME .. " By " .. rastrosData.MOD_AUTHOR .. " (v." .. rastrosData.MOD_VERSION .. ")") 
end

-- RastrosCaidosModS.onCreatePlayer = function()
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


-- RastrosCaidosModS.serverStats = function()
--     local players = getOnlinePlayers()
--     local zombieCount = getTotalZombies()
--     local rd = getModData()

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

-- RastrosCaidosModS.serverStats = function()
--     local players = getOnlinePlayers()
--     local zombieCount = getTotalZombies()
--     local rd = getModData()
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
-- Events.OnGameBoot.Add(RastrosCaidosModS.setSpawn)
Events.OnGameStart.Add(RastrosCaidosModS.info)
-- Events.OnGameStart.Add(onCreatePlayer)
Events.LoadGridsquare.Add(RastrosCaidosModS.onLoadGridSquare)
-- Events.OnConnected.Add(serverStats)
-- Events.OnDisconnect.Add(serverStats)