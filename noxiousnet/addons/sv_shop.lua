local ShopItems = NDB.ShopItems

NDB.TitleAliases = {
	["(zs champion)"] = "(zombie survival champion)",
	["(rtp apprentice)"] = "(team play apprentice)",
	["(rtp battle apprentice)"] = "(team play battle apprentice)",
	["(rtp midfielder)"] = "(team play midfielder)",
	["(rtp battle midfielder)"] = "(team play battle midfielder)",
	["(rtp master)"] = "(team play master)",
	["(rtp battle master)"] = "(team play battle master)",
	["(rtp champion)"] = "(team play champion)",
	["(smb novice)"] = "(mario boxes novice)",
	["(smb knight)"] = "(mario boxes knight)",
	["(smb hero)"] = "(mario boxes hero)",
	["(smb champion)"] = "(mario boxes champion)"
}

hook.Add("PostPlayerReady", "NDB_Shop_PlayerReady", function(pl)
	local costumeslots = pl.CostumeSlots
	if not costumeslots or GAMEMODE.HatsDisabled then return end

	for slot in pairs(COSTUMESLOTS) do
		if slot ~= COSTUMESLOT_NONE then
			pl:AddCostume(costumeslots[slot], true)
		end
	end

	if table.Count(pl:GetCostumes()) > 0 then
		pl:UpdateCostumes()
	end
end)

hook.Add("PostPlayerReady", "TitlePlayerReady", function(pl)
	local curtitle = string.lower(pl.NewTitle or "none")
	for i, tab in pairs(ShopItems) do
		if tab[CAT_TITLE] then
			local lowername = string.lower(tab[CAT_TITLE])
			if string.find(curtitle, lowername, 1, true) or NDB.TitleAliases[lowername] and string.find(curtitle, NDB.TitleAliases[lowername], 1, true) then
				if tab.CanUseCallback and not tab.CanUseCallback(pl) then
					pl:PrintMessage(HUD_PRINTTALK, "You no longer qualify for the \""..curtitle.."\" title and it has been removed.")
					pl:SetTitle(pl:GetDefaultTitle())
				end

				break
			end
		end
	end
end)

local function Give(pl, slot, typ)
	if GAMEMODE.HatsDisabled or not typ or CurTime() < (pl.NextHat or 0) then return end
	pl.NextHat = CurTime() + 0.25

	local cur = pl.CostumeSlots[slot]
	if cur then
		pl:RemoveCostume(cur, cur ~= typ)

		if cur == typ then
			pl.CostumeSlots[slot] = nil
			pl:SetKeyDirty("CostumeSlots")
			pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=user> You <red>remove</red> what was in your <lb>"..COSTUMESLOTS[slot].."</lb> slot.")
			return
		end
	end

	if table.Count(pl.CostumeSlots) >= 1 then
		local costume = costumes[typ]
		if costume then
			local current = pl:GetCostumesElementCount()
			if current + #costume.Elements > NDB.GetMaxCostumeModels(pl) then
				pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=user> <red>You can't equip such a complex costume. Take off some other costumes and try again.</red>")
				return
			end
		end
	end

	pl:AddCostume(typ)
	if slot ~= COSTUMESLOT_NONE then
		pl.CostumeSlots[slot] = typ
		pl:SetKeyDirty("CostumeSlots")
	end
	pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=user> <lg>"..typ.."</lg> is now being worn in your <lb>"..COSTUMESLOTS[slot].."</lb> slot.")
end

ShopItems["Title Reset"].Use = function(pl)
	pl:ChangeTitle("None")
end
ShopItems["Title Clear"].Use = function(pl)
	pl:ChangeTitle("")
end

concommand.Add("ndb_buyshopitem", function(pl, command, arguments)
	if not pl:IsValidAccountNotify() then return end

	local item = table.concat(arguments, " ")

	if not ShopItems[item] then return end

	if NDB.PlayerHasShopItem(pl, item) then
		pl:UpdateShopInventory()
		return pl:PrintMessage(HUD_PRINTTALK, "You already have this item.")
	end

	local itemname = item
	item = ShopItems[item]

	if item.SpecialRequire then
		pl:PrintMessage(HUD_PRINTTALK, "This item is not for sale!")
		return
	end

	if item.GoldMember and pl:GetMemberLevel() ~= MEMBER_GOLD then
		pl:PrintMessage(HUD_PRINTTALK, "This item is only for Gold Members.")
		return
	end

	if item.DiamondMember and pl:GetMemberLevel() ~= MEMBER_DIAMOND then
		pl:PrintMessage(HUD_PRINTTALK, "This item is only for Diamond Members.")
		return
	end

	if item.Money and pl:GetSilver() < math.ceil(pl:GetDiscount() * item.Money) then
		pl:PrintMessage(HUD_PRINTTALK, "You don't have enough Silver for this item.")
		return
	end

	if item.Awards then
		local hasawards = true

		for _, award in pairs(item.Awards) do
			if not pl:HasAward(award) then
				pl:PrintMessage(HUD_PRINTTALK, "This item requires these awards: "..table.concat(item.Awards, ", ")..".")
				return
			end
		end
	end

	if item.CTFKills and pl.CTFKills < item.CTFKills then
		pl:PrintMessage(HUD_PRINTTALK, "You don't have enough TeamPlay kills for this item.")
		return
	end

	if item.CTFCaptures and pl.CTFCaptures < item.CTFCaptures then
		pl:PrintMessage(HUD_PRINTTALK, "You don't have enough TeamPlay flag captures for this item.")
		return
	end

	if item.Money then
		pl:SetSilver(pl:GetSilver() - math.ceil(pl:GetDiscount() * item.Money))
	end

	table.insert(pl.Inventory, item.Bit)

	pl:SetKeyDirty("Inventory")

	pl:UpdateShopInventory()

	pl:UpdateDB()

	pl:PrintMessage(HUD_PRINTTALK, "You have obtained: "..itemname.."!")

	NDB.LogLine("<"..pl:SteamID().."> "..pl:Name().." purchased shop item "..itemname)

	if item.Class and costumes[item.Class] and costumes[item.Class].AuthorID and NDB.CostumeAuthorSilver > 0 and not (item.Money and item.Money < 2000) then
		local authorid = costumes[item.Class].AuthorID

		for _, p in pairs(player.GetAll()) do
			if p:SteamID() == authorid then
				p:PrintMessage(HUD_PRINTTALK, "<silkicon icon=money> <lg>Someone just purchased your item: "..itemname..". You have been awarded "..string.CommaSeparate(NDB.CostumeAuthorSilver).." Silver.</lg>")
				p:AddSilver(NDB.CostumeAuthorSilver, true)
				p:UpdateDB()
				return
			end
		end

		local accountid = AccountID(authorid)
		if accountid then
			file.Write("costumeauthors/"..accountid..".txt", tostring((tonumber(file.Read("costumeauthors/"..accountid..".txt", "DATA") or "") or 0) + 1))
		end
	end
end)

