--CACHED GLOBALS
local next = next
local pairs = pairs
local table_insert = table.insert
local NULL = NULL

local system_HasFocus = system.HasFocus
--

local Cache = {}
local Requesting = {}
local WaitingFor = {}
local Playing = {}

local snd_mute_losefocus = GetConVar("snd_mute_losefocus")

local snd_uid = 0

hook.Add("Think", "dynsoundparent", function()
	for uid, snd in pairs(Playing) do
		if snd.channel:IsValid() then
			if snd.distort then
				snd.channel:SetPlaybackRate(snd.pitch * (1 + math.sin((uid + RealTime()) * 5) * 0.4))
			end

			if snd_mute_losefocus:GetBool() and not system_HasFocus() then
				snd.channel:Stop()
			elseif snd.parent and snd.parent:IsValid() then
				snd.channel:SetPos(snd.parent:EyePos())
			end
		else
			Playing[uid] = nil
		end
	end
end)

local function CreateSound(name, ent_or_pos, pitch, distort)
	if not ent_or_pos then return end

	local islocal = ent_or_pos == LocalPlayer()

	sound.PlayFile("data/noxiousnetdynsound/"..name..".dat", islocal and "" or "3d mono", function(channel, errorid)
		if errorid then return end

		if pitch then
			channel:SetPlaybackRate(pitch)
		end

		local snd = {
			distort = distort,
			pitch = pitch,
			channel = channel
		}

		if not islocal then
			channel:Set3DFadeDistance(450, 0)
			channel:SetVolume(1)

			if ent_or_pos.x and ent_or_pos.GetNormalized then
				channel:SetPos(ent_or_pos)
			elseif ent_or_pos:IsValid() then
				channel:SetPos(ent_or_pos:EyePos())
				snd.parent = ent_or_pos
			else
				channel:Stop()
			end
		end

		snd_uid = snd_uid + 1
		Playing[snd_uid] = snd
	end)
end

hook.Add("InitPostEntity", "dynsound", function()
	file.CreateDir("noxiousnetdynsound")

	local files = file.Find("noxiousnetdynsound/*.dat", "DATA")

	for _, fil in next, files do
		Cache[string.StripExtension(fil)] = true
	end
end)

local function FetchDynSound(name)
	if Requesting[name] then return end

	Cache[name] = nil
	Requesting[name] = true

	http.Fetch("https://noxiousnet.com/static/dynsound/"..name..".ogg",
	function(body, length, headers, code)
		if code and code >= 200 and code < 300 and body and #body > 0 then
			Cache[name] = true
			Requesting[name] = nil

			file.Write("noxiousnetdynsound/"..name..".dat", body)

			if WaitingFor[name] then
				local wait = WaitingFor[name]
				WaitingFor[name] = nil

				for _, w in next, wait do
					CreateSound(name, w.ent, w.pitch, w.distort)
				end
			end
		end
	end,
	function()
		Requesting[name] = nil
	end)
end

function NDB.PlayDynSound(name, ent_or_pos, pitch, distort)
	if snd_mute_losefocus:GetBool() and not system_HasFocus() then return end

	name = string.StripExtension(name)

	if Cache[name] then
		CreateSound(name, ent_or_pos, pitch, distort)
	else
		WaitingFor[name] = WaitingFor[name] or {}
		table_insert(WaitingFor[name], {ent = ent_or_pos, pitch = pitch, distort = distort})
		FetchDynSound(name)
	end
end
