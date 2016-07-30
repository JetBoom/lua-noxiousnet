local function SpectatingCalcView(pl, origin, angles, fov, znear, zfar)
	local ent = NDB.SpectatingEntity
	if IsValid(ent) then
		return {origin = ent:EyePos(), angles = ent:EyeAngles()}
	else
		hook.Remove("CalcView", "NDB.SpectatingCalcView")
	end
end

function NDB.StopSpectating()
	hook.Remove("CalcView", "NDB.SpectatingCalcView")
	if IsValid(NDB.SpectatingEntity) then
		NDB.SpectatingEntity:SetNoDraw(false)
	end
	NDB.SpectatingEntity = nil
end

function NDB.StartSpectating(ent)
	NDB.SpectatingEntity = ent
	if IsValid(ent) then
		NDB.SpectatingEntity:SetNoDraw(true)
	end
	hook.Add("CalcView", "NDB.SpectatingCalcView", SpectatingCalcView)
end

local function kickcallback(pl)
	if not (pl and pl:IsValid()) then
		LocalPlayer():ChatPrint("Player already left.")
		return
	end

	local wid = 300

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetTitle("Kick "..pl:Name().." because...")
	frame:SetPos(gui.MousePos())
	frame:SetWide(300)

	local y = 32
	local tentry = vgui.Create("DTextEntry", frame)
	tentry:SetWide(wid - 16)
	tentry:SetPos(8, y)
	y = y + tentry:GetTall() + 8

	local button = EasyButton(frame, "Kick", 8, 4)
	button:SetPos(wid * 0.5 - button:GetWide() * 0.5, y)
	button.UserID = pl:UserID()
	button.DoClick = function(btn)
		RunConsoleCommand("a_kick", btn.UserID, tentry:GetValue())
		frame:Remove()
	end
	y = y + button:GetTall() + 8

	frame:SetTall(y)
	frame:SetSkin("Default")
	frame:MakePopup()
end

local function forceurlcallback(pl)
	if not (pl and pl:IsValid()) then
		LocalPlayer():ChatPrint("Player already left.")
		return
	end

	local wid = 300

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetTitle("Force "..pl:Name().." to...")
	frame:SetPos(gui.MousePos())
	frame:SetWide(300)

	local y = 32
	local tentry = vgui.Create("DTextEntry", frame)
	tentry:SetWide(wid - 16)
	tentry:SetPos(8, y)
	y = y + tentry:GetTall() + 8

	local button = EasyButton(frame, "Force URL", 8, 4)
	button:SetPos(wid * 0.5 - button:GetWide() * 0.5, y)
	button.UserID = pl:UserID()
	button.DoClick = function(btn)
		RunConsoleCommand("a_forceurl", btn.UserID, tentry:GetValue())
		frame:Remove()
	end
	y = y + button:GetTall() + 8

	frame:SetTall(y)
	frame:SetSkin("Default")
	frame:MakePopup()
end

local function rightscallback(userid, level)
	local wid = 360

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetDeleteOnClose(true)
	frame:SetTitle("Set rights for UserID "..tostring(userid))
	frame:SetPos(gui.MousePos())
	frame:SetWide(wid)

	local y = 32

	local tentry = vgui.Create("DTextEntry", frame)
	tentry:SetWide(wid - 16)
	tentry:SetPos(8, y)
	tentry:SetTooltip("Reason for changing")
	y = y + tentry:GetTall() + 8

	local slider = vgui.Create("DEXNumSlider", frame)
	slider:SetMinMax(1, 5)
	slider:SetValue(level or 1)
	slider:SetDecimals(0)
	slider:SetPos(8, y)
	slider:SetText("Level")
	slider:SizeToContents()
	slider:SetWide(wid - 16)
	slider:SetTooltip("Builder level")
	y = y + slider:GetTall() + 8

	local button = EasyButton(frame, "OK", 8, 4)
	button:SetPos(frame:GetWide() * 0.5 - button:GetWide() * 0.5, y)
	button.DoClick = function(btn)
		RunConsoleCommand("setrights", userid, slider:GetValue(), tentry:GetValue())
		frame:Remove()
	end
	y = y + button:GetTall() + 8

	frame:SetTall(y)
	frame:SetSkin("Default")
	frame:MakePopup()
