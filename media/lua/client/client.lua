--[[
 ███████╗████████╗██████╗  █████╗ ██████╗ ██╗ ██████╗ █████╗ ██████╗ ██╗   ██╗███████╗
 ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║   ██║██╔════╝
 ███████╗   ██║   ██████╔╝███████║██████╔╝██║██║     ███████║██████╔╝██║   ██║███████╗
 ╚════██║   ██║   ██╔═██╗ ██╔══██║██╔═══╝ ██║██║     ██╔══██║██╔═██╗ ██║   ██║╚════██║
 ███████║   ██║   ██║  ██╗██║  ██║██║     ██║╚██████╗██║  ██║██║  ██╗╚██████╔╝███████║
 ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ 
 
 File    : client.lua
 Version : 0.2.69
--]]

local RastrosCaidosMod = RastrosCaidosMod or {}

local gen = "_M"
local timerLastSay = 0
local waitToSpeak = 0.02
local itemLastCheck = 0
local playerPanicLvl = 0
local panicLastCheck = 0
local panicLastLow = 0
local dmgLastCheck = 0
local otherRandom = newrandom()

local keyData = {
    PANIC = {
        key = "IGUI_RASTROSCAIDOS_PANIC_",
        timer = 0,
        lowtimer = 0,
        wait = 1.3,
        lowwait = 2.1,
        len = 46
    },
    ATTACK = {
        key = "IGUI_RASTROSCAIDOS_ATTACK_",
        timer = 0,
        wait = 0.7,
        len = 16
    },
    POISON = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_POISON_",
        timer = 0,
        wait = 1.6,
        len = 5
    },
    HUNGRY = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_HUNGRY_",
        timer = 0,
        wait = 1.3,
        len = 5
    },
    SICK = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_SICK_",
        timer = 0,
        wait = 1.4,
        len = 5
    },
    THIRST = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_THIRST_",
        timer = 0,
        wait = 1.1,
        len = 5
    },
    BLEEDING = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_BLEEDING_",
        timer = 0,
        wait = 0.8,
        len = 3,
        noWait = true
    },
    HEAVYLOAD = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_HEAVYLOAD_",
        timer = 0,
        wait = 1.5,
        len = 3
    },
    INFECTION = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_INFECTION_",
        timer = 0,
        wait = 2.2,
        len = 3
    },
    LOWWEIGHT = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_LOWWEIGHT_",
        timer = 0,
        wait = 1.6,
        len = 3
    },
    FALLDOWN = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_FALLDOWN_",
        timer = 0,
        wait = 1.6,
        len = 3
    },
    WEAPONHIT = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_WEAPONHIT_",
        timer = 0,
        wait = 0.8,
        len = 3
    },
    CARHITDAMAGE = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_CARHITDAMAGE_",
        timer = 0,
        wait = 0.5,
        len = 3
    },
    CARCRASHDAMAGE = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_CARCRASHDAMAGE_",
        timer = 0,
        wait = 1.9,
        len = 3
    },
    HOUSE = {
        key = "IGUI_RASTROSCAIDOS_HOUSE_",
        timer = 0,
        wait = 1.9,
        len = 3
    },
    ROOM = {
        key = "IGUI_RASTROSCAIDOS_ROOM_",
        timer = 0,
        wait = 1.3,
        len = 7
    },
    MOBILEX = {
        key = "IGUI_RASTROSCAIDOS_MOBILEX_",
        timer = 0,
        wait = 2.4,
        len = 7
    },
    MOBILIN = {
        key = "IGUI_RASTROSCAIDOS_MOBILIN_",
        timer = 0,
        wait = 3.2,
        len = 10
    },
    MOBILSEAT = {
        key = "IGUI_RASTROSCAIDOS_MOBILSEAT_",
        timer = 0,
        wait = 1.6,
        len = 7
    },
    RELOAD = {
        key = "IGUI_RASTROSCAIDOS_RELOAD_",
        timer = 0,
        wait = 1.1,
        len = 10
    },
    MECHANIC = {
        key = "IGUI_RASTROSCAIDOS_MECHANIC_",
        timer = 0,
        wait = 1.3,
        len = 10
    },
    ITEMFALL = {
        key = "IGUI_RASTROSCAIDOS_ITEMFALL_",
        timer = 0,
        wait = 0.9,
        len = 7
    },
    ITEMPICKUP = {
        key = "IGUI_RASTROSCAIDOS_ITEMPICKUP_",
        timer = 0,
        wait = 0.03,
        noWait = true,
        len = 7
    },
    RASTRO = {
        key = "IGUI_RASTROSCAIDOS_RASTRO_",
        timer = 0,
        wait = 0.02,
        tittle = "IGUI_RASTROSCAIDOS_TITTLE_",
        len = 10,
        noWait = true,
        text = "IGUI_RASTROSCAIDOS_BODY_",
    },
    FACTION = {
        key = "IGUI_RASTROSCAIDOS_FACTION_",
        timer = 0,
        wait = 0.05,
        len = 5
    },
}

