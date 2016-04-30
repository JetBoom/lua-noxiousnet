local FOLDERINDEX
local FILES
local CHANGED

local function DataTimer()
	if FILES and #FILES > 0 then
		local filepath = "noxaccounts/"..FOLDERINDEX.."/"..FILES[#FILES]
		local contents = file.Read(filepath, "DATA")
		if contents then
			local self = Deserialize(contents)
			local changed = false
			-- Compatabillity for changing .Money to .Silver
			if self.Money then
				self.Silver = self.Money
				self.Money = nil
				changed = true
			end
			if self.MoneyEarned then
				self.SilverEarned = self.MoneyEarned
				self.MoneyEarned = nil
				changed = true
			end

			-- Compatabillity for shop backend
			if self.ShopInventory then
				self.Inventory = self.Inventory or {}
				for itemname, itemtab in pairs(NDB.ShopItems) do
					if itemtab.Bit then
						local b = 2 ^ itemtab.Bit
						if bit.band(b, self.ShopInventory) == b then
							self.Inventory[#self.Inventory+1] = itemtab.Bit
						end
					end
				end
				self.ShopInventory = nil
				changed = true
			end

			-- Compatabillity from when we had subdiamond and infinite silver for diamond.
			if self.DiamondMember then
				self.Silver = 30000
				self.MemberLevel = MEMBER_DIAMOND
				self.DiamondMember = nil
				self.SubDiamondMember = nil
				self.GoldMember = nil
				changed = true
			elseif self.SubDiamondMember then
				self.MemberLevel = MEMBER_DIAMOND
				self.SubDiamondMember = nil
				self.GoldMember = nil
				changed = true
			elseif self.GoldMember then
				self.MemberLevel = MEMBER_GOLD
				self.GoldMember = nil
				changed = true
			end
			if self.DiamondMember ~= nil then
				self.DiamondMember = nil
				changed = true
			end
			if self.GoldMember ~= nil then
				self.GoldMember = nil
				changed = true
			end
			if self.SubDiamondMember ~= nil then
				self.SubDiamondMember = nil
				changed = true
			end

			self.Silver = math.floor(self.Silver or 0)

			if changed then
				CHANGED = CHANGED + 1
				MsgC("Compat for "..filepath.." executed. ("..CHANGED..")\n")
				file.Write(filepath, Serialize(self))
			end
		end
		table.remove(FILES, #FILES)
		--[[if #FILES % 50 == 0 then
			MsgC(#FILES, " files in this group left.\n")
		end]]
	else
		FOLDERINDEX = FOLDERINDEX + 1
		if FOLDERINDEX == 100 then
			MsgC(Color(30, 255, 30), "Data conversion done! All old data should no longer need compat checks! Run SQL conversion now!\n")
			MsgC(Color(255, 0, 0), "Total compats done: ", CHANGED, "\n")
			return
		elseif FOLDERINDEX > 100 then return end

		MsgC(Color(255, 255, 0), "Starting conversion for accounts starting with ", FOLDERINDEX, "\n")

		local files, folders = file.Find("noxaccounts/"..FOLDERINDEX.."/*.txt", "DATA")
		FILES = files

		MsgC(Color(255, 255, 0), "(Found ", #files, " accounts starting with ", FOLDERINDEX, ")\n")
	end
end

function NDB.ConvertData()
	FOLDERINDEX = 0
	CHANGED = 0
	timer.Create("DataTimer", 0, 0, function() for i=1, 30 do DataTimer() end end)
end

local function concat2(tab)
	for i=1, #tab do
		if tab[i] == nil then
			local newtab = {}
			for _, v in pairs(tab) do
				newtab[#newtab + 1] = v
			end
			tab = newtab
			break
		end
	end

	return table.concat(tab, ",")
end

local AllKeys
local InsertQuery
local ValuesQuery
local BuffNum
local Buffer

local function WriteBuffer()
	if #Buffer > 0 then
		file.Append("sqlconvert.txt", InsertQuery..string.sub(Buffer, 1, #Buffer - 1).." ON DUPLICATE KEY UPDATE SteamID = SteamID;\n")
	end

	Buffer = ""
	BuffNum = 0
end

local function SQLTimer()
	if FILES and #FILES > 0 then
		local filename = FILES[#FILES]
		local filepath = "noxaccounts/"..FOLDERINDEX.."/"..filename
		local contents = file.Read(filepath, "DATA")
		if contents then
			local data = Deserialize(contents)

			local accountid = string.sub(filename, 1, -5)
			local steamid = "STEAM_0:0:"..accountid

			local args = {steamid}
					
			table.insert(args, "Unknown")
			table.insert(args, "localhost")

			for i, key in ipairs(AllKeys) do
				if NDB.PlayerKeysSpecial[key] then continue end

				local val = data[key]
				if NDB.PlayerKeysStringTablesSRL[key] then
					if val == nil or type(val) ~= "table" or table.Count(val) == 0 then
						val = ""
					else
						val = Serialize(val)
					end
				elseif NDB.PlayerKeysStringTables[key] or NDB.PlayerKeysNumberTables[key] or type(val) == "table" then
					val = concat2(val or {}, ",")
				elseif NDB.PlayerKeysString[key] then
					val = val and tostring(val) or ""
					--print(key, "is string", val)
				else
					val = tonumber(val or 0) or 0
					if not NDB.PlayerKeysSigned[key] then
						val = math.max(val, 0)
					end
					--print(key, "is number", val)
				end

				table.insert(args, val)
			end

			Buffer = Buffer..string.format(ValuesQuery, unpack(args))
			Buffer = Buffer..","
			steamid = "STEAM_0:1:"..accountid
			args[1] = steamid
			Buffer = Buffer..string.format(ValuesQuery, unpack(args))
			Buffer = Buffer..","
			BuffNum = BuffNum + 1
			if BuffNum >= 250 then
				WriteBuffer()
			end

			CHANGED = CHANGED + 1
		end

		table.remove(FILES, #FILES)
	else
		FOLDERINDEX = FOLDERINDEX + 1
		if FOLDERINDEX == 100 then
			WriteBuffer()
			file.Append("sqlconvert.txt", [[
SET SQL_SAFE_UPDATES = 0;
UPDATE noxplayers SET TimesPunished = NULL WHERE TimesPunished = '';
UPDATE noxplayers SET CostumeOptions = NULL WHERE CostumeOptions = '';
UPDATE noxplayers SET CostumeSlots = NULL WHERE CostumeSlots = '';
UPDATE noxplayers SET TitleExpirations = NULL WHERE TitleExpirations = '';
UPDATE noxplayers SET Titles = NULL WHERE Titles = '';
UPDATE noxplayers SET Saved3DTitles = NULL WHERE Saved3DTitles = '';
UPDATE noxplayers SET SavedTitles = NULL WHERE SavedTitles = '';
UPDATE noxplayers SET Flags = NULL WHERE Flags = '';
UPDATE noxplayers SET Inventory = NULL WHERE Inventory = '';
UPDATE noxplayers SET Title = NULL WHERE Title = '';
UPDATE noxplayers SET Title3D = NULL WHERE Title3D = '';
UPDATE noxplayers SET Awards = NULL WHERE Awards = '';]])
			MsgC(Color(30, 255, 30), "SQL conversion done! Manually delete all data after confirmation of migration.\n")
			MsgC(Color(255, 0, 0), "Total: ", CHANGED, "\n")
			return
		elseif FOLDERINDEX > 100 then return end

		MsgC(Color(255, 255, 0), "Starting conversion for accounts starting with ", FOLDERINDEX, "\n")

		local files, folders = file.Find("noxaccounts/"..FOLDERINDEX.."/*.txt", "DATA")
		FILES = files

		MsgC(Color(255, 255, 0), "(Found ", #files, " accounts starting with ", FOLDERINDEX, ")\n")
	end
end

function NDB.ConvertSQL()
	FOLDERINDEX = 0
	CHANGED = 0
	BuffNum = 0
	Buffer = ""
	AllKeys = {}
	AllSQLKeys = {}

	table.insert(AllKeys, "SteamID")
	table.insert(AllSQLKeys, "SteamID")
	table.insert(AllKeys, "Name")
	table.insert(AllSQLKeys, "Name")
	table.insert(AllKeys, "IPAddress")
	table.insert(AllSQLKeys, "IPAddress")

	for _, key in pairs(NDB.PlayerKeys) do
		table.insert(AllKeys, key)
		table.insert(AllSQLKeys, NDB.PlayerKeysAliasSQL[key] or key)
	end
	for gm, keys in pairs(NDB.PlayerKeysForGamemode) do
		for _, key in pairs(keys) do
			table.insert(AllKeys, key)
			table.insert(AllSQLKeys, NDB.PlayerKeysAliasSQL[key] or key)
		end
	end

	InsertQuery = "INSERT INTO noxplayers ("..table.concat(AllSQLKeys, ", ")..") VALUES "

	--[[for i=1, 2 do
		table.remove(AllKeys, #AllKeys)
		table.remove(AllSQLKeys, #AllSQLKeys)
	end]]

	ValuesQuery = "("
	local forms = {}
	for i, key in ipairs(AllKeys) do
		if NDB.PlayerKeysStringTables[key] or NDB.PlayerKeysNumberTables[key] or NDB.PlayerKeysStringTablesSRL[key] or NDB.PlayerKeysString[key] then
			table.insert(forms, "%q")
		else
			table.insert(forms, "%d")
		end
	end
	ValuesQuery = ValuesQuery..table.concat(forms, ", ")..")"

	print(InsertQuery)
	print(ValuesQuery)

	timer.Create("SQLTimer", 0, 0, function() for i=1, 50 do SQLTimer() end end)
end
