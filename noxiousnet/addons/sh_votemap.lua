-- TODO: Super admin can force a changelevel through this.

NDB.VoteMap = {}
local VoteMap = NDB.VoteMap

VoteMap.MapsBeforeRandom = 8

VoteMap.Votes = {}
VoteMap.TotalVotes = {}
VoteMap.Locks = {}

function VoteMap.LockMap(mapid)
	local locks = VoteMap.GetLocks()
	locks[mapid] = math.min(2, VoteMap.GetMapLockState(mapid) + 1)

	if SERVER then
		file.Write(VoteMap.GetMapLockFile(), Serialize(locks))
	end
end

function VoteMap.GetLocks()
	return VoteMap.Locks
end

function VoteMap.SetLocks(locks)
	if not locks then return end

	if SERVER then
		local maplist = VoteMap.GetMapList()

		local num0s = 0
		for k, v in pairs(locks) do
			if v == 0 and maplist[k] ~= nil then
				num0s = num0s + 1
			end
		end

		if num0s <= math.Clamp(#maplist * 0.2, 5, 20) then --if num0s <= 3 then
			locks = {}
			for mapid in pairs(maplist) do
				locks[mapid] = 0
			end

			print("Map locks have been cleared.")
		end
	end

	VoteMap.Locks = locks
end

function VoteMap.IsMapLocked(mapid)
	-- Special cases...
	local maplist = VoteMap.GetMapList()
	if maplist[mapid] then
		local mapname = string.lower(maplist[mapid][1])
		if string.sub(mapname, 1, 3) == "ze_" and string.sub(string.lower(game.GetMap()), 1, 3) == "ze_" then
			return true
		end

		if (string.sub(mapname, 1, 3) == "ze_" or string.find(mapname, "_obj_", 1, true)) and #player.GetAll() < 20 then
			return true
		end

		if maplist[mapid][3] and #player.GetAll() < maplist[mapid][3] then
			return true
		end
	end

	return VoteMap.GetMapLockState(mapid) == 2
end

function VoteMap.NoLocks()
	return #VoteMap.GetMapList() <= 8
end

function VoteMap.GetMapLockState(mapid)
	return VoteMap.NoLocks() and 0 or VoteMap.Locks[mapid] or 0
end

function VoteMap.UniqueID(pl)
	return type(pl) == "string" and pl or pl:UniqueID()
end

function VoteMap.Player(pl)
	if type(pl) == "string" then
		for _, otherpl in pairs(player.GetAll()) do
			if otherpl:UniqueID() == pl then return otherpl end
		end

		return NULL
	end

	return pl
end

function VoteMap.GetTotalVotes(mapid)
	return VoteMap.TotalVotes[mapid] or 0
end

function VoteMap.RefreshAllTotalVotes()
	local totalvotes = {}
	for mapid = 1, #VoteMap.GetMapList() do
		totalvotes[mapid] = 0
	end

	for uid, vote in pairs(VoteMap.GetVotes()) do
		totalvotes[ vote[1] ] = totalvotes[ vote[1] ] + vote[2]
	end

	VoteMap.TotalVotes = totalvotes
end

function VoteMap.RefreshTotalVotes(mapid)
	local votes = 0

	for uid, vote in pairs(VoteMap.GetVotes()) do
		if vote[1] == mapid then
			votes = votes + vote[2]
		end
	end

	VoteMap.TotalVotes[mapid] = votes
end

function VoteMap.GetMapLockFile()
	return VoteMap.GetFilePrefix().."_maplocks.txt"
end

function VoteMap.GetFilePrefix()
	return GAMEMODE.FolderName..string.Replace(GetConVarString("ip") or "localhost", ".", "_")..(GetConVarString("hostport") or "0")
end

function VoteMap.GetMapList()
	return NDB.MapList[string.lower(GAMEMODE.FolderName)] or {}
end

function VoteMap.GetTopMap()
	if VoteMap.RandomMap then
		return VoteMap.RandomMap
	end

	local maplist = VoteMap.GetMapList()
	local totalvotes = {}

	for mapid = 1, #maplist do
		totalvotes[mapid] = VoteMap.GetTotalVotes(mapid)
	end

	local top = 1
	local most = 0
	for mapid, votes in pairs(totalvotes) do
		if most < votes then
			most = votes
			top = mapid
		end
	end

	return top
end

function VoteMap.RefreshNextMap()
	local mapid = VoteMap.GetTopMap()
	local maplist = VoteMap.GetMapList()

	if maplist[mapid] then
		NDB.NEXT_MAP = maplist[mapid][1]
		NDB.REDIRECT_MAP = maplist[mapid][4]
	end
end

function VoteMap.AddVote(pl, mapid, overridevotes)
	if overridevotes then
		VoteMap.SetVote(pl, mapid, overridevotes)
	else
		local votes = 1

		local ent = VoteMap.Player(pl)
		if ent:IsValid() then
			votes = VoteMap.GetVoteCount(ent) or 1

			if SERVER then
				local curvote = VoteMap.GetVote(pl)
				if not curvote or curvote[1] ~= mapid then
					local maptab = VoteMap.GetMapList()[mapid]
					local msg = pl:NoParseName().." placed <lg>"..votes.."</lg> "..(votes == 1 and "vote" or "votes").." for <lg>"..(maptab and (maptab[2] or maptab[1]) or mapid).."</lg>"
					local memberlevel = pl:GetMemberLevel()
					if NDB.MemberNames[memberlevel] and NDB.MemberVotePower[memberlevel] then
						msg = msg.." <pink>[+".. (NDB.MemberVotePower[memberlevel] - 1) * 100 .."% "..NDB.MemberNames[memberlevel].." Member bonus]</pink>"
					end
					if pl:IsInNoxSteamGroup() then
						msg = msg.." <purple>[+10% Steam Group bonus]</purple>"
					end

					msg = msg.."."

					PrintMessage(HUD_PRINTTALK, msg)
				end
			end
		end

		VoteMap.SetVote(pl, mapid, votes)
	end
end

function VoteMap.SetVote(pl, mapid, votes)
	VoteMap.Votes[VoteMap.UniqueID(pl)] = {mapid, votes}

	VoteMap.RefreshAllTotalVotes()
	VoteMap.RefreshNextMap()

	if SERVER then
		VoteMap.Send(pl)
	end
	if CLIENT then
		VoteMap.UpdateAll()
	end
end

function VoteMap.SetVotes(votes)
	VoteMap.Votes = votes

	VoteMap.RefreshAllTotalVotes()
	VoteMap.RefreshNextMap()

	if SERVER then
		VoteMap.SendAll()
	end
	if CLIENT then
		VoteMap.UpdateAll()
	end
end

function VoteMap.GetVote(pl)
	return VoteMap.Votes[VoteMap.UniqueID(pl)]
end

function VoteMap.GetVotes()
	return VoteMap.Votes
end

local function GetVoteMultiplier(pl)
	local multiplier = NDB.MemberVotePower[pl:GetMemberLevel()] or 1

	if pl:IsInNoxSteamGroup() then multiplier = multiplier + 0.1 end

	return multiplier
end

VoteMap.GamemodeVoteCountCallbacks = {}

VoteMap.GamemodeVoteCountCallbacks["extremfootballthrowdown"] = function(pl)
	return pl:Frags() / 10
end

VoteMap.GamemodeVoteCountCallbacks["pedobearescape2"] = function(pl)
	return pl:Frags() * 10 + pl:Deaths()
end

VoteMap.GamemodeVoteCountCallbacks["zombiesurvival"] = function(pl)
	local votes = pl.ZombiesKilled * 0.125 + pl.BrainsEaten

	if pl.SurvivalTime then
		votes = votes + pl.SurvivalTime * 0.0125
	end

	if ROUNDWINNER and ROUNDWINNER == TEAM_UNDEAD and GAMEMODE.StartingZombie[pl:UniqueID()] then
		votes = votes + math.max(0, (900 - CurTime()) * 0.025)
	end

	return votes
end

function VoteMap.GetVoteCount(pl)
	local amount = pl:Frags()
	local callback = VoteMap.GamemodeVoteCountCallbacks[GAMEMODE.FolderName]
	if callback then
		amount = callback(pl) or amount
	end

	return math.max(1, math.ceil(amount ^ 0.8 * GetVoteMultiplier(pl)))
end

function VoteMap.InitializeLocks()
	local locks = VoteMap.GetLocks()
	for mapid in pairs(VoteMap.GetMapList()) do
		locks[mapid] = locks[mapid] or 0
	end
end

hook.Add("Initialize", "RefreshAllVotes", VoteMap.RefreshAllTotalVotes)
hook.Add("Initialize", "InitializeLocks", VoteMap.InitializeLocks)
