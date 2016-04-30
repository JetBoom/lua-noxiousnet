local CODEDIRECTORY = "noxiousnetpromocodes"

hook.Add("Initialize", "NDB_Promo_Live_Initialize", function()
	file.CreateDir(CODEDIRECTORY)
end)

local function ValidatedMessage(pl, item)
	pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=money> <lg>Promo code validated! You have been given </lg>"..item.."<lg>!</lg>")
end

function NDB.ClaimCode(pl, code)
	local filename = CODEDIRECTORY.."/"..code..".code", "DATA"
	if not file.Exists(filename) then return false end

	local contents = file.Read(filename, "DATA")
	file.Delete(filename)

	local func, value = string.match(contents, "(.+)%:(.+)")

	if func and value then
		if func == "Silver" then
			value = tonumber(value)
			if value and value > 0 then
				ValidatedMessage(pl, value.." Silver")
				pl:AddSilver(value, true)
				pl:UpdateDB()
				return true
			end
		elseif func == "StoreItem" then
			if NDB.ShopItems[value] then
				if pl:HasShopItem(value) then
					pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=decline> <red>The promo code was for "..value..". You already have this item!</red>")
					return false
				elseif NDB.ShopItems[value].Bit then
					ValidatedMessage(pl, value)
					table.insert(pl.Inventory, NDB.ShopItems[value].Bit)
					pl:SetKeyDirty("Inventory")
					pl:UpdateShopInventory()
					pl:UpdateDB()
					return true
				end
			end
		end
	end

	pl:PrintMessage(HUD_PRINTTALK, "Something went horribly wrong trying to process that code!")
	return false
end
