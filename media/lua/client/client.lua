--[[
 ███████╗████████╗██████╗  █████╗ ██████╗ ██╗ ██████╗ █████╗ ██████╗ ██╗   ██╗███████╗
 ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██║   ██║██╔════╝
 ███████╗   ██║   ██████╔╝███████║██████╔╝██║██║     ███████║██████╔╝██║   ██║███████╗
 ╚════██║   ██║   ██╔═██╗ ██╔══██║██╔═══╝ ██║██║     ██╔══██║██╔═██╗ ██║   ██║╚════██║
 ███████║   ██║   ██║  ██╗██║  ██║██║     ██║╚██████╗██║  ██║██║  ██╗╚██████╔╝███████║
 ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ 
 
 File    : client.lua
 Author  : Strapicarus
 Version : 0.2.3
--]]

local gen = "_M"
local p = {}
local nrandom = newrandom()

-- Last Action Timers
local lastSay = 0
local lastSayWait = 0.03
-- local lastNewRoom = 0
local lastReload = 0
-- local lastMechanicAction = 0
local lastEnterVehicle = 0
local itemLastCheck = 0

local panicLastCheck = 0
local panicLastLow = 0

-- local lastLocalTimeUpdated = 0

-- -- Last Damage type timers
local dmgLastCheck = 0
-- local dmgLastPoison = 0
-- local dmgLastHungry = 0
-- local dmgLastSick = 0
-- local dmgLastBleeding = 0
-- local dmgLastThirts = 0

-- local damageLastChangeInfection = 0
-- local lastCheck = 0
local lastPlayerAttack = 0

local keyData = {
    ALIVE = {
        key = "IGUI_RASTROSCAIDOS_ALIVE_",
        timer = 0,
        len = 1
    },
    PANIC = {
        key = "IGUI_RASTROSCAIDOS_PANIC_",
        timer = 0,
        len = 1
    },
    ATTACK = {
        key = "IGUI_RASTROSCAIDOS_ATTACK_",
        timer = 0,
        len = 16
    },
    POISON = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_POISON_",
        timer = 0,
        len = 5
    },
    HUNGRY = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_HUNGRY_",
        timer = 0,
        len = 5
    },
    SICK = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_SICK_",
        timer = 0,
        len = 5
    },
    THIRST = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_THIRST_",
        timer = 0,
        len = 5
    },
    BLEEDING = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_BLEEDING_",
        timer = 0,
        len = 3
    },
    HEAVYLOAD = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_HEAVYLOAD_",
        timer = 0,
        len = 3
    },
    INFECTION = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_INFECTION_",
        timer = 0,
        len = 3
    },
    LOWWEIGHT = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_LOWWEIGHT_",
        timer = 0,
        len = 3
    },
    FALLDOWN = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_FALLDOWN_",
        timer = 0,
        len = 3
    },
    WEAPONHIT = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_WEAPONHIT_",
        timer = 0,
        len = 3
    },
    CARHITDAMAGE = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_CARHITDAMAGE_",
        timer = 0,
        len = 3
    },
    CARCRASHDAMAGE = {
        key = "IGUI_RASTROSCAIDOS_DAMAGE_CARCRASHDAMAGE_",
        timer = 0,
        len = 3
    },
    HOUSE = {
        key = "IGUI_RASTROSCAIDOS_HOUSE_",
        timer = 0,
        len = 3
    },
    ROOM = {
        key = "IGUI_RASTROSCAIDOS_ROOM_",
        timer = 0,
        len = 7
    },
    MOBILEX = {
        key = "IGUI_RASTROSCAIDOS_MOBILEX_",
        timer = 0,
        len = 7
    },
    MOBILIN = {
        key = "IGUI_RASTROSCAIDOS_MOBILIN_",
        timer = 0,
        len = 10
    },
    MOBILSEAT = {
        key = "IGUI_RASTROSCAIDOS_MOBILSEAT_",
        timer = 0,
        len = 7
    },
    RELOAD = {
        key = "IGUI_RASTROSCAIDOS_RELOAD_",
        timer = 0,
        len = 10
    },
    MECHANIC = {
        key = "IGUI_RASTROSCAIDOS_MECHANIC_",
        timer = 0,
        len = 10
    },
    ITEMFALL = {
        key = "IGUI_RASTROSCAIDOS_ITEMFALL_",
        timer = 0,
        len = 7
    },
    PANIC = {
        key = "IGUI_RASTROSCAIDOS_PANIC_",
        timer = 0,
        len = 45
    },
}


--translations array length
-- local attkLen = 16
-- local dmgPoisonLen = 5
-- local dmgHungryLen = 5
-- local dmgSickLen = 5
-- local dmgThirstLen = 5
-- local dmgLen = 3

