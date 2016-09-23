-- If you're reading this then either gmod has another hilarious exploit or I've gone insane and given you this.

include("sh_core.lua")

include("sv_globals.lua")

--include("sv_conversion.lua")

AddCSLuaFile("cl_core.lua")
AddCSLuaFile("sh_core.lua")
AddCSLuaFile("sh_globals.lua")
AddCSLuaFile("sh_maplist.lua")
AddCSLuaFile("maplist.lua")

for _, filename in pairs(file.Find("noxiousnet/modules/cl_*.lua", "LUA")) do AddCSLuaFile("modules/"..filename) end
for _, filename in pairs(file.Find("noxiousnet/modules/sh_*.lua", "LUA")) do AddCSLuaFile("modules/"..filename) end
for _, filename in pairs(file.Find("noxiousnet/extensions/cl_*.lua", "LUA")) do AddCSLuaFile("extensions/"..filename) end
for _, filename in pairs(file.Find("noxiousnet/extensions/sh_*.lua", "LUA")) do AddCSLuaFile("extensions/"..filename) end
for _, filename in pairs(file.Find("noxiousnet/addons/cl_*.lua", "LUA")) do AddCSLuaFile("addons/"..filename) end
for _, filename in pairs(file.Find("noxiousnet/addons/sh_*.lua", "LUA")) do AddCSLuaFile("addons/"..filename) end
for _, filename in pairs(file.Find("noxiousnet/addons/vgui/*.lua", "LUA")) do AddCSLuaFile("addons/vgui/"..filename) end
for _, filename in pairs(file.Find("noxiousnet/addons/chatbox/*.lua", "LUA")) do AddCSLuaFile("addons/chatbox/"..filename) end
for _, filename in pairs(file.Find("noxiousnet/addons/chatbox/parsers/*.lua", "LUA")) do AddCSLuaFile("addons/chatbox/parsers/"..filename) end

AddCSLuaFile("addons/accountbox/options.lua")
AddCSLuaFile("addons/accountbox/emotes.lua")
AddCSLuaFile("addons/accountbox/modelselect.lua")
AddCSLuaFile("addons/accountbox/rules.lua")

AddCSLuaFile("addons/placebo/client.lua")

include("modules/gatekeeper.lua")
include("modules/mysql.lua") --include("modules/mysqlfakke.lua")
--include("modules/cmd.lua")
--include("modules/rawio.lua")

include("addons/placebo/server.lua")

include("extensions/sv_player.lua")

include("addons/sv_logs.lua")
include("addons/sv_admin.lua")
include("addons/sv_awards.lua")
include("addons/sv_catbomb.lua")
include("addons/sv_chatcommands.lua")
include("addons/sv_costumes.lua")
include("addons/sv_crossserverchat.lua")
include("addons/sv_donations.lua")
include("addons/sv_gamemodeautoexec.lua")
include("addons/sv_labels.lua")
include("addons/sv_lottery.lua")
include("addons/sv_mapstatistics.lua")
include("addons/sv_opensocket.lua")
include("addons/sv_punishments.lua")
include("addons/sv_resourcechecker.lua")
include("addons/sv_shop.lua")
include("addons/sv_steamgroup.lua")
include("addons/sv_titlechange.lua")
include("addons/sv_votekick.lua")
include("addons/sv_votemap.lua")
include("addons/sv_webchat.lua")
include("addons/sv_ticker.lua")
include("addons/sv_retardchecker.lua")
--include("addons/sv_masterfix.lua")

include("addons/promotion_codes.lua")
--include("addons/promotion_forums.lua")
include("addons/promotion_tribes.lua")
include("addons/promotion_truepatriot.lua")

if not gmod.BroadcastLua then
	function gmod.BroadcastLua(lua)
		for _, pl in pairs(player.GetAll()) do
			pl:SendLua(lua)
		end
	end
end
BroadcastLua = gmod.BroadcastLua

function NDB.IsOnline(net)
	for _, pl in pairs(player.GetAll()) do
		if pl:AccountNumber() == net then
			print("Person is currently connected as "..pl:Name()..".")
			return pl
		end
	end
end

hook.Add("Initialize", "AddReadyHook", function()
	if GAMEMODE and not GAMEMODE.PlayerReady then
		function GAMEMODE:PlayerReady(pl)
		end
	end
	if GAMEMODE and not GAMEMODE.PostPlayerReady then
		function GAMEMODE:PostPlayerReady(pl)
		end
	end
end)

concommand.Add("initpostentity", function(sender, command, arguments)
	if not sender.DidInitPostEntity then
		sender.DidInitPostEntity = true

		gamemode.Call("PlayerReady", sender)
	end
end)

net.Receive("nox_chatstate", function(length, sender)
	local chatting = net.ReadBit() == 1

	if sender:IsValid() and chatting ~= sender.ChattingState then
		sender.ChattingState = chatting

		net.Start("nox_chatstate")
			net.WriteEntity(sender)
			net.WriteBit(chatting)
		net.Broadcast()
	end
end)

