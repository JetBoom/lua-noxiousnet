local VoteMap = NDB.VoteMap

VoteMap.DisabledMaps = {}

function VoteMap.InitiateVoteMap(votetime, displaymenutime)
	for _, pl in pairs(player.GetAll()) do -- This refreshes everyone's votes if they voted before the game was over.
		local curvote = VoteMap.GetVote(pl)
		if curvote then
			local oldvotes = curvote[2]
			curvote[2] = VoteMap.GetVoteCount(pl) or 1
			if curvote[2] ~= oldvotes then
				VoteMap.Send(pl)
			end
		end
	end

	votetime = votetime or 30
	VoteMap.EndTime = CurTime() + votetime
	timer.SimpleEx(displaymenutime or 5, BroadcastLua, "NDB.OpenVoteMapMenu()")

	timer.SimpleEx(votetime, game.LoadNextMap)
	timer.SimpleEx(votetime + 30, RunConsoleCommand, "changelevel", game.GetMap())

	NDB.GlobalSave()
end

function VoteMap.Send(pl, filter)
	local uniqueid = VoteMap.UniqueID(pl)
	local vote = VoteMap.Votes[uniqueid]
	if vote then
		net.Start("nox_votemapvote")
			net.WriteString(uniqueid)
			net.WriteUInt(vote[1], 16)
			net.WriteUInt(vote[2], 16)
		if filter then
			net.Send(filter)
		else
			net.Broadcast()
		end
	end
end

function VoteMap.SendAll(filter)
	local votes = VoteMap.Votes
	local count = table.Count(votes)

	net.Start("nox_votemapvotes")
	net.WriteUInt(count, 16)
	for uniqueid, vote in pairs(votes) do
		net.WriteString(uniqueid)
		net.WriteUInt(vote[1], 16)
		net.WriteUInt(vote[2], 16)
	end
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

function VoteMap.SendLocks(filter)
	local locks = VoteMap.GetLocks()
	local tosend = {}

	for lockid, lockstate in pairs(locks) do
		if lockstate ~= 0 then
			tosend[lockid] = lockstate
		end
	end

	net.Start("nox_votemapunlocks")
	net.WriteUInt(table.Count(tosend), 16)
	for k, v in pairs(tosend) do
		net.WriteUInt(k, 16)
		net.WriteUInt(v, 8)
	end
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

concommand.Add("nnvotemap", function(sender, command, arguments)
	if VoteMap.RandomMap then
		sender:PrintMessage(HUD_PRINTTALK, "<red>A random map is being chosen this round.</red>")
		return
	end

	if not sender:IsValid() or sender:IsPunishedNotify(PUNISHMENT_NOVOTES) or CurTime() < (sender.NextVoteMap or 0) then return end
	sender.NextVoteMap = CurTime() + 1

	local maplist = VoteMap.GetMapList()

	if #maplist == 0 then
		sender:PrintMessage(HUD_PRINTTALK, "This gamemode does not have voting enabled.")
		return
	end

	local mapid = tonumber(arguments[1])
	if not mapid then return end
	local mapdata = maplist[mapid]
	if not mapdata then return end

	local lowermapname = string.lower(mapdata[1])

	if string.lower(NDB.CurrentOverrideMap or game.GetMap()) == lowermapname then
		sender:PrintMessage(HUD_PRINTTALK, "<red>You can't vote for the same map that's being played.</red>")
		return
	end

	if VoteMap.DisabledMaps[lowermapname] then
		sender:PrintMessage(HUD_PRINTTALK, "<red>That map is disabled because "..tostring(VoteMap.DisabledMaps[lowermapname]).."</red>")
		return
	end

	if mapdata[3] and #player.GetAll() < mapdata[3] then
		sender:PrintMessage(HUD_PRINTTALK, "<red>That map requires at least "..mapdata[3].." players in the game!</red>")
		return
	end

	if VoteMap.IsMapLocked(mapid) then
		sender:PrintMessage(HUD_PRINTTALK, "<red>That map is currently locked. Wait until all maps have been played at least once.</red>")
		return
	end

	VoteMap.AddVote(sender, mapid, sender:IsSuperAdmin() and tonumbersafe(arguments[2]))
end)

hook.Add("ShutDown", "ndb_votemap_shutdown", function()
	local thismap = string.lower(game.GetMap())
	local maplist = VoteMap.GetMapList()
	for mapid, maptab in pairs(maplist) do
		if string.lower(maptab[1]) == thismap then
			VoteMap.LockMap(mapid)

			break
		end
	end
end)