local function normalizeBodyPart(bodyPart)
    local name = tostring(bodyPart)
    return name:gsub("_[RL]$", "") .. "_"
end

function getTxtRandom(len, key)
    local sel = nrandom:random(1,len)
    local txKey = key .. sel .. gen
    local tx = getText(txKey)
    if tx and tx ~= "" then
        return tx
    else
        print("Error: Traducción no encontrada para la clave: " .. txKey)
    end
    return "Oops!"
end

function getTxtIndx(len, key, index)
    local txKey = key .. index .. gen
    local tx = getText(txKey)
    if tx and tx ~= "" then
        return tx
    else
        print("Error: Traducción no encontrada para la clave: " .. txKey)
    end
    return "Oops!"
end

local function onCreatePlayer()
    p = getPlayer()
    gen = p:isFemale() and "_F" or "_M"
    local key = keyData["ALIVE"]
    local tx = getTxtRandom(1, key.key)
    p:Say(tx)
end

local function playerAttackFinished(character, weapon, atk)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - lastPlayerAttack
    local last = currentTime - lastSay
    if ti < 0.04 or last < lastSayWait then
        return
    end
    local key = keyData["ATTACK"]
    local tx = getTxtRandom(key.len, key.key)
    character:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function playerGetDamaged(character, damageType, damage)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - dmgLastCheck
    local last = currentTime - lastSay

    if ti < 0.04 or last < lastSayWait then
        return
    end

    dmgLastCheck = currentTime

    local damageInfo = keyData[damageType]
    if damageInfo and damageType ~= "BLEEDING" then
        local t = currentTime - damageInfo.timer
        if t > 0.5 then
            damageInfo.timer = currentTime
            local tx = getTxtRandom(damageInfo.len, damageInfo.key)
            character:Say(tx)
            lastSay = currentTime
        end
    elseif damageInfo and damageType == "BLEEDING" then
        local bodyDamage = character:getBodyDamage()
        local bodyParts = bodyDamage:getBodyParts()
        for i = 0, bodyParts:size() - 1 do
            local t = currentTime - damageInfo.timer
            if t > 0.5 then
                local bodyPart = bodyParts:get(i)
                local bn = bodyPart:getType()
                local bodyPartName = normalizeBodyPart(bn)
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
                    local tx = getTxtRandom(damageInfo.len, key)
                    character:Say(tx)
                    damageInfo.timer = currentTime
                    lastSay = currentTime
                end
            end
            
        end
    end
end

local function safeHouseChange()
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - lastSay
    if ti < lastSayWait then
        return
    end
    local key = keyData["HOUSE"]
    local t = currentTime - key.timer
    if t < 0.2 then
        return
    end
    local tx = getTxtRandom(key.len, key.key)
    local p = getPlayer()
    p:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function newRoom(room)
    local currentTime = getGameTime():getWorldAgeHours()
    local last = currentTime - lastSay
    if last < lastSayWait or type(room) == nil then
        return 
    end
    local key = keyData["ROOM"]
    local t = currentTime - key.timer
    if t < 0.2 then
        return
    end
    local tx = getTxtRandom(key.len, key.key)
    local p = getPlayer()
    p:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function vehicleExited(character)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - lastSay
    if ti < lastSayWait then
        return
    end
    local key = keyData["MOBILEX"]
    local t = currentTime - key.timer
    if t < 0.05 then
        return
    end
    local tx = getTxtRandom(key.len, key.key)
    character:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function vehicleEnter(character)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - lastSay
    if ti < lastSayWait then
        return
    end
    local key = keyData["MOBILIN"]
    local t = currentTime - key.timer
    if t < 0.05 then
        return
    end
    local tx = getTxtRandom(key.len, key.key)
    character:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function seatChaged(character)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - lastSay
    if ti < lastSayWait then
        return
    end
    local key = keyData["MOBILSEAT"]
    local t = currentTime - key.timer
    if t < 0.05 then
        return
    end
    local tx = getTxtRandom(key.len, key.key)
    character:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function reloadingWeapon(character, weapon)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - lastSay
    if ti < lastSayWait then
        return
    end
    local key = keyData["RELOAD"]
    local t = currentTime - key.timer
    if t < 0.05 then
        return
    end
    local tx = getTxtRandom(key.len, key.key)
    character:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function mechanicAction(character, success, vehicleId, partType, itemId, installing)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - lastSay
    if ti < lastSayWait then
        return
    end
    local key = keyData["MECHANIC"]
    local t = currentTime - key.timer
    if t < 0.05 then
        return
    end
    local tx = getTxtRandom(key.len, key.key)
    character:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function factionInvitation(factionName, hostUsername)
    local p = getPlayer()
    p:Say("Recibi una invitacion a una faccion, ahora podre destruirlos desde dentro jajajaja....")
