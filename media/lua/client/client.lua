

local lastSay = 0
local lastNewRoom = 0
local lastReload = 0
local lastMechanicAction = 0
local lastEnterVehicle = 0
local lastBleeding = 0
local panicLastCheck = 0
local panicLastLow = 0
local damageLastCheck = 0
local lastLocalTimeUpdated = 0
local damageLastText = 0
local itemLastCheck = 0
local damageLastChangeInfection = 0
local lastCheck = 0
local lastPlayerAttack = 0

local function onContainerUpdate(container)
    print("container update")
    print(container)
    local p = getPlayer()
    p:Say("ContainerUpdate")
end

local function playerAttackFinished(player, weapon, atk)
    local currentTime = getGameTime():getWorldAgeHours() * 60
    local ti = currentTime - lastPlayerAttack
    local last = currentTime - lastSay
    print(ti)
    if ti < 10 or lastSay < 2  then
        return
    end
    local frs = {
        "¡Toma esto, para que aprendas la lección!",
        "¡Ni viste eso venir, ¿verdad?!",
        "¡Voy a hacer que recuerdes mi nombre!",
        "¡Eso te enseniara a no meterte conmigo!",
        "¡Con esto vas a pensar dos veces antes de intentarlo de nuevo!",
        "¡Apenas estoy calentando, prepárate!",
        "¡Este es solo el principio, quédate para el gran final!",
        "¡Ahí va, directo a tu dignidad!",
        "¡Esto es tan divertido que podría hacerlo todo el día!",
        "¡Espero que estés tomando notas, porque estoy dando una clase magistral!",
        "¡Ese error te acaba de costar caro!",
        "¡Vamos, no te quedes ahí parado!",
        "¡Cada movimiento mío es un paso más cerca de tu derrota!",
        "¡Te estoy dejando sin excusas ni oportunidades!",
        "¡Esto no es suerte, es pura habilidad!",
        "Venga mas!!! que no me canso..."
    }
    local sel = ZombRand(#frs)+1
    local tx = frs[sel]
    player:Say(tx)
    -- if sel > 0 and sel <= #frs then
    --     local tx = frs[sel]
    --     player:Say(tx)
    -- else
    --     player:Say("Fuera de rango func playerAttackFinished()\nsel:" .. sel .. "\nfrs:" .. #frs)
    -- end
    lastPlayerAttack = getGameTime():getWorldAgeHours() * 60
    lastSay = getGameTime():getWorldAgeHours() * 60 
end

local function playerGetDamaged(character, damageType, damage)

    local currentTime = getGameTime():getWorldAgeHours() * 60
    local ti = currentTime - damageLastCheck
    local last = currentTime - lastSay
    if ti < 10 or last < 2 then
        return
    end
    damageLastCheck = getGameTime():getWorldAgeHours() * 60
    if(damageType == "POISON") then
        local t = currentTime - damageLastText
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        character:Say("Deberia conseguir un poco de sal y agua... no se porque...")
        return
    end

    if(damageType == "HUNGRY") then
        character:Say("Siento que un churrasco me vendria bien")
        return
    end

    if(damageType == "SICK") then
        character:Say("Creo que la langosta no me cayo bien...")
        return
    end

    if(damageType == "BLEEDING") then
        local last = currentTime - lastSay
        local b = currentTime - lastBleeding
        if b < 15 or last < 2 then
            return
        end
        local bodyDamage = character:getBodyDamage()
        local bodyParts = bodyDamage:getBodyParts()
        local bodyPartTypeName = ""
        local bleedingSeverity = 0

        for i = 0, bodyParts:size() - 1 do
            local bodyPart = bodyParts:get(i)

            if bodyPart:bleeding() and not bodyPart:IsBleedingStemmed() then
                if bodyPart:scratched() then
                    bleedingSeverity = bleedingSeverity + 1 
                elseif bodyPart:isCut() then
                    bleedingSeverity = bleedingSeverity + 2
                elseif bodyPart:bitten() then
                    bleedingSeverity = bleedingSeverity + 3
                elseif bodyPart:isDeepWounded() then
                    bleedingSeverity = bleedingSeverity + 4
                end

                if bodyPart:getScratchTime() > 10 then
                    bleedingSeverity = bleedingSeverity + 1
                end
                if bodyPart:getCutTime() > 10 then
                    bleedingSeverity = bleedingSeverity + 2
                end
                if bodyPart:getDeepWoundTime() > 10 then
                    bleedingSeverity = bleedingSeverity + 3
                end

                if bodyPart:haveGlass() then
                    bleedingSeverity = bleedingSeverity + 2
                end

                if bodyPart:getScratchSpeedModifier() > 1 then
                    bleedingSeverity = bleedingSeverity + 1
                end
                if bodyPart:getCutSpeedModifier() > 1 then
                    bleedingSeverity = bleedingSeverity + 2
                end
                if bodyPart:getDeepWoundSpeedModifier() > 1 then
                    bleedingSeverity = bleedingSeverity + 3
                end
                bodyPartType = type(bodyPart)
            end
        end


        if bleedingSeverity > 15 then
            character:SayShout("Auxilio! me muero desangrado...")
        elseif bleedingSeverity > 11 then
            character:Say("Tengo una herida profunda... sangrando...")
        elseif bleedingSeverity > 8 then
            character:Say("Aaaarg!!!! Eso duele y sangra...")
        elseif bleedingSeverity > 4 then
            character:Say("Solo es un poco de sangre...")
        elseif bleedingSeverity > 0 then
            character:Say("Un corte con papel...")
        end      
        lastSay = getGameTime():getWorldAgeHours() * 60
        lastBleeding = getGameTime():getWorldAgeHours() * 60
        return
    end

    if(damageType == "THIRST") then
        local t = currentTime - damageLastText
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        character:Say("Tomar cervezas no calma la sed...")
        return
    end

    if(damageType == "HEAVYLOAD") then
        local t = currentTime - damageLastText
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        character:Say("No deberia llevar tanta basura en mi espalda...")
        return
    end

    if(damageType == "INFECTION") then
        local t = currentTime - damageLastText
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        character:Say("Eso es todo? tanto drama para morir de una infeccion porque no vacunarme!")
        return
    end

    if(damageType == "LOWWEIGHT") then
        local t = currentTime - damageLastText
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        character:Say("Soy muy fuerte, puedo llevar mas... comida en el estomago...")
        return
    end

    if(damageType == "FALLDOWN") then
        local t = currentTime - damageLastText
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        character:Say("Ma caigo que no tengo 2 pies izquierdos...")
        return
    end
    
    if(damageType == "WEAPONHIT") then
        local t = currentTime - damageLastText
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        character:Say("Te di!!! y no lo vas a negar!!!")
        return
    end

    if(damageType == "CARHITDAMAGE") then
        local t = currentTime - damageLastText
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        character:Say("Weon!! aprende a conducir!!!... si estas borracho no conduzcas...")
        return
    end

    if(damageType == "CARCRASHDAMAGE") then
        local t = currentTime - damageLastText
        character:Say("accidente")
        if t < 50 then
            return
        end
        damageLastText = getGameTime():getWorldAgeHours() * 60
        local frs = {"Pude sacar la licencia de conducir\npero no crei que fuera necesario...", "Un poco de pintura y se arregla...", "No lo vi y no estoy ciego...", "Se atravezo, no es mi culpa, no me dio tiempo de reaccion..."}
        local sel = ZombRand(#frs)+1
        local tx = frs[sel]
        if sel > 0 and sel <= #frs then
            character:Say(tx)
        else
            character:Say("Fuera de rango func checkDamage")
        end
        return
    end
    lastSay = getGameTime():getWorldAgeHours() * 60
end

local function safeHouseChange()
    local p = getPlayer()
    p:Say("Hogar dulce hogar... a ver cuando aguanta...")
end

local function newRoom(room)
    local currentTime = getGameTime():getWorldAgeHours() * 60
    local last = currentTime - lastSay
    if last < 2 then
        return 
    end
    if type(room) == nil then
        return
    end
    local p = getPlayer()
    local frs = {
        "¿Que habra ahi adelante?",
        "¿Deberia explorar un poco mas?",
        "¿Sera seguro seguir por aqui?",
        "¿Habra algo interesante aqui?",
        "Quizas deberia echar un vistazo mas de cerca.",
        "¿Esto sera lo que estoy buscando?",
        "¿Deberia revisar este lugar?",
        "¿Estara la puerta abierta?",
        "Creo que no habia visto esta parte."
    }
    local sel = ZombRand(#frs)+1
    local tx = frs[sel]
    p:Say(tx)
    lastSay = getGameTime():getWorldAgeHours() * 60
end

local function factionInvitation(factionName, hostUsername)
    local p = getPlayer()
    p:Say("Recibi una invitacion a una faccion, ahora podre destruirlos desde dentro jajajaja....")
end

local function safeHouseInvitation(tittle, hostUsername)
    local p = getPlayer()

    p:Say("Recibi una invitacion a una casa segura... ojala tengan piscina")
end

local function vehicleExited(character)
    local p = getPlayer()
    p:Say("Que no se te olvide donde parquee...")
end

local function vehicleEnter(character)
    local currentTime = getGameTime():getWorldAgeHours() * 60
    local ti = currentTime - lastEnterVehicle
    local last = currentTime - lastSay
    if ti < 50 or last < 2 then
        return
    end
    lastEnterVehicle = getGameTime():getWorldAgeHours() *60
    local p = getPlayer()
    local frs = {
        "Siempre quise aprender a conducir... lastima que sea ahora.",
        "¿El freno es el que esta a la izquierda o a la derecha?",
        "Nunca tuve licencia, pero tengo mucha fe.",
        "Esto no puede ser tan dificil... ¿o si?",
        "Creo que en las peliculas lo hacen ver más facil.",
        "¿Que podria salir mal? Bueno, mejor no respondas.",
        "Si no saben que no se manejar, no se asustan, ¿verdad?",
        "¿El claxon es para frenar? ¡Ah, no era asi!",
        "La buena noticia: tengo las llaves. La mala: no se usarlas.",
        "Conducir es como andar en bici, ¿no? Excepto por todo lo demas."
    }
    local sel = ZombRand(#frs)+1
    local tx = frs[sel]
    p:Say(tx)
    lastSay = getGameTime():getWorldAgeHours() * 60
end

local function seatChaged(character)
    local p = getPlayer()
    p:Say("Vamooos! para el asiento de atras, que te parece?")
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
    local currentTime = getGameTime():getWorldAgeHours() * 60
    local ti = currentTime - itemLastCheck
    local last = currentTime - lastSay
    if ti < 25 or last < 2 then
        return
    end
    local p = getPlayer()
    if string.find(item:getName(), "Rastros N", 1, true) then
        p:Say("Mira lo que me encontre... Una pista!!!")
    elseif string.find(item:getName(), "M16", 1, true) then
            p:Say("Pero mira que cosa. puede servirme...")
    end
    p:Say("Espero no pese mucho...")
    itemLastCheck = getGameTime():getWorldAgeHours() * 60
    lastSay = getGameTime():getWorldAgeHours() * 60
end

local function reloadingWeapon(player, weapon)
    local currentTime = getGameTime():getWorldAgeHours() *60
    local ti = currentTime - lastReload
    local last = currentTime - lastSay
    if ti < 10 or last < 2 then
        return
    end
    lastReload = getGameTime():getWorldAgeHours() * 60
    local frs = {
        "Recargando la chingadera.",
        "Esperame tantito, ya casi cargo esto.",
        "¡Aguanten! Estoy metiendo las balas.",
        "Dame un segundo, esto lleva su tiempo.",
        "Cargando el artefacto del caos.",
        "Tranquilos, que ya viene la diversion.",
        "Un momento, la polvora esta entrando en su lugar.",
        "Espera... ¡se me cayo una bala!",
        "Dame chance, estoy preparando la fiesta.",
        "Ya casi, solo falta apretar este boton raro."
    } 
    local p = getPlayer()
    local sel = ZombRand(#frs)+1
    local tx = frs[sel]
    p:Say(tx)
    lastSay = getGameTime():getWorldAgeHours() * 60
end

local function mechanicAction(character, success, vehicleId, partType, itemId, installing)
    local p = getPlayer()
    local currentTime = getGameTime():getWorldAgeHours() * 60
    local ti = currentTime - lastMechanicAction
    local last = currentTime - lastSay
    if ti < 40 or last < 2 then
        return
    end
    lastMechanicAction = getGameTime():getWorldAgeHours() *60
    local frs = {
        "Seria mecanico si no fuera streamer.",
        "La llave inglesa no arregla corazones, pero yo lo intento.",
        "El aceite esta caro, mejor le echo cafe al motor.",
        "Si suena raro, ponle cinta adhesiva y reza.",
        "Esto no es un taller, es un milagro ambulante.",
        "Le cambie las bujias y ahora suena como un mariachi.",
        "¿Check engine? Eso significa 'sigue manejando'.",
        "No arregle el carro, pero quede bien para Instagram.",
        "El motor esta perfecto, solo necesita un poco de fe.",
        "Soy mecanico porque no me dejaron ser astronauta."
    }
    local sel = ZombRand(#frs)+1
    local tx = frs[sel]
    p:Say(tx)
    lastSay = getGameTime():getWorldAgeHours() * 60
end

local function itemFall()
    local p = getPlayer()
    p:Say("Manos de mantequilla! se me cae todo...")
end

local function onFillContainer(roomName, containerType, itemContainer)
    -- print("itemContainer .. roomName .. containerType")
    -- print(roomName)
    -- print(containerType)
    -- local p = getPlayer()
    -- p:Say("fillContainer")
end

local function check(player)

    local currentTime = getGameTime():getWorldAgeHours() * 60
    local ti = currentTime - panicLastCheck

    if ti < 7 then
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
            panicLastLow = getGameTime():getWorldAgeHours() * 60
        end
    end
    panicLastCheck = getGameTime():getWorldAgeHours() * 60
end

Events.OnGameStart.Add(info)
Events.OnGameStart.Add(onCreatePlayer)
Events.OnPlayerAttackFinished.Add(playerAttackFinished)
Events.OnPlayerGetDamage.Add(playerGetDamaged)
Events.OnSafehousesChanged.Add(safeHouseChange)
--Events.OnSeeNewRoom.Add(newRoom)
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