end

function NDB.RemovePunishmentMenu(steamid, punishment)
	if pRemovePunishment and pRemovePunishment:IsValid() then
		pRemovePunishment:Remove()
		pRemovePunishment = nil
	end

	local wid = 360

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetDeleteOnClose(true)
	frame:SetWide(wid)
	frame:SetTitle("Remove a suspension / punishment")

	local y = 32

	local sidentry = vgui.Create("DTextEntry", frame)
	if steamid then
		sidentry:SetValue(steamid)
	end
	sidentry:SetPos(y)
	sidentry:SetWide(wid * 0.5 - 8)
	sidentry:SetPos(wid * 0.5, y)
	local sidlab = EasyLabel(frame, "SteamID or UserID")
	sidlab:SetPos(8, y + sidentry:GetTall() * 0.5 - sidlab:GetTall() * 0.5)
	y = y + sidentry:GetTall() + 8

	local dropdown = vgui.Create("DComboBox", frame)
	dropdown:SetWide(wid * 0.5 - 8)
	dropdown:SetPos(wid * 0.5, y)
	for k, v in pairs(NDB.PunishmentsNames) do
		dropdown:AddChoice(v, k)
	end
	if punishment then
		dropdown:SetText(NDB.PunishmentsNames[punishment])
	end
	local ddlab = EasyLabel(frame, "Punishment type")
	ddlab:SetPos(8, y + dropdown:GetTall() * 0.5 - ddlab:GetTall() * 0.5)
	y = y + dropdown:GetTall() + 8

	local submit = EasyButton(frame, "Remove", 8, 4)
	submit:SetPos(wid * 0.5 - submit:GetWide() * 0.5, y)
	submit.DoClick = function(btn)
		local name = dropdown:GetValue()
		for k, v in pairs(NDB.PunishmentsNames) do
			if v == name then
				RunConsoleCommand("unpunish", sidentry:GetValue(), k)
				break
			end
		end
		frame:Remove()
	end
	y = y + submit:GetTall() + 8

	frame:Center()
	frame:SetTall(y)
	frame:SetSkin("Default")
	frame:MakePopup()
end

