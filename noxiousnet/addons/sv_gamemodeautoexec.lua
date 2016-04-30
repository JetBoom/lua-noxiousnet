function NDB.GamemodeAutoExec(gamemodefolder)

if gamemodefolder == "zombiesurvival" then

local TRACK_THRESHOLD = 10 --20
local BONUS_THRESHOLD = 30
local MAPBONUS_SILVER = 5000

local AlreadyLost = {}
local AlreadyWon = {}
local TRACKING = false

NDB.AddChatCommand("/mapstats", function(sender, text)
	local wins = mapstats.GetStat("Wins")
	local played = mapstats.GetStat("Played")

	local msg = "<silkicon icon=map> "..sender:NoParseName()..", this map has been played <red>"..played.."</red> time(s) and won <lg>"..wins.."</lg> time(s). Win rate: <lb>"..math.Round(wins / math.max(played, 1) * 100, 1).."%</lb>"

	if sender:IsMuted() then
		sender:PrintMessage(HUD_PRINTTALK, msg)
	else
		PrintMessage(HUD_PRINTTALK, msg)
	end

	return ""
end)

hook.Add("PropBroken", "NDB", function(ent, attacker)
	if IsValid(ent) and IsValid(attacker) and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN then
		local line = attacker:LogID().." broke "..ent:GetModel()
		--PrintMessage(HUD_PRINTCONSOLE, line)
		NDB.LogLine(line)
	end
end)

local MAPBONUS = {
	--[[ ["zs_forestofthedamned"] = "survive_forest_of_the_damned",
	["zs_hamlet"] = "survive_hamlet",
	["zs_noir"] = "survive_noir",
	["zs_cityholdout"] = "survive_city_holdout",
	["zs_mines"] = "survive_mines",
	["zs_woodhouse_rain"] = "survive_rain_house",
	["zs_villagehouse"] = "survive_village_house",
	["zs_cabin"] = "survive_cabin",
	["zs_shithole"] = "survive_shithole",
	["zs_fortress"] = "survive_fortress",
	["zs_stormier"] = "survive_stormier",
	["zs_farmhouse"] = "survive_farm_house",
	["zs_vulture"] = "survive_vulture",
	["zs_fireforest"] = "survive_fire_forest",
	["zs_overran_city"] = "survive_overran_city",
	["zs_sector4"] = "survive_sector_4",
	["zs_uglyfort"] = "survive_ugly_fort",
	["zm_distant"] = "survive_distant",
	["zs_nastyhouse"] = "survive_nasty_house",
	["zs_placid"] = "survive_placid",
	["zs_village_v2"] = "survive_village",
	["zs_lost_coast_house"] = "survive_lost_coast_house",
	["zs_junkyard"] = "survive_junkyard",
	["zs_asylum"] = "survive_asylum",
	["rd_zombocity"] = "survive_zombo_city",
	["zs_raunchyhouse"] = "survive_raunchy_house",
	["zm_mall"] = "survive_mall",
	["zs_the_house_of_doom"] = "survive_the_house_of_doom",
	["zs_lostfarm"] = "survive_lost_farm",
	["zs_korsakovia"] = "survive_korsakovia",
	["zm_gilmanhouse"] = "survive_gilman_house",
	["zm_countrytrain"] = "survive_country_train",
	["zs_motel"] = "survive_motel",
	["zps_silence"] = "survive_silence",
	["zs_swimming_pool"] = "survive_swimming_pool",
	["zm_subway"] = "survive_subway",
	["zs_urbandecay"] = "survive_urban_decay",
	["zs_thevillage"] = "survive_the_village",
	["zs_desert_hideout"] = "survive_desert_hideout",
	["cs_sprint_trading"] = "survive_sprint_trading",
	["zm_honkers_club"] = "survive_honkers_club",
	["zs_death_house"] = "survive_death_house",
	["zs_nestlings"] = "survive_nestlings",
	["zs_house_outbreak"] = "survive_house_outbreak",
	["abandonned_building"] = "survive_abandonned_building",
	["zs_deadhouse"] = "survive_dead_house",
	["zs_outpost"] = "survive_outpost_gold",
	["zs_darkvilla_v2"] = "survive_darkvilla_2",
	["zs_fearhouse"] = "survive_fear_house",
	["zs_fury"] = "survive_fury",
	["zs_refuge"] = "survive_refuge",
	["zs_deadblock"] = "survive_dead_block",
	["zs_pub"] = "survive_pub",
	["zs_dezecrated"] = "survive_dezecrated",
	["zs_houseruins"] = "survive_house_ruins",
	["zs_ambush"] = "survive_ambush",
	["zs_forgotten_town"] = "survive_forgotten_town",
	["zs_lost_faith"] = "survive_lost_faith",
	["zm_farm2_nav72"] = "survive_farm",
	["zs_siege"] = "survive_siege"]]
}

