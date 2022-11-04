local imgui = require("mimgui")
script_name ('information')
script_author ('adshishkov')
---------------------------------[time]----------------------------------
local days = {
    [2] = "�����������",
    [3] = "�������",
    [4] = "�����",
    [5] = "�������",
    [6] = "�������",
    [7] = "�������",
    [1] = "�����������"
}

local months = {
    [1] = "������",
    [2] = "�������",
    [3] = "�����",
    [4] = "������",
    [5] = "���",
    [6] = "����",
    [7] = "����",
    [8] = "�������",
    [9] = "��������",
    [10] = "�������",
    [11] = "������",
    [12] = "�������"
}
---------------------------------[localki]----------------------------------
local ffi = require 'ffi'
local fps = math.ceil(ffi.cast('float*', 0xB7CB50)[0])
local ping = sampGetPlayerPing(myid)
local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
local nameserver = sampGetCurrentServerName()
local score = sampGetPlayerScore(id)
local playedMinutes = 0
local playedSeconds = 0
local onEdit = false
local font = {}
function getFps() return math.ceil(ffi.cast("float*", 0xB7CB50)[0]) end

function main()
    while true do
        wait(0)
--------------------[�����]---------------------------
        ping = sampGetPlayerPing(myid)
        _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        nick = sampGetPlayerNickname(id)
        fps = math.ceil(ffi.cast('float*', 0xB7CB50)[0])
        score = sampGetPlayerScore(id)
        getFps()
        wait(500) -- �������� ���������� FPS
        if tostring(getfps):find(".") then
            newfps = tostring(getfps):match("(%d+).%d+") -- ��� ���������� 152.15468468, ��� ������� ������ 152
            if newfps == nil then
                return false
            end
            fps = newfps
        else
            fps = getfps
        end
------------------[������� �������]--------------------
        wait(1000)
        if not isGamePaused() then
            local arr = os.date("*t")
            playedSeconds = playedSeconds + 1
            if playedSeconds == 60 then
                playedSeconds = 0
                playedMinutes = playedMinutes + 1
            end
            if 60 - arr.min == 0 then
                playedSeconds = 0
                playedMinutes = 0
            end
        end
    end
end
------------------------------------[�����]--------------------------------------
imgui.OnInitialize(function()
    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    local path = getFolderPath(0x14) .. '\\comicbd.ttf'
    imgui.GetIO().Fonts:Clear()
------------------------------------[����� ������ ������]------------------------------------------------------
    imgui.GetIO().Fonts:AddFontFromFileTTF(path, 20, nil, glyph_ranges) --����� ������ ������
----------------------------------[����������� ������� ��� �����]---------------------------------------------
    font[18] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 18.0, nil, glyph_ranges)
    font[25] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 25.0, nil, glyph_ranges)
    font[22] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 22.0, nil, glyph_ranges)
    font[40] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 40.0, nil, glyph_ranges)
---------------------------------------------------------------------------------------------------------------
end)

----------------------------------[MIMGUI]-----------------------------------------------------
imgui.OnFrame(function() return not isPauseMenuActive() end,
function(self)
    self.HideCursor = true
------------------------------------[����� ������ IMGUI ����]----------------------------------------------------------
    imgui.SetNextWindowSize(imgui.ImVec2(202, 238))--[[(������ �������� ������� - ������, ������ ������ ����)]]
    imgui.Begin("Time", nil, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize)
    local arr = os.date("*t")
    imgui.PushFont(font[18])
    imgui.TextColored(imgui.ImVec4(1, 0.48, 0, 1.0)," ".. nameserver)
    imgui.PopFont()
------------------------------------[���������� ����� IMGUI]----------------------------------------------------------
    imgui.BeginChild('##time', imgui.ImVec2(190, 98)--[[(������ �������� �������, ������ ������ ����)]], true --[[���������� �� �����]])
--====[������������ ������ ������ imgui.PushFont popfont]=========
    imgui.PushFont(font[22])
--~~~~~~~~~~~~~~~~~~~~~~~~~~~
    imgui.TextColored(imgui.ImVec4(0.5, 0.7, 0.1, 1.0),(os.date('%H:%M:%S') .. " (".. 60 - arr.min .. ":" .. 60 - arr.sec .. ")"))
    imgui.Separator() -- �����
    imgui.TextColored(imgui.ImVec4(0.9, 0.13, 0.13, 1.0),(("%d %s %d ���"):format(arr.day, months[arr.month], arr.year, days[arr.wday])))
    imgui.Separator() -- �����
    imgui.TextColored(imgui.ImVec4(1, 0.68, 0.05, 1.0),(("(%s)"):format(days[arr.wday])))
--~~~~~~~~~~~~~~~~~~~~~~~~~~~
    imgui.PopFont()
--~~~~~~~~~~~~~~~~~~~~~~~~~~~
    imgui.EndChild()
------------------------------------[���������� ����� IMGUI]-----------------------------------------------------------
    imgui.BeginChild('##nickfps', imgui.ImVec2(190, 95), true --[[���������� �� �����]])
------------------------------------[����� ������]---------------------------------------------------
    imgui.TextColored(imgui.ImVec4(0.1, 0.67, 0.16, 1.0),"".. tostring(nick).. '['..tostring(id)..'] [' ..score..']')
    imgui.Separator() -- �����
    imgui.TextColored(imgui.ImVec4(0.92, 0.93, 0.05, 1.0),"FPS: ".. fps)
    imgui.Separator() -- �����
    imgui.TextColored(imgui.ImVec4(0.92, 0.93, 0.05, 1.0),"PING: " .. ping)
-----------------------------------------------------------------------------------------------------
    imgui.EndChild()
----------------------------------------------------------------------------------------------------------------
    --imgui.CenterText(("�� PayDay: %d:%d"):format(60 - arr.min, 60 - arr.sec))
    --imgui.CenterText(("�� ��� ��������: %d:%d"):format(playedMinutes, playedSeconds))
    imgui.End()
end)

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local lenght = imgui.CalcTextSize(text).x
    imgui.SetCursorPosX((width - lenght) / 2)
    imgui.Text(text)
end