local SavedName
local SavedTime = 0
local SavedReason = "Idiot."
function NDB.NewPunishmentMenu(steamid, punishment, duration, reason)
	if pNewPunishment and pNewPunishment:IsValid() then
		pNewPunishment:Remove()
		pNewPunishment = nil
	end

	local wid = 360

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetDeleteOnClose(true)
	frame:SetWide(wid)
	frame:SetTitle("Create a suspension / punishment")
	pNewPunishment = frame

	local y = 32

	local sidentry = vgui.Create("DTextEntry", frame)
	if steamid then
		sidentry:SetValue(steamid)
	end
	sidentry:SetPos(y)
	sidentry:SetWide(wid * 0.5 - 8)
	sidentry:SetPos(wid * 0.5, y)
	local sidlab = EasyLabel(frame, "SteamID or UserID")
	sidlab:SetPos(8, y + sidentry:GetTall() * 0.5 - sidlab:GetTall() * 0.5)
	y = y + sidentry:GetTall() + 8

	local isonlymoderator = LocalPlayer():IsOnlyModerator()

	local dropdown = vgui.Create("DComboBox", frame)
	dropdown:SetWide(wid * 0.5 - 8)
	dropdown:SetPos(wid * 0.5, y)
	for k, v in pairs(NDB.PunishmentsNames) do
		if not isonlymoderator or k == PUNISHMENT_BAN or k == PUNISHMENT_MUTE or k == PUNISHMENT_VOICEMUTE or k == PUNISHMENT_BALLPIT then
			dropdown:AddChoice(v, k)
		end
	end
	if punishment then
		dropdown:SetText(NDB.PunishmentsNames[punishment])
	elseif SavedName then
		dropdown:SetText(SavedName)
	end
	local ddlab = EasyLabel(frame, "Punishment type")
	ddlab:SetPos(8, y + dropdown:GetTall() * 0.5 - ddlab:GetTall() * 0.5)
	y = y + dropdown:GetTall() + 8

	local slider = vgui.Create("DEXNumSlider", frame)
	slider:SetMinMax(0, 10080)
	slider:SetValue(duration or SavedTime or 0)
	slider:SetDecimals(0)
	slider:SetPos(wid * 0.5, y)
	slider:SetText("Time")
	slider:SizeToContents()
	slider:SetWide(wid * 0.5 - 8)
	local slidlab = EasyLabel(frame, "Duration in minutes (0 = permanent)")
	slidlab:SetPos(8, y + slider:GetTall() * 0.5 - slidlab:GetTall() * 0.5)
	y = y + slider:GetTall() + 8

	local reasonentry = vgui.Create("DTextEntry", frame)
	reasonentry:SetValue(reason or SavedReason)
	reasonentry:SetPos(y)
	reasonentry:SetWide(wid * 0.5 - 8)
	reasonentry:SetPos(wid * 0.5, y)
	local reasonlab = EasyLabel(frame, "Reason")
	reasonlab:SetPos(8, y + reasonentry:GetTall() * 0.5 - reasonlab:GetTall() * 0.5)
	y = y + reasonentry:GetTall() + 8

	local submit = EasyButton(frame, "Submit", 8, 4)
	submit:SetPos(wid * 0.5 - submit:GetWide() * 0.5, y)
	submit.DoClick = function(btn)
		local name = dropdown:GetValue()
		SavedName = name
		for k, v in pairs(NDB.PunishmentsNames) do
			if v == name then
				SavedTime = slider:GetValue()
				SavedReason = reasonentry:GetValue()

				net.Start("nox_addpunishment")
					net.WriteString(sidentry:GetValue())
					net.WriteString(SavedReason)
					net.WriteUInt(k, 8)
					net.WriteUInt(SavedTime, 32)
				net.SendToServer()

				break
			end
		end
		frame:Remove()
	end
	y = y + submit:GetTall() + 8

	frame:Center()
	frame:SetTall(y)
	frame:SetSkin("Default")
	frame:MakePopup()
end

local function RemovePunishment(btn)
	surface.PlaySound("buttons/button2.wav")
	btn:SetDisabled(true)
	RunConsoleCommand("unpunish", btn.SteamID, btn.Punishment)
	timer.Simple(0, function() net.Start("nox_requestpunishments") net.SendToServer() end)
end

NDB.Punishments = NDB.Punishments or {}

