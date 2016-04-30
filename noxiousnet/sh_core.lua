NDB = {}

include("buffthefps.lua")
include("nixthelag.lua")

include("sh_globals.lua")
include("sh_maplist.lua")

include("extensions/sh_file.lua")
include("extensions/sh_timer.lua")
include("extensions/sh_string.lua")
include("extensions/sh_table.lua")
include("extensions/sh_color.lua")
include("extensions/sh_entity.lua")
include("extensions/sh_player.lua")
include("extensions/sh_serialize.lua")

include("addons/sh_costumes.lua")
include("addons/sh_labels.lua")
include("addons/sh_punishments.lua")
include("addons/sh_shop.lua")
include("addons/sh_statushook.lua")
include("addons/sh_votemap.lua")
include("addons/sh_expressions.lua")

function AccountID(str)
	return string.sub(str, 11)
end

function AccountFolder(id)
	return "noxaccounts/"..string.sub(id, 1, 2)
end

function AccountFile(id)
	return AccountFolder(id).."/"..id..".txt"
end

local validmodels = player_manager.AllValidModels()
validmodels["tf01"] = nil
validmodels["tf02"] = nil

function tonumbersafe(a)
	local n = tonumber(a)

	if n then
		if n == 0 or n < 0 or n > 0 then
			return n
		end

		-- NaN!
		return 0
	end

	return n
end

if not FixedSoundDuration then
FixedSoundDuration = true
local OldSoundDuration = SoundDuration
function SoundDuration(snd)
	if snd then
		local ft = string.sub(snd, -4)
		if ft == ".mp3" then
			return OldSoundDuration(snd) * 2.25
		end
		if ft == ".ogg" then
			return OldSoundDuration(snd) * 3
		end
	end

	return OldSoundDuration(snd)
end
end
