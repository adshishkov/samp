script_name('Fps and Ping')
script_author('adshishkov')
script_version('1.0')


require 'lib.moonloader'
local memory = require 'memory'
local ffi = require("ffi")
local inicfg = require "inicfg"
local cfg = inicfg.load({
   config = {
      CPX = 13,
      CPY = 992,
      SizeFont = 7,
      FlagFont = 5,
   }
}, "\\[SAD]Projects\\Fps and Ping\\settings.ini")
font = renderCreateFont("JetBrains Mono", cfg.config.SizeFont, cfg.config.FlagFont)

local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local window = imgui.ImBool(false)
local sizefont = imgui.ImInt(cfg.config.SizeFont)
local flagfont = imgui.ImInt(cfg.config.FlagFont)

fps = {
   last_update = 0,
   value = 0,
   get = function()
      if os.clock() - fps.last_update > 1 then
         fps.last_update = os.clock()
         fps.value = math.ceil(ffi.cast('float*', 0xB7CB50)[0])
         ping = sampGetPlayerPing(id)
      end
      return fps.value
   end
}

function imgui.OnDrawFrame()
   if window.v then
      imgui.SetNextWindowPos(imgui.ImVec2(350.0, 250.0), imgui.Cond.FirstUseEver)
      imgui.Begin('Fps and Ping', window, imgui.WindowFlags.AlwaysAutoResize)
      if imgui.Button(u8'Изменить позицию') then
         changepos = true             
         sampAddChatMessage('Нажмите ЛКМ чтобы сохранить позицию.',-1) 
         window.v = false
      end
      imgui.Text(u8'Размер шрифта')
      imgui.SameLine()
      imgui.PushItemWidth(70)
      if imgui.InputInt('##size', sizefont) then
         font = renderCreateFont("JetBrains Mono", cfg.config.SizeFont, cfg.config.FlagFont)
         cfg.config.SizeFont = sizefont.v
         inicfg.save(cfg, "\\[SAD]Projects\\Fps and Ping\\settings.ini")
      end
      imgui.Text(u8'Флаг шрифта')
      imgui.SameLine()
      imgui.PushItemWidth(70)
      if imgui.InputInt('##flag', flagfont) then
         font = renderCreateFont("JetBrains Mono", cfg.config.SizeFont, cfg.config.FlagFont)
         cfg.config.FlagFont = flagfont.v
         inicfg.save(cfg, "\\[SAD]Projects\\Fps and Ping\\settings.ini")
      end
      imgui.End()
   end
end

function main()
   while not isSampAvailable() do wait(0) end
   imgui.Process = false
   sampRegisterChatCommand('fp', function()
      window.v = not window.v
   end)
   _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
   while true do
      wait(0)
      imgui.Process = window.v
      currentFps = fps.get()
      -- RENDER -- 
      renderFontDrawText(font,'{FFD700}'..ping..'       {00FA9A}  '..currentFps, cfg.config.CPX, cfg.config.CPY, 0xFFFFFFFF, 0x90000000)
      -- POS --
      if changepos then
         sampToggleCursor(true)
         local CPX, CPY = getCursorPos()
         cfg.config.CPX = CPX
         cfg.config.CPY = CPY
         inicfg.save(cfg, "\\[SAD]Projects\\Fps and Ping\\settings.ini")
      end
      if isKeyJustPressed(VK_LBUTTON) and changepos then
         changepos = false
         sampToggleCursor(false)
         sampAddChatMessage('Позиция сохранена.', -1)
         window.v = true
      end
   end
end