function NDB.PunishmentsMenu(page, maxpages)
	if pPunishments and pPunishments:IsValid() then
		pPunishments:Remove()
		pPunishments = nil
	end

	if not MySelf:IsAdmin() then return end

	page = page or 1
	maxpages = maxpages or page

	local wid, hei = 640, 480

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetDeleteOnClose(true)
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetTitle("Punishments editor (Page "..page.." of "..maxpages..")")
	--frame.OnRemove = function() NDB.Punishments = nil end
	pPunishments = frame

	local newbutton = EasyButton(frame, "Create a new suspension", 8, 4)
	newbutton:SetPos(8, 32)
	newbutton.DoClick = function(btn) NDB.NewPunishmentMenu() end

	local refreshbutton = vgui.Create("DImageButton", frame)
	refreshbutton:SetImage("icon16/arrow_refresh.png")
	refreshbutton:SizeToContents()
	refreshbutton:SetPos(16 + newbutton:GetWide(), 32)
	refreshbutton:SetTooltip("Refresh list")
	refreshbutton.DoClick = function(btn) btn:SetDisabled(true) net.Start("nox_requestpunishments") net.WriteUInt(page, 16) net.SendToServer() end

	local prevbutton = vgui.Create("DButton", frame)
	prevbutton:SetText("< Prev page")
	prevbutton:SizeToContents()
	prevbutton:SetSize(prevbutton:GetWide() + 8, prevbutton:GetTall() + 8)
	prevbutton:MoveRightOf(refreshbutton, 80)
	prevbutton.DoClick = function(btn) NDB.PunishmentsMenu(page - 1) net.Start("nox_requestpunishments") net.WriteUInt(page - 1, 16) net.SendToServer() end
	prevbutton:SetDisabled(page == 1)

	local nextbutton = vgui.Create("DButton", frame)
	nextbutton:SetText("Next page >")
	nextbutton:SizeToContents()
	nextbutton:SetSize(nextbutton:GetWide() + 8, nextbutton:GetTall() + 8)
	nextbutton:MoveRightOf(prevbutton, 4)
	nextbutton.DoClick = function(btn) NDB.PunishmentsMenu(page + 1) net.Start("nox_requestpunishments") net.WriteUInt(page + 1, 16) net.SendToServer() end
	nextbutton:SetDisabled(page >= maxpages)

	local thetime = os.time()

	local total = 0
	local active = 0
	for _, punishment in pairs(NDB.Punishments) do
		if punishment.Expires == 0 or thetime < punishment.Expires then
			active = active + 1
		end
		total = total + 1
	end

	local countlab = EasyLabel(frame, active.." active suspensions, "..total.." total", nil, COLOR_RED)
	countlab:SetPos(wid - 8 - countlab:GetWide(), 32)

	local list = vgui.Create("DPanelList", frame)
	list:SetSize(wid - 16, hei - 64)
	list:SetPos(8, 56)
	list:SetPadding(2)
	list:SetSpacing(2)
	list:EnableVerticalScrollbar(true)

	for i, punishment in ipairs(NDB.Punishments) do
		if not punishment then continue end

		local pan = vgui.Create("DEXRoundedPanel")
		pan:SetTall(32)
		if punishment.Reason then
			pan:SetTooltip(punishment.Reason)
		end

		local x = 8

		local removebutton = vgui.Create("DImageButton", pan)
		removebutton:SetImage("icon16/exclamation.png")
		removebutton:SizeToContents()
		removebutton:SetPos(x, pan:GetTall() * 0.5 - removebutton:GetTall() * 0.5)
		removebutton:SetTooltip("Remove")
		removebutton.SteamID = punishment.SteamID
		removebutton.Punishment = punishment.Punishment
		removebutton.DoClick = RemovePunishment
		x = x + removebutton:GetWide() + 8

		local namelab = EasyLabel(pan, punishment.Name or "")
		namelab:SetPos(x, pan:GetTall() * 0.5 - namelab:GetTall() * 0.5)
		x = list:GetWide() * 0.45

		local steamidlab = EasyLabel(pan, punishment.SteamID or "UNKNOWN")
		steamidlab:SetPos(x - steamidlab:GetWide() * 0.5, pan:GetTall() * 0.5 - steamidlab:GetTall() * 0.5)
		x = list:GetWide() * 0.7

		local expireslab
		if punishment.Expires == 0 then
			expireslab = EasyLabel(pan, "Eternal", "DefaultFontBold", COLOR_RED)
		else
			local delta = punishment.Expires - thetime
			if delta <= 0 then
				expireslab = EasyLabel(pan, "EXPIRED", "DefaultFontSmall", COLOR_CYAN)
			else
				local col = COLOR_RED
				if delta <= 3600 then
					col = COLOR_LIMEGREEN
				elseif delta <= 86400 then
					col = COLOR_GREEN
				elseif delta <= 604800 then
					col = COLOR_YELLOW
				end
				expireslab = EasyLabel(pan, TimeToEnglish(delta), nil, col)
			end
		end
		expireslab:SetPos(x - expireslab:GetWide() * 0.5, pan:GetTall() * 0.5 - expireslab:GetTall() * 0.5)

		local punishmentlab = EasyLabel(pan, NDB.PunishmentsNames[punishment.Punishment] or "?", "DefaultFontSmall", color_white)
		punishmentlab:SetPos(list:GetWide() - 32 - punishmentlab:GetWide(), 2)

		local adminlab = EasyLabel(pan, punishment.Admin or "?", "DefaultFontSmall", color_white)
		adminlab:SetPos(list:GetWide() - 32 - adminlab:GetWide(), pan:GetTall() - 2 - adminlab:GetTall())

		list:AddItem(pan)
	end

	frame:SetSkin("Default")
	frame:MakePopup()