RastrosCaidosMod.normalizeBodyPart = function(bodyPart)
    local name = tostring(bodyPart)
    return name:gsub("_[RL]$", "") .. "_"
end

RastrosCaidosMod.extNumFrom = function(text)
    local number = text:match("Rastro N%. (%d+)")
    return number and tonumber(number) or nil
end

RastrosCaidosMod.getTxtRandom = function(len, key)
    local makeRandom =  ZombRand(3) + 1
    local sel = nil
    if makeRandom > 3 then
        sel = ZombRand(1, len)
    else
        sel = otherRandom:random(1,len)
    end
    if not sel then sel = ZombRand(1, len) end
    local txKey = key .. sel .. gen
    local tx = getText(txKey)
    if tx and tx ~= "" then
        return tx
    else
        print("Error: Traducción no encontrada para la clave: " .. txKey)
    end
    return "Oops!"
end

RastrosCaidosMod.getTxtRange = function(len, key, ifirst, ilast)
local sel = 1
    for i=1,3 do
        sel = ZombRand(ifirst, ilast)
    end
    local txKey = key .. sel .. gen
    local tx = getText(txKey)
    if tx and tx ~= "" then
        return tx
    else
        print("Error: Traducción no encontrada para la clave: " .. txKey)
    end
    return "Oops!"
end

RastrosCaidosMod.getTxtIndx = function(len, key, index)
    local txKey = key .. index .. gen
    local tx = getText(txKey)
    if tx and tx ~= "" then
        return tx
    else
        print("Error: Traducción no encontrada para la clave: " .. txKey)
    end
    return "Oops!"
end

RastrosCaidosMod.onCreatePlayer = function()
    local p = getPlayer()
    gen = p:isFemale() and "_F" or "_M"
end

local playerSay = function(shout, random, key, player, index, last, extraStr)

    local currentTime = getGameTime():getWorldAgeHours()
    local lTime = currentTime - timerLastSay
    local k = keyData[key]

    if lTime < waitToSpeak and not k.noWait then
        return
    end

    local ti = currentTime - k.timer
    if ti < k.wait and key ~= "RASTRO" then
        return
    end

    player = player or getPlayer()
    index = index or false
    extraStr = extraStr or ""
    local tx = ""

    if random then
        tx = RastrosCaidosMod.getTxtRandom(k.len, k.key) .. " " .. extraStr
    elseif index and not last then
        tx = RastrosCaidosMod.getTxtIndx(k.len, k.key, index) .. " " .. extraStr
    elseif index and last then
        tx = RastrosCaidosMod.getTxtRange(k.len, k.key, index, last) .. " " .. extraStr
    else
       tx = "Mmmm... " .. extraStr
    end
    if shout and playerPanicLvl > 40 then
        local mayus = string.upper(tx)
        player:SayShout(mayus)
    else
        player:Say(tx)
    end
    k.timer = currentTime
    timerLastSay = currentTime
end