local function FindMapBonusAward()
	local thismap = string.lower(game.GetMap())
	for mapname, award in pairs(MAPBONUS) do
		if string.sub(thismap, 1, #mapname) == mapname then
			return award
		end
	end
end

hook.Add("EntityTakeDamage", "NDB", function(ent, dmginfo)
	if not ent:IsPlayer() then
		local attacker = dmginfo:GetAttacker()
		if attacker:IsValidHuman() and attacker:IsPunished(PUNISHMENT_NOHAMMER) and (string.sub(ent:GetClass(), 1, 12) == "prop_physics" or string.sub(ent:GetClass(), 1, 12) == "func_physbox") then
			dmginfo:SetDamage(0)
			dmginfo:SetDamageType(DMG_BULLET)
			return true
		end
	end
end)

hook.Add("DisallowHumanPickup", "NDB", function(pl, entity)
	if pl:IsPunished(PUNISHMENT_NOHAMMER) then
		return true
	end
end)

hook.Add("SetWave", "BonusNotification", function(wave)
	if wave == 1 then
		local bonusaward = FindMapBonusAward()
		if bonusaward then
			PrintMessage(HUD_PRINTTALK, "<silkicon icon=world color=255,0,0> Difficulty bonus! Win this round with "..BONUS_THRESHOLD.." or more players and get an additional <lg>"..MAPBONUS_SILVER.."</lg> Silver and the <lg>"..string.upper(bonusaward).."</lg> award!")
		end

		if not GAMEMODE.LockedDifficulty then
			local played = mapstats.GetStat("Played")
			if played > 30 then
				local wins = mapstats.GetStat("Wins")
				local multiplier = math.Clamp(1.2 - (wins * 2 / played) ^ 2, 0.6, 1)
				if multiplier < 1 then
					multiplier = math.floor(multiplier * 100) * 0.01
					PrintMessage(HUD_PRINTTALK, "<silkicon icon=world color=255,0,0> The game's difficulty has been adjusted because of this map's survival rate. Zombies will take <red>".. multiplier * 100 .."%</red> damage.")
					GAMEMODE.ZombieDamageMultiplier = multiplier
				end
			end
		end
	end
end)

hook.Add("PlayerIsAdmin", "NDB_PlayerIsAdmin", function(pl)
	return pl:IsModerator()
end)

hook.Add("InitPostEntity", "NDB_ZS_Initialize", function()
	if string.find(string.lower(GetConVar("hostname"):GetString()), "classic mode") then
		RunConsoleCommand("zs_classicmode", "1")
		MsgN("Classic Mode in hostname - going to classic mode!")
	else
		RunConsoleCommand("zs_classicmode", "0")
	end
end)

local function PrettyName(ent)
	if not IsValid(ent) then
		return "world"
	end

	return ent:GetClass().." ("..ent:GetModel()..")"
end
hook.Add("OnNailRemoved", "NDB_ZS_OnNailRemoved", function(nail, ent1, ent2, remover)
	if remover and remover:IsValid() and remover:IsPlayer() then
		local deployer = nail:GetDeployer()
		if deployer:IsValid() and deployer:Team() == TEAM_HUMAN then
			local nailcount = 0
			if IsValid(ent1) then
				nailcount = #ent1:GetNails()
			end
			local line = remover:LogID().." removed a nail belonging to "..deployer:LogID().." from "..PrettyName(ent1).." + "..PrettyName(ent2).." which leaves "..nailcount.." nail(s) left. Remover score: "..remover:Frags().." Deployer score: "..deployer:Frags()
			PrintMessage(HUD_PRINTCONSOLE, line)
			NDB.LogLine(line)
		end
	end
end)

hook.Add("OnWaveStateChanged", "NDB", function()
	if GAMEMODE:GetWave() <= 1 then
		TRACKING = #player.GetAll() >= TRACK_THRESHOLD
	end
end)

hook.Add("PlayerInitialSpawn", "NDB_ZS_PlayerInitialSpawn", function(pl)
	if #player.GetAll() >= TRACK_THRESHOLD then
		TRACKING = true
	end

	pl.ZombiesAssassinated = 0
	pl.SlugRifleHeadShots = 0
	pl.GraveDiggerKills = 0
	pl.OcelotKills = 0
	pl.MeleeKills = 0
	pl.m_HeadsUpHumansDownKills = 0
	pl.m_BatterUpKills = 0
	pl.CheckedHumanAward = {}

	local uid = pl:UniqueID()
	if AlreadyLost[uid] then
		AlreadyLost[uid] = nil

		pl:AddPKV("ZSGamesLost", -1)
	end
end)

local ZSASSASSIN_AWARDS = {}
ZSASSASSIN_AWARDS[4] = "Zombie_Assassin_-_Novice"
ZSASSASSIN_AWARDS[8] = "Zombie_Assassin_-_Adept"
ZSASSASSIN_AWARDS[16] = "Zombie_Assassin_-_Master"
local function CheckZSAssassinAwards(pl, kills)
	local award = ZSASSASSIN_AWARDS[kills]
	if award and not pl:HasAward(award) then
		pl:GiveAward(award)
	end
end

hook.Add("ObjectPackedUp", "NDB_ZS_ObjectPackedUp", function(pack, packer, owner)
	if packer ~= owner and owner:IsValid() and owner:IsPlayer() and packer:IsValid() and packer:IsPlayer() then
		local packers = {}
		for _, ent in pairs(ents.FindByClass("status_packup")) do
			if ent:GetPackUpEntity() == pack and ent:GetOwner():IsValid() then
				table.insert(packers, ent:GetOwner():LogID())
			end
		end

		NDB.LogLine(table.concat(packers, ", ").." removed a "..pack:GetClass().." belonging to "..owner:LogID())
	end
end)

hook.Add("PostHumanKilledZombie", "NDB_ZS_PostHumanKilledZombie", function(pl, attacker, inflictor, dmginfo, assistpl, assistamount, headshot)
	if TRACKING then
		attacker:AddPKV("ZSZombiesKilled", 1)
	end

	if inflictor ~= attacker and inflictor:IsValid() then
		local entclass = inflictor:GetClass()
		if entclass == "prop_physics" or entclass == "prop_physics_multiplayer" or entclass == "func_physbox" then
			attacker.m_BatterUpKills = attacker.m_BatterUpKills + 1
			if attacker.m_BatterUpKills >= 4 and not attacker:HasAward("batter_up") then
				attacker:GiveAward("batter_up")
			end

			local phys = inflictor:GetPhysicsObject()
			if phys:IsValid() and phys:GetMass() >= 250 and not attacker:HasAward("piano_trick") then
				attacker:GiveAward("piano_trick")
			end
		elseif entclass == "weapon_zs_swissarmyknife" then
			if not dmginfo:IsExplosionDamage() then
				attacker.ZombiesAssassinated = attacker.ZombiesAssassinated + 1

				CheckZSAssassinAwards(attacker, attacker.ZombiesAssassinated)
			end
		elseif entclass == "weapon_zs_slugrifle" then
			if headshot then
				attacker.SlugRifleHeadShots = attacker.SlugRifleHeadShots + 1
				if 10 <= attacker.SlugRifleHeadShots and not attacker:HasAward("Sharpshooter") then
					attacker:GiveAward("Sharpshooter")
				end
			else
				attacker.SlugRifleHeadShots = 0
			end
		elseif entclass == "weapon_zs_shovel" then
			if pl.Revive and pl.Revive:IsValid() then
				attacker.GraveDiggerKills = attacker.GraveDiggerKills + 1
				if attacker.GraveDiggerKills >= 15 and not attacker:HasAward("grave_digger") then
					attacker:GiveAward("grave_digger")
				end
			end
		elseif entclass == "projectile_arrow" then
			inflictor.Kills = (inflictor.Kills or 0) + 1
			if 6 <= inflictor.Kills and not attacker:HasAward("Hellsing") then
				attacker:GiveAward("Hellsing")
			end
		elseif entclass == "weapon_zs_magnum" and dmginfo:IsBulletDamage() then
			if attacker.RicochetBullet then
				attacker.OcelotKills = attacker.OcelotKills + 1
				if attacker.OcelotKills >= 15 and not attacker:HasAward("ocelot") then
					attacker:GiveAward("ocelot")
				end
			end
		end

		if inflictor.IsMelee and not dmginfo:IsExplosionDamage() then
			attacker.MeleeKills = attacker.MeleeKills + 1
			if attacker.MeleeKills >= 30 and not attacker:HasAward("rambo") then
				attacker:GiveAward("rambo")
			end
		end
	end
end)

hook.Add("PostDoHonorableMentions", "NDB_ZS_PostDoHonorableMentions", function()
	local cached = GAMEMODE.CachedHMs
	if cached and HM_MOSTZOMBIESKILLED and HM_MOSTDAMAGETOUNDEAD and HM_MOSTBRAINSEATEN and HM_MOSTDAMAGETOHUMANS
	and cached[HM_MOSTZOMBIESKILLED] and cached[HM_MOSTDAMAGETOUNDEAD] and cached[HM_MOSTBRAINSEATEN] and cached[HM_MOSTDAMAGETOHUMANS]
	and cached[HM_MOSTZOMBIESKILLED][1] == cached[HM_MOSTDAMAGETOUNDEAD][1] and cached[HM_MOSTDAMAGETOUNDEAD][1] == cached[HM_MOSTBRAINSEATEN][1] and cached[HM_MOSTBRAINSEATEN][1] == cached[HM_MOSTDAMAGETOHUMANS][1] then
		local pl = cached[HM_MOSTDAMAGETOUNDEAD][1]
		if pl and pl:IsValid() and pl:IsPlayer() and not pl:HasAward("across_the_board") then
			pl:GiveAward("across_the_board")
		end
	end
end)

hook.Add("LastBite", "NDB_ZS_LastBite", function(victim, attacker)
	if not attacker:HasAward("last_bite") then
		attacker:GiveAward("last_bite")
	end
end)

hook.Add("PlayerDisconnected", "NDB_ZS_PlayerDisconnected", function(pl)
	local uid = pl:UniqueID()
	if pl.WaveJoined and pl.WaveJoined < GAMEMODE.NumberOfWaves
		and GAMEMODE:GetWave() > 0 and not GAMEMODE.RoundEnded
		and not AlreadyWon[uid]
		and not AlreadyLost[uid] then
		AlreadyLost[uid] = true

		--if not GAMEMODE.ZombieEscape then
			pl:AddPKV("ZSGamesLost", 1)
			pl:UpdateDB()
		--end
	end
end)

hook.Add("PlayerNoClip", "NDB_ZS_PlayerNoClip", function(pl, on)
	if pl:IsAdmin() then
		if on then
			LogAction("[Admin CMD] <"..pl:SteamID().."> "..pl:Name().." TURNED ON NOCLIP")
		else
			LogAction("[Admin CMD] <"..pl:SteamID().."> "..pl:Name().." TURNED OFF NOCLIP")
		end

		--return true
	end

	--return false
end)

hook.Add("LoadNextMap", "NDB_ZS_LoadNextMap", function()
	return true
end)

hook.Add("RestartRound", "NDB", function()
	AlreadyLost = {}
	AlreadyWon = {}
end)

hook.Add("OnPlayerWin", "NDB", function(pl)
	local uid = pl:UniqueID()
	if AlreadyLost[uid] then
		AlreadyLost[uid] = nil
		pl:AddPKV("ZSGamesLost", -1)
	end

	if pl.SpawnedTime then
		pl.SurvivalTime = CurTime() - pl.SpawnedTime -- Votemap bonus
	end

	if not TRACKING then return end

	if not AlreadyWon[uid] then
		AlreadyWon[uid] = true
		pl:AddPKV("ZSGamesSurvived", 1)

		local played = mapstats.GetStat("Played")
		local ishardmap = played >= 25 and mapstats.GetStat("Wins") / played <= 0.05

		pl:AddSilver(GAMEMODE.ZombieEscape and 2000 or 5000)
		if ishardmap and not pl:HasAward("trendsetter") then
			pl:GiveAward("trendsetter")
		end

		if pl.ZSGamesSurvived == 1 and pl.ZSGamesLost == 0 and not pl:HasAward("not_that_easy") then
			pl:GiveAward("not_that_easy")
		end

		if pl:IsSkillActive(SKILL_D_WEAKNESS) and pl:IsSkillActive(SKILL_D_SLOW) and pl:IsSkillActive(SKILL_D_PALSY) and pl:IsSkillActive(SKILL_D_HEMOPHILIA) and pl:IsSkillActive(SKILL_D_BANNEDFORLIFE) and pl:Frags() >= 200 and not pl:HasAward("nightmare_mode") then
			pl:GiveAward("nightmare_mode")
		end

		if pl:Health() <= 2 and not pl:HasAward("close_call") then
			pl:GiveAward("close_call")
		end
	end
end)

hook.Add("OnPlayerLose", "NDB", function(pl)
	local uid = pl:UniqueID()
	if AlreadyWon[uid] then
		AlreadyWon[uid] = nil
		pl:AddPKV("ZSGamesSurvived", -1)
	end

	if not TRACKING then return end

	if pl.WaveJoined >= GAMEMODE.NumberOfWaves then return end

	if not AlreadyLost[uid] then
		AlreadyLost[uid] = true
		pl:AddPKV("ZSGamesLost", 1)
	end
end)

hook.Add("PostEndRound", "NDB_ZS_PostEndRound", function(winner)
	if not gamemode.Call("ShouldRestartRound") then
		NDB.VoteMap.InitiateVoteMap(GAMEMODE.EndGameTime, 10)
	end

	local allplayers = player.GetAll()
	local numplayers = #allplayers

	local humans = team.GetPlayers(TEAM_HUMAN)

	-- Clear out people who might have gotten a leaver's loss.
	--[[for _, pl in pairs(allplayers) do
		local uid = pl:UniqueID()
		if AlreadyLost[uid] then
			pl:AddPKV("ZSGamesLost", -1)
			AlreadyLost[uid] = nil
		end
	end]]

	if TRACKING then
		mapstats.IncrementStat("Played")

		if winner == TEAM_HUMAN then
			mapstats.IncrementStat("Wins")

			PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> All humans have been awarded "..(GAMEMODE.ZombieEscape and "2,000" or "5,000").." Silver for surviving!")

			--[[if numplayers >= BONUS_THRESHOLD then
				local bonusaward = FindMapBonusAward()
				if bonusaward then
					PrintMessage(HUD_PRINTTALK, "<silkicon icon=star> All humans have been awarded <lg>"..MAPBONUS_SILVER.." bonus Silver</lg> for surviving "..game.GetMap().."!!")
					for _, pl in pairs(humans) do
						if not pl:HasAward(bonusaward) then
							pl:AddSilver(MAPBONUS_SILVER)
							pl:GiveAward(bonusaward)
						end
					end
				end
			end]]
		end

		local wins = mapstats.GetStat("Wins")
		local played = mapstats.GetStat("Played")
		PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> This map has now been played "..played.." times and won "..wins.." times. <red>("..math.Round((wins / played) * 100, 2).."% survival rate)</red>")
	--elseif GAMEMODE.ZombieEscape then
		--PrintMessage(HUD_PRINTTALK, "<silkicon icon=cancel> Stats and rewards are currently disabled for Zombie Escape while we test it.")
	else
		PrintMessage(HUD_PRINTTALK, "<silkicon icon=cancel> Stat tracking and rewards are disabled with less than <red>"..TRACK_THRESHOLD.."</red> people playing.")
	end

	if game.IsDedicated() and numplayers >= 2 then
		if winner == TEAM_HUMAN then
			opensocket.Broadcast("PrintMessage", "<silkicon icon=world> The humans have <lg>WON</lg> "..GAMEMODE.Name.." on the map <lg>"..game.GetMap().."</lg> with <lb>"..#humans.."</lb> humans remaining and <lg>"..team.NumPlayers(TEAM_UNDEAD).."</lg> zombies.")
			webchat.Add("<img src='/silkicons/world.png'> The humans have <span style='color:green'>WON</span> "..GAMEMODE.Name.." on the map <span style='color:green'>"..game.GetMap().."</span> with <span style='color:blue'>"..#humans.."</span> humans remaining and <span style='color:green'>"..team.NumPlayers(TEAM_UNDEAD).."</span> zombies.")
		else
			opensocket.Broadcast("PrintMessage", "<silkicon icon=world> The humans have <red>LOST</red> "..GAMEMODE.Name.." on the map <lg>"..game.GetMap().."</lg> with <lg>"..#player.GetAll().."</lg> total players. It was wave "..GAMEMODE:GetWave()..".")
			webchat.Add("<img src='/silkicons/world.png'> The humans have <span style='color:red'>LOST</span> "..GAMEMODE.Name.." on the map <span style='color:green'>"..game.GetMap().."</span> with <span style='color:green'>"..#player.GetAll().."</span> total players. It was wave "..GAMEMODE:GetWave()..".")
		end
	end

	NDB.GlobalSave()
end)

local Redeemed = {}
hook.Add("PrePlayerRedeemed", "NDB_ZS_PlayerRedeemed", function(pl)
	Redeemed[pl:UniqueID()] = true

	local line = pl:LogID().." redeemed as "..pl:GetModel().." while a "..pl:GetZombieClassTable().Name
	PrintMessage(HUD_PRINTCONSOLE, line)
	NDB.LogLine(line)
end)

hook.Add("EndRound", "NDB_ZS_EndRound", function(winner)
	if winner == TEAM_HUMAN then
		for _, pl in pairs(player.GetAll()) do
			if pl:Team() == TEAM_HUMAN and Redeemed[pl:UniqueID()] and not pl:HasAward("Redeemer") then
				pl:GiveAward("Redeemer")
			end
		end
	end

	Redeemed = {}

	if timer.Exists("Survivalist") then
		timer.Remove("Survivalist")
	end
end)

local function CheckSurvivalist(pl, uid)
	if GAMEMODE.RoundEnded or not (pl:IsValid() and pl:Team() == TEAM_HUMAN and pl:UniqueID() == uid) then return end

	if not pl:HasAward("survivalist") then
		pl:GiveAward("survivalist")
	end
end

hook.Add("LastHuman", "NDB_ZS_LastHuman", function(pl)
	if pl and pl:IsValid() then
		timer.CreateEx("Survivalist", 300, 1, CheckSurvivalist, pl, pl:UniqueID())
	end
end)

local BrainsEatenAccumilationAwards = {}
BrainsEatenAccumilationAwards[25] = "Pest_Of_Humans"
BrainsEatenAccumilationAwards[50] = "Killer_Of_Humans"
BrainsEatenAccumilationAwards[100] = "Marauder_Of_Humans"
BrainsEatenAccumilationAwards[250] = "Butcher_Of_Humans"
BrainsEatenAccumilationAwards[500] = "Exterminator_Of_Humans"
BrainsEatenAccumilationAwards[1000] = "Destroyer_Of_Humans"
BrainsEatenAccumilationAwards[2500] = "Annihilator_Of_Humans"
BrainsEatenAccumilationAwards[5000] = "Eradicator_Of_Humans"
BrainsEatenAccumilationAwards[10000] = "Bane_Of_Humanity"

local function CheckZSZombieAccumilationAwards(pl)
	local award = BrainsEatenAccumilationAwards[pl.ZSBrainsEaten or 0]
	if not award then return end
	for _, awd in pairs(pl.Awards) do
		if awd == award then return end
	end
	NDB.GiveAward(pl, award)
end

local ZSZOMBIE_AWARDS = {}
ZSZOMBIE_AWARDS[5] = "ZS_Zombie_Bronze"
ZSZOMBIE_AWARDS[7] = "ZS_Zombie_Silver"
ZSZOMBIE_AWARDS[9] = "ZS_Zombie_3rd"
ZSZOMBIE_AWARDS[11] = "ZS_Zombie_2nd"
ZSZOMBIE_AWARDS[13] = "ZS_Zombie_1st"
local function CheckZSZombieAwards(pl, brains)
	if GAMEMODE.ZombieEscape then return end

	local award = ZSZOMBIE_AWARDS[brains]
	if award and not pl:HasAward(award) then
		pl:GiveAward(award)
	end
end

local ZSHUMAN_AWARDS = {}
ZSHUMAN_AWARDS[300] = "ZS_Human_Bronze"
ZSHUMAN_AWARDS[400] = "ZS_Human_Silver"
ZSHUMAN_AWARDS[500] = "ZS_Human_3rd"
ZSHUMAN_AWARDS[600] = "ZS_Human_2nd"
ZSHUMAN_AWARDS[700] = "ZS_Human_1st"

hook.Add("PlayerPointsAdded", "NDB_ZS_PlayerPointsAdded", function(pl, amount)
	if amount > 0 then
		pl:AddSilver(amount * 3)
		if TRACKING then
			pl:AddPKV("ZSPoints", amount)
		end

		if not GAMEMODE.ZombieEscape then
			local points = pl:Frags()
			for k, v in pairs(ZSHUMAN_AWARDS) do
				if points >= k and not pl.CheckedHumanAward[k] then
					pl.CheckedHumanAward[k] = true
					if not pl:HasAward(v) then
						pl:GiveAward(v)
					end
				end
			end
		end
	end
end)

hook.Add("NestDestroyed", "NDB", function(ent, attacker)
	if IsValid(ent) and IsValid(attacker) and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD then
		local line = attacker:LogID().." team killed a nest at "..tostring(ent:GetPos()).." (builder: "..(ent.Owner and ent.Owner:IsValid() and ent.Owner:IsPlayer() and ent.Owner:LogID() or "unknown")..")"
		--PrintMessage(HUD_PRINTCONSOLE, line)
		NDB.LogLine(line)
	end
end)

hook.Add("PostZombieKilledHuman", "NDB_ZS_PostZombieKilledHuman", function(pl, attacker, inflictor, dmginfo, headshot, suicide)
	attacker:AddSilver(150)

	if TRACKING then
		attacker:AddPKV("ZSBrainsEaten", 1)
	end

	if ZSZOMBIE_AWARDS[attacker.BrainsEaten] then
		CheckZSZombieAwards(attacker, attacker.BrainsEaten)
	end
	if BrainsEatenAccumilationAwards[attacker.ZSBrainsEaten or 0] then
		CheckZSZombieAccumilationAwards(attacker)
	end

	inflictor = dmginfo:GetInflictor()
	if inflictor:IsValid() then
		local entclass = inflictor:GetClass()
		if entclass == "prop_physics" or entclass == "prop_physics_multiplayer" or entclass == "func_physbox" then
			attacker.m_HeadsUpHumansDownKills = attacker.m_HeadsUpHumansDownKills + 1
			if attacker.m_HeadsUpHumansDownKills >= 4 and not attacker:HasAward("heads_up_humans_down") then
				attacker:GiveAward("heads_up_humans_down")
			end

			local phys = inflictor:GetPhysicsObject()
			if phys:IsValid() and phys:GetMass() >= 250 and not attacker:HasAward("piano_trick") then
				attacker:GiveAward("piano_trick")
			end
		elseif LASTHUMAN and entclass == "weapon_zs_chemzombie" and not dmginfo:IsExplosionDamage() and not attacker:HasAward("breathe_this") then
			attacker:GiveAward("breathe_this")
		end
	end

	if pl.KnockedDown and not attacker:HasAward("wake_up") then
		attacker:GiveAward("wake_up")
	end

	--[[if timer.IsTimer("Exists") and GAMEMODE:GetRedeemBrains() > 0 and GAMEMODE.AutoRedeem and GAMEMODE:GetRedeemBrains() <= attacker:Frags() then
		timer.Destroy("Survivalist")
	end]]
end)

hook.Add("CanRemoveOthersNail", "NDB_ZS_CanRemoveOthersNail", function(pl, nailowner, ent)
	if pl:IsPunishedNotify(PUNISHMENT_NOHAMMER) then return false end
end)

hook.Add("CanPlaceNail", "NDB_ZS_CanPlaceNail", function(pl, tr)
	if pl:IsPunishedNotify(PUNISHMENT_NOHAMMER) then return false end
end)

hook.Add("CanRemoveNail", "NDB_ZS_CanRemoveNail", function(pl, nail)
	if pl:IsPunishedNotify(PUNISHMENT_NOHAMMER) then return false end
end)

elseif gamemodefolder == "deathrun" then

local SILVER_KILLRUNNER = 20
local SILVER_KILLDEATH = 200
local SILVER_WINASRUNNER = 1000
local SILVER_WINASDEATH = 200

hook.Add("PostRoundStart", "NDB", function()
	for _, pl in pairs(player.GetAll()) do
		if pl:Team() == TEAM_DEATH then
			pl:AddPKV("DRPlayedDeath3", 1)
		elseif pl:Team() == TEAM_RUNNER then
			pl:AddPKV("DRPlayedRunner3", 1)
		end
	end
end)

hook.Add("PostRoundEnd", "NDB", function(winner)
	local eventison = os.time() < os.time({hour = 0,min = 0,sec = 0,year = 2013, month = 5, day = 1})

	if winner == TEAM_DEATH then
		for _, pl in pairs(team.GetPlayers(winner)) do
			pl:AddPKV("DRWonDeath3", 1)
			pl:AddSilver(SILVER_WINASDEATH)

			if eventison and pl.DRWonDeath3 >= 50 and not pl:HasAward("fallen_angel") then
				pl:GiveAward("fallen_angel")
			end
		end
	elseif winner == TEAM_RUNNER then
		for _, pl in pairs(team.GetPlayers(winner)) do
			pl:AddPKV("DRWonRunner3", 1)
			pl:AddSilver(SILVER_WINASRUNNER)

			if eventison and pl.DRWonRunner3 >= 150 and not pl:HasAward("quick_runner") then
				pl:GiveAward("quick_runner")
			end
		end
	end
end)

hook.Add("RunnerKilledDeath", "NDB", function(pl, attacker, dmginfo)
	attacker:AddSilver(SILVER_KILLDEATH)
end)

hook.Add("DeathKilledRunner", "NDB", function(pl, attacker, dmginfo)
	attacker:AddSilver(SILVER_KILLRUNNER)
end)

function GAMEMODE:SetupDefaults(pl)
	pl.DRPlayedDeath3 = pl.DRPlayedDeath3 or 0
	pl.DRPlayedRunner3 = pl.DRPlayedRunner3 or 0
	pl.DRWonDeath3 = pl.DRWonDeath3 or 0
	pl.DRWonRunner3 = pl.DRWonRunner3 or 0
end

hook.Add("StartMapVote", "NDB", function()
	NDB.VoteMap.InitiateVoteMap(GAMEMODE:GetRoundTime())

	return true
end)

hook.Add("EndMapVote", "NDB", function()
	return true
end)

elseif gamemodefolder == "terrortown" then

VOTEMAPLOCKED = true

function CheckForMapSwitch()
   -- Check for mapswitch
   local rounds_left = math.max(0, GetGlobalInt("ttt_rounds_left", 6) - 1)
   SetGlobalInt("ttt_rounds_left", rounds_left)

   local time_left = math.max(0, (GetConVar("ttt_time_limit_minutes"):GetInt() * 60) - CurTime())
   local switchmap = false
   local nextmap = string.upper(game.GetMapNext())

   if ShouldMapSwitch() then
      if rounds_left <= 0 then
         LANG.Msg("limit_round", {mapname = nextmap})
         switchmap = true
      elseif time_left <= 0 then
         LANG.Msg("limit_time", {mapname = nextmap})
         switchmap = true
      end
   else
      -- we only get here if fretta_voting is on and always_use_mapcycle off
      if rounds_left <= 0 or time_left <= 0 then
        LANG.Msg("limit_vote")

        -- pending fretta replacement...
        switchmap = true
        --GAMEMODE:StartFrettaVote()
      end
   end

   if switchmap then
      timer.Stop("end2prep")
      NDB.VoteMap.InitiateVoteMap()
   elseif ShouldMapSwitch() then
      LANG.Msg("limit_left", {num = rounds_left,
                              time = math.ceil(time_left / 60),
                              mapname = nextmap})
   end
end

hook.Add("TTTPrepareRound", "NDB_TTT_PrepareRound", function()
	for _, pl in pairs(player.GetAll()) do
		if not pl:IsSpec() then
			pl:AddPKV("TTTRoundsPlayed", 1)
		end
	end
end)

hook.Add("DoPlayerDeath", "NDB_TTT_DoPlayerDeath", function(pl, attacker, dmginfo)
	if pl:IsBot() or attacker:IsValid() and attacker:IsPlayer() and attacker:IsBot() then return end

	if not pl:IsSpec() and GetRoundState() == ROUND_ACTIVE and IsValid(attacker) and attacker:IsPlayer() then
		if attacker:GetTraitor() then
			if pl:GetTraitor() then
				attacker:AddPKV("TTTTeamKills", 1)
			else
				attacker:AddPKV("TTTInnocentKills", 1)
			end
		else
			if pl:GetTraitor() then
				attacker:AddPKV("TTTTraitorKills", 1)
			else
				attacker:AddPKV("TTTTeamKills", 1)
			end
		end
	end
end)

function CheckForMapSwitch()
   -- Check for mapswitch
   local rounds_left = math.max(0, GetGlobalInt("ttt_rounds_left", 6) - 1)
   SetGlobalInt("ttt_rounds_left", rounds_left)

   local time_left = math.max(0, (GetConVar("ttt_time_limit_minutes"):GetInt() * 60) - CurTime())
   local switchmap = false
   local nextmap = string.upper(game.GetMapNext())

   --if ShouldMapSwitch() then
      if rounds_left <= 0 then
         LANG.Msg("limit_round", {mapname = nextmap})
         switchmap = true
      elseif time_left <= 0 then
         LANG.Msg("limit_time", {mapname = nextmap})
         switchmap = true
      end
   --[[else
      -- we only get here if fretta_voting is on and always_use_mapcycle off
      if rounds_left <= 0 or time_left <= 0 then
         LANG.Msg("limit_vote")

         -- pending fretta replacement...
         switchmap = true
         --GAMEMODE:StartFrettaVote()
      end
   end]]

   if switchmap then
      timer.Stop("end2prep")
      NDB.VoteMap.InitiateVoteMap()
   else
      LANG.Msg("limit_left", {num = rounds_left,
                              time = math.ceil(time_left / 60),
                              mapname = nextmap})
   end
end

hook.Add("PlayerUse", "NDB_TTT_PlayerUse", function(pl, ent)
	local entclass = ent:GetClass()
	if entclass == "prop_door_rotating" then
		if CurTime() < (ent.m_AntiDoorSpam or 0) then
			return false
		end
		ent.m_AntiDoorSpam = CurTime() + 0.85
	end
end)

function GAMEMODE:SetupDefaults(pl)
	pl.TTTKarma = pl.TTTKarma or 1000
	pl.TTTInnocentKills = pl.TTTInnocentKills or 0
	pl.TTTTraitorKills = pl.TTTTraitorKills or 0
	pl.TTTRoundsPlayed = pl.TTTRoundsPlayed or 0
	pl.TTTTeamKills = pl.TTTTeamKills or 0
end

function GAMEMODE:PlayerCanCSC(pl)
	return pl:Alive() and not pl:IsSpec()
end

local meta = FindMetaTable("Player")
meta.PreTTTAddFrags = meta.AddFrags
function meta:AddFrags(frags)
	self:PreTTTAddFrags(frags)
	if frags > 0 then
		self:AddSilver(frags * 100)
	end
end

function meta:SetLiveKarma(karma)
	karma = karma or 0
	karma = tonumber(karma)
	karma = karma or self.live_karma or 0

	self.live_karma = karma

	self:SetPKV("TTTKarma", karma)
end

hook.Add("PostPlayerReady", "NDB_TTT", function(pl)
	if pl.TTTKarma then
		pl:SetBaseKarma(pl.TTTKarma)
		pl:SetLiveKarma(pl.TTTKarma)
		KARMA.ApplyKarma(pl)
	end
end)

hook.Add("InitPostEntity", "NDB_TTT_InitPostEntity", function()
	RunConsoleCommand("sv_voiceenable", "1")
	RunConsoleCommand("sv_alltalk", "0")
	RunConsoleCommand("fretta_voting", "0")
	RunConsoleCommand("ttt_detective_karma_min", "800")
	RunConsoleCommand("ttt_roundtime_minutes", "7")
	RunConsoleCommand("ttt_spec_prop_force", "140")
	RunConsoleCommand("ttt_karma_round_increment", "10")
	RunConsoleCommand("ttt_posttime_seconds", "20")
	RunConsoleCommand("ttt_preptime_seconds", "20")
	RunConsoleCommand("ttt_no_nade_throw_during_prep", "1")
	RunConsoleCommand("ttt_karma_low_amount", "200")
	RunConsoleCommand("ttt_postround_dm", "1")
	RunConsoleCommand("ttt_haste", "0")
	RunConsoleCommand("ttt_karma_low_autokick", "0")
end)

function KARMA.ApplyKarma(ply)
	local df = 1

	if ply:GetBaseKarma() < 1000 then
		df = ((ply:GetBaseKarma() + 100) / 1000) ^ 1.6
	end

	ply:SetDamageFactor(math.Clamp(df, 0.1, 1.0))
end

elseif gamemodefolder == "pedobearescape2" then

hook.Add("RoundEnded", "NDB", function()
	local numplaying = team.NumPlayers(TEAM_RUNNER)
	if numplaying > 4 then
		local silver = math.Clamp(numplaying * 85, 1, 3000)
		for _, pl in pairs(GAMEMODE:GetPlayingPlayers()) do
			pl:AddSilver(silver)
		end
	end
end)

hook.Add("LoadNextMap", "NDB_LoadNextMap", function()
	if not INITVOTEMAP then
		INITVOTEMAP = true
		NDB.VoteMap.InitiateVoteMap()
	end

	return true
end)

elseif gamemodefolder == "awesomestrike" then

function GAMEMODE:SetupDefaults(pl)
	pl.ASSKills = pl.ASSKills or 0
	pl.ASSDeaths = pl.ASSDeaths or 0
	pl.ASSWins = pl.ASSWins or 0
	pl.ASSPlayed = pl.ASSPlayed or 0
end

hook.Add("LoadNextMap", "NDB_LoadNextMap", function()
	NDB.VoteMap.InitiateVoteMap()

	return true
end)

hook.Add("AddedPoints", "NDB_AddedPoints", function(pl, points)
	pl:AddSilver(points * 40)
end)

local function HTMLSafe(str)
	return string.Replace(string.Replace(str, "<", " "), ">", " ")
end

local streakqueue

local function BroadcastStreakQueue()
	if streakqueue then
		local str
		if #streakqueue == 1 then
			if streakqueue[1][2] % 5 ~= 0 then streakqueue = nil return end
			str = streakqueue[1][1].." is on an Awesome Strike win streak of "..streakqueue[1][2].."!"
		else
			str = "Awesome Strike win streaks: "
			local tab = {}
			local shouldbroadcast = false
			for k, v in ipairs(streakqueue) do
				table.insert(tab, v[1].." - "..v[2])
				if not shouldbroadcast and v[2] % 5 == 0 then shouldbroadcast = true end
			end
			if not shouldbroadcast then streakqueue = nil return end
			str = str..table.concat(tab, ", ")
		end
		webchat.Add("<img src='/silkicons/world.png'> "..str)
		opensocket.Broadcast("PrintMessage", "<silkicon icon=world><defstyle color=255,255,0> "..str, true)
		streakqueue = nil
	end
end

hook.Add("WinStreak", "NDB_WinStreak", function(pl, streak)
	if streak >= 10 then
		if team.NumPlayers(pl:Team() == TEAM_T and TEAM_CT or TEAM_T) >= 4 then
			if not pl:HasAward("all_points_bulletin") then pl:GiveAward("all_points_bulletin") end
			if streak >= 20 and not pl:HasAward("unstoppable") then pl:GiveAward("unstoppable") end
		end

		streakqueue = streakqueue or {}
		table.insert(streakqueue, {HTMLSafe(pl:Name()), streak})
		timer.CreateEx("BroadcastStreakQueue", 1, 1, BroadcastStreakQueue)
	end
end)

hook.Add("WinStreakEnded", "NDB_WinStreakEnded", function(pl, streak)
	if streak >= 10 then
		local str = HTMLSafe(pl:Name()).."'s Awesome Strike win streak of "..streak.." was just ended!"
		webchat.Add("<img src='/silkicons/world.png'> "..str)
		opensocket.Broadcast("PrintMessage", "<silkicon icon=world><defstyle color=255,0,0> "..str, true)
	end
end)

hook.Add("PostDoPlayerDeath", "NDB_PostDoPlayerDeath", function(pl, attacker, inflictor, dmginfo, maintype, subtypes)
	if pl:IsBot() or attacker:IsValid() and attacker:IsPlayer() and attacker:IsBot() then return end

	pl:AddPKV("ASSDeaths", 1)

	if pl == attacker or not attacker:IsValid() or not attacker:IsPlayer() then return end

	attacker:AddPKV("ASSKills", 1)

	if inflictor:IsValid() then
		local inflictorclass = inflictor:GetClass()
		if inflictorclass == "weapon_as_detpack" or inflictorclass == "projectile_detpack" then
			if pl.LastDefuseAttempt and CurTime() <= pl.LastDefuseAttempt + 2 and #ents.FindByClass("planted_bomb") >= 1 and not attacker:HasAward("defuse_this") then attacker:GiveAward("defuse_this") end
		end
	end
end)

hook.Add("PostEndRound", "NDB_PostEndRound", function(winner, nosoundormessage, reason)
	local numts = team.NumPlayers(TEAM_T)
	local numcts = team.NumPlayers(TEAM_CT)
	for _, pl in pairs(player.GetAll()) do
		if pl:Team() == winner and (winner == TEAM_T and 0 < numcts or winner == TEAM_CT and 0 < numts) then
			pl:AddPKV("ASSWins", 1)
		end

		if pl:Team() ~= TEAM_SPECTATOR then
			pl:AddPKV("ASSPlayed", 1)
		end
	end
end)

hook.Add("PostAddKillStreak", "NDB_PostAddKillStreak", function(pl, inflictor, maintype, streak, streakmaintype)
	if not streakmaintype then return end

	if streak == 10 then
		if streakmaintype == KILLACTION_DINKIED then
			if not pl:HasAward("you_got_dinkied") then pl:GiveAward("you_got_dinkied") end
		elseif streakmaintype == KILLACTION_STAB then
			if not pl:HasAward("shank_master") then pl:GiveAward("shank_master") end
		elseif streakmaintype == KILLACTION_SLASH then
			if not pl:HasAward("berserk") then pl:GiveAward("berserk") end
		elseif streakmaintype == KILLACTION_RAILGUN then
			if not pl:HasAward("rail_me") then pl:GiveAward("rail_me") end
		elseif streakmaintype == KILLACTION_AWESOMERIFLE or streakmaintype == KILLACTION_AWESOMERIFLEGUIDED then
			if not pl:HasAward("eyes_on_you") then pl:GiveAward("eyes_on_you") end
		elseif streakmaintype == KILLACTION_AWESOMELAUNCHER or streakmaintype == KILLACTION_AWESOMELAUNCHERGUIDED then
			if not pl:HasAward("bomb_the_lasanga") then pl:GiveAward("bomb_the_lasanga") end
		elseif streakmaintype == KILLACTION_SHOCKWAVEBAT then
			if not pl:HasAward("bat_man") then pl:GiveAward("bat_man") end
		elseif streakmaintype == KILLACTION_SMARTRIFLED then
			if not pl:HasAward("smart_ass") then pl:GiveAward("smart_ass") end
		end
	elseif streak == 5 then
		if streakmaintype == KILLACTION_HOOKED then
			if not pl:HasAward("ass_pirate") then pl:GiveAward("ass_pirate") end
		end
	end
end)

elseif gamemodefolder == "supermayhemboxes" then

hook.Add("AddedPoints", "NDB_AddedPoints", function(pl, points)
	pl:AddSilver(points * 50)
end)

hook.Add("PlayerKilledByPlayer", "AwardsPlayerKilledByPlayer", function(victim, attacker, inflictor)
	if inflictor and inflictor:IsValid() then
		local inflictorclass = inflictor:GetClass()
		if inflictorclass == "projectile_kamehameha" then
			inflictor.Kills = (inflictor.Kills or 0) + 1
			if inflictor.Kills >= 6 and not attacker:HasAward("goku") then
				attacker:GiveAward("goku")
			end
		elseif inflictorclass == "status_timeroller" then
			inflictor.Kills = (inflictor.Kills or 0) + 1
			if inflictor.Kills >= 6 and not attacker:HasAward("back_to_the_future") then
				attacker:GiveAward("back_to_the_future")
			end
		end
	end

	if victim.status_weapon_kamehameha and victim.status_weapon_kamehameha:IsValid() and victim.status_weapon_kamehameha:GetDTFloat(0) > 0 and not attacker:HasAward("goku_killer") then
		attacker:GiveAward("goku_killer")
	end
end)

hook.Add("PlayerGrappledObject", "AwardsPlayerGrappledObject", function(pl, box, proj, ent, data)
	if ent and ent:IsValid() and ent:GetClass() == "projectile_bazookamissile" and pl and pl:IsValid() and not pl:HasAward("rocket_skiing") then
		pl:GiveAward("rocket_skiing")
	end
end)

hook.Add("PostEndGame", "NDB_PostEndGame", function(winner)
	NDB.GlobalSave()

	NDB.VoteMap.InitiateVoteMap(GAMEMODE.EndGameTime, 10)

	if winner and winner > 0 and game.IsDedicated() and #player.GetAll() >= 2 then
		opensocket.Broadcast("PrintMessage", "<silkicon icon=world> "..team.GetName(winner).." has <lg>WON</lg> "..GAMEMODE.Name.." on the map <lg>"..game.GetMap().."</lg>.")
	end
end)

elseif gamemodefolder == "extremefootballthrowdown" then

GAMEMODE.SaveKeys = {
	"EFTRoundsPlayed",
	"EFTWins",
	"EFTTouchDowns",
	"EFTKnockDowns",
	"EFTKnockedDown",
	"EFTKills",
	"EFTDeaths",
	"EFTStruggles",
	"EFTStruggleWins"
}

function GAMEMODE:SetupDefaults(pl)
	for _, name in pairs(GAMEMODE.SaveKeys) do
		pl[name] = pl[name] or 0
	end
end

local joined = {}
hook.Add("OnPlayerChangedTeam", "NDB_EFT_OnPlayerChangedTeam", function(pl, oldteamid, teamid)
	if not joined[pl:UniqueID()] and (teamid == TEAM_RED or teamid == TEAM_BLUE) then
		joined[pl:UniqueID()] = true

		pl:AddPKV("EFTRoundsPlayed", 1)
	end
end)

hook.Add("OnEndOfGame", "NDB_EFT_OnEndOfGame", function(bGamemodeVote)
	local winner = team.GetScore(TEAM_RED) == team.GetScore(TEAM_BLUE) and -1 or team.GetScore(TEAM_RED) > team.GetScore(TEAM_BLUE) and TEAM_RED or TEAM_BLUE

	for _, pl in pairs(player.GetAll()) do
		if team.Joinable(pl:Team()) and pl:Team() == winner and (not pl.LastTeamChange or CurTime() > pl.LastTeamChange + 180) then
			pl:AddPKV("EFTWins", 1)
		end
	end
end)

hook.Add("OnPlayerKnockedDownBy", "NDB_EFT_OnPlayerKnockedDownBy", function(pl, knocker)
	knocker:AddPKV("EFTKnockDowns", 1)
	pl:AddPKV("EFTKnockedDown", 1)
end)

hook.Add("OnTeamScored", "NDB_EFT_OnTeamScored", function(teamid, hitter, points, istouch)
	if hitter:IsValid() and hitter:IsPlayer() then
		hitter:AddPKV("EFTTouchDowns", 1)
	end
end)

hook.Add("OnPowerStruggleWin", "NDB_EFT_OnPowerStruggleWin", function(pl, other)
	pl:AddPKV("EFTStruggles", 1)
	pl:AddPKV("EFTStruggleWins", 1)
end)

hook.Add("OnPowerStruggleLose", "NDB_EFT_OnPowerStruggleLose", function(pl, other)
	pl:AddPKV("EFTStruggles", 1)
end)

hook.Add("OnDoPlayerDeath", "NDB_EFT_OnDoPlayerDeath", function(pl, attacker, dmginfo)
	if attacker ~= pl and attacker:IsValid() and attacker:IsPlayer() then
		attacker:AddPKV("EFTKills", 1)
	end

	pl:AddPKV("EFTDeaths", 1)
end)

function GAMEMODE:StartMapVote()
	if NDB then
		NDB.VoteMap.InitiateVoteMap()
		return
	end

	return self.BaseClass.StartMapVote(self)
end

hook.Add("InitPostEntity", "NDB_EFT_InitPostEntity", function()
	RunConsoleCommand("sv_voiceenable", "1")
	RunConsoleCommand("sv_alltalk", "0")
	RunConsoleCommand("fretta_voting", "0")
end)

local meta = FindMetaTable("Player")
meta.PreEFTAddFrags = meta.AddFrags
function meta:AddFrags(frags)
	self:PreEFTAddFrags(frags)
	if frags > 0 then
		self:AddSilver(frags * 5)
	end
end

end

end

hook.Add("Initialize", "NDB_Initialize_GamemodeAutoexec", function()
	if not GAMEMODE then return end

	NDB.GamemodeAutoExec(GAMEMODE.FolderName)
end)
