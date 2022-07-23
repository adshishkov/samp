local se = require 'samp.events'
local vehNames = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista-C", "P-Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring A", "Hotring B", "Bloodring", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV-1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat", "Streak", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale Shit", "Sadler Shit", "Luggage", "Luggage", "Stairs", "Boxville", "Tiller", "Utility"}

function se.onServerMessage(color, text)
	if color == 0x73B461FF and text:match('^%[ News .. %]') then
		return false
	end

	if 	text:find('В нашем магазине ты можешь приобрести нужное количество игровых денег и потратить', 1, true) or 
		text:find('их на желаемый тобой {FFFFFF}бизнес, дом, аксессуар{6495ED} или на покупку каких-нибудь безделушек.', 1, true) or 
		text:find('Игроки со статусом {FFFFFF}VIP{6495ED} имеют большие возможности, подробнее /help [Преимущества VIP]', 1, true) or
		text:find('можно приобрести редкие {FFFFFF}автомобили, аксессуары, воздушные шары', 1, true) or
		text:find('предметы, которые выделят тебя из толпы! Наш сайт: {FFFFFF}arizona-rp.com', 1, true) then
		return false
	end

	if 	text:find('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', 1, true) or
		text:find('- Основные команды сервера: /menu /help /gps /settings', 1, true) or
		text:find('- Пригласи друга и получи бонус в размере $300 000!', 1, true) or
		text:find('- Наш сайт: arizona-rp.com (Личный кабинет/Донат)', 1, true) then
		return false
	end

	if text:find('{DFCFCF}[Подсказка] {DC4747}Чтобы завести двигатель введите {DFCFCF}/engine{DC4747} или нажмите {DFCFCF}N', 1, true) then
		local car 	= storeCarCharIsInNoSave(PLAYER_PED)
		local name 	= doesVehicleExist(car) and vehNames[getCarModel(car) - 399] or 'Unknown'
		local id 	= doesVehicleExist(car) and select(2, sampGetVehicleIdByCarHandle(car)) or '?'
		local outtext = string.format('[Подсказка] {CCCCCC}Транспорт: {33AA33}%s[%s]{CCCCCC} | Двигатель: {33AA33}N{CCCCCC} | Поворотники: {33AA33}Q/E{CCCCCC}', name, id)
		return { 0x33AA33FF, outtext }
	elseif 	text:find('{DFCFCF}[Подсказка] {DC4747}Чтобы включить радио используйте кнопку {DFCFCF}R', 1, true) or
			text:find('{DFCFCF}[Подсказка] {DC4747}Для управления поворотниками используйте клавиши: {DFCFCF}(Q/E)', 1, true) or
			text:find('{DFCFCF}[Подсказка] {DC4747}В транспорте присутствует радио{DFCFCF} [/radio]', 1, true) then
		return false
	end

	if color == 0x73B461FF then
		local ad, tel = text:match('^Объявление:%s(.+)%.%sОтправил:%s[A-z0-9_]+%[%d+%]%sТел%.%s(%d+)')
		if ad ~= nil then
			local outstring = string.format('AD: {73B461}%s {D5A457}| Тел: %s', ad, tel)
			return { 0xD5A457FF, outstring }
		elseif text:find('Отредактировал сотрудник') then
			return false
		end
	end

	if color == -1 then
		local ad, tel = text:match('^{%x+}%[VIP%]%sОбъявление:%s(.+)%.%sОтправил:%s[A-z0-9_]+%[%d+%]%sТел%.%s(%d+)')
		if ad ~= nil then
			local outstring = string.format('VIP AD: {73B461}%s {D5A457}| Тел: %s', ad, tel)
			return { 0xD5A457FF, outstring }
		elseif text:find('Отредактировал сотрудник') then
			return false
		end
	end

	if text:find('Администратор') then
		if color == -10270721 then -- действия FF6347FF
			return { 0xFF0063FF, text }
		elseif color == -2686721 then -- /ao FFD700FF
			return { 0xFF0063FF, text }
		end
	end

	if text:match('^{6495ED}%[VIP%]') then
		text = text:gsub('^{6495ED}%[VIP%]', '[VIP]')
		return { 0x00C6FfFF, text }
	end

	if text:match('^{F345FC}%[PREMIUM%]') then
		text = text:gsub('^{F345FC}%[PREMIUM%]', '[PREMIUM]')
		return { 0x00FF99FF, text }
	end

	if text:match('^{FCC645}%[ADMIN%]') then
		text = text:gsub('^{FCC645}%[ADMIN%]', '[ADMIN]')
		return { 0xFF0063FF, text }
	end

	local sec = string.match(text, '^Вы заглушены. Оставшееся время заглушки (%d+) секунд')
	if sec ~= nil then
		local end_mute = os.time() + tonumber(sec)
		local get = function(count)
			local normal = count + (86400 - os.date('%H', 0) * 3600)
			if count < 3600 then
				return os.date('%M:%S', normal)
			else
			    return os.date('%H:%M:%S', normal)
			end
		end
		text = text:gsub('%d+ секунд', get(end_mute - os.time()) .. ' (До ' .. os.date('%H:%M:%S', end_mute) .. ')')
		return { color, text }
	end
end