end

local function safeHouseInvitation(tittle, hostUsername)
    local p = getPlayer()

    p:Say("Recibi una invitacion a una casa segura... ojala tengan piscina")
end

local function itemPickup(item)
    if item == nil then
        return
    end
    local nam = item:getName()
    if nam == nil then
        return
    end
    if #nam < 6 then
        return
    end
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - itemLastCheck
    local last = currentTime - lastSay
    if ti < 0.03 or last < lastSayWait then
        return
    end
    local p = getPlayer()
    local inam = item:getName()
    if string.find(inam, "Rastros N", 1, true) then
        p:Say("Mira lo que me encontre... Una pista!!!")
    elseif string.find(item:getName(), "M16", 1, true) then
            p:Say("Pero mira que cosa. puede servirme...")
    end
    p:Say("Espero no pese mucho...")
    itemLastCheck = currentTime
    lastSay = currentTime
end

local function itemFall()
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - lastSay
    if ti < lastSayWait then
        return
    end
    local key = keyData["ITEMFALL"]
    local t = currentTime - key.timer
    if t < 0.05 then
        return
    end
    local character = getPlayer()
    local tx = getTxtRandom(key.len, key.key)
    character:Say(tx)
    key.timer = currentTime
    lastSay = currentTime
end

local function onFillContainer(roomName, containerType, itemContainer)
    -- print("itemContainer .. roomName .. containerType")
    -- print(roomName)
    -- print(containerType)
    -- local p = getPlayer()
    -- p:Say("fillContainer")
end

