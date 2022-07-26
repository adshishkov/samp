script_name('Time')
script_author('adshishkov')
script_version('1.0')

--~ =========================================================[LIBS]=========================================================
local res                   = pcall(require, 'lib.moonloader')                      assert(res, 'Lib MOONLOADER not found!')
local res                   = pcall(require, 'lib.sampfuncs')                       assert(res, 'Lib SAMPFUNCS not found')
local res, inicfg           = pcall(require, 'inicfg')                              assert(res, 'Lib INICFG not found')
local res, socket           = pcall(require, 'socket')                              assert(res, 'Lib SOCKET not found')
--~ =========================================================[VARS]=========================================================
local moving = false
--~ =========================================================[INI]=========================================================
local f_ini         = getGameDirectory().."\\moonloader\\[SAD]Projects\\Time\\settings.ini"
ini = {
    settings = {
        activate = false,
        x = 300,
        y = 300,
        color = "FFFFFF",
        msColor = "󙄟�3",
        fontsize = 12
    }
}
local config = inicfg.load(nil, f_ini)
--~ =========================================================[MAIN]=========================================================
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then error(script_name..' needs SA:MP and SAMPFUNCS!') end
    while not isSampAvailable() do wait(100) end
    ----------------------------------------------------------------
    if config == nil then
        createDirectory(getGameDirectory().."\\moonloader\\[SAD]Projects\\Time")
        local f = io.open(f_ini, "w")
        f:close()
        if inicfg.save(ini, f_ini) then 
            config = inicfg.load(nil, f_ini)
        end
        print("Created default settings.ini") 
    end
    ----------------------------------------------------------------
    font = renderCreateFont("JetBrains Mono", config.settings.fontsize, 9)
    ----------------------------------------------------------------
    sampRegisterChatCommand('atime', cmd_atime)
    ----------------------------------------------------------------------
    local hour = tonumber(os.date("%H"))
    local name = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
    if hour >= 5 and hour <= 10 then chatmsg(string.format("念狃铄 篁痤, %s! {C3C3C3}(/atime)", name)) end
    if hour >= 11 and hour <= 16 then chatmsg(string.format("念狃 溴睃, %s! {C3C3C3}(/atime)", name)) end
    if hour >= 17 and hour <= 22 then chatmsg(string.format("念狃 忮麇�, %s! {C3C3C3}(/atime)", name)) end
    if hour >= 23 or hour <= 4 then chatmsg(string.format("念狃铋 眍麒, %s! {C3C3C3}(/atime)", name)) end
    ----------------------------------------------------------------
    while true do
        wait(0)
        if config.settings.activate or moving then
            if moving then
                sampToggleCursor(true)
                local x, y = getCursorPos()
                config.settings.x = x
                config.settings.y = y
                if isKeyJustPressed(0x01) then
                    moving = false
                    sampToggleCursor(false)
                    inicfg.save(config, f_ini)
                end
            end
            local date_table = os.date("*t")
            local ms = tostring(math.ceil(socket.gettime()*1000))
            local ms = tonumber(string.sub(ms, #ms-2, #ms))
            local hour, minute, second = date_table.hour, date_table.min, date_table.sec
            local result = string.format("    %02d:%02d:%02d{" ..config.settings.msColor.. "}\n{0bfc75}Arthur Shishkov", hour, minute, second)

            renderFontDrawText(font, result, config.settings.x, config.settings.y, "0xFF"..config.settings.color)
        end
    end
end
--~ =========================================================[FUNC]=========================================================
function chatmsg(text)
    sampAddChatMessage(string.format("[SAD]Time: {FFFFFF}%s", text), 0xA77BCA)
end
--~ =========================================================[CMDS]=========================================================
function cmd_atime()
    lua_thread.create(function()
        local dtext = "悟钺疣驵螯 怵屐� 磬 疣礤\t" .. (config.settings.activate and "{45d900}ON\n" or "{ff0000}OFF\n") -- 0
        local dtext = dtext .. "朽珈屦 梏蜞:\t" .. config.settings.fontsize .. "\n"                    -- 1
        local dtext = dtext .. "肘弪 怵屐屙�:\t{" .. config.settings.color .. "}||||||||||\n"           -- 2
        local dtext = dtext .. "肘弪 扈腚桉尻箜�:\t{" .. config.settings.msColor .. "}||||||||||\n"     -- 3
        local dtext = dtext .. "如戾龛螯 镱腩驽龛�"                                                      -- 4
        sampShowDialog(10, "{A77BCA}[SAD]Time", dtext, "OK", "悟戾磬", DIALOG_STYLE_TABLIST)
        while sampIsDialogActive(10) do wait(0) end
        local result, button, list, input = sampHasDialogRespond(10)

        if result and button == 1 then
            if list == 0 then
                config.settings.activate = not config.settings.activate
                inicfg.save(config, f_ini)
                return true
            end

            if list == 1 then
                sampShowDialog(11, "{A77BCA}[SAD]Time", "{FFFFFF}骡邃栩� 眍忸� 珥圜屙桢 梏蜞:", "OK", "悟戾磬", DIALOG_STYLE_INPUT)
                while sampIsDialogActive(11) do wait(0) end
                local result, button, list, input = sampHasDialogRespond(11)
                if result then
                    if tonumber(input) then
                        config.settings.fontsize = tonumber(input)
                        font = renderCreateFont('Arial', config.settings.fontsize, 5)
                        inicfg.save(config, f_ini)
                        return true
                    else
                        chatmsg("琼圜屙桢 漕腈眍 猁螯 麒耠铎!")
                        return true
                    end
                else
                    return true
                end
            end

            if list == 2 then
                sampShowDialog(11, "{A77BCA}[SAD]Time", "{FFFFFF}骡邃栩� 眍忸� 珥圜屙桢 鲡弪�:\n{c3c3c3}袜镳桁屦: AE433D 桦� A77BCA (镱 箪铍鬣龛� FFFFFF)", "OK", "悟戾磬", DIALOG_STYLE_INPUT)
                while sampIsDialogActive(11) do wait(0) end
                local result, button, list, input = sampHasDialogRespond(11)
                if result then
                    if not input:match("[�-��-擗竇+") then
                        config.settings.color = input
                        inicfg.save(config, f_ini)
                        return true
                    else
                        chatmsg("湾镳噔桦 忖钿.")
                        return true
                    end
                else
                    return true
                end
            end

            if list == 3 then
                sampShowDialog(11, "{A77BCA}[SAD]Time", "{FFFFFF}骡邃栩� 眍忸� 珥圜屙桢 鲡弪�:\n{c3c3c3}袜镳桁屦: AE433D 桦� A77BCA (镱 箪铍鬣龛� 858585)", "OK", "悟戾磬", DIALOG_STYLE_INPUT)
                while sampIsDialogActive(11) do wait(0) end
                local result, button, list, input = sampHasDialogRespond(11)
                if result then
                    if not input:match("[�-��-擗竇+") then
                        config.settings.msColor = input
                        inicfg.save(config, f_ini)
                        return true
                    else
                        chatmsg("湾镳噔桦 忖钿.")
                        return true
                    end
                else
                    return true
                end
            end

            if list == 4 then
                moving = true
                chatmsg("袜骒栩� 耸� 潆� 耦躔囗屙�� 镱腩驽龛�.")
            end
        end
    end)
end