RastrosCaidosMod.playerAttackFinished = function(character, weapon, atk)
    playerSay(true ,true, "ATTACK", character)
end

RastrosCaidosMod.safeHouseChange = function()
    playerSay(false ,true, "HOUSE")
end

RastrosCaidosMod.newRoom = function(room)
    playerSay(false ,true, "ROOM")
end

RastrosCaidosMod.vehicleExited = function(character)
    playerSay(false ,true, "MOBILEX", character)
end

RastrosCaidosMod.vehicleEnter = function(character)
    playerSay(false ,true, "MOBILIN", character)
end

RastrosCaidosMod.seatChaged = function(character)
    playerSay(false ,true, "MOBILSEAT", character)
end

RastrosCaidosMod.reloadingWeapon = function(character, weapon)
    playerSay(true, true, "RELOAD", character)
end

RastrosCaidosMod.mechanicAction = function(character, success, vehicleId, partType, itemId, installing)
    playerSay(false ,true, "MECHANIC", character)
end

RastrosCaidosMod.itemFall = function()
    playerSay(false ,true, "ITEMFALL")
end

RastrosCaidosMod.factionInvitation = function(factionName, hostUsername)
    playerSay(false ,true, "FACTION")
end

RastrosCaidosMod.safeHouseInvitation = function(tittle, hostUsername)
    playerSay(false ,true, "HOME")
end

RastrosCaidosMod.itemPickup = function(item)
    if item == nil then
        return
    end
    local nam = item:getName()
    if nam == nil then
        return
    end
    local character = getPlayer()
    if string.find(nam, "Rastro N.", 1, true) then
        playerSay(false , true, "RASTRO", character)
    else
        playerSay(false ,true, "ITEMPICKUP", character, false, false, nam)
    end
end

RastrosCaidosMod.checkpanic = function(player)
    playerPanicLvl = player:getStats():getPanic()
    local k = "PANIC"
    local panicData = keyData[k]
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - panicData.timer
    if ti < panicData.wait then
        return
    end
    if playerPanicLvl > 94 then
        playerSay(true, false, k, player, 1, 5)
    elseif playerPanicLvl > 82 then
        playerSay(false ,false, k, player, 6, 10)
    elseif playerPanicLvl > 70 then
        playerSay(false ,false, k, player, 11, 15)
    elseif playerPanicLvl > 58 then
        playerSay(false ,false, k, player, 16, 20)
    elseif playerPanicLvl > 46 then
        playerSay(false ,false, k, player, 21, 25)
    elseif playerPanicLvl > 34 then
        playerSay(false ,false, k, player, 26, 30)
    elseif playerPanicLvl > 22 then
        playerSay(false ,false, k, player, 31, 35)
    elseif playerPanicLvl > 10 then
        playerSay(false ,false, k, player, 36, 40)
    else
        local panlowtime = currentTime - panicData.lowtimer
        if panlowtime > panicData.lowwait then
            playerSay(false ,false, k, player, 41, 46)
            panicData.lowtimer = currentTime
        end
    end
end

