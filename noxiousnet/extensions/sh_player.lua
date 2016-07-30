function player.GetAllNoBots()
	local tab = player.GetAll()
	for i, pl in ipairs(tab) do
		if pl and pl:IsBot() then
			table.remove(tab, i)
			i = i - 1
		end
	end
	return tab
end

-- TODO: Remove this protection when fixed in c++
if CLIENT then
	local meta = FindMetaTable("Entity")
	local old = meta.GetBonePosition
	meta.GetBonePosition = function(self, boneid)
		if not boneid or boneid < 0 or boneid >= self:GetBoneCount() then return self:GetPos(), self:GetAngles() end

		return old(self, boneid)
	end
end

local meta = FindMetaTable("Player")
if not meta then return end

function meta:IsTyping()
	return self.ChattingState
end

function meta:SetVoicePitch(pitch, noupdate)
	self.VoicePitch = pitch

	if SERVER then
		self:SetKeyDirty("VoicePitch")
		if not noupdate then
			self:UpdateVoicePitch()
		end
	end
end

function meta:SetTitleChangeCards(m)
	self.TitleChangeCards = m

	if SERVER then
		self:SetKeyDirty("TitleChangeCards")
		self:UpdateTitleChangeCards()
	end
end

function meta:GetTitleChangeCards()
	return self.TitleChangeCards or 0
end

function meta:LogID()
	return "<"..self:SteamID().."> "..self:Name()
end

function meta:HasAward(nam)
	if not self.Awards then return false end

	nam = string.lower(nam)
	for _, awdname in pairs(self.Awards) do
		if string.lower(awdname) == nam then
			return true
		end
	end

	return false
end

function meta:GetDefaultTitle()
	return NDB.DefaultMemberTitles[self:GetMemberLevel()] or NDB.DefaultMemberTitles[MEMBER_NONE] or ""
end

function meta:GetPreTitle()
	local title = ""

	if self:IsSuperAdmin() then
		title = NDB.SuperAdminTitle
	elseif self:IsAdmin() then
		title = NDB.AdminTitle
	elseif self:IsModerator() then
		title = NDB.ModeratorTitle
	end

	if NDB.MemberAvatar[self:GetMemberLevel()] then
		title = title == "" and "<avatar>" or "<avatar> "..title
	end

	return title
end

function meta:GetMemberLevel()
	return self.MemberLevel or MEMBER_DEFAULT
end

function meta:IsModerator()
	return self:IsAdmin() or self:IsOnlyModerator()
end

function meta:IsOnlyModerator()
	return self:IsUserGroup("moderator")
end

function meta:GetVotePower()
	return NDB.MemberVotePower[self:GetMemberLevel()] or 1
end

function meta:GetDiscount()
	return NDB.MemberDiscounts[self:GetMemberLevel()] or 1
end

function meta:HasShopItem(item)
	return NDB.PlayerHasShopItem(self, item)
end

function meta:AddSilver(int, norecord)
	if SERVER and int > 0 and not norecord then
		--int = math.ceil(int * 1.5) -- Holiday 2014
		self:AddPKV("SilverEarned", int)
	end

	self:SetSilver(self:GetSilver() + int)
end

function meta:GetSilver()
	return self.Silver or 0
end

function meta:AccountFolder()
	return GetAccountFolder(self:AccountNumber())
end

function meta:AccountNumber()
	return GetAccountID(self:SteamID())
end

function meta:AccountNumber()
	return AccountID(self:SteamID())
end

function meta:AccountFolder()
	return AccountFolder(self:AccountNumber())
end

function meta:AccountFile()
	return AccountFile(self:AccountNumber())
end

function meta:NoParseName()
	local name, num = string.Replace(self:Name(), "</noparse>", "</noparse><noparse>")
	return "<noparse>"..name.."</noparse>"
end
