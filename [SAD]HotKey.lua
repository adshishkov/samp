script_name('HotKey')
script_author('adshishkov')
script_version('1.0')

local key = require 'vkeys'

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    while true do
    wait(0)
        -- Lock Car
        if not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() and not sampIsCursorActive() then
            if wasKeyPressed(key.VK_L) then
            sampSendChat('/lock')
            end
        end
        -- Key Car
        if not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() and not sampIsCursorActive() then
            if wasKeyPressed(key.VK_K) then
            sampSendChat('/key')
            end
        end
        -- Bring down Anim
        if not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() and not sampIsCursorActive() then
            if wasKeyPressed(key.VK_1) then
            if not isCharInAnyCar(PLAYER_PED) then clearCharTasksImmediately(PLAYER_PED) setPlayerControl(playerHandle, 1) freezeCharPosition(PLAYER_PED, false) end
            end
        end
        -- Time
        if not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() and not sampIsCursorActive() then
            if wasKeyPressed(key.VK_X) then
            sampSendChat('/time')
            wait(1000)
            sampSendChat('/me приподн€в руку смотрит на часы [Apple Watch 7]')
            wait(1000)
            sampSendChat("/do —ейчас на часах: " .. os.date("%X"))
            end
        end
        -- Mask
        if not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() and not sampIsCursorActive() then
            if wasKeyPressed(key.VK_M) then
            sampSendChat('/mask')
            end
        end
    end
end