local playerGetDamaged = function(character, damageType, damage)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - dmgLastCheck

    if ti < 0.05 then
        return
    end

    dmgLastCheck = currentTime

    local damageInfo = keyData[damageType]
    if damageInfo and damageType ~= "BLEEDING" then
        local t = currentTime - damageInfo.timer
        if t > 0.5 then
            damageInfo.timer = currentTime
            local tx = RastrosCaidosMod.getTxtRandom(damageInfo.len, damageInfo.key)
            character:Say(tx)
            timerLastSay = currentTime
        end
    elseif damageInfo and damageType == "BLEEDING" then
        local bodyDamage = character:getBodyDamage()
        local bodyParts = bodyDamage:getBodyParts()
        for i = 0, bodyParts:size() - 1 do
            local t = currentTime - damageInfo.timer
            if t > 0.5 then
                local bodyPart = bodyParts:get(i)
                local bn = bodyPart:getType()
                local bodyPartName = RastrosCaidosMod.normalizeBodyPart(bn)
                if bodyPart:bleeding() and not bodyPart:IsBleedingStemmed() then
                    local bodyPartDamage = ""
                    if bodyPart:scratched() then
                        bodyPartDamage = "scratched_"
                    elseif bodyPart:isCut() then
                        bodyPartDamage = "isCut_"
                    elseif bodyPart:bitten() then
                        bodyPartDamage = "bitten_"
                    elseif bodyPart:isDeepWounded() then
                        bodyPartDamage = "isDeepWounded_"
                    -- elseif bodyPart:haveGlass() then
                    --     bodyPartDamage = "haveGlass_"
                    -- -haveGlass
                    -- -haveBullet
                    -- -hasInjury
                    -- -isBurnt
                    -- -isNeedBurnWash
                    end
                    local key = damageInfo.key .. bodyPartDamage .. bodyPartName
                    local tx = RastrosCaidosMod.getTxtRandom(damageInfo.len, key)
                    character:Say(tx)
                    damageInfo.timer = currentTime
                    timerLastSay = currentTime
                end
            end
            
        end
    end
end

-- RastrosCaidosMod.onContainerUpdate = function(container)
--     print("container update")
--     print(container)
--     local p = getPlayer()
--     p:Say("ContainerUpdate")
-- end

-- RastrosCaidosMod.onFillContainer = function(roomName, containerType, itemContainer)
--     -- print("itemContainer .. roomName .. containerType")
--     -- print(roomName)
--     -- print(containerType)
--     -- local p = getPlayer()
--     -- p:Say("fillContainer")
-- end

-- RastrosCaidosModS.setSpawn = function()
--     print("SETTING SPAWN..................SET SPAWN")
--     SpawnOrigin.new(5, 5, 4672, 8597)
-- end

-- Events.OnGameStart.Add(info)
Events.OnGameStart.Add(RastrosCaidosMod.onCreatePlayer)
-- Events.OnGameTimeLoaded.Add()

Events.OnPlayerAttackFinished.Add(RastrosCaidosMod.playerAttackFinished)
Events.OnPlayerGetDamage.Add(playerGetDamaged)
Events.OnSafehousesChanged.Add(RastrosCaidosMod.safeHouseChange)
Events.OnSeeNewRoom.Add(RastrosCaidosMod.newRoom)
Events.ReceiveFactionInvite.Add(RastrosCaidosMod.factionInvitation)
Events.ReceiveSafehouseInvite.Add(RastrosCaidosMod.safeHouseInvitation)
Events.OnExitVehicle.Add(RastrosCaidosMod.vehicleExited)
Events.OnEnterVehicle.Add(RastrosCaidosMod.vehicleEnter)
Events.OnPlayerUpdate.Add(RastrosCaidosMod.checkpanic)
-- Events.OnUseVehicle.Add(RastrosCaidosMod.nUseVehicle)
Events.OnSwitchVehicleSeat.Add(RastrosCaidosMod.seatChaged)
Events.OnPressReloadButton.Add(RastrosCaidosMod.reloadingWeapon)
Events.OnObjectAboutToBeRemoved.Add(RastrosCaidosMod.itemPickup)
Events.OnMechanicActionDone.Add(RastrosCaidosMod.mechanicAction)
Events.onItemFall.Add(RastrosCaidosMod.itemFall)
-- Events.OnItemFound.Add(RastrosCaidosMod.itemFound)
-- Events.OnGameBoot.Add(RastrosCaidosMod.setSpawn)
-- Events.OnCreatePlayer.Add(RastrosCaidosMod.onCreatePlayer)
-- Events.OnContainerUpdate.Add(RastrosCaidosMod.onContainerUpdate)
-- Events.OnFillContainer.Add(RastrosCaidosMod.onFillContainer)
-- Events.OnGameStart.Add(RastrosCaidosMod.spawnSpecialNote)
-- Events.OnPlayerGetItem.Add(RastrosCaidosMod.onItemPickup
-- Events.LoadGridsquare.Add(RastrosCaidosMod.onLoadGridSquare)