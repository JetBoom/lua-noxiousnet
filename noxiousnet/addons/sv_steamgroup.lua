local SteamGroupID = "103582791429579864"

local function MessageInGroup(pl)
	if pl:IsValid() and not pl:IsInNoxSteamGroup() then
		pl:PrintMessage(HUD_PRINTTALK, "Join our Steam group: <lg>www.steamcommunity.com/groups/noxiousnet</lg> for <lg>+10% map voting power</lg>!")
	end
end

hook.Add("PlayerInitialSpawn", "SteamGroup_PlayerInitialSpawn", function(pl)
	pl.GroupStatus = pl.GroupStatus or {}

	if pl:RequestGroupStatus(SteamGroupID) then
		timer.SimpleEx(15, MessageInGroup, pl)
	end
end)

hook.Add("GSGroupStatus", "SteamGroup_GSGroupStatus", function(steamid, groupid, member, officer)
	for _, pl in pairs(player.GetAll()) do
		if pl:SteamID() == steamid then
			if member then
				pl.GroupStatus[groupid] = officer
			else
				pl.GroupStatus[groupid] = nil
			end

			break
		end
	end
end)

local meta = FindMetaTable("Player")
if not meta then return end

function meta:RequestGroupStatus(groupid)
	if furryfinder then
		local result, a = pcall(furryfinder.RequestGroupStatus, self:SteamID(), groupid)
		if result then
			return a
		end
	end
end

function meta:IsInSteamGroup(groupid)
	return self.GroupStatus ~= nil and self.GroupStatus[groupid] ~= nil
end

function meta:IsSteamGroupOfficer(groupid)
	return self.GroupStatus ~= nil and self.GroupStatus[groupid]
end

function meta:IsInNoxSteamGroup()
	return self:IsInSteamGroup(SteamGroupID)
end

function meta:IsNoxSteamGroupOfficer()
	return self:IsSteamGroupOfficer(SteamGroupID)
end

pcall(require, "furryfinder")