concommand.Add("ndb_shop_unequip_all", function(sender, command, arguments)
	if not sender:IsValidAccountNotify() then return end

	local removed = false
	for slot, slotname in pairs(COSTUMESLOTS) do
		local cur = sender.CostumeSlots[slot]
		if cur then
			removed = true
			sender:RemoveCostume(cur, true)
			sender.CostumeSlots[slot] = nil
			sender:SetKeyDirty("CostumeSlots")
		end
	end

	if removed then
		sender:PrintMessage(HUD_PRINTTALK, "<silkicon icon=user> You <red>removed</red> all costumes.")
		sender:UpdateCostumes()
	end
end)

concommand.Add("ndb_shop_unequip", function(sender, command, arguments)
	if not sender:IsValidAccountNotify() then return end

	local slot = tonumber(arguments[1]) or 0
	local slotname = NDB.ShopCategories[slot]
	if slotname then
		if slot == CAT_HEAD then
			slot = COSTUMESLOT_HEAD
		elseif slot == CAT_FACE then
			slot = COSTUMESLOT_FACE
		elseif slot == CAT_ACCESSORY then
			slot = COSTUMESLOT_ACCESSORY
		elseif slot == CAT_BODY then
			slot = COSTUMESLOT_BODY
		elseif slot == CAT_BACK then
			slot = COSTUMESLOT_BACK
		elseif slot == CAT_TITLE then
			return
		elseif slot == CAT_MODEL then
			return
		else
			slot = COSTUMESLOT_OTHER
		end

		local cur = sender.CostumeSlots[slot]
		if cur then
			sender:RemoveCostume(cur)
			sender.CostumeSlots[slot] = nil
			sender:SetKeyDirty("CostumeSlots")
			sender:PrintMessage(HUD_PRINTTALK, "<silkicon icon=user> You <red>remove</red> what was in your <lb>"..slotname.."</lb> slot.")
		end
	end
end)

concommand.Add("ndb_useshopitem", function(sender, command, arguments)
	if not sender:IsValidAccountNotify() then return end

	local itemname = table.concat(arguments, " ")
	local item = ShopItems[itemname]

	if not item then
		sender:PrintMessage(HUD_PRINTTALK, "That item doesn't exist.")
	elseif not NDB.PlayerHasShopItem(sender, itemname) then
		sender:PrintMessage(HUD_PRINTTALK, item.SpecialRequire or "You don't have that item!")
	elseif item.Use then
		item.Use(sender)
	elseif item[CAT_HEAD] then
		Give(sender, COSTUMESLOT_HEAD, item.Class)
	elseif item[CAT_BODY] then
		Give(sender, COSTUMESLOT_BODY, item.Class)
	elseif item[CAT_ACCESSORY] then
		Give(sender, COSTUMESLOT_ACCESSORY, item.Class)
	elseif item[CAT_FACE] then
		Give(sender, COSTUMESLOT_FACE, item.Class)
	elseif item[CAT_BACK] then
		Give(sender, COSTUMESLOT_BACK, item.Class)
	elseif item[CAT_OTHER] then
		Give(sender, COSTUMESLOT_OTHER, item.Class)
	elseif item[CAT_TITLE] then
		sender:ChangeTitle(item[CAT_TITLE])
	elseif item[CAT_MODEL] then
		sender:SendLua([[RunConsoleCommand("cl_playermodel", "]]..item[CAT_MODEL]..[[")]])
		sender:PrintMessage(HUD_PRINTTALK, "Your default model has been changed.")
	else
		sender:PrintMessage(HUD_PRINTTALK, "That item can't be activated directly.")
	end
end)

local function CC_OpenBuyMenu(pl)
	if pl:IsValidAccountNotify() then
		pl:ConCommand("shopmenu")
	end

	return ""
end
NDB.AddChatCommand("/store", CC_OpenBuyMenu, "Open the global NoXiousNet store.", true)
NDB.AddChatCommand("/shop", CC_OpenBuyMenu, "Open the global NoXiousNet store.", true)
NDB.AddChatCommand("/buy", CC_OpenBuyMenu, "Open the global NoXiousNet store.", true)
NDB.AddChatCommand("!store", CC_OpenBuyMenu, "Open the global NoXiousNet store.", true)
NDB.AddChatCommand("!shop", CC_OpenBuyMenu, "Open the global NoXiousNet store.", true)
NDB.AddChatCommand("!buy", CC_OpenBuyMenu, "Open the global NoXiousNet store.", true)