local function check(player)
    local currentTime = getGameTime():getWorldAgeHours()
    local ti = currentTime - panicLastCheck
    if ti < lastSay then
        return
    end
    local panic = player:getStats():getPanic()

    if panic > 94 then
        player:SayShout("AYUDAME JEBUS!!!")
    elseif panic > 89 then
        player:SayShout("MAAAMMAAAAA!!!")
    elseif panic > 87 then
        player:SayShout("¡Se acabo, aqui me muero! ¡Adios mundo cruel!")
    elseif panic > 85 then
        player:SayShout("¡Alguien traiga una bomba y tambien pañales!")
    elseif panic > 83 then
        player:SayShout("¡Esto es peor que cuando mi suegra me visito una semana!")
    elseif panic > 81 then
        player:SayShout("¡Ya ni mis memes favoritos pueden calmarme ahora!")
    elseif panic > 79 then
        player:SayShout("¡Alguien haga algo!!! \n Auxilio!!! me come el coco!!!")
    elseif panic > 77 then
        player:SayShout("¡Corran! ¡Yo los distraigo con mi grito desgarrador!")
    elseif panic > 75 then
        player:SayShout("¿Por que siento que el piso tiembla o son mis piernas?")
    elseif panic > 73 then
        player:SayShout("¡Voy a correr tan rapido que ganare una medalla de oro!")
    elseif panic > 71 then
        player:Say("Necesito muchas balas... ¡y tal vez un milagro!")
    elseif panic > 69 then
        player:Say("¿Esta permitido llorar y disparar al mismo tiempo?")
    elseif panic > 67 then
        player:Say("¿Esto es la vida real o ya estoy en modo fantasma?")
    elseif panic > 65 then
        player:Say("¡A este ritmo, el coco ni me atrapa, me alcanza mi infarto!")
    elseif panic > 63 then
        player:Say("Alguien agarralos a golpes mientras corro... ¡Por favor!")
    elseif panic > 61 then
        player:Say("¡No puedo con esto!...\n¡Mejor me hago bolita y lloro!")
    elseif panic > 59 then
        player:Say("¿Por que siento que mis piernas estan hechas de gelatina?")
    elseif panic > 57 then
        player:Say("¡A este nivel de panico, mis gritos se escuchan en Marte!")
    elseif panic > 55 then
        player:Say("¡Creo que ya me orine un poquito... o mucho!")
    elseif panic > 53 then
        player:Say("¡Esto no esta pasando, esto no esta pasando!")
    elseif panic > 51 then
        player:Say("¿Por que no inventaron aun un boton de 'calma instantanea'?")
    elseif panic > 49 then
        player:Say("¿Que les pasa a mis piernas?\n¡Esten temblando como flan!")
    elseif panic > 47 then
        player:Say("¡Voy a necesitar un terapeuta despues de esto!")
    elseif panic > 45 then
        player:Say("¿Por que siento que alguien detras mio me respira en la nuca?")
    elseif panic > 43 then
        player:Say("Cuando era pequeño me comia las uñas...\n¡Y ahora tambien!")
    elseif panic > 41 then
        player:Say("¡Yo no queria ser heroe, solo vine por los snacks gratis!")
    elseif panic > 39 then
        player:Say("¿Cómo es que siempre termino en estos lios? ¡Soy un iman del drama!")
    elseif panic > 37 then
        player:Say("Descargando ansiedad...\n¡Aaaaaaaaarrgh!")
    elseif panic > 35 then
        player:Say("¿Qué hago aqui? ¿Quien me metio en este problema?")
    elseif panic > 33 then
        player:Say("Si lo encuentran, diganle a mi perro que lo extranio.")
    elseif panic > 31 then
        player:Say("¡Esto no esta tan mal! Oh, espera... ¡Si lo esta!")
    elseif panic > 29 then
        player:SayWhisper("¡Si me salvo de esta, prometo que me porto bien un dia entero!")
    elseif panic > 27 then
        player:SayWhisper("¿Por qué siento que mi vida es ahora un reality show?")
    elseif panic > 25 then
        player:SayWhisper("¡No tengo miedo, no tengo miedo...")
    elseif panic > 23 then
        player:SayWhisper("No me dicen calma por estar tranquilo...")
    elseif panic > 21 then
        player:SayWhisper("Un tequila resolveria esto... o no, pero lo intentare.")
    elseif panic > 19 then
        player:SayWhisper("¡Esto no da miedo, pero mis piernas no estan de acuerdo!")
    elseif panic > 17 then
        player:SayWhisper("Respira profundo...")
    elseif panic > 15 then
        player:SayWhisper("¿Seguro que esto es peligroso?... Yo puedo con esto.")
    elseif panic > 13 then
        player:SayWhisper("Me tomaria un daiquiri... ¡O dos!")
    elseif panic > 11 then
        player:SayWhisper("¡Vamos! ¡Esto es pan comido!...")
    elseif panic > 9 then
        player:SayWhisper("Esto me huele raro, ya empieza a incomodar.")
    elseif panic > 7 then
        player:SayWhisper("¡Ok, esto no me gusta, pero nada de nada!")
    elseif panic > 5 then
        player:SayWhisper("Eso no asusta, pero podria.")
    elseif panic > 3 then
        player:SayWhisper("¡Eso no asusta, ja! Soy valiente.")
    else
        if currentTime - panicLastLow > 80 then
            local frs = {"Lo bueno es que sigo con vida!!!", "No encuentro mi osito...", "Se que no hay acentos...\nYo tambien quisiera que estuviera bien escrito..."}
            local sel = ZombRand(#frs)+1
            if sel > 0 and sel <= #frs then
                local tx = frs[sel]
                player:Say(tx)
            else
                player:Say("Fuera de rango func check")
            end
            panicLastLow = getGameTime():getWorldAgeHours()
        end
    end
    panicLastCheck = getGameTime():getWorldAgeHours()
end

local function onContainerUpdate(container)
    print("container update")
    print(container)
    local p = getPlayer()
    p:Say("ContainerUpdate")
end

-- Events.OnGameStart.Add(info)
Events.OnGameStart.Add(onCreatePlayer)
-- Events.OnGameTimeLoaded.Add()

Events.OnPlayerAttackFinished.Add(playerAttackFinished)
Events.OnPlayerGetDamage.Add(playerGetDamaged)
Events.OnSafehousesChanged.Add(safeHouseChange)
Events.OnSeeNewRoom.Add(newRoom)
Events.ReceiveFactionInvite.Add(factionInvitation)
Events.ReceiveSafehouseInvite.Add(safeHouseInvitation)
Events.OnExitVehicle.Add(vehicleExited)
Events.OnEnterVehicle.Add(vehicleEnter)
Events.OnPlayerUpdate.Add(check)
-- Events.OnUseVehicle.Add(nUseVehicle)
Events.OnSwitchVehicleSeat.Add(seatChaged)
Events.OnPressReloadButton.Add(reloadingWeapon)
Events.OnObjectAboutToBeRemoved.Add(itemPickup)
Events.OnMechanicActionDone.Add(mechanicAction)
Events.onItemFall.Add(itemFall)
-- Events.OnItemFound.Add(itemFound)
-- Events.OnGameBoot.Add(info)
-- Events.OnCreatePlayer.Add(onCreatePlayer)
-- Events.OnContainerUpdate.Add(onContainerUpdate)
Events.OnFillContainer.Add(onFillContainer)
-- Events.OnGameStart.Add(spawnSpecialNote)
-- Events.OnPlayerGetItem.Add(onItemPickup
-- Events.LoadGridsquare.Add(onLoadGridSquare)