end

local function Premade(pl, reasoncode)
	net.Start("nox_addpremadepunishment")
		net.WriteEntity(pl)
		net.WriteUInt(reasoncode, 8)
	net.SendToServer()
end
function NDB.AdminMenu(menu, pl)
	local userid = pl:UserID()
	local accountid = pl:AccountNumber()
	local plmenu = menu:AddSubMenu("Administrate "..pl:Name().." (u:"..userid.." e:"..pl:EntIndex()..")")
	plmenu.Player = pl

	local premademenu = plmenu:AddSubMenu("Premade punishments >")
	for k, v in pairs(NDB.PreMadePunishments) do
		premademenu:AddOption(v[1], function() Premade(pl, k) end)
	end

	plmenu:AddOption("Kick...", function() kickcallback(pl) end)
	plmenu:AddOption("Ban...", function() NDB.NewPunishmentMenu(userid, PUNISHMENT_BAN) end)
	plmenu:AddOption("Mute..", function() NDB.NewPunishmentMenu(userid, PUNISHMENT_MUTE) end)
	plmenu:AddOption("Voice mute..", function() NDB.NewPunishmentMenu(userid, PUNISHMENT_VOICEMUTE) end)
	plmenu:AddOption("Send to the ball pit (only voice message other people in ball pit)...", function() NDB.NewPunishmentMenu(userid, PUNISHMENT_BALLPIT) end)
	plmenu:AddOption("Kill", function() RunConsoleCommand("a_slay", userid) end)

	if LocalPlayer():IsAdmin() then
		plmenu:AddOption("Other punishments...", function() NDB.NewPunishmentMenu(userid) end)
		plmenu:AddOption("Remove punishments...", function() NDB.RemovePunishmentMenu(userid) end)
		plmenu:AddSpacer()
		if not pl:IsAdmin() and not pl:IsSuperAdmin() then
			plmenu:AddOption("Force URL...", function() forceurlcallback(pl) end)
			plmenu:AddSpacer()
		end
		plmenu:AddOption("Blow up (area damage)", function() RunConsoleCommand("a_blowup", userid) end)

		local slapmenu = plmenu:AddSubMenu("Slap >")
		slapmenu:AddOption("Hard with no damage", function() RunConsoleCommand("a_slap", userid, 2000, 0) end)
		slapmenu:AddOption("To the Moon", function() RunConsoleCommand("a_slap", userid, 5000, 100) end)
		slapmenu:AddOption("Very hard", function() RunConsoleCommand("a_slap", userid, 1500, 50) end)
		slapmenu:AddOption("Hard", function() RunConsoleCommand("a_slap", userid, 1000, 25) end)
		slapmenu:AddOption("Softly", function() RunConsoleCommand("a_slap", userid, 500, 15) end)
		slapmenu:AddOption("Nudge", function() RunConsoleCommand("a_slap", userid, 200, 0) end)

		local ignitemenu = plmenu:AddSubMenu("Ignite >")
		ignitemenu:AddOption("2 seconds", function() RunConsoleCommand("a_ignite", userid, 2) end)
		ignitemenu:AddOption("5 seconds", function() RunConsoleCommand("a_ignite", userid, 5) end)
		ignitemenu:AddOption("10 seconds", function() RunConsoleCommand("a_ignite", userid, 10) end)
		ignitemenu:AddOption("15 seconds", function() RunConsoleCommand("a_ignite", userid, 15) end)
		ignitemenu:AddOption("20 seconds", function() RunConsoleCommand("a_ignite", userid, 20) end)
		ignitemenu:AddOption("30 seconds", function() RunConsoleCommand("a_ignite", userid, 30) end)

		plmenu:AddSpacer()
		plmenu:AddOption("Teleport them to me", function() RunConsoleCommand("a_bringtome", userid) end)
		plmenu:AddOption("Teleport to them", function() RunConsoleCommand("a_teleporttothem", userid) end)
		plmenu:AddOption("Teleport them to my target", function() RunConsoleCommand("a_teleporttotarget", userid) end)

		plmenu:AddSpacer()
		plmenu:AddOption("Enable godmode", function() RunConsoleCommand("a_god", userid, 1) end)
		plmenu:AddOption("Disable godmode", function() RunConsoleCommand("a_god", userid, 0) end)
		plmenu:AddSpacer()
		plmenu:AddOption("Enable invisibility", function() RunConsoleCommand("a_invisibility", userid, 1) end)
		plmenu:AddOption("Disable invisibility", function() RunConsoleCommand("a_invisibility", userid, 0) end)
		plmenu:AddSpacer()
		plmenu:AddOption("Freeze", function() RunConsoleCommand("a_freeze", userid, 1) end)
		plmenu:AddOption("Unfreeze", function() RunConsoleCommand("a_freeze", userid, 0) end)
	end

	plmenu:AddSpacer()
	plmenu:AddOption("Spectate", function() RunConsoleCommand("a_spectate", userid) end)
	plmenu:AddOption("UnSpectate", function() RunConsoleCommand("a_unspectate", userid) end)
	plmenu:AddSpacer()
	plmenu:AddOption("Generate screen capture", function() RunConsoleCommand("a_screencapture", userid) end)
	plmenu:AddOption("View screen capture", function() NDB.CheckRetard(accountid) end)
