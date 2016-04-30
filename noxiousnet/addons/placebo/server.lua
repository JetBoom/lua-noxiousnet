-- Placebo - the shitty lua based anti cheat for detecting shitty cheaters
local Seed = ""
function StringName(str)
	local crc = tonumber(util.CRC(Seed..str..Seed) or 1)

	crc = bit.rol(crc, 8)

	return "cl_"..tostring(crc):sub(2, 8)
end

local function HasModerators()
	for _, p in pairs(player.GetAll()) do
		if p:IsModerator() then
			return true
		end
	end

	return false
end

local function WarnModeratorsAbout(pl, reason)
	PrintToModerators(HUD_PRINTTALK, "["..pl:Name().." | "..pl:SteamID().." | "..pl:IPAddress().."] is probably cheating. "..reason)

	--[[if not HasModerators() then
		NDB.InstantBan(pl, "Cheating. You know what you did.", 0, "Placebo")
	end]]
end

---
-- Simple convar checking. First line of defense.
-- Obviously can be detoured or altered but requires a module, stopping cheatengine users.
---

local ConVars = {
	["sv_cheats"] = 0,
	["host_timescale"] = 1
}

local function ConVarChecking()
	local cv

	for cvname, cvsanevalue in pairs(ConVars) do
		cv = GetConVar(cvname)
		if not cv or cvsanevalue ~= cv:GetInt() then
			return false
		end
	end

	return true
end

hook.Add("Initialize", "Placebo", function()
	-- Change network string names every map
	-- Stops people black listing them and forces them to use a white list
	-- One of the required net messages is a ping sent every few minutes
	-- Could probably predict the order.
	local seednum = 12 --os.time()
	local seedstr = tostring(seednum)
	for i=1, #seedstr do
		seednum = seednum + string.byte(seedstr, i)
	end
	Seed = seednum

	--util.AddNetworkString(StringName("pingpong"))
end)

hook.Add("PlayerReady", "Placebo", function(pl) -- They could drop the ready message but they'd not be able to do much at that point.
	--print(pl, "placebo is ready")
	pl.PlaceboReady = true

	--pl:SendLua("function D(_,__) return bit.rol(_, __) end K(0x2e2f) C=util.CRC Q("..Seed..")")
	--pl:SendLua("K(0x2e2f) C=util.CRC Q("..Seed..")")
end)

local NextCheckID = 1
timer.Create("Placebo_ConVarChecking", 3, 0, function()
	if not ConVarChecking() then return end

	local allplayers = player.GetAll()
	local maxplayers = #allplayers

	while not allplayers[NextCheckID] and NextCheckID < maxplayers do
		NextCheckID = NextCheckID + 1
	end
	if NextCheckID > maxplayers then
		NextCheckID = 1
	end

	local pl = allplayers[NextCheckID]
	if not IsValid(pl) or not pl.PlaceboReady or pl:IsBot() then return end

	for cvname, cvsanevalue in pairs(ConVars) do
		local num = pl:GetInfoNum(StringName(cvname.."_mirror"), -1) -- This requires a module to detour
		if num == -1 then
			WarnModeratorsAbout(pl, "Can't read their "..cvname..".")
		elseif num ~= cvsanevalue then
			WarnModeratorsAbout(pl, "Expected their "..cvname.." to be "..cvsanevalue.." but is "..num..".")
		end
	end

	NextCheckID = NextCheckID + 1
end)
