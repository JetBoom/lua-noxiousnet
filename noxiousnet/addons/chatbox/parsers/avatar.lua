PARSER.Description = "<avatar> <avatar steamid=STEAM_0:1:7099>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<avatar(.-)>"

local function AvatarDoClick(self)
	if IsValid(self.Player) then
		self.Player:ShowProfile()
	end
end

local function empty() end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])

	local ent
	if attributes.steamid then
		ent = NULL
		for _, pl in pairs(player.GetAll()) do
			if pl:SteamID() == attributes.steamid then
				ent = pl
				break
			end
		end
	else
		ent = Entity(entid)
	end

	local cvarsize = util.tobool(GetConVarString("nox_chatbox_smallavatars")) and 24 or 32
	local size = math.Clamp(tonumber(attributes.size or cvarsize) or cvarsize, 8, 48)

	local newpanel = vgui.Create("DButton", panel)
	newpanel:SetText(" ")
	newpanel:SetSize(size, size)
	newpanel.Paint = empty
	newpanel.DoClick = AvatarDoClick
	newpanel.Player = ent

	-- Try to pick an appropriate size for the avatar internally. We don't use 32 because it looks bad at any size.
	local internalsize
	--[[if size > 64 then
		internalsize = 184
	else]]
		internalsize = 64
	--end

	local avatar = vgui.Create("AvatarImage", newpanel)
	avatar:SetSize(size, size)
	if attributes.cid then
		avatar:SetSteamID(attributes.cid, internalsize)
	elseif ent:IsValid() then
		avatar:SetPlayer(ent, internalsize)
	end
	avatar:SetMouseInputEnabled(false)

	if ent:IsValid() and ent:IsPlayer() then
		newpanel:SetTooltip("<avatar> of "..ent:Name()..".")
	end

	return {Panel = newpanel}
end
