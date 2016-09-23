local meta = FindMetaTable("Player")
if not meta then return end

function meta:SafeKick(reason)
	local cmd = string.format("kickid %d %s\n", self:UserID(), reason:gsub(";|\n", ""))
	for i=1, 5 do
		game.ConsoleCommand(cmd)
	end
end

function meta:IsValidAccount()
	return self:IsValid() and self._VALIDACCOUNT_
end

function meta:IsValidAccountNotify()
	if self:IsValidAccount() then
		return true
	end

	self:PrintMessage(HUD_PRINTTALK, "<flash color=255,0,0 rate=10>Your account didn't load yet. If this message persists then contact an admin:</flash> admin@noxiousnet.com <silkicon icon=exclamation size=150>")
	return false
end

function meta:StrippedIPAddress()
	local ip = self:IPAddress()
	local ip8, ip16 = string.match(ip, "(%d+)%.(%d+)%.%d+%.%d+")
	if ip16 then
		return ip8.."."..ip16..".*.*"
	end

	return ip
end

function IPUID(ip)
	return util.CRC("_sALT"..ip)
end

function meta:IPUID()
	return IPUID(self:IPAddress())
end

-- We use this to set keys as "dirty". Only dirty keys are updated in our SQL UPDATE queries.
function meta:SetPlayerKeyValue(key, value)
	if not self:IsValidAccount() then return end

	self:SetKeyDirty(key)
	self[key] = value
end
meta.SetPKV = meta.SetPlayerKeyValue

function meta:AddPlayerKeyValue(key, value)
	if self[key] ~= nil then
		self:SetPlayerKeyValue(key, self[key] + value)
	end
end
meta.AddPKV = meta.AddPlayerKeyValue

function meta:SetKeyDirty(key)
	self._DirtyKey[key] = true
end

function meta:UpdateDB(buffer, complete)
	if not self:IsValidAccount() then return end

	local time = os.time()
	self:SetPlayerKeyValue("LastOnline", time)
	self:AddPKV("TimeOnline", time - self.TimeOnlineStart)
	self.TimeOnlineStart = time

	local qt = {}
	local args = {}
	local strquery = "UPDATE noxplayers SET "

	for k in pairs(self._DirtyKey) do
		local isnull = false
		local val = self[k]
		if NDB.PlayerKeysStringTablesSRL[k] then
			if val == nil or table.Count(val) == nil then
				isnull = true
			else
				val = Serialize(val, true) or ""
			end
		elseif NDB.PlayerKeysStringTables[k] or NDB.PlayerKeysNumberTables[k] or type(val) == "table" then
			if val == nil or #val == 0 then
				isnull = true
			else
				val = table.concat(val, ",") or ""
			end
		elseif NDB.PlayerKeysString[k] then
			if val == nil then
				isnull = true
			else
				val = tostring(val)
			end
		else
			val = tonumber(val or 0) or 0
			if not NDB.PlayerKeysSigned[k] then
				val = math.max(val, 0)
			end
		end

		table.insert(qt, (NDB.PlayerKeysAliasSQL[k] or k).." = "..(isnull and "%s" or type(val) == "number" and "%d" or "%q"))
		if isnull then
			table.insert(args, "NULL")
		else
			table.insert(args, val)
		end
	end

	local name = self:Name()
	local ipaddress = self:IPAddressNoPort()

	if complete or name ~= self._LASTNAME then
		self._LASTNAME = name
		table.insert(qt, "Name = %q")
		table.insert(args, name)
	end
	if complete or ipaddress ~= self._LASTIPADDRESS then
		self._LASTIPADDRESS = ipaddress
		table.insert(qt, "IPAddress = %q")
		table.insert(args, ipaddress)
	end

	strquery = strquery..table.concat(qt, ", ")

	strquery = strquery.." WHERE SteamID = %q LIMIT 1"
	table.insert(args, self:SteamID())

	strquery = string.format(strquery, unpack(args))

	if buffer then
		table.insert(buffer, strquery)
	else
		mysql_query(strquery)
	end

	self._DirtyKey = {}

	self:PrintMessage(HUD_PRINTCONSOLE, "Your NoXiousNet account has been saved.")
