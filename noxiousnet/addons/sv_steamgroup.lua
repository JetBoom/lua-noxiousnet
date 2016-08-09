local SteamGroupID = "103582791429579864"

local InGroup = {}

local function MessageInGroup(pl)
	if pl:IsValid() and not pl:IsInNoxSteamGroup() then
		pl:PrintMessage(HUD_PRINTTALK, "Join our Steam group: <lg>www.steamcommunity.com/groups/noxiousnet</lg> for <lg>+10% map voting power</lg>!")
	end
end

hook.Add("PlayerInitialSpawn", "SteamGroup_PlayerInitialSpawn", function(pl)
	timer.Simple(20, function() MessageInGroup(pl) end)
end)

local function RefreshSteamGroupStatus(page)
	page = page or 1

	http.Fetch("http://steamcommunity.com/gid/"..SteamGroupID.."/memberslistxml/?xml=1&p="..page, function(body)
		if not body then return end

		local online = tonumber(body:match("%<membersOnline%>(%d*)%<%/membersOnline%>") or 0) or 0
		local totalpages = math.ceil(online / 1000)

		if page == 1 then
			InGroup = {}
		end

		for steamid64 in body:gmatch("%<steamID64%>([0-9]+)%<%/steamID64%>") do
			InGroup[steamid64] = true
		end

		if page < totalpages then
			timer.Simple(2.5, function() RefreshSteamGroupStatus(page + 1) end)
		else
			print("Finished refreshing group membership for "..online.." online steamid64s")
		end
	end)
end

timer.Create("RefreshSteamGroupStatus", 600, 0, RefreshSteamGroupStatus)
hook.Add("InitPostEntity", "RefreshSteamGroupStatus", function() timer.Simple(5, RefreshSteamGroupStatus) end)

local meta = FindMetaTable("Player")
if not meta then return end

function meta:IsInNoxSteamGroup()
	return InGroup[self:SteamID64()]
end