end

function NDB.RightsMenu(menu, pl)
	local userid = pl:UserID()
	local rightsmenu = menu:AddSubMenu("Set rights >")
	rightsmenu:AddOption("Guest)", function() rightscallback(userid, 1) end)
	rightsmenu:AddOption("Trial Builder", function() rightscallback(userid, 2) end)
	rightsmenu:AddOption("Builder", function() rightscallback(userid, 3) end)
	rightsmenu:AddOption("Advanced Builder", function() rightscallback(userid, 4) end)
	rightsmenu:AddOption("SandBox Moderator", function() rightscallback(userid, 5) end)
	menu:AddOption("Get rights history", function() RunConsoleCommand("getrights", userid) end)
end

local menu

concommand.Add("+admin", function(sender, command, arguments)
	if not sender:IsModerator() then return end

	menu = DermaMenu()
	menu:SetPos(150, 100)

	local allplayers = player.GetAll()
	table.sort(allplayers, function(a,b)
		local tab = {a:Name(), b:Name()}
		table.sort(tab)
		return a:Name() == tab[1]
	end)

	local submenu = menu:AddSubMenu("Players")
	for _, pl in ipairs(allplayers) do
		NDB.AdminMenu(submenu, pl)
	end

	if sender:IsModerator() then
		menu:AddSpacer()
		menu:AddOption("Toggle All Talk on self", function() RunConsoleCommand("nox_togglealltalk") end)
	end

	if sender:IsAdmin() then
		menu:AddSpacer()
		menu:AddOption("Punishments editor", function() net.Start("nox_requestpunishments") net.WriteUInt(1, 16) net.SendToServer() NDB.PunishmentsMenu(1) end)

		menu:AddSpacer()
		local mapmenu = menu:AddSubMenu("Restart the map")
		local mapmenu2 = mapmenu:AddSubMenu("Really?")
		mapmenu2:AddOption("Really, really?", function() RunConsoleCommand("a_restartmap") end)
	end

	menu:MakePopup()

	timer.Simple(0, function() gui.SetMousePos(150, 100) end)
end)

concommand.Add("-admin", function(sender, command, arguments)
	if menu and menu:IsValid() then
		menu:Remove()
		menu = nil
	end
end)
