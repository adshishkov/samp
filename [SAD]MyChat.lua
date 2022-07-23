local se = require 'samp.events'
local vehNames = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista-C", "P-Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring A", "Hotring B", "Bloodring", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV-1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat", "Streak", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale Shit", "Sadler Shit", "Luggage", "Luggage", "Stairs", "Boxville", "Tiller", "Utility"}

function se.onServerMessage(color, text)
	if color == 0x73B461FF and text:match('^%[ News .. %]') then
		return false
	end

	if 	text:find('� ����� �������� �� ������ ���������� ������ ���������� ������� ����� � ���������', 1, true) or 
		text:find('�� �� �������� ����� {FFFFFF}������, ���, ���������{6495ED} ��� �� ������� �����-������ ����������.', 1, true) or 
		text:find('������ �� �������� {FFFFFF}VIP{6495ED} ����� ������� �����������, ��������� /help [������������ VIP]', 1, true) or
		text:find('����� ���������� ������ {FFFFFF}����������, ����������, ��������� ����', 1, true) or
		text:find('��������, ������� ������� ���� �� �����! ��� ����: {FFFFFF}arizona-rp.com', 1, true) then
		return false
	end

	if 	text:find('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', 1, true) or
		text:find('- �������� ������� �������: /menu /help /gps /settings', 1, true) or
		text:find('- �������� ����� � ������ ����� � ������� $300 000!', 1, true) or
		text:find('- ��� ����: arizona-rp.com (������ �������/�����)', 1, true) then
		return false
	end

	if text:find('{DFCFCF}[���������] {DC4747}����� ������� ��������� ������� {DFCFCF}/engine{DC4747} ��� ������� {DFCFCF}N', 1, true) then
		local car 	= storeCarCharIsInNoSave(PLAYER_PED)
		local name 	= doesVehicleExist(car) and vehNames[getCarModel(car) - 399] or 'Unknown'
		local id 	= doesVehicleExist(car) and select(2, sampGetVehicleIdByCarHandle(car)) or '?'
		local outtext = string.format('[���������] {CCCCCC}���������: {33AA33}%s[%s]{CCCCCC} | ���������: {33AA33}N{CCCCCC} | �����������: {33AA33}Q/E{CCCCCC}', name, id)
		return { 0x33AA33FF, outtext }
	elseif 	text:find('{DFCFCF}[���������] {DC4747}����� �������� ����� ����������� ������ {DFCFCF}R', 1, true) or
			text:find('{DFCFCF}[���������] {DC4747}��� ���������� ������������� ����������� �������: {DFCFCF}(Q/E)', 1, true) or
			text:find('{DFCFCF}[���������] {DC4747}� ���������� ������������ �����{DFCFCF} [/radio]', 1, true) then
		return false
	end

	if color == 0x73B461FF then
		local ad, tel = text:match('^����������:%s(.+)%.%s��������:%s[A-z0-9_]+%[%d+%]%s���%.%s(%d+)')
		if ad ~= nil then
			local outstring = string.format('AD: {73B461}%s {D5A457}| ���: %s', ad, tel)
			return { 0xD5A457FF, outstring }
		elseif text:find('�������������� ���������') then
			return false
		end
	end

	if color == -1 then
		local ad, tel = text:match('^{%x+}%[VIP%]%s����������:%s(.+)%.%s��������:%s[A-z0-9_]+%[%d+%]%s���%.%s(%d+)')
		if ad ~= nil then
			local outstring = string.format('VIP AD: {73B461}%s {D5A457}| ���: %s', ad, tel)
			return { 0xD5A457FF, outstring }
		elseif text:find('�������������� ���������') then
			return false
		end
	end

	if text:find('�������������') then
		if color == -10270721 then -- �������� FF6347FF
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

	local sec = string.match(text, '^�� ���������. ���������� ����� �������� (%d+) ������')
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
		text = text:gsub('%d+ ������', get(end_mute - os.time()) .. ' (�� ' .. os.date('%H:%M:%S', end_mute) .. ')')
		return { color, text }
	end
end