local function PlayerReady(pl)
	if not pl:IsValid() then return end

	-- Maybe the query isn't done yet.
	if not pl:IsValidAccount() then
		timer.Simple(0.25, function() PlayerReady(pl) end)
		return
	end

	pl:UpdateSilver()

	-- Holiday 2014
	--[[if not pl:HasFlag("holiday2014") then
		pl:AddFlag("holiday2014")

		local FreeItems = {"Santa Hat", "Snowman Face", "Christmas Tree Hat", "Angelic Halo"}
		for _, itemname in pairs(FreeItems) do
			if not pl:HasShopItem(itemname) then
				local item = NDB.ShopItems[itemname]
				if item and item.Bit then
					table.insert(pl.Inventory, item.Bit)

					pl:SetKeyDirty("Inventory")
				end
			end
		end

		if table.Count(pl:GetCostumes()) == 0 then
			local typ = NDB.ShopItems[ FreeItems[math.random(#FreeItems)] ].Class
			pl:AddCostume(typ)
			pl.CostumeSlots[COSTUMESLOT_HEAD] = typ
			pl:SetKeyDirty("CostumeSlots")
		end

		pl:PrintMessage(HUD_PRINTTALK, "<flashhsv>Happy Holidays from NoXiousNet! You have been given a free Santa Hat, Snowman Face, Christmas Tree Hat, Angelic Halo, and two special event back slot items.</flashhsv>")
	end]]
	-- End Holiday 2014

	pl:UpdateShopInventory()

	pl.NewTitle = pl.NewTitle or ""
	pl.PersonalChatColor = pl.PersonalChatColor or 0

	-- COMPAT: Fix up really old titles.
	if string.lower(pl.NewTitle) == "none" or pl.NewTitle == "G" or pl.NewTitle == "D" or pl.NewTitle == "NN" then
		pl:SetTitle(pl:GetDefaultTitle())
	end

	-- COMPAT: Fix <avatar> being in people's titles from before we just attached them to the beginning of messages. Shouldn't break custom titles since they start with ( or [
	if string.sub(pl.NewTitle, 1, 8) == "<avatar>" then
		pl:SetTitle(string.Trim(string.sub(pl.NewTitle, 9)))
	end

	local member = pl:GetMemberLevel()
	if member ~= MEMBER_NONE then
		local membername = NDB.MemberNames[member]
		if membername then
			local col = NDB.MemberColors[member]
			if col then
				pl:PrintMessage(HUD_PRINTTALK, "Welcome back, <style color="..col.r..","..col.g..","..col.b..">"..membername.."</style> Member. <silkicon icon=emoticon_smile>")
			else
				pl:PrintMessage(HUD_PRINTTALK, "Welcome back, "..membername.." Member. <silkicon icon=emoticon_smile>")
			end
		end
	end

	local ostime = os.time()

	-- COMPAT: If our title is locked convert it to the new title slot system.
	if pl.TitleLock then
		if type(pl.TitleLock) == "number" and pl.TitleLock > 0 and ostime < pl.TitleLock and pl.NewTitle and pl.NewTitle ~= "" then
			local x = #pl.Titles + 1
			pl.Titles[x] = pl.NewTitle
			pl.TitleExpirations[x] = pl.TitleLock
			pl:SetKeyDirty("Titles")
			pl:SetKeyDirty("TitleExpirations")
		end

		pl:SetTitle(pl:GetDefaultTitle())
		pl.TitleLock = nil
	end

	-- Check for expired titles.
	if pl.Titles and #pl.Titles > 0 then
		local newtitles = {}
		local newtitleexpirations = {}
		local expired = {}

		for i = 1, #pl.Titles do
			local title = pl.Titles[i]
			local expire = pl.TitleExpirations[i]
			if expire and ostime < expire then
				table.insert(newtitles, title)
				table.insert(newtitleexpirations, expire)
			else
				table.insert(expired, title)
			end
		end

		if #expired > 0 then
			pl.Titles = newtitles
			pl.TitleExpirations = newtitleexpirations
			pl:SetKeyDirty("Titles")
			pl:SetKeyDirty("TitleExpirations")
		end

		for _, v in pairs(expired) do
			pl:PrintMessage(HUD_PRINTTALK, "The title "..v.." has expired and will no longer show up.")
		end

		for i = 1, #newtitles do
			local title = newtitles[i]
			local expire = newtitleexpirations[i]
			if expire then
				local delta = expire - ostime
				local expiretime
				if delta > 86400 then
					expiretime = math.Round(delta / 86400, 1).. " day(s)"
				elseif delta > 3600 then
					expiretime = math.Round(delta / 3600, 1).. " hours(s)"
				else
					expiretime = math.Round(delta / 60, 1).. " minutes(s)"
				end
				pl:PrintMessage(HUD_PRINTTALK, "The title "..title.." will expire in <red>"..expiretime.."</red>.")
			end
		end
	end

	-- Broadcast our member level, chat color, etc. Then send everyone else's to us.
	pl:SendNDBInfo()
	if pl.Titles and #pl.Titles > 0 then
		pl:SendTitles()
	end
	for _, other in pairs(player.GetAll()) do
		if other ~= pl then
			other:SendNDBInfo(pl)
			if other.Titles and #other.Titles > 0 then
				other:SendTitles(pl)
			end
		end
	end

	if pl:GetTitleChangeCards() > 0 then
		pl:UpdateTitleChangeCards()
	end

	pl:Update3DTitle()

	if pl.SavedTitles and #pl.SavedTitles > 0 then
		pl:UpdateSavedTitles()
	end
	if pl.Saved3DTitles and #pl.Saved3DTitles > 0 then
		pl:UpdateSaved3DTitles()
	end
	if pl.VoicePitch then
		pl:UpdateVoicePitch()
	end

	local costumeauthorfile = "costumeauthors/"..pl:AccountNumber()..".txt"
	if file.Exists(costumeauthorfile, "DATA") then
		local amount = tonumber(file.Read(costumeauthorfile, "DATA"))
		file.Delete(costumeauthorfile)
		if amount then
			local silver = amount * NDB.CostumeAuthorSilver
			pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=money> <lg>You sold "..amount.." cop"..(amount == 1 and "y" or "ies").." of your costumes while you were away. You have been awarded "..string.CommaSeparate(silver).." Silver!</lg>")
			pl:AddSilver(silver, true)
			pl:UpdateDB()
		end
	end

	pl.Ballpit = pl:GetInfoNum("nox_ballpit", 0) == 1

	-- Check if we're using a player model we're not allowed to.
	-- We allow them to use whatever model in PlayerSpawn because their SQL data hasn't been loaded yet.
	local mdl = pl:GetModel()
	for itemname, itemtab in pairs(NDB.ShopItems) do
		if itemtab[CAT_MODEL] and itemtab.Model == mdl and not pl:HasShopItem(itemname) then
			pl:SetModel("models/player/kleiner.mdl")
			break
		end
	end

	pl:PrintMessage(HUD_PRINTCONSOLE, "Your NoXiousNet account has been loaded.")

	hook.Call("PostPlayerReady", GAMEMODE, pl)
end
hook.Add("PlayerReady", "NDB.PlayerReady", PlayerReady)

function NDB.SetupDefaults(pl)
	pl.Silver = pl.Silver or 0

	pl.NewTitle = pl.NewTitle or "None"
	pl.Flags = pl.Flags or {}
	pl.Inventory = pl.Inventory or {}
	pl.Awards = pl.Awards or {}
	pl.SavedTitles = pl.SavedTitles or {}
	pl.Saved3DTitles = pl.Saved3DTitles or {}
	pl.CostumeSlots = pl.CostumeSlots or {}
	pl.CostumeOptions = pl.CostumeOptions or {}
	pl.TimesPunished = pl.TimesPunished or {}
	pl.Titles = pl.Titles or {}
	pl.TitleExpirations = pl.TitleExpirations or {}

	pl.SilverEarned = pl.SilverEarned or 0
	pl.TimeOnline = pl.TimeOnline or 0

	pl.ZSBrainsEaten = pl.ZSBrainsEaten or 0
	pl.ZSZombiesKilled = pl.ZSZombiesKilled or 0
	pl.ZSGamesSurvived = pl.ZSGamesSurvived or 0
	pl.ZSGamesLost = pl.ZSGamesLost or 0
	pl.ZSPoints = pl.ZSPoints or 0

	pl.MarioBoxesWins = pl.MarioBoxesWins or 0
	pl.MarioBoxesLosses = pl.MarioBoxesLosses or 0
	pl.MarioBoxesKills = pl.MarioBoxesKills or 0
	pl.MarioBoxesDeaths = pl.MarioBoxesDeaths or 0

	pl.AssaultDefense = pl.AssaultDefense or 0
	pl.AssaultOffense = pl.AssaultOffense or 0
	pl.AssaultWins = pl.AssaultWins or 0
	pl.AssaultLosses = pl.AssaultLosses or 0
	pl.CTFKills = pl.CTFKills or 0
	pl.CTFDeaths = pl.CTFDeaths or 0
	pl.CTFCaptures = pl.CTFCaptures or 0
	pl.TeamPlayAssists = pl.TeamPlayAssists or 0

	gamemode.Call("SetupDefaults", pl)
end

hook.Add("PlayerInitialSpawn", "NDB.PlayerInitialSpawn", function(pl)
	if not pl:IsValid() then return end

	pl.TimeOnlineStart = os.time()
	pl.LastChat = 0
	pl.LastMessageText = ""

	pl:InitDB()

	NDB.LogLine("<Player Initial Spawned> - "..pl:SteamID().." "..pl:Name().." | "..pl:IPUID())
end)

function NDB.GlobalSave()
	local buffer = {}

	for _, pl in pairs(player.GetAll()) do
		if pl:IsConnected() and pl:IsValidAccount() then
			pl:UpdateDB(buffer)
		end
	end

	mysql_multi_query(buffer)
end
timer.Create("GlobalSave", 240, 0, NDB.GlobalSave)

timer.Create("IdleSilver", NDB.IdleSilverTime, 0, function()
	for _, pl in pairs(player.GetAll()) do
		if pl:GetObserverMode() == OBS_MODE_NONE and pl:Alive() then
			pl:AddSilver(NDB.IdleSilver)
		end
	end
end)

function NDB.SaveInfo(pl)
	pl:UpdateDB()
end

local function BroadcastCurrentMap()
	if not opensocket or not game.IsDedicated() then return end

	local numclients = NDB.GetNumberOfClients()
	--if numclients <= 0 then return end

	local currentmap = game.GetMap()
	local serverip = opensocket.ThisServerIP
	local serverport = opensocket.ThisServerPort
	local servername = NDB.GetServerName(serverip, serverport)
	local maxclients = game.MaxPlayers()

	if servername then
		opensocket.Broadcast("PrintMessage", "<silkicon icon=world> <lg>"..servername.."</lg> is now playing <lg>"..currentmap.."</lg>. Click to join: <connect="..servername..">")
	else
		opensocket.Broadcast("PrintMessage", "<silkicon icon=world> <lg>"..(serverip..":"..serverport).."</lg> is now playing <lg>"..currentmap.."</lg>.")
	end
	--[[if servername then
		opensocket.Broadcast("PrintMessage", "<silkicon icon=world> <lg>"..servername.."</lg> is now playing <lg>"..currentmap.."</lg> with <lg>"..numclients.."/"..maxclients.."</lg> players. Click to join: <connect="..servername..">")
	else
		opensocket.Broadcast("PrintMessage", "<silkicon icon=world> <lg>"..(serverip..":"..serverport).."</lg> is now playing <lg>"..currentmap.."</lg> with <lg>"..numclients.."/"..maxclients.."</lg> players.")
	end]]

	if webchat and numclients > 0 then
		if servername then
			webchat.Add("<img src='/silkicons/world.png'> <span style='color:green'>"..servername.."</span> is now playing <span style='color:green'>"..currentmap.."</span> with <span style='color:green'>"..numclients.."/"..maxclients.."</span> players.")
		else
			webchat.Add("<img src='/silkicons/world.png'> <span style='color:green'>"..(serverip..":"..serverport).."</span> is now playing <span style='color:green'>"..currentmap.."</span> with <span style='color:green'>"..numclients.."/"..maxclients.."</span> players.")
		end
	end
end

hook.Add("InitPostEntity", "MapOnLoad", function()
	local fil = string.gsub(GetConVar("ip"):GetString(), "%.", "_").."_"..GetConVar("hostport"):GetString().."_load.txt"
	if file.Exists(fil, "DATA") then
		local cont = file.Read(fil, "DATA")
		file.Delete(fil)

		print("Found OnLoad: "..fil)
		timer.Simple(0, function() RunString(cont) end)
		print("Completed.")
	end

	for _, ent in pairs(ents.FindByClass("lua_run")) do ent:Remove() end

	timer.Simple(0, BroadcastCurrentMap)
end)

hook.Add("Initialize", "NDBInitialize", function()
	util.AddNetworkString("nox_playeraccount")
	util.AddNetworkString("nox_money")
	util.AddNetworkString("nox_requestaccount")
	util.AddNetworkString("nox_playerinventory")
	util.AddNetworkString("nox_ndbinfo")
	util.AddNetworkString("nox_titles")
	util.AddNetworkString("nox_localplayerpunished")
	util.AddNetworkString("nox_titlecards")
	util.AddNetworkString("nox_savedtitles")
	util.AddNetworkString("nox_saved3dtitles")
	util.AddNetworkString("nox_chat")
	util.AddNetworkString("nox_update_ballpit")
	util.AddNetworkString("nox_chatstate")
	util.AddNetworkString("nox_voicepitch")
	util.AddNetworkString("nox_afkkick")

	file.CreateDir("costumeauthors")
	file.CreateDir("donations")
	file.CreateDir("prevdonations")
	file.CreateDir("retardchecker")

	resource.AddWorkshop("187693631") -- Static content pack (files below)
	--resource.AddWorkshop("237618708") -- Dynamic content pack (emotes)

	--[[resource.AddFile("materials/noxctf/sprite_flame.vmt")

	resource.AddFile("sound/noxiousnet/clownstep1.ogg")
	resource.AddFile("sound/noxiousnet/clownstep2.ogg")

	resource.AddFile("sound/synth/square.wav")
	resource.AddFile("sound/synth/saw.wav")
	resource.AddFile("sound/synth/sine.wav")

	resource.AddFile("models/Aviator/aviator.mdl")
	resource.AddFile("materials/Aviator/Aviator.vmt")
	resource.AddFile("materials/Aviator/Aviator_envmap.vtf")

	-- Plain hat
	resource.AddFile("models/viroshat/viroshat.mdl")
	resource.AddFile("materials/models/viroshat/viroshat.vmt")
	resource.AddFile("materials/viroshat.vtf")

	-- Witch hat
	resource.AddFile("models/hatt.mdl")
	resource.AddFile("materials/models/kassii/hatt.vmt")
	resource.AddFile("materials/models/kassii/hatt_normal.vtf")

	-- Gurren Lagann glasses
	resource.AddFile("models/Items/glasses/simon_glasses.mdl")
	resource.AddFile("models/Items/glasses/kamina_glasses.mdl")
	resource.AddFile("materials/models/items/glasses/glass_sheet.vmt")
	resource.AddFile("materials/models/items/glasses/glass_sheet2.vmt")

	-- Creeper player model
	resource.AddFile("models/jessev92/player/misc/creepr.mdl")
	for _, filename in pairs(file.Find("materials/jessev92/dean/creepr/*.vtf", "MOD")) do
		resource.AddSingleFile("materials/jessev92/dean/creepr/"..filename)
	end
	for _, filename in pairs(file.Find("materials/jessev92/dean/creepr/*.vmt", "MOD")) do
		resource.AddSingleFile("materials/jessev92/dean/creepr/"..filename)
	end

	-- Bin Laden player model
	resource.AddSingleFile("models/jessev92/player/misc/osamabl1.mdl")
	resource.AddSingleFile("models/jessev92/player/misc/osamabl1.vvd")
	resource.AddSingleFile("models/jessev92/player/misc/OsamaBL1.phy")
	resource.AddSingleFile("models/jessev92/player/misc/OsamaBL1.dx80.vtx")
	resource.AddSingleFile("models/jessev92/player/misc/OsamaBL1.dx90.vtx")
	resource.AddSingleFile("models/jessev92/player/misc/OsamaBL1.sw.vtx")
	resource.AddSingleFile("models/jessev92/player/misc/OsamaBL1.xbox.vtx")
	for _, filename in pairs(file.Find("materials/jessev92/player/common/*.vtf", "MOD")) do
		resource.AddSingleFile("materials/jessev92/player/common/"..filename)
	end
	for _, filename in pairs(file.Find("materials/jessev92/player/common/*.vmt", "MOD")) do
		resource.AddSingleFile("materials/jessev92/player/common/"..filename)
	end
	for _, filename in pairs(file.Find("materials/jessev92/player/misc/osama/*.vmt", "MOD")) do
		resource.AddSingleFile("materials/jessev92/player/misc/osama/"..filename)
	end
	for _, filename in pairs(file.Find("materials/jessev92/player/misc/osama/*.vtf", "MOD")) do
		resource.AddSingleFile("materials/jessev92/player/misc/osama/"..filename)
	end

	-- Black*Rock Shooter player model
	resource.AddSingleFile("models/player/BRSP.dx80.vtx")
	resource.AddSingleFile("models/player/BRSP.dx90.vtx")
	resource.AddSingleFile("models/player/BRSP.phy")
	resource.AddSingleFile("models/player/BRSP.sw.vtx")
	resource.AddSingleFile("models/player/brsp.vvd")
	resource.AddSingleFile("models/player/brsp.mdl")
	for _, filename in pairs(file.Find("materials/BlackRockShooter/*.vtf", "MOD")) do
		resource.AddSingleFile("materials/BlackRockShooter/"..filename)
	end
	for _, filename in pairs(file.Find("materials/BlackRockShooter/*.vmt", "MOD")) do
		resource.AddSingleFile("materials/BlackRockShooter/"..filename)
	end

	-- Danboard player model
	resource.AddFile("models/player/danboard.mdl")
	resource.AddSingleFile("materials/models/player/danboard_arm_leg_sheet.vmt")
	resource.AddSingleFile("materials/models/player/danboard_arm_leg_sheet.vtf")
	resource.AddSingleFile("materials/models/player/danboard_body_sheet.vmt")
	resource.AddSingleFile("materials/models/player/danboard_body_sheet.vtf")
	resource.AddSingleFile("materials/models/player/danboard_head_sheet.vmt")
	resource.AddSingleFile("materials/models/player/danboard_head_sheet.vtf")

	-- Grim player model
	resource.AddFile("models/grim.mdl")
	for _, filename in pairs(file.Find("materials/models/grim/*.vtf", "MOD")) do
		resource.AddSingleFile("materials/models/grim/"..filename)
	end
	for _, filename in pairs(file.Find("materials/models/grim/*.vmt", "MOD")) do
		resource.AddSingleFile("materials/models/grim/"..filename)
	end

	-- Moe GlaDOS player model
	resource.AddSingleFile("models/player/Moe_Glados_p.dx80.vtx")
	resource.AddSingleFile("models/player/Moe_Glados_p.dx90.vtx")
	resource.AddSingleFile("models/player/Moe_Glados_p.phy")
	resource.AddSingleFile("models/player/Moe_Glados_p.sw.vtx")
	resource.AddSingleFile("models/player/moe_glados_p.vvd")
	resource.AddSingleFile("models/player/moe_glados_p.mdl")
	for _, filename in pairs(file.Find("materials/Glados_xeno/*.vmt", "MOD")) do
		resource.AddSingleFile("materials/Glados_xeno/"..filename)
	end
	for _, filename in pairs(file.Find("materials/Glados_xeno/*.vtf", "MOD")) do
		resource.AddSingleFile("materials/Glados_xeno/"..filename)
	end

	-- GabeN player model
	resource.AddSingleFile("Models/Jason278-Players/Gabe_3.dx80.vtx")
	resource.AddSingleFile("Models/Jason278-Players/Gabe_3.dx90.vtx")
	resource.AddSingleFile("Models/Jason278-Players/Gabe_3.sw.vtx")
	resource.AddSingleFile("Models/Jason278-Players/Gabe_3.xbox.vtx")
	resource.AddSingleFile("Models/Jason278-Players/Gabe_3.phy")
	resource.AddSingleFile("Models/Jason278-Players/gabe_3.vvd")
	resource.AddSingleFile("Models/Jason278-Players/gabe_3.mdl")
	for _, filename in pairs(file.Find("materials/models/player/ssgabe/*.vmt", "MOD")) do
		resource.AddSingleFile("materials/models/player/ssgabe/"..filename)
	end
	for _, filename in pairs(file.Find("materials/models/player/ssgabe/*.vtf", "MOD")) do
		resource.AddSingleFile("materials/models/player/ssgabe/"..filename)
	end

	-- Snowman player model
	resource.AddFile("models/player/snow_man_pm/snow_man_pm.mdl")
	for _, filename in pairs(file.Find("materials/models/player/snow_man_pm/*.vmt", "GAME")) do
		resource.AddSingleFile("materials/models/player/snow_man_pm/"..filename)
	end
	for _, filename in pairs(file.Find("materials/models/player/snow_man_pm/*.vtf", "GAME")) do
		resource.AddSingleFile("materials/models/player/snow_man_pm/"..filename)
	end]]
end)

hook.Add("PlayerCanHearPlayersVoice", "NDB_MutedVoice", function(listener, talker)
	if talker:IsPunished(PUNISHMENT_VOICEMUTE) or talker:IsPunished(PUNISHMENT_MUTE)
		or not listener.Ballpit and talker:IsPunished(PUNISHMENT_BALLPIT) and not listener:IsPunished(PUNISHMENT_BALLPIT) then return false end

	if listener.AllTalk or talker.AllTalk then return true end
end)

concommand.Add("nox_togglealltalk", function(sender)
	if sender:IsValid() and sender:IsModerator() then
		sender.AllTalk = not sender.AllTalk

		if sender.AllTalk then
			sender:PrintMessage(HUD_PRINTTALK, "You are now listening and speaking to all voice chat channels. Do not use this for anything besides handing out punishments.")
		else
			sender:PrintMessage(HUD_PRINTTALK, "You are now listening and speaking to default voice chat channels.")
		end
	end
end)

function game.GetMapNext()
	if NDB.NEXT_MAP then
		return NDB.NEXT_MAP
	end

	return "random"
end

function game.LoadNextMap()
	local currentbsp = game.GetMap()
	local currentmap = NDB.CurrentOverrideMap or currentbsp
	local nextmap = game.GetMapNext()

	if nextmap == "random" then
		local maplist = NDB.VoteMap.GetMapList()
		if maplist and #maplist > 0 then
			local tab = maplist[math.random(#maplist)]
			if tab then
				nextmap = tab[1]
			end
		end
	end

	local nextbsp = NDB.REDIRECT_MAP or nextmap

	if not file.Exists("maps/"..nextbsp..".bsp", "GAME") then
		nextmap = currentmap
		nextbsp = currentbsp
	end

	RunConsoleCommand("changelevel", nextbsp)
end

concommand.Add("ndb_setdefaultchatcolor", function(sender, command, arguments)
	if sender:IsValid() and NDB.MemberPersonalChatColors[sender:GetMemberLevel()] then
		-- Don't spam net messages.
		timer.Create("SetDefaultChatColor"..sender:EntIndex(), 0.25, 1, function()
			if sender:IsValid() then
				sender:SetDefaultChatColor(math.Clamp(math.ceil(tonumbersafe(arguments[1] or 0)), 0, 255), math.Clamp(math.ceil(tonumbersafe(arguments[2] or 0)), 0, 255), math.Clamp(math.ceil(tonumbersafe(arguments[3] or 0)), 0, 255))
			end
		end)
	end
end)

net.Receive("nox_afkkick", function(length, sender)
	if sender:IsValid() and game.IsDedicated() then
		sender:SafeKick("Being idle too long.")
	end
end)

concommand.Add("transfersilver", function(sender, command, arguments)
	if not sender:IsValid() then return end

	local userid = tonumbersafe(arguments[1])
	local amount = tonumbersafe(arguments[2])

	if not amount or not userid then return end

	amount = math.floor(amount)

	local target

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == userid then
			target = pl
			break
		end
	end

	if not target or target == pl then return end

	if sender.m_NextGiveMoney and CurTime() < sender.m_NextGiveMoney then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait before sending more Silver to people.")
		return
	end

	if amount < 25 then
		sender:PrintMessage(HUD_PRINTTALK, "You can't transfer such low amounts of money.")
		return
	end

	if 100000 < amount then
		sender:PrintMessage(HUD_PRINTTALK, "For your security, only transfer 100,000 Silver at one time.")
		return
	end

	if sender:GetSilver() < amount then
		sender:PrintMessage(HUD_PRINTTALK, "You don't even have that much money!")
		return
	end

	target:AddSilver(amount, true)
	sender:AddSilver(-amount, true)

	sender:PrintMessage(HUD_PRINTTALK, "You have transfered <lg>"..amount.."</lg> Silver to "..target:NoParseName()..".")
	target:PrintMessage(HUD_PRINTTALK, sender:NoParseName().." has transfered <lg>"..amount.."</lg> Silver to you.")

	target:UpdateDB()
	sender:UpdateDB()

	sender.m_NextGiveMoney = CurTime() + 3

	NDB.LogLine("<"..sender:SteamID().."> "..sender:Name().." gave "..amount.." Silver to <"..target:SteamID().."> "..target:Name())
end)

local FloodProtection = {}
local LastConnect = {}
hook.Add("PlayerConnect", "NDB.PlayerConnect", function(name, ip)
	LastConnect[ip] = LastConnect[ip] or -10

	if CurTime() < LastConnect[ip] + 4 then
		FloodProtection[ip] = (FloodProtection[ip] or 0) + 1

		if 6 <= FloodProtection[ip] then
			NDB.LogLine("<FLOOD DETECTED> "..name.." | "..ip)
			RunConsoleCommand("addip", "5", string.Explode(":", ip)[1])
		end
	end

	--NDB.LogLine("<Player Connected> "..name.." | "..ip)
	if game.IsDedicated() then
		PrintMessage(HUD_PRINTTALK, "Player "..name.." has joined the game.")
	end

	LastConnect[ip] = CurTime()
end)

hook.Add("PlayerDisconnected", "NDB.PlayerDisconnected", function(pl)
	if pl:IsValid() then
		NDB.LogLine("<Player Disconnected> - "..pl:SteamID().." "..pl:Name().." | IPUID: "..pl:IPUID())

		pl:UpdateDB()
	end
end)

hook.Add("PlayerSay", "NDB.PlayerSay", function(pl, text, teamonly)
	if not pl:IsPlayer() or not pl:IsConnected() then return "" end

	if not pl:IsValidAccountNotify() then
		return ""
	end

	text = string.Trim(text)

	local textlower = string.lower(text)
	for i, tab in pairs(NDB.ChatCommands) do
		if tab.Perfect and textlower == tab.Text or tab.NonPositional and string.find(textlower, tab.Text, 1, true) or not tab.Perfect and string.sub(textlower, 1, #tab.Text) == tab.Text then
			local ret = tab.Callback(pl, text, teamonly)
			if ret then text = ret end
		end
	end

	if #text == 0 or pl:IsPunishedNotify(PUNISHMENT_MUTE) or pl:CheckChatSpamming(text, teamonly) then return "" end

	pl.LastMessageText = text
	pl.LastChat = SysTime()

	for _, muteword in pairs(NDB.MuteWords) do
		if string.find(textlower, muteword, 1, true) then
			--[[if pl.WarnedAboutStupidPhrases then
				NDB.AddPunishment(pl, PUNISHMENT_MUTE, 1440, "Said something stupid TWICE!", "Schenck and company")
			else
				pl.WarnedAboutStupidPhrases = true
				pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> <red>Either stop saying stupid things (</red>"..muteword.."<red>) or get muted.</red>")
			end]]

			pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> <red>Don't say stupid things (</red>"..muteword.."<red>). Trying to get around this will get you muted.</red>")

			return ""
		end
	end

	if GAMEMODE.HandleNDBPlayerSay then
		return GAMEMODE:HandleNDBPlayerSay(pl, text, teamonly)
	else
		local blocktext = false
		for i, nam in pairs(NDB.EmotesNames) do
			if text == nam then
				blocktext = NDB.EmotesNoChat[i]
				break
			end
		end

		if not blocktext then
			for trigger in pairs(NDB.DynamicEmoteSounds) do
				if text == trigger then
					blocktext = true
					break
				end
			end
		end

		if not blocktext then
			local logc
			if teamonly then
				logc = pl:LogID().." [Team Say | "..tostring(team.GetName(pl:Team())).."]: "..text
			else
				logc = pl:LogID()..": "..text
			end

			print(logc)
			NDB.LogLine(logc)
		end
	end
end)

local function UserIDSort(a, b)
	return b:UserID() < a:UserID()
end

local function ReservedSlotQuery(query, result)
	if gatekeeper.GetNumClients().total < game.MaxPlayers() - 1 then return end

	if result[1] then
		local memberlevel = result[1].MemberLevel
		local steamid = result[1].SteamID

		if NDB.MemberReservedSlots[memberlevel] then
			local allplayers = player.GetAll()
			table.sort(allplayers, UserIDSort)

			for i, kickee in ipairs(allplayers) do
				if kickee and kickee:GetMemberLevel() == MEMBER_NONE and not kickee.ReservedSlot and not kickee:IsAdmin() then
					gatekeeper.Drop(kickee:UserID(), "Kicked to make room for a Diamond Member.")
					return
				end
			end

			for i, kickee in ipairs(allplayers) do
				if kickee and kickee:GetMemberLevel() ~= MEMBER_DIAMOND and not kickee.ReservedSlot and not kickee:IsAdmin() then
					gatekeeper.Drop(kickee:UserID(), "No guests left, kicked to make room for a Diamond Member.")
					return
				end
			end

			gatekeeper.DropSteamID(steamid, "Sorry, the entire server is full of Diamond Members!")
		else
			local myip, myport = GetConVar("ip"):GetString(), tonumber(GetConVar("hostport"):GetString()) or 0
			for _, server in pairs(NDB.Servers) do
				if server[7] == myip and server[8] == myport then
					gatekeeper.DropSteamID(steamid, "Server is full! Use the alternate server: "..server[2]..":"..server[3])
					return
				end
			end

			gatekeeper.DropSteamID(steamid, "Sorry, we're full! Last slot is for Diamond Members.")
		end
	end
end

hook.Add("PlayerPasswordAuth", "NDB.PlayerPasswordAuth", function(name, pass, steamid, ipaddress)
	if not game.IsDedicated() then return end

	if gatekeeper.GetNumClients().total >= game.MaxPlayers() - 2 then
		mysql_query(
			string.format(
				"SELECT SteamID, MemberLevel FROM noxplayers WHERE SteamID = %q LIMIT 1",
				steamid
			),
			ReservedSlotQuery
		)
	end

	NDB.LogLine("<Player Connected> "..name.." | "..steamid.." | IPUID: "..IPUID(ipaddress))
end)

net.Receive("nox_requestaccount", function(length, sender)
	if CurTime() < (sender._NextAccountRequest or 0) then return end
	sender._NextAccountRequest = CurTime() + 0.5

	local pl = net.ReadEntity()
	if pl:IsValid() and pl:IsPlayer() then
		local tosave = {}
		for _, key in pairs(NDB.PlayerKeys) do
			tosave[key] = pl[key]
		end
		for gm, keys in pairs(NDB.PlayerKeysForGamemode) do
			for _, key in pairs(keys) do
				tosave[key] = pl[key]
			end
		end

		net.Start("nox_playeraccount")
			net.WriteEntity(pl)
			net.WriteTable(tosave)
		net.Send(sender)
	end
end)

net.Receive("nox_chat", function(length, sender)
	local teamonly = net.ReadBit() == 1
	local text = net.ReadString()

	text = string.sub(text, 1, NDB.MaxChatSize)

	text = gamemode.Call("PlayerSay", sender, text, teamonly) or text

	if text ~= "" then
		net.Start("nox_chat")
		net.WriteBit(teamonly)
		net.WriteEntity(sender)
		net.WriteString(text)
		if teamonly then
			for _, pl in pairs(team.GetPlayers(sender:Team())) do
				net.Send(pl)
			end
		else
			net.Broadcast()
		end
	end
end)

net.Receive("nox_update_ballpit", function(length, sender)
	timer.Create("updateballpit"..sender:UserID(), 0.2, 1, function()
		sender.Ballpit = sender:GetInfoNum("nox_ballpit", 0) == 1
	end)
end)

function PrintToAdmins(printtype, message)
	for _, pl in pairs(player.GetAll()) do
		if pl:IsAdmin() then
			pl:PrintMessage(printtype, message)
		end
	end
end

function PrintToModerators(printtype, message)
	for _, pl in pairs(player.GetAll()) do
		if pl:IsModerator() then
			pl:PrintMessage(printtype, message)
		end
	end
end
