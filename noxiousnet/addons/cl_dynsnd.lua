--CACHED GLOBALS
local next = next
local table_insert = table.insert
local NULL = NULL

local system_HasFocus = system.HasFocus
--

local Cache = {}
local Requesting = {}
local WaitingFor = {}
local Parents = {}

local snd_mute_losefocus = GetConVar("snd_mute_losefocus")

hook.Add("Think", "dynsoundparent", function()
	for channel, parent in next, Parents do
		if channel:IsValid() then
			if snd_mute_losefocus:GetBool() and not system_HasFocus() then
				channel:Stop()
			elseif parent:IsValid() then
				channel:SetPos(parent:EyePos())
			end
		else
			Parents[channel] = nil
		end
	end
end)

local function CreateSound(name, ent_or_pos, pitch)
	--print("CreateSound", name, ent_or_pos, pitch)
	if not ent_or_pos then return end

	local islocal = ent_or_pos == LocalPlayer()

	sound.PlayFile("data/noxiousnetdynsound/"..name..".dat", islocal and "" or "3d mono", function(channel, errorid)
		if errorid or islocal then return end

		channel:Set3DFadeDistance(450, 0)
		channel:SetVolume(1)
		if pitch then
			channel:SetPlaybackRate(pitch)
		end

		if ent_or_pos.x and ent_or_pos.GetNormalized then
			channel:SetPos(ent_or_pos)
			Parents[channel] = NULL
		elseif ent_or_pos:IsValid() then
			channel:SetPos(ent_or_pos:EyePos())
			Parents[channel] = ent_or_pos
		else
			channel:Stop()
		end
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

	--print("fetching "..name)

	http.Fetch("https://noxiousnet.com/static/dynsound/"..name..".ogg",
		function(body, length, headers, code)
			--print("code "..code)
			if code and code >= 200 and code < 300 and body and #body > 0 then
				--print("ok writing")
				Cache[name] = true
				Requesting[name] = nil

				file.Write("noxiousnetdynsound/"..name..".dat", body)

				if WaitingFor[name] then
					local wait = WaitingFor[name]
					WaitingFor[name] = nil

					for _, w in next, wait do
						CreateSound(name, w.ent, w.pitch)
					end
				end
			end
		end,
		function()
			Requesting[name] = nil
		end)
end

function NDB.PlayDynSound(name, ent_or_pos, pitch)
	if snd_mute_losefocus:GetBool() and not system_HasFocus() then return end

	name = string.StripExtension(name)

	if Cache[name] then
		CreateSound(name, ent_or_pos, pitch)
	else
		WaitingFor[name] = WaitingFor[name] or {}
		table_insert(WaitingFor[name], {ent = ent_or_pos, pitch = pitch})
		FetchDynSound(name)
	end
end