end

local function InitQueryInsert(query, result, pl)
	if IsValid(pl) then
		pl._VALIDACCOUNT_ = true

		pl:PrintMessage(HUD_PRINTTALK, "Welcome to <lg>NoXiousNet</lg>! Our website is <lg>noxiousnet.com</lg>. If you're curious about anything then just ask or press F1.")
		PrintMessage(HUD_PRINTTALK, "<silkicon icon=user> Everybody welcome <lg>"..pl:Name().."</lg> as they have joined for the first time!")

		pl:PostDBInit()
	end
end

local function InitQuery(query, result, pl)
	if not IsValid(pl) then return end

	if result[1] then
		for k, v in pairs(result[1]) do
			local callback = NDB.PlayerKeysSpecial[k]
			if callback then
				callback(pl, v)
			else
				local pk = NDB.PlayerKeysAliasGame[k] or k
				if NDB.PlayerKeysStringTablesSRL[k] then
					pl[pk] = Deserialize(v)
				elseif NDB.PlayerKeysStringTables[k] then
					if v == "" then
						pl[pk] = {}
					else
						pl[pk] = string.Explode(",", v)
					end
				elseif NDB.PlayerKeysNumberTables[k] then
					if v == "" then
						pl[pk] = {}
					else
						local numtab = string.Explode(",", v)
						for nk, nv in ipairs(numtab) do
							numtab[nk] = tonumber(nv or 0) or 0
						end
						pl[pk] = numtab
					end
				else
					pl[pk] = v
				end
			end
		end

		pl._VALIDACCOUNT_ = true
	else
		mysql_query(
			string.format(
				"INSERT INTO noxplayers (SteamID, Name, IPAddress, Money, MemberLevel, LastOnline) VALUES(%q, %q, %q, %d, %d, %d)",
				pl:SteamID(),
				pl:Name(),
				pl:IPAddressNoPort(),
				pl:GetSilver(),
				pl:GetMemberLevel(),
				os.time()
			),
			InitQueryInsert,
			pl
		)
	end

	pl:PostDBInit()
end

function meta:InitDB()
	self._DirtyKey = {}

	self._VALIDACCOUNT_ = false -- We become valid after the query stuff is done successfully.

	NDB.SetupDefaults(self)
	mysql_query(
		string.format(
			"SELECT * FROM noxplayers WHERE SteamID = %q LIMIT 1",
			self:SteamID()
		),
		InitQuery, self
	)
end

function meta:PostDBInit()
	-- Check if they should be an elder member.
	local haselder = self:HasAward("elder_member")
	if not haselder or self:GetMemberLevel() == MEMBER_NONE then
		local played = 0
		for _, key in pairs(NDB.PlayedKeys) do
			if self[key] then
				played = played + self[key]
			end
		end
		if played >= NDB.ElderMemberThreshold then
			if not haselder then
				self:GiveAward("elder_member")
			end
			if self:GetMemberLevel() == MEMBER_NONE then
				self:SetMemberLevel(MEMBER_ELDER)
				self:PrintMessage(HUD_PRINTTALK, "<silkicon icon=emoticon_smile> <flash color=200,200,200 rate=6>You have been made an Elder Member for being a very frequent selfayer!</flash>")
			end
		end
	end

	-- Shouldn't have a voice pitch if not a diamond member.
	if self.VoicePitch and self:GetMemberLevel() ~= MEMBER_DIAMOND then
		self:SetPKV("VoicePitch", nil)
	end

	hook.Call("PostDBInit", GAMEMODE, self)
end

function meta:IPAddressNoPort()
	local ip = self:IPAddress()
	return string.match(ip, "(.+):") or ip
end

function meta:Update3DTitle()
	if self.Title3D then
		if self.Title3DEnd and os.time() >= self.Title3DEnd then
			self:SetPKV("Title3D", nil)
			self:SetPKV("Title3DEnd", nil)
			self:PrintMessage(HUD_PRINTTALK, "Your 3D title has expired.")
			self:RemoveCostume("title3d")
		else
			self:SetCostumeOption("title3d", COSTUMEOPTION_TITLESTRING, self.Title3D)
			self:AddCostume("title3d")
		end
	end
