--[[
 ███████╗████████╗██████╗  █████╗ ██████╗ ██╗ ██████╗ █████╗ ██████╗ ██╗   ██╗███████╗
 ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║   ██║██╔════╝
 ███████╗   ██║   ██████╔╝███████║██████╔╝██║██║     ███████║██████╔╝██║   ██║███████╗
 ╚════██║   ██║   ██╔═██╗ ██╔══██║██╔═══╝ ██║██║     ██╔══██║██╔═██╗ ██║   ██║╚════██║
 ███████║   ██║   ██║  ██╗██║  ██║██║     ██║╚██████╗██║  ██║██║  ██╗╚██████╔╝███████║
 ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ 
 
 File    : server.lua
 Author  : Strapicarus
 Version : 0.1.6

--]]


local rastrosData = {}

local function getModData()
    if not ModData.exists("datosRastros") then
        print("Loading... RastrosCaidos Data")
        rastrosData = ModData.create("datosRastros")
        rastrosData.MOD_ID = "RASTROSCAIDOS"
        rastrosData.MOD_NAME = "Rastro de los caidos"
        rastrosData.MOD_VERSION = "0.1.6"
        rastrosData.MOD_AUTHOR = "Strapicarus"
        rastrosData.MOD_DESCRIPTION = "Pequeña historia dejada en rastros por los que ya no están."
        rastrosData.deathCount = 0
        rastrosData.nota1_spwnd = false
        rastrosData.nota2_spwnd = false
        rastrosData.nota3_spwnd = false
        rastrosData.nota4_spwnd = false
        rastrosData.HasCustomSpawn = false

        return rastrosData
    else
        rastrosData = ModData.get("datosRastros")
        return rastrosData
    end
end

local function spawnSpecialNote(sq, tittle, text, n)
    local nota = InventoryItemFactory.CreateItem("RASTROSCAIDOS.SpecialNote")
    if nota then
        nota:setName(tittle)
        nota:addPage(1, text)
        sq:AddWorldInventoryItem(nota, 0.5, 0.5, 0)
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
    else
        print("Error: No se pudo crear el objeto SpecialNote.")
    end
end

local function onLoadGridSquare(sq)

    local x, y, z = sq:getX(), sq:getY(), sq:getZ()
    local rd = getModData()
    local xP1, yP1 = 5409, 6076
    local xP2, yP2 = 5611, 5899
    local xP3, yP3 = 6079, 5261
    local xP4, yP4 = 6372, 5257

    if x == xP1 and y == yP1 and rd.nota1_spwnd == false then
        spawnSpecialNote(sq, rd.nota1_tittle, rd.nota1_text, 1)
        rd.nota1_spwnd = true
        return
    end

    if x == xP2 and y == yP2 and rd.nota2_spwnd == false then
        spawnSpecialNote(sq, rd.nota2_tittle, rd.nota2_text, 2)
        rd.nota2_spwnd = true
        return
    end

    if x == xP3 and y == yP3 and rd.nota3_spwnd == false then
        spawnSpecialNote(sq, rd.nota3_tittle, rd.nota3_text, 3)
        rd.nota3_spwnd = true
        return
    end
    
    if x == xP4 and y == yP4 and rd.nota4_spwnd == false then
        spawnSpecialNote(sq, rd.nota4_tittle, rd.nota4_text, 4)
        rd.nota4_spwnd = true
        return
    end
end

local function info()
    rastrosData = getModData()
    print("Mod Loaded: " .. rastrosData.MOD_NAME .. " By " .. rastrosData.MOD_AUTHOR .. " (v." .. rastrosData.MOD_VERSION .. ")") 
end

-- local function onCreatePlayer()
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

local function serverStats()
    local players = getOnlinePlayers()
    local zombieCount = getTotalZombies()
    local rd = getModData()
    local data = {
        players = #players,
        zombies = zombieCount,
        time = getGameTime():getWorldAgeHours(),
        deaths = rd.deathCount
    }
    local file = io.open("server_status.json", "w")
    file:write(json.encode(data))
    file:close()
end

--Events.OnServerStart.Add(onServerStart)
Events.OnGameStart.Add(info)
-- Events.OnGameStart.Add(onCreatePlayer)
Events.LoadGridsquare.Add(onLoadGridSquare)
Events.OnConnected.Add(serverStats)
Events.OnDisconnect.Add(serverStats)