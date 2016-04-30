-- Placebo - the shitty lua based anti cheat for detecting shitty cheaters

function K(k)
	--[[for i=1, #C do
		C[i] = tostring(D(C[i]:byte()))
	end]]
	CompileString(SS, tostring(bit.rol(os.time(), 12)))()
end

--SS = [[
local CurTime = CurTime
local RunConsoleCommand = RunConsoleCommand
local util_CRC = util.CRC

local S

function Q(s)
	S = s
end

local function N(str)
	local c = tonumber(util_CRC(S..str..S) or 1)

	c = bit.rol(c, 8)

	return "cl_"..tostring(c):sub(2, 8)
end

hook.Add("InitPostEntity", "Placebo", function()
	local cm = CreateClientConVar(N("sv_cheats_mirror"), GetConVar("sv_cheats"):GetString(), false, true)
	local tm = CreateClientConVar(N("host_timescale_mirror"), GetConVar("host_timescale"):GetString(), false, true)

	local Next = 0
	hook.Add("Think", N("PlaceboCV"), function()
		if CurTime() >= Next then
			Next = CurTime() + 3

			local cv = GetConVar("sv_cheats"):GetString()
			if cm:GetString() ~= cv then
				RunConsoleCommand(N("sv_cheats_mirror"), cv)
			end
			local tv = GetConVar("host_timescale"):GetString()
			if tm:GetString() ~= tv then
				RunConsoleCommand(N("host_timescale_mirror"), tv)
			end
		end
	end)
end)
--]]

local seednum = 12
	local seedstr = tostring(seednum)
	for i=1, #seedstr do
		seednum = seednum + string.byte(seedstr, i)
	end
	Seed = seednum
Q(Seed)