end

function meta:UpdateSavedTitles()
	net.Start("nox_savedtitles")
		net.WriteUInt(#self.SavedTitles, 16)
		for i=1, #self.SavedTitles do
			net.WriteString(self.SavedTitles[i])
		end
	net.Send(self)
end

function meta:UpdateSaved3DTitles()
	net.Start("nox_saved3dtitles")
		net.WriteUInt(#self.Saved3DTitles, 16)
		for i=1, #self.Saved3DTitles do
			net.WriteString(self.Saved3DTitles[i])
		end
	net.Send(self)
end

function meta:UpdateVoicePitch(filter)
	net.Start("nox_voicepitch")
		net.WriteEntity(self)
		net.WriteUInt(self.VoicePitch or 0, 8)
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

function meta:SendNDBInfo(filter)
	net.Start("nox_ndbinfo")
		net.WriteEntity(self)
		net.WriteUInt(self.PersonalChatColor or 0, 24)
		net.WriteUInt(self:GetMemberLevel(), 8)
		net.WriteString(self.NewTitle or "")
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

function meta:SendTitles(filter)
	net.Start("nox_titles")
		net.WriteEntity(self)
		net.WriteUInt(#self.Titles, 8)
		for i, v in ipairs(self.Titles) do
			net.WriteString(tostring(v))
		end
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end
meta.UpdateTitles = meta.SendTitles

function meta:UpdateTitleChangeCards()
	net.Start("nox_titlecards")
		net.WriteUInt(self:GetTitleChangeCards(), 16)
	net.Send(self)
end

function meta:SetDefaultChatColor(r, g, b)
	self:SetPKV("PersonalChatColor", encodecolor(r, g, b))
	self:SendNDBInfo()
end

function meta:SetTitle(title)
	self:SetPKV("NewTitle", title)
	self:SendNDBInfo()
end

function meta:SetMemberLevel(level)
	self:SetPKV("MemberLevel", level)
	self:SendNDBInfo()
end

function meta:CheckChatSpamming(text, all)
	if not self:IsAdmin() then
		local delay = math.Clamp(#self.LastMessageText / (NDB.MaxChatSize / 3), 0.2, 1) * NDB.MaxChatTimeout
		local samemessage = text == self.LastMessageText
		if samemessage then
			delay = delay * 2
		end

		if SysTime() < self.LastChat + delay then
			if text == self.LastMessageText then
				self:PrintMessage(HUD_PRINTTALK, "<red>You only spam yourself, moron.</red>")
			else
				self:PrintMessage(HUD_PRINTTALK, "<red>Please use one sentence to convey your messages.</red>")
			end

			return true
		end
	end

	return false
end

function meta:GiveAward(nam)
	return NDB.GiveAward(self, nam)
end

function meta:HasAward(nam)
	if self.Awards then
		nam = string.lower(nam)
		for _, awdname in pairs(self.Awards) do
			if string.lower(awdname) == nam then
				return true
			end
		end
	end

	return false
end

function meta:HasFlag(flag)
	if self.Flags then
		flag = string.lower(flag)
		for i, myflag in pairs(self.Flags) do
			if myflag == flag then return true end
		end
	end

	return false
end

function meta:GetVotePower()
	return NDB.MemberVotePower[self:GetMemberLevel()] or 1
end

function meta:GetDiscount()
	return NDB.MemberDiscounts[self:GetMemberLevel()] or 1
end

function meta:RemoveFlag(flag)
	flag = string.lower(flag)
	for i, myflag in ipairs(self.Flags) do
		if myflag == flag then
			table.remove(self.Flags, i)
			self:SetKeyDirty("Flags")
			return true
		end
	end

	return false
end

function meta:GiveFlag(flag)
	flag = string.lower(flag)
	for i, myflag in pairs(self.Flags) do
		if myflag == flag then return true end
	end

	table.insert(self.Flags, flag)
	self:SetKeyDirty("Flags")
	return true
end
meta.AddFlag = meta.GiveFlag

function meta:HasShopItem(item)
	return NDB.PlayerHasShopItem(self, item)
end

function meta:GetSilver()
	return self.Silver or 0
end

function meta:NoParseName()
	local name, num = string.Replace(self:Name(), "</noparse>", "</noparse><noparse>")
	return "<noparse>"..name.."</noparse>"
end

function meta:CustomGesture(gesture)
	self:AnimRestartGesture(GESTURE_SLOT_CUSTOM, gesture, true)
	umsg.Start("cusges")
		umsg.Entity(self)
		umsg.Short(gesture)
	umsg.End()
end

function meta:ChangeTitle(title)
	if not title then return end

	title = tostring(title)

	--[[if self.TitleLock and not self:IsSuperAdmin() then
		if type(self.TitleLock) == "number" then
			local timeleft = self.TitleLock - os.time()
			if timeleft > 0 then
				self:PrintMessage(HUD_PRINTTALK, "Your title is locked for "..math.ceil(timeleft / 60).." more minutes.")
				return
			end
		else
			self:PrintMessage(HUD_PRINTTALK, "Your title is currently locked.")
			return
		end
	end]]

	if string.lower(title) == "none" then
		title = self:GetDefaultTitle()
	end

	self:SetTitle(title)

	self:PrintMessage(HUD_PRINTTALK, "Your main title has been set to \""..title.."\"")
end

function meta:SetSilver(int)
	self:SetPKV("Silver", math.floor(int))

	self:UpdateSilver()
end

function meta:UpdateSilver()
	net.Start("nox_money")
		net.WriteUInt(self:GetSilver(), 32)
	net.Send(self)
end

function meta:IsMuted()
	return self:IsPunished(PUNISHMENT_MUTE)
end

function meta:NotifyPunishment(punishment)
	if punishment.Expires == 0 then
		self:PrintMessage(HUD_PRINTTALK, "You have been <red>permanently "..tostring(NDB.PunishmentsPastNames[punishment.Punishment]).."</red> because: "..tostring(punishment.Reason))
	else
		self:PrintMessage(HUD_PRINTTALK, "You have been <red>"..tostring(NDB.PunishmentsPastNames[punishment.Punishment]).."</red> because: "..tostring(punishment.Reason))
		self:PrintMessage(HUD_PRINTTALK, "Expires in <red>"..TimeToEnglish(math.max(1, punishment.Expires - os.time())).."</red>.")
	end
end

function meta:IsPunishedNotify(punishment)
	local tab = self:IsPunished(punishment)
	if tab then
		self:NotifyPunishment(tab)

		return true
	end
end

function meta:AbuseHelp()
	self:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> Please contact <lb>admin@noxiousnet.com</lb> or complain on <lg>noxiousnet.com</lg> if you believe this to be abusive.")
end

function meta:UpdateShopInventory(target)
	net.Start("nox_playerinventory")
		net.WriteEntity(target or self)
		net.WriteUInt(#self.Inventory, 16)
		for k, v in ipairs(self.Inventory) do
			net.WriteUInt(v, 16)
		end
	net.Send(self)
end

local old = meta.SetModel
function meta:SetModel(mdl, override)
	if not override and self:IsValidAccount() then
		for itemname, itemtab in pairs(NDB.ShopItems) do
			if itemtab[CAT_MODEL] and itemtab.Model == mdl and not self:HasShopItem(itemname) then
				mdl = "models/player/kleiner.mdl"
				break
			end
		end
	end

	if old then
		old(self, mdl)
	else
		FindMetaTable("Entity").SetModel(self, mdl)
	end
end

net.Receive("nox_voicepitch", function(length, sender)
	local pitch = net.ReadUInt(8)

	if sender:IsValid() and sender:GetMemberLevel() == MEMBER_DIAMOND then
		sender:SetVoicePitch(math.Clamp(math.ceil(pitch), 50, 200))
	end
end)