hook.Add("Initialize", "ndb_votemap_sv_initialize", function()
	util.AddNetworkString("nox_votemapunlocks")
	util.AddNetworkString("nox_votemapvotes")
	util.AddNetworkString("nox_votemapvote")

	local filename = VoteMap.GetMapLockFile()
	if file.Exists(filename, "DATA") then
		VoteMap.SetLocks(Deserialize(file.Read(filename, "DATA")))
	end

	if #VoteMap.GetMapList() >= 64 then
		local randommaptime = VoteMap.GetFilePrefix().."_randomtime.txt"
		if file.Exists(randommaptime, "DATA") then
			local mapsleft = tonumber(file.Read(randommaptime, "DATA") or 0) - 1
			if mapsleft <= 0 then
				file.Write(randommaptime, tostring(VoteMap.MapsBeforeRandom))

				local currentmap = string.lower(NDB.CurrentOverrideMap or game.GetMap())

				local maplist = {}
				for k, v in pairs(VoteMap.GetMapList()) do
					local lowermapname = string.lower(v[1])

					if currentmap ~= lowermapname and not VoteMap.DisabledMaps[lowermapname] and not VoteMap.IsMapLocked(k) then
						table.insert(maplist, k)
					end
				end

				if #maplist > 0 then
					VoteMap.RandomMap = maplist[math.random(#maplist)]
					VoteMap.RefreshNextMap()
				end
			else
				file.Write(randommaptime, tostring(mapsleft - 1))
			end
		else
			file.Write(randommaptime, tostring(VoteMap.MapsBeforeRandom))
		end
	end
end)

local function DelayedFeed(pl)
	VoteMap.SendAll(pl)
	VoteMap.SendLocks(pl)

	if VoteMap.RandomMap then
		pl:SendLua("NDB.VoteMap.RandomMap=\""..tostring(VoteMap.RandomMap).."\"")
	end
end
hook.Add("PostPlayerReady", "ndb_votemap_playerready", function(pl)
	timer.Simple(5, function() DelayedFeed(pl) end)
end)

hook.Add("Initialize", "GameTypeVotingInitialize", function()
	hook.Remove("Initialize", "GameTypeVotingInitialize")

	if not GAMEMODE.GameTypes then return end

	GAMEMODE.GameTypeVoted = {}
	GAMEMODE.GameTypeVotedVotes = {}
	GAMEMODE.GameTypeVotes = {}
	for _, gt in pairs(GAMEMODE.GameTypes) do
		GAMEMODE.GameTypeVotes[gt] = 0
	end
	GAMEMODE.TopGameTypeVotes = 0
	concommand.Add("votegt", function(sender, command, arguments)
		if not sender:IsValid() or CurTime() < (sender.NextVoteGameType or 0) then return end

		if sender:IsPunishedNotify(PUNISHMENT_NOVOTES) then return end

		sender.NextVoteGameType = CurTime() + 2.5

		--[[if not ENDGAME then
			sender:PrintMessage(HUD_PRINTTALK, "Can only vote for a gametype after the current game has ended!")
			return
		end]]

		arguments = arguments[1]
		if not arguments then return end

		local gonethrough = false
		for _, gt in pairs(GAMEMODE.GameTypes) do
			if arguments == gt then
				gonethrough = true
				break
			end
		end

		if not gonethrough then
			sender:PrintMessage(HUD_PRINTTALK, "Error. Gametype doesn't exist?")
			return
		end

		if GAMEMODE.NoGameTypeTwiceInRow and 1 < #GAMEMODE.GameTypes and arguments == GAMEMODE.GameType then sender:PrintMessage(HUD_PRINTTALK, "The same game type can't be played twice in a row.") return end

		local votes
		if sender:GetMemberLevel() == MEMBER_DIAMOND then
			votes = 3
		elseif sender:GetMemberLevel() == MEMBER_GOLD then
			votes = 2
		else
			votes = 1
		end

		local uid = sender:UniqueID()

		local votedalready = GAMEMODE.GameTypeVoted[uid]
		if votedalready == arguments then return end
		if votedalready then
			GAMEMODE.GameTypeVotes[votedalready] = GAMEMODE.GameTypeVotes[votedalready] - GAMEMODE.GameTypeVotedVotes[uid]
			GAMEMODE.GameTypeVotedVotes[uid] = nil
			GAMEMODE.GameTypeVoted[uid] = nil

			umsg.Start("recgtnumvotes")
				umsg.String(votedalready)
				umsg.Short(GAMEMODE.GameTypeVotes[votedalready])
			umsg.End()
		end

		GAMEMODE.GameTypeVoted[uid] = arguments
		GAMEMODE.GameTypeVotedVotes[uid] = votes
		GAMEMODE.GameTypeVotes[arguments] = GAMEMODE.GameTypeVotes[arguments] + votes

		local most = 0
		for _, gt in pairs(GAMEMODE.GameTypes) do
			if GAMEMODE.GameTypeVotes[gt] > most then
				most = GAMEMODE.GameTypeVotes[gt]
				file.Write(GAMEMODE.FolderName.."_gametype.txt", gt)
			end
		end

		PrintMessage(HUD_PRINTTALK, sender:Name().." placed <red>"..votes.."</red> vote"..(votes == 1 and "" or "s").." for <red>"..arguments.."</red>.")

		sender:SendLua("surface.PlaySound(\"buttons/button3.wav\")")

		umsg.Start("recgtnumvotes")
			umsg.String(arguments)
			umsg.Short(GAMEMODE.GameTypeVotes[arguments])
		umsg.End()
	end)
end)
