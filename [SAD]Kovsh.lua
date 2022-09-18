require 'lib.moonloader'
local OFFSET = 2
local object = nil
local inicfg = require 'inicfg'
local directIni = '[SAD]Kovsh.ini'
local ini = inicfg.load(inicfg.load({
    main = {
        enabled = true
    },
}, directIni))
inicfg.save(ini, directIni)
local active = ini.main.enabled

function main()
    while true do
        wait(0)
        if wasKeyPressed(VK_XBUTTON2) then
            active = not active
            sampAddChatMessage('{FFD700}[SAD]Memory{ffffff}: Память '..(active and '{FF0000}Заполнена' or '{00FF00}Очищена'), -1)
            ini.main.enabled = active
            inicfg.save(ini, directIni)
        end
        if isCharInAnyCar(PLAYER_PED) and active then
            if not doesObjectExist(object) then
                object = createObject(19601, 0, 0, -10)
            else
                local veh = storeCarCharIsInNoSave(PLAYER_PED)
                local c = getCarModelCorners(getCarModel(veh))
                local offset = getDistanceBetweenCoords3d(c[1][1], c[1][2], c[1][3], c[4][1], c[4][2], c[4][3])
                setObjectScale(object, 0)
                attachObjectToCar(object, veh, 0, offset / 2, 0, 180, 0, 0)
            end
        else
            if doesObjectExist(object) then
                deleteObject(object)
            end
        end
    end
end

function onScriptTerminate(s, q)
    if s == thisScript() then
        if doesObjectExist(object) then
            deleteObject(object)
        end
    end
end

function getCarModelCorners(id)
    local x1, y1, z1, x2, y2, z2 = getModelDimensions(id)
    local t = {
        [1] = {getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(PLAYER_PED), x1         , y1 * -1.0, z1)}, -- {x = x1, y = y1 * -1.0, z = z1},
        [2] = {getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(PLAYER_PED), x1 * -1.0  , y1 * -1.0, z1)}, -- {x = x1 * -1.0, y = y1 * -1.0, z = z1},
        [3] = {getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(PLAYER_PED), x1 * -1.0  , y1       , z1)}, -- {x = x1 * -1.0, y = y1, z = z1},
        [4] = {getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(PLAYER_PED), x1         , y1       , z1)}, -- {x = x1, y = y1, z = z1},
        [5] = {getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(PLAYER_PED), x2 * -1.0  , y2       , z10)}, -- {x = x2 * -1.0, y = 0, z = 0},
        [6] = {getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(PLAYER_PED), x2 * -1.0  , y2 * -1.0, z2)}, -- {x = x2 * -1.0, y = y2 * -1.0, z = z2},
        [7] = {getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(PLAYER_PED), x2         , y2 * -1.0, z2)}, -- {x = x2, y = y2 * -1.0, z = z2},
        [8] = {getOffsetFromCarInWorldCoords(storeCarCharIsInNoSave(PLAYER_PED), x2         , y2       , z2)}, -- {x = x2, y = y2, z = z2},
    }
    return t
end