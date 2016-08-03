NDB.PunishmentsFile = "suspensions.txt"

function NDB.LoadPunishments(fil)
	fil = fil or NDB.PunishmentsFile
	if file.Exists(fil, "DATA") then
		--[[local tab = {}
		for i, line in ipairs(string.Explode("\n", file.Read(fil, "DATA"))) do
			local puntab = string.Explode("|", line)
			tab[i] = {
				["SteamID"] = puntab[1],
				["Name"] = puntab[2],
				["Punishment"] = tonumber(puntab[3]) or 0,
				["Admin"] = puntab[4],
				["Reason"] = puntab[5],
				["Expires"] = tonumber(puntab[6]) or 0,
				["Log"] = puntab[7]
			}
		end]]

		NDB.Punishments = util.JSONToTable(file.Read(fil, "DATA") or "") or {}
	end
end

function NDB.SavePunishments(fil)
	--[[local buffer = {}
	for k, tab in ipairs(NDB.Punishments) do
		buffer[#buffer + 1] = tostring(tab.SteamID).."|"..string.gsub(tostring(tab.Name), "|", " ").."|"..tostring(tab.Punishment).."|"..string.gsub(tostring(tab.Admin), "|", " ").."|"..string.gsub(tostring(tab.Reason), "|", " ").."|"..tostring(tab.Expires).."|"..tostring(tab.Log or "")
	end

	file.Write(fil or NDB.PunishmentsFile, table.concat(buffer, "\n"))]]

	file.Write(fil or NDB.PunishmentsFile, util.TableToJSON(NDB.Punishments) or "")
end

function NDB.RemoveAllExpiredPunishments()
	local newbans = {}

	local thetime = os.time()
	for i, tab in ipairs(NDB.Punishments) do
		if 0 == tab.Expires or thetime < tab.Expires then
			newbans[#newbans + 1] = tab
		end
	end

	NDB.Punishments = newbans
	NDB.SavePunishments()
end

function NDB.SyncPunishments()
	NDB.LoadPunishments()

	local thetime = os.time()

	local steamhash = {}
	for _, pl in pairs(player.GetAll()) do
		steamhash[pl:SteamID()] = pl
	end

	for i, tab in pairs(NDB.Punishments) do
		local pl = steamhash[tab.SteamID]
		if pl then
			if pl:IsPunished(tab.Punishment) then
				if 0 < tab.Expires and tab.Expires <= thetime then
					-- Check for active duplicates first.
					local active = false
					for __, tab2 in pairs(NDB.Punishments) do
						if tab2.SteamID == tab.SteamID and tab2.Punishment == tab.Punishment and (tab2.Expires == 0 or thetime < tab2.Expires) then
							active = true
							break
						end
					end

					if not active then
						pl:SetPunished(tab.Punishment, false, tab)
					end
				end
			elseif tab.Expires == 0 or thetime < tab.Expires then
				pl:SetPunished(tab.Punishment, true, tab)
			end
		end
	end
end
timer.Create("PunishmentsSync", 30, 0, function() NDB.SyncPunishments() end)

local APIKey = "814FDBCBC3EE377D5F84DAA2A24FF4DD"

local function HandleSharedPlayer(pl, lenderSteamID)
	print(string.format("FamilySharing: %s | %s has been lent Garry's Mod by %s", pl:Nick(), pl:SteamID(), lenderSteamID))
    pl._LenderSteamID = util.SteamIDFrom64(lenderSteamID)

    for _, tab in pairs(NDB.Punishments) do
    	if tab.Punishment == PUNISHMENT_BAN and tab.SteamID == lenderSteamID and (tab.Expires == 0 or os.time() < tab.Expires) then
			pl:SafeKick("Trying to use FamilySharing to bypass a ban.")
			break
		end
	end
end

hook.Add("PlayerAuthed", "ndb_familysharing", function(pl)
	http.Fetch(
		string.format("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=%s&format=json&steamid=%s&appid_playing=4000",
			APIKey,
			pl:SteamID64() or 0
		),

		function(body)
			if not IsValid(pl) then return end

			body = util.JSONToTable(body)

			if body and body.response and body.response.lender_steamid then
				local lender = body.response.lender_steamid
				if lender ~= "0" then
					HandleSharedPlayer(pl, util.SteamIDFrom64(lender))
				end
			else
				print(string.format("FamilySharing: Invalid Steam API response for %s | %s\n", pl:Nick(), pl:SteamID()))
			end
		end,

		function(code)
			print(string.format("FamilySharing: Failed API call for %s | %s (Error: %s)\n", pl:Nick(), pl:SteamID(), code))
		end
	)
end)

net.Receive("nox_requestpunishments", function(length, sender)
	if sender:IsAdmin() then
		local page = net.ReadUInt(16)

		local perpage = 200
		local start = 1 + (page - 1) * perpage
		local tosend = {}

		for i=start, start + perpage do
			if NDB.Punishments[i] then
				tosend[#tosend + 1] = NDB.Punishments[i]
			end
		end

		net.Start("nox_punishments")
			net.WriteUInt(page, 16)
			net.WriteUInt(math.max(1, math.ceil(#NDB.Punishments / perpage)), 16)
			net.WriteUInt(#tosend, 16)
			for i, tab in ipairs(tosend) do
				net.WriteString(tab.SteamID)
				net.WriteString(tab.Name)
				net.WriteString(tab.Reason)
				net.WriteString(tab.Admin)
				net.WriteUInt(tab.Punishment, 8)
				net.WriteUInt(tab.Expires, 32)
			end
		net.Send(sender)
	end
end)

function NDB.AddPunishment(plorsteamidoruserid, punishment, duration, reason, adminnameorplayer, overridename, silent)
	local pl
	local steamid
	local name
	if type(plorsteamidoruserid) == "string" or type(plorsteamidoruserid) == "number" then
		for _, p in pairs(player.GetAll()) do
			if p:SteamID() == plorsteamidoruserid or p:UserID() == tonumber(plorsteamidoruserid) then
				pl = p
				name = p:Name()
				steamid = p:SteamID()
				break
			end
		end

		if not pl and not tonumber(plorsteamidoruserid) then
			steamid = plorsteamidoruserid
		end
	elseif type(plorsteamidoruserid) == "Player" then
		pl = plorsteamidoruserid
	end

	local plvalid
	if pl and pl:IsValid() and pl:IsPlayer() then
		if punishment == PUNISHMENT_BAN and pl._LenderSteamID then
			steamid = pl._LenderSteamID
		else
			steamid = pl:SteamID()
		end
		name = pl:Name()
		plvalid = true
	end

	if not steamid then return end

	local admin
	if not adminnameorplayer then
		admin = "Remote"
	elseif type(adminnameorplayer) == "Player" then
		admin = adminnameorplayer:Name()
	else
		admin = tostring(adminnameorplayer)
	end

	punishment = punishment or PUNISHMENT_BAN
	duration = (duration or 0) * 60
	reason = reason or "No reason."
	admin = admin or "Remote"

	if punishment == PUNISHMENT_BAN and duration > 172800 then
		if plvalid then
			if NDB.MemberBanProtection[pl:GetMemberLevel()] then
				duration = 172800
			end
		--[[else
			local filename = AccountFile(AccountID(steamid))
			if file.Exists(filename, "DATA") and NDB.MemberBanProtection[tonumber(Deserialize(file.Read(filename, "DATA")).MemberLevel) or 0] then
				duration = 172800
			end]]
		end
	end

	local tab
	for _, t in pairs(NDB.Punishments) do
		if t.SteamID == steamid and t.Punishment == punishment then
			if duration == 0 then
				t.Expires = 0
			else
				t.Expires = os.time() + duration
			end

			t.Name = name or overridename or "Unknown"
			t.Admin = admin
			t.Reason = reason

			tab = t

			break
		end
	end

	name = name or overridename or "Unknown"

	if not tab then
		local t = {SteamID = steamid, Name = name, Punishment = punishment, Admin = admin, Reason = reason}
		if duration == 0 then
			t.Expires = 0
		else
			t.Expires = os.time() + duration
		end

		table.insert(NDB.Punishments, 1, t)
		tab = t
	end

	tab.Log = NDB.GetLogArchiveName()

	NDB.SavePunishments()

	local msg = "<defc=255,0,0><silkicon icon=user_delete> "
	if duration == 0 then
		msg = msg.."<purple>"..tostring(name or steamid).."</purple> has been <red>permanently "..tostring(NDB.PunishmentsPastNames[punishment]).."</red> by <purple>"..tostring(admin).."</purple> because \"<lb>"..tostring(reason).."</lb>\""
	else
		msg = msg.."<purple>"..tostring(name or steamid).."</purple> has been <red>"..tostring(NDB.PunishmentsPastNames[punishment]).."</red> by <purple>"..tostring(admin).."</purple> because \"<lb>"..tostring(reason).."</lb>\". The duration is <red>"..TimeToEnglish(duration).."</red>."
	end

	local plainmsg
	if duration == 0 then
		plainmsg = "<"..tostring(steamid).."> "..tostring(name or steamid).." has been permanently "..tostring(NDB.PunishmentsPastNames[punishment]).." by "..tostring(admin).." because "..tostring(reason).."."
	else
		plainmsg = "<"..tostring(steamid).."> "..tostring(name or steamid).." has been "..tostring(NDB.PunishmentsPastNames[punishment]).." by "..tostring(admin).." because "..tostring(reason)..". The duration is "..TimeToEnglish(duration).."."
	end

	NDB.LogLine(plainmsg)

	if plvalid and tab then
		pl:SetPunishment(punishment, true, tab, nil, silent)
	end

	if not silent then
		PrintMessage(HUD_PRINTTALK, msg)
	end
	--opensocket.Broadcast("MessageToAdmins", "[<pink>"..GetHostName().."</pink>] "..msg)
end

function NDB.InstantBan(pl, reason, duration, banner, silent, punishment)
	return NDB.AddPunishment(pl, punishment or PUNISHMENT_BAN, duration, reason, banner, nil, silent)
end

function NDB.RemovePunishment(plorsteamidoruserid, punishment, adminnameorplayer)
	local pl
	local steamid
	local name
	if type(plorsteamidoruserid) == "string" or type(plorsteamidoruserid) == "number" then
		for _, p in pairs(player.GetAll()) do
			if p:SteamID() == plorsteamidoruserid or p:UserID() == tonumber(plorsteamidoruserid) then
				pl = p
				name = p:Name()
				steamid = p:SteamID()
				break
			end
		end

		if not pl and not tonumber(plorsteamidoruserid) then
			steamid = plorsteamidoruserid
		end
	elseif type(plorsteamidoruserid) == "Player" then
		pl = plorsteamidoruserid
	end

	local plvalid
	if pl and pl:IsValid() and pl:IsPlayer() then
		steamid = pl:SteamID()
		plvalid = true
	end

	if not steamid then return end

	local admin
	if not adminnameorplayer then
		admin = "Remote"
	elseif type(adminnameorplayer) == "Player" then
		admin = adminnameorplayer:Name()
	else
		admin = tostring(adminnameorplayer)
	end

	punishment = punishment or PUNISHMENT_BAN
	admin = admin or "Remote"

	for i, tab in ipairs(NDB.Punishments) do
		if tab.SteamID == steamid and tab.Punishment == punishment then
			if plvalid then
				pl:SetPunishment(punishment, false, tab)
			end

			table.remove(NDB.Punishments, i)
			NDB.SavePunishments()
			local msg = "<"..tostring(steamid).."> "..tostring(name or steamid).." had their "..tostring(NDB.PunishmentsNames[punishment]).." removed by "..tostring(admin).."."
			PrintMessage(HUD_PRINTTALK, msg)
			NDB.LogLine(msg)
			break
		end
	end
end

net.Receive("nox_addpunishment", function(length, sender)
	local id = net.ReadString()
	local reason = net.ReadString()
	local punishment = net.ReadUInt(8)
	local duration = net.ReadUInt(32)

	if sender:IsValid() and sender:IsModerator() then
		if sender:IsOnlyModerator() then
			if punishment ~= PUNISHMENT_BAN and punishment ~= PUNISHMENT_MUTE and punishment ~= PUNISHMENT_VOICEMUTE and punishment ~= PUNISHMENT_BALLPIT then
				sender:PrintMessage(HUD_PRINTTALK, "<red>Moderators can only ban, mute, voice mute, ball pit, or use premade punishments.</red>")
				return
			end

			if punishment ~= PUNISHMENT_VOICEMUTE and punishment ~= PUNISHMENT_BALLPIT then
				duration = math.Clamp(duration, 1, 10080)
			end
		end

		NDB.AddPunishment(id, punishment, duration, reason, sender)
	end
end)

net.Receive("nox_addpremadepunishment", function(length, sender)
	local pl = net.ReadEntity()
	local reasoncode = net.ReadUInt(8)

	if not (sender:IsValid() and sender:IsModerator() and pl:IsValid() and pl:IsPlayer()) then return end

	local premade = NDB.PreMadePunishments[reasoncode]
	if not premade then return end

	local reason = premade[1]
	local punishment = premade[2]

	pl.TimesPunished[reasoncode] = (pl.TimesPunished[reasoncode] or 0) + 1
	pl:SetKeyDirty("TimesPunished")

	local times = pl.TimesPunished[reasoncode]

	local duration = premade[3][times] or premade[3][ #premade[3] ]

	NDB.AddPunishment(pl, punishment, duration, reason, sender)
end)

concommand.Add("unpunish", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsAdmin()) then return end

	local steamidoruserid = arguments[1]
	if not steamidoruserid then
		sender:PrintMessage(HUD_PRINTTALK, "No UserID or SteamID given.")
		return
	end

	local punishment = tonumbersafe(arguments[2])
	if not punishment then
		sender:PrintMessage(HUD_PRINTTALK, "No punishment given.")
		return
	end

	NDB.RemovePunishment(steamidoruserid, punishment, sender)
end)

hook.Add("Initialize", "NDB.LoadPunishments", function()
	util.AddNetworkString("nox_requestpunishments")
	util.AddNetworkString("nox_punishments")
	util.AddNetworkString("nox_addpunishment")
	util.AddNetworkString("nox_addpremadepunishment")

	hook.Remove("Initialize", "NDB.LoadPunishments")
	NDB.SyncPunishments()
end)

hook.Add("PlayerPasswordAuth", "PunishmentsPlayerPasswordAuth", function(name, pass, steamid, ipaddress)
	for i, tab in pairs(NDB.Punishments) do
		if tab.Punishment == PUNISHMENT_BAN and tab.SteamID == steamid then
			if tab.Expires == 0 then
				return string.format("Permanently banned: %s", tab.Reason)
			elseif os.time() < tab.Expires then
				return string.format("Banned for %s: %s", TimeToEnglish(tab.Expires - os.time()), tab.Reason)
			end
		end
	end
end)

local function DoHealthMul(pl, mul)
	if pl:IsValid() then
		pl:SetMaxHealth(math.max(1, math.ceil(pl:GetMaxHealth() * mul)))
		pl:SetHealth(math.max(1, math.ceil(pl:Health() * mul)))
	end
end

local function EntityTakeDamage_DoubleDamage(ent, dmginfo)
	if ent:IsPlayer() and ent:IsPunished(PUNISHMENT_DOUBLEDAMAGE) then
		dmginfo:SetDamage(dmginfo:GetDamage() * 2)
	end
end

local function EntityTakeDamage_InstantDeath(ent, dmginfo)
	if ent:IsPlayer() and ent:IsPunished(PUNISHMENT_INSTANTDEATH) then
		dmginfo:SetDamage(math.max(dmginfo:GetDamage(), ent:Health() * 1.4))
	end
end

hook.Add("PlayerSpawn", "PunishmentsPlayerSpawn", function(pl)
	if pl:IsPunished(PUNISHMENT_DOUBLEDAMAGE) then
		hook.Add("EntityTakeDamage", "NDB_DoubleDamage", EntityTakeDamage_DoubleDamage)
	end

	if pl:IsPunished(PUNISHMENT_INSTANTDEATH) then
		hook.Add("EntityTakeDamage", "NDB_InstantDeath", EntityTakeDamage_InstantDeath)
	end
end)

hook.Add("PlayerSpray", "PunishmentsSpray", function(pl)
	if pl:IsPunishedNotify(PUNISHMENT_NOSPRAY) then
		return true
	end
end)

hook.Add("PostPlayerReady", "PunishmentsDeaf", function(pl)
	if pl:IsPunished(PUNISHMENT_DEAF) then
		pl:SendLua([[hook.Add("Think", "NDB_Deaf", function() local pl = LocalPlayer() if pl:IsValid() then pl:SetDSP(math.Round(math.abs(math.sin(CurTime() * 5))) + 35) end end)]])
	end

	pl.NotAvoidingPunishments = true
	local steamid = pl:SteamID()
	for i, tab in pairs(NDB.Punishments) do
		if tab.SteamID == steamid and (tab.Expires == 0 or os.time() < tab.Expires) then
			pl:SetPunished(tab.Punishment, true, tab, true)
		end
	end
end)

local function AvoidPunishments(pl)
	if not pl:IsValid() or pl.NotAvoidingPunishments then return end

	pl.NotAvoidingPunishments = true
	local steamid = pl:SteamID()
	for i, tab in pairs(NDB.Punishments) do
		if tab.SteamID == steamid and (tab.Expires == 0 or os.time() < tab.Expires) then
			pl:SetPunished(tab.Punishment, true, tab, true)
		end
	end
end

hook.Add("PlayerInitialSpawn", "PunishmentsPlayerInitialSpawn", function(pl)
	local steamid = pl:SteamID()
	for i, tab in pairs(NDB.Punishments) do
		if tab.SteamID == steamid and tab.Punishment == PUNISHMENT_BAN and (tab.Expires == 0 or os.time() < tab.Expires) then
			if gatekeeper then
				timer.SimpleEx(2, gatekeeper.Drop, pl:UserID(), "Banned: "..tostring(tab.Reason))
			end

			timer.SimpleEx(3, game.ConsoleCommand, string.rep("kickid "..pl:SteamID().." Banned: "..tostring(tab.Reason).."\n", 6))
		end
	end

	timer.SimpleEx(5, AvoidPunishments, pl)
end)

local meta = FindMetaTable("Player")
function meta:IsPunished(punishment)
	return self.Punishments and self.Punishments[punishment]
end

local SetPunishedCB = {}
SetPunishedCB[PUNISHMENT_SNAIL] = function(pl, onoff, tab, onspawn)
	for _, pl in pairs(player.GetAll()) do
		if pl:IsPunished(PUNISHMENT_SNAIL) then
			hook.Add("Move", "NDB.SnailMove", NDB.SnailMove)
			return
		end
	end

	hook.Remove("Move", "NDB.SnailMove")
end
SetPunishedCB[PUNISHMENT_DEAF] = function(pl, onoff, tab, onspawn)
	if onoff then
		pl:SendLua([[hook.Add("Think", "NDB_Deaf", function() local pl = LocalPlayer() if pl:IsValid() then pl:SetDSP(math.Round(math.abs(math.sin(CurTime() * 5))) + 35) end end)]])
	else
		pl:SendLua([[hook.Remove("Think", "NDB_Deaf")]])
	end
end
local function IceSkates(pl, mv)
	if pl:IsPunished(PUNISHMENT_ICESKATES) then
		pl:SetGroundEntity(NULL)
		local vel = mv:GetVelocity()
		local vel2d = Vector(vel.x, vel.y, 0)
		local newvel = math.min(vel2d:Length(), mv:GetMaxSpeed()) * vel2d
		newvel.z = vel.z
		mv:SetVelocity(newvel)
	end
end
SetPunishedCB[PUNISHMENT_ICESKATES] = function(pl, onoff, tab, onspawn)
	if onoff then
		hook.Add("Move", "IceSkates", IceSkates)
		pl:SendLua("NDB.StartIceSkates()")
	else
		pl:SendLua("NDB.EndIceSkates()")
		local iceskates = false
		for _, ent in pairs(player.GetAll()) do
			if ent:IsPunished(PUNISHMENT_ICESKATES) then
				iceskates = true
				break
			end
		end
		if not iceskates then
			hook.Remove("Move", "IceSkates")
		end
	end
end
SetPunishedCB[PUNISHMENT_NOEMOTES] = function(pl, onoff, tab, onspawn)
	pl:SetNetworkedBool("noemotes", util.tobool(onoff))
end
SetPunishedCB[PUNISHMENT_SOHIGHRIGHTNOW] = function(pl, onoff, tab, onspawn)
	if onoff then
		pl:SendLua([[StartSoHighRightNow()]])
	else
		pl:SendLua([[EndSoHighRightNow()]])
	end
end
SetPunishedCB[PUNISHMENT_DOUBLEDAMAGE] = function(pl, onoff, tab, onspawn)
	if onoff then
		hook.Add("EntityTakeDamage", "NDB_DoubleDamage", EntityTakeDamage_DoubleDamage)
	end
end
SetPunishedCB[PUNISHMENT_INSTANTDEATH] = function(pl, onoff, tab, onspawn)
	if onoff then
		hook.Add("EntityTakeDamage", "NDB_InstantDeath", EntityTakeDamage_InstantDeath)
	end
end
SetPunishedCB[PUNISHMENT_BAN] = function(pl, onoff, tab, onspawn, silent)
	if onoff then
		if onspawn then -- This shouldn't ever happen unless the hook breaks.
			if gatekeeper then
				timer.SimpleEx(2, gatekeeper.Drop, pl:UserID(), "You are banned.")
			else
				local commnd = "kickid "..pl:SteamID().." You are banned.\n"
				timer.SimpleEx(2, game.ConsoleCommand, commnd..commnd..commnd..commnd..commnd..commnd)
			end

			return
		end

		--[[if tab.Expires == 0 and scripted_ents.GetStored("bantrain") then
			pl.BanTrainComment = "Banned forever: "..tostring(tab.Reason)
			BanTrain(pl)
		else]]
			if not silent then
				BroadcastLua("surface.PlaySound(\"vo/npc/male01/gethellout.wav\")")
			end

			if gatekeeper then
				timer.SimpleEx(2, gatekeeper.Drop, pl:UserID(), "Banned: "..tostring(tab.Reason))
			else
				local commnd = "kickid "..pl:SteamID().." Banned: "..tostring(tab.Reason).."\n"
				timer.SimpleEx(2, game.ConsoleCommand, commnd..commnd..commnd..commnd..commnd..commnd)
			end
		--end
	end
end

function meta:SetPunished(punishment, onoff, tab, onspawn, silent)
	if onoff then
		self.Punishments = self.Punishments or {}
		self.Punishments[punishment] = tab
		self:PrintMessage(HUD_PRINTTALK, "You have been "..tostring(NDB.PunishmentsPastNames[punishment])..".")
	elseif self.Punishments and self.Punishments[punishment] then
		self.Punishments[punishment] = nil
		self:PrintMessage(HUD_PRINTTALK, "Your "..tostring(NDB.PunishmentsNames[punishment]).." has expired or been removed.")
	end

	net.Start("nox_localplayerpunished")
		net.WriteUInt(punishment, 8)
		net.WriteBit(onoff)
	net.Send(self)

	if SetPunishedCB[punishment] then
		SetPunishedCB[punishment](self, onoff, tab, onspawn, silent)
	end
end
meta.SetPunishment = meta.SetPunished
meta = nil

function BanTrain(pl)
	PrintMessage(HUD_PRINTTALK, "<defc=255,0,0>The Ban Train is coming to pick up "..pl:Name()..". <flash rate=10>No return trips!</flash>")

	pl:Freeze(true)
	pl:SetEyeAngles(Angle(0, 270, 0))

	local ent = ents.Create("bantrain")
	if ent:IsValid() then
		ent:SetPos(pl:GetPos() + Vector(0, -24000, 100))
		ent.Banee = pl
		ent:Spawn()
		ent:Fire("farhorn", "", 1)
		ent:Fire("closehorn", "", 8)
		ent:Fire("kill", "", 60)
	end
	local ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetModel("models/props_trainstation/train002.mdl")
		ent2:SetPos(pl:GetPos() + Vector(0,-24500,100))
		ent2:SetKeyValue("solid", "0")
		ent2:Spawn()
		ent2:SetParent(ent)
	end
	ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetModel("models/props_trainstation/train003.mdl")
		ent2:SetPos(pl:GetPos() + Vector(0,-25000,100))
		ent2:SetKeyValue("solid", "0")
		ent2:Spawn()
		ent2:SetParent(ent)
	end
end

scripted_ents.Register({
Type = "anim",

Initialize = function(self)
	self.DieTime = CurTime() + math.Rand(20, 35)

	self:SetModel("models/props_trainstation/train001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:Wake()
	end

	util.PrecacheSound("ambient/alarms/train_horn2.wav")
	util.PrecacheSound("ambient/alarms/train_horn_distant1.wav")
end,

AcceptInput = function(self, name, activator, caller, args)
	if name == "closehorn" then
		for _, pl in pairs(player.GetAll()) do
			pl:SendLua("surface.PlaySound(\"ambient/alarms/train_horn2.wav\")")
		end

		return true
	elseif name == "farhorn" then
		for _, pl in pairs(player.GetAll()) do
			pl:SendLua("surface.PlaySound(\"ambient/alarms/train_horn_distant1.wav\")")
		end

		return true
	end
end,

Think = function(self)
	local banee = self.Banee
	if not self.AlreadyHit and banee:IsValid() and banee:GetPos().y <= self:GetPos().y then
		self.AlreadyHit = true

		PrintMessage(HUD_PRINTTALK, banee:Name().." was hit by the Ban Train.")
		gatekeeper.Drop(banee:UserID(), banee.BanTrainComment or "Hit by the ban train.")
		self:Fire("kill", "", 6)
	end

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetVelocityInstantaneous(Vector(0, 4000, 0))
	end
end,

UpdateTransmitState = function(self)
	return TRANSMIT_PVS
end}, "bantrain")
