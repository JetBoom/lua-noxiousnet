function NDB.AddSilverDB(net, int)
	if tonumber(net) == nil then return end
	if tonumber(int) == nil then return end

	int = math.floor(int)
	for _, pl in pairs(player.GetAll()) do
		if pl:AccountID() == net then
			Msg("Person is currently connected.\n")
			if int ~= 0 then
				pl:AddSilver(int, true)
				pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=heart> <flash color=255,255,255 rate=6>An admin has given you "..int.." Silver.</flash>")
				pl:UpdateDB()
				Msg("Gave "..int.." Silver.\n")
			end

			return
		end
	end

	Msg("Couldn't find person!")

	--[[local filename = AccountFile(net)
	if file.Exists(filename, "DATA") then
		local tab = Deserialize(file.Read(filename, "DATA"))
		tab.Silver = (tab.Money or tab.Silver) + int
		file.Write(filename, Serialize(tab))
		Msg("Account awarded "..int.." Silver!\n")
	else
		Msg("Account did not exist!\n")
	end]]
end

function NDB.AddGoldMember(pl)
	pl:SetMemberLevel(MEMBER_GOLD)
	pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=emoticon_smile> <flash color=255,255,0 rate=6>Your account's member level has been changed to Gold Member!</flash>")
	pl:SendLua("MySelf.MemberLevel=MEMBER_GOLD")
	Msg(pl:Name().." added as Gold Member!\n")
	pl:UpdateDB()
end

function NDB.AddGoldMemberDB(net)
	for _, pl in pairs(player.GetAll()) do
		if pl:AccountID() == net then
			Msg("Person is currently connected.\n")
			NDB.AddGoldMember(pl)
			return
		end
	end

	Msg("Couldn't find person!")

	--[[local filename = AccountFile(net)
	if file.Exists(filename, "DATA") then
		local tab = Deserialize(file.Read(filename, "DATA"))
		tab.MemberLevel = MEMBER_GOLD
		file.Write(filename, Serialize(tab))
		Msg("Account edited to Gold Member!\n")
	else
		Msg("Account did not exist!\n")
	end]]
end

function NDB.AddDiamondMember(pl)
	pl:SetMemberLevel(MEMBER_DIAMOND)
	pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=emoticon_smile> <flash color=255,255,255 rate=6>Your account's member level has been changed to Diamond Member!</flash>")
	pl:SendLua("MySelf.MemberLevel=MEMBER_DIAMOND")
	Msg(pl:Name().." added as Diamond Member!\n")
	pl:UpdateDB()
end

function NDB.AddDiamondMemberDB(net)
	for _, pl in pairs(player.GetAll()) do
		if pl:AccountID() == net then
			Msg("Person is currently connected.\n")
			NDB.AddDiamondMember(pl)
			return
		end
	end

	Msg("Couldn't find person!")

	--[[local filename = AccountFile(net)
	if file.Exists(filename, "DATA") then
		local tab = Deserialize(file.Read(filename, "DATA"))
		tab.MemberLevel = MEMBER_DIAMOND
		file.Write(filename, Serialize(tab))
		Msg("Account edited to Diamond Member!\n")
	else
		Msg("Account did not exist!\n")
	end]]
end

function NDB.CheckDonations(pl)
	if pl:IsValid() and pl:IsConnected() and pl:IsValidAccount() then
		local steamid = pl:SteamID()
		local net = AccountID(steamid)

		if not file.Exists("donations/"..net..".txt", "DATA") then return end

		local contents = file.Read("donations/"..net..".txt", "DATA")
		file.Write("prevdonations/"..net..".txt", contents)
		local topmemberlevel
		local moneytoadd = 0
		local cardstoadd = 0
		for i, cont in pairs(string.Explode(",", contents)) do
			local __, ___, amount = string.find(cont, "Money:(%d+)")
			if amount then
				amount = tonumber(amount)
				if amount then
					moneytoadd = moneytoadd + amount
				end
			end

			local ____, ______, lvl = string.find(cont, "MemberLevel:(%d+)")
			if lvl then
				lvl = tonumber(lvl)
				if lvl and lvl > (topmemberlevel or 0) then
					topmemberlevel = lvl
				end
			end

			local cards = string.match(cont, "TitleChangeCards:(%d+)")
			if cards then
				cards = tonumber(cards)
				if cards then
					cardstoadd = cardstoadd + cards
				end
			end
		end

		if topmemberlevel and topmemberlevel ~= pl:GetMemberLevel() then
			if topmemberlevel == MEMBER_GOLD then
				pl:PrintMessage(HUD_PRINTTALK, "<lg>You've been given Gold Member for your donation!</lg>")
				pl:SetMemberLevel(MEMBER_GOLD)
				pl:SendLua("LocalPlayer().MemberLevel="..tostring(pl.MemberLevel))
				NDB.LogLine("<Donation> Gold Member - "..steamid.." "..pl:Name())
			elseif topmemberlevel == MEMBER_DIAMOND then
				pl:PrintMessage(HUD_PRINTTALK, "<lg>You've been given Diamond Member for your donation!</lg>")
				pl:SetMemberLevel(MEMBER_DIAMOND)
				pl:SendLua("LocalPlayer().MemberLevel="..tostring(pl.MemberLevel))
				NDB.LogLine("<Donation> Diamond Member - "..steamid.." "..pl:Name())
			end
		end

		if moneytoadd > 0 then
			pl:AddSilver(moneytoadd, true)
			pl:PrintMessage(HUD_PRINTTALK, "<lg>You've been given "..moneytoadd.." Silver for your donation!</lg>")
			NDB.LogLine("<Donation> "..moneytoadd.." Silver - "..steamid.." "..pl:Name())
		end

		if cardstoadd > 0 then
			pl:SetTitleChangeCards(pl:GetTitleChangeCards() + cardstoadd)
			pl:PrintMessage(HUD_PRINTTALK, "<lg>You've been given "..cardstoadd.." Title Change Card"..(cardstoadd == 1 and "" or "s").."!</lg>")
			NDB.LogLine("<Donation> "..cardstoadd.." Title Change Cards - "..steamid.." "..pl:Name())
		end

		file.Delete("donations/"..net..".txt", "DATA")
		pl:UpdateDB()
	end
end

hook.Add("PostPlayerReady", "NDB.CheckDonations", function(pl)
	NDB.CheckDonations(pl)
end)
