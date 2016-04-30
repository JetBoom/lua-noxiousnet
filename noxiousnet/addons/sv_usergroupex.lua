local meta = FindMetaTable("Player")
if not meta then return end

function meta:SetUserGroup(name, active)
	if active == nil then active = true end

	self:SetNWString("UserGroup", name)
end

hook.Add("PlayerInitialSpawn", "PlayerAuthSpawn", function(pl)
	if pl.UGroupAdded then return end
	pl.UGroupAdded = true

	if game.SinglePlayer() or ply:IsListenServerHost() then
		ply:AddUserGroup("superadmin")
		return
	end

	local steamid = ply:SteamID()
	local steamids = util.GetUserGroups()

	if steamids[steamid] == nil then
		ply:SetUserGroup("user")
		return
	end

	-- Admin SteamID need to be fully authenticated by Steam!
	if ply.IsFullyAuthenticated and not ply:IsFullyAuthenticated() then
		ply:ChatPrint(string.format("Hey '%s' - Your SteamID wasn't fully authenticated, so your usergroup has not been set to '%s.'",
			steamids[steamid].name, steamids[steamid].group))
		ply:ChatPrint("Try restarting Steam.")
		return
	end

	ply:SetUserGroup(steamids[steamid].group)
	ply:ChatPrint(string.format("Hey '%s' - You're in the '%s' group on this server.",
		steamids[steamid].name, steamids[steamid].group))
end)
