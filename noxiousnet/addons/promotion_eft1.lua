--[[local uscores = {}
hook.Add("TeamScored", "promo_eft1", function(opposite, carrier, points, istouch)
	if GAMEMODE.FolderName ~= "extremefootballthrowdown" or not carrier or not carrier:IsValid() or not carrier:IsPlayer() or team.NumPlayers(TEAM_RED) + team.NumPlayers(TEAM_BLUE) < 8 then return end

	local uid = carrier:UniqueID()
	uscores[uid] = (uscores[uid] or 0) + 1

	if uscores[uid] >= 4 and not carrier:HasShopItem("Senator Armstrong") then
		table.insert(carrier.Inventory, NDB.ShopItems["Senator Armstrong"].Bit)
		carrier:SetKeyDirty("Inventory")
		carrier:UpdateShopInventory()
		carrier:UpdateDB()
		carrier:PrintMessage(HUD_PRINTTALK, "You have unlocked the Senator Armstrong player model!")
	end

	if uscores[uid] >= 2 and not carrier:HasShopItem("Obama") then
		table.insert(carrier.Inventory, NDB.ShopItems["Obama"].Bit)
		carrier:SetKeyDirty("Inventory")
		carrier:UpdateShopInventory()
		carrier:UpdateDB()
		carrier:PrintMessage(HUD_PRINTTALK, "You have unlocked the Obama player model!")
	end
end)]]
