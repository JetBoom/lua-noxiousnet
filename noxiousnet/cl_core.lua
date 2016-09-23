include("sh_core.lua")

include("extensions/cl_surface.lua")
include("extensions/cl_player.lua")

include("addons/cl_vgui.lua")
include("addons/cl_accountbox.lua")
include("addons/cl_admin.lua")
include("addons/cl_afkkicker.lua")
include("addons/cl_announcements.lua")
include("addons/cl_awards.lua")
include("addons/cl_chatbox.lua")
include("addons/cl_costumes.lua")
include("addons/cl_gamemodeautoexec.lua")
include("addons/cl_shop.lua")
include("addons/cl_song.lua")
include("addons/cl_titlechange.lua")
include("addons/cl_votemap.lua")
include("addons/cl_retardchecker.lua")
include("addons/cl_dynsnd.lua")
include("addons/placebo/client.lua")

include("addons/vgui/dexhtml.lua")
include("addons/vgui/dexnumslider.lua")
include("addons/vgui/dexpingbars.lua")
include("addons/vgui/dexroundedframe.lua")
include("addons/vgui/dexroundedpanel.lua")
include("addons/vgui/dexchanginglabel.lua")
include("addons/vgui/dexcyclepanel.lua")
include("addons/vgui/dextriangle.lua")
include("addons/vgui/dexlabel.lua")
include("addons/vgui/voicenotify.lua")

concommand.Add("printdxinfo", function()
	print("DX Level", render.GetDXLevel())
	print("Supports HDR", render.SupportsHDR())
	print("Supports Pixel Shaders 1.4", render.SupportsPixelShaders_1_4())
	print("Supports Pixel Shaders 2.0", render.SupportsPixelShaders_2_0())
	print("Supports Vertex Shaders 2.0", render.SupportsVertexShaders_2_0())
end)

MySelf = MySelf or NULL
hook.Add("InitPostEntity", "GetLocal", function()
	MySelf = LocalPlayer()

	GAMEMODE.HookGetLocal = GAMEMODE.HookGetLocal or (function(g) end)
	gamemode.Call("HookGetLocal", MySelf)
	RunConsoleCommand("initpostentity")
end)

hook.Add("HookGetLocal", "NDB.HookGetLocal", function()
	MySelf.Silver = MySelf.Silver or 0
end)

CreateClientConVar("nox_ballpit", 0, true, true)
cvars.AddChangeCallback("nox_ballpit", function(cvar, oldvalue, newvalue)
	net.Start("nox_update_ballpit")
	net.SendToServer()
end)

-- Scales the screen based around 1080p but doesn't make things TOO tiny on low resolutions.
function BetterScreenScale()
	return math.max(0.6, math.min(1, ScrH() / 1080))
end

function WordBox(parent, text, font, textcolor)
	local cpanel = vgui.Create("DEXRoundedPanel", parent)
	local label = EasyLabel(cpanel, text, font, textcolor)
	local tsizex, tsizey = label:GetSize()
	cpanel:SetSize(tsizex + 16, tsizey + 8)
	label:SetPos(8, (tsizey + 8) * 0.5 - tsizey * 0.5)
	cpanel:SetVisible(true)
	cpanel:SetMouseInputEnabled(false)
	cpanel:SetKeyboardInputEnabled(false)

	return cpanel
end

function EasyLabel(parent, text, font, textcolor)
	local dpanel = vgui.Create("DLabel", parent)
	if font then
		dpanel:SetFont(font or "DefaultFont")
	end
	if text then
		dpanel:SetText(text)
	end
	dpanel:SizeToContents()
	if textcolor then
		dpanel:SetTextColor(textcolor)
	end
	dpanel:SetKeyboardInputEnabled(false)
	dpanel:SetMouseInputEnabled(false)

	return dpanel
end

function EasyDEXLabel(parent, text, font, textcolor, outline)
	local dpanel = vgui.Create("DEXLabel", parent)
	if font then
		dpanel:SetFont(font or "DefaultFont")
	end
	if text then
		dpanel:SetText(text)
	end
	dpanel:SizeToContents()
	if textcolor then
		dpanel:SetTextColor(textcolor)
	end
	dpanel:SetKeyboardInputEnabled(false)
	dpanel:SetMouseInputEnabled(false)
	dpanel:SetOutline(outline)

	return dpanel
end

function EasyButton(parent, text, xpadding, ypadding)
	local dpanel = vgui.Create("DButton", parent)
	if textcolor then
		dpanel:SetFGColor(textcolor or color_white)
	end
	if text then
		dpanel:SetText(text)
	end
	dpanel:SizeToContents()

	if xpadding then
		dpanel:SetWide(dpanel:GetWide() + xpadding * 2)
	end

	if ypadding then
		dpanel:SetTall(dpanel:GetTall() + ypadding * 2)
	end

	return dpanel
end

COLOR_RED = Color(255, 0, 0)
COLOR_YELLOW = Color(255, 255, 0)
COLOR_ORANGE = Color(255, 200, 0)
COLOR_PINK = Color(255, 20, 100)
COLOR_GREEN = Color(0, 255, 0)
COLOR_LIMEGREEN = Color(50, 255, 50)
COLOR_PURPLE = Color(255, 0, 255)
COLOR_BLUE = Color(0, 0, 255)
COLOR_LIGHTBLUE = Color(0, 80, 255)
COLOR_CYAN = Color(0, 255, 255)
COLOR_WHITE = Color(255, 255, 255)
COLOR_BLACK = Color(0, 0, 0)

color_black_alpha90 = Color(0, 0, 0, 90)
color_black_alpha180 = Color(0, 0, 0, 180)
color_black_alpha220 = Color(0, 0, 0, 220)

hook.Add("Initialize", "NDBINITIALIZE", function()
	hook.Remove("Initialize", "NDBINITIALIZE")

	if GAMEMODE.NoCostumes then
		hook.Remove("PostPlayerDraw", "costumes_PostPlayerDraw")
	end

	NDB.CreateInternalFonts()

	surface.CreateLegacyFont("tahoma", 20, 400, true, false, "awardsname")

	concommand.Remove("pp_PixelRender")

	if timer.Exists("CheckHookTimes") then
		timer.Remove("CheckHookTimes")
	end

	RunConsoleCommand("r_drawmodeldecals", "0")
end)

function NDB.CreateInternalFonts()
	surface.CreateFont("DefaultFontVerySmall", {font = "tahoma", size = 10, weight = 0, antialias = false})
	surface.CreateFont("DefaultFontSmall", {font = "tahoma", size = 11, weight = 0, antialias = false})
	surface.CreateFont("DefaultFontSmallDropShadow", {font = "tahoma", size = 11, weight = 0, shadow = true, antialias = false})
	surface.CreateFont("DefaultFont", {font = "tahoma", size = 13, weight = 500, antialias = false})
	surface.CreateFont("DefaultFontBold", {font = "tahoma", size = 13, weight = 1000, antialias = false})
	surface.CreateFont("DefaultFontLarge", {font = "tahoma", size = 16, weight = 0, antialias = false})
end

function ForceURL(url)
	local pan = vgui.Create("DHTML")
	pan:SetPos(0,0)
	pan:SetSize(ScrW(), ScrH())
	if string.sub(url, 1, 4) == "http" then
		pan:OpenURL(url)
	else
		pan:OpenURL("http://"..url)
	end
end

local function IceSkates(pl, mv)
	pl:SetGroundEntity(NULL)
	local vel = mv:GetVelocity()
	local vel2d = Vector(vel.x, vel.y, 0)
	local newvel = math.min(vel2d:Length(), mv:GetMaxSpeed()) * vel2d
	newvel.z = vel.z
	mv:SetVelocity(newvel)
end
function NDB.StartIceSkates()
	hook.Add("Move", "IceSkates", IceSkates)
end
function NDB.EndIceSkates()
	hook.Remove("Move", "IceSkates")
end

net.Receive("nox_ndbinfo", function(length)
	local ent = net.ReadEntity()
	local chatcol = net.ReadUInt(24)
	local memberlevel = net.ReadUInt(8)
	local title = net.ReadString()

	if IsValid(ent) then
		if chatcol == 0 then
			ent.PersonalChatColor = nil
		else
			ent.PersonalChatColor = Color(decodecolor(chatcol))
		end
		ent.NewTitle = title
		ent.MemberLevel = memberlevel
	end
end)

net.Receive("nox_titles", function(length)
	local tab = {}
	local ent = net.ReadEntity()
	local num = net.ReadUInt(8)
	for i=1, num do
		table.insert(tab, net.ReadString())
	end

	if IsValid(ent) then
		ent.Titles = tab
	end
end)

net.Receive("nox_savedtitles", function(length)
	local tab = {}
	local num = net.ReadUInt(16)
	for i=1, num do
		table.insert(tab, net.ReadString())
	end
	LocalPlayer().SavedTitles = tab
end)

net.Receive("nox_saved3dtitles", function(length)
	local tab = {}
	local num = net.ReadUInt(16)
	for i=1, num do
		table.insert(tab, net.ReadString())
	end
	LocalPlayer().Saved3DTitles = tab
end)

local function VoteKickDoClick(self)
	if self.Ban then
		RunConsoleCommand("voteban", self.ID)
	else
		RunConsoleCommand("votekick", self.ID)
	end

	surface.PlaySound("buttons/button3.wav")

	self:GetParent():GetParent():GetParent():Remove()
end

function OpenVoteKick(ban)
	local wid, hei = 280, 420

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	if ban then
		frame:SetTitle("Voteban")
	else
		frame:SetTitle("Votekick")
	end
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetDeleteOnClose(true)

	local y = 32

	local label = EasyLabel(frame, "This should only be used against cheaters, griefers, and exploiters! If you are unsure then DON'T USE THIS BECAUSE YOU WILL GET BANNED YOURSELF.", nil, COLOR_RED)
	label:SetSize(wid - 16, 72)
	label:SetWrap(true)
	label:SetContentAlignment(8)
	label:SetPos(0, y)
	label:CenterHorizontal()
	y = y + label:GetTall() + 8

	local list = vgui.Create("DPanelList", frame)
	list:SetSize(wid - 16, hei - y - 8)
	list:SetPos(8, y)
	list:SetSpacing(2)
	list:EnableVerticalScrollbar()

	for _, pl in pairs(player.GetAll()) do
		if pl ~= MySelf and pl:IsValid() and not pl:IsAdmin() then
			local button = EasyButton(list, pl:Name(), 0, 4)
			button.DoClick = VoteKickDoClick
			button.Ban = ban
			button.ID = pl:AccountNumber()

			list:AddItem(button)
		end
	end

	frame:SetSkin("Default")
	frame:MakePopup()
end

function NDB.GeneralPlayerMenu(pl, popup, x, y)
	if not pl:IsValid() then return end

	if pl.HasDermaMenu and pl.HasDermaMenu:IsValid() then
		pl.HasDermaMenu:Remove()
	end

	local plmenu = DermaMenu()
	pl.HasDermaMenu = plmenu
	if x and y then
		plmenu:SetPos(x, y)
	else
		plmenu:SetPos(gui.MouseX(), gui.MouseY())
	end

	plmenu.Player = pl
	plmenu:AddOption(pl:Name())
	plmenu:AddSpacer()
	plmenu:AddOption("View Steam profile", function() pl:ShowProfile() end)
	plmenu:AddOption("Copy SteamID to clipboard", function() SetClipboardText(pl:SteamID()) end)
	plmenu:AddOption("View stats and awards", function() NDB.CreateProfile(pl) end)
	if pl ~= MySelf then
		plmenu:AddOption("Transfer Silver", function()
			Derma_StringRequest("Silver Transfer", "Transfer how much to "..pl:Name().."?", "0", function(text) RunConsoleCommand("transfersilver", pl:UserID(), text) end, function() end, "OK", "Cancel")
		end)
		plmenu:AddSpacer()
		local accountid = pl:AccountNumber()
		plmenu:AddOption("Vote to kick", function() RunConsoleCommand("votekick", accountid) end)
		plmenu:AddOption("Vote to ban", function() RunConsoleCommand("voteban", accountid) end)

		if noxgroups then
			plmenu:AddSpacer()
			noxgroups.GroupMenu(plmenu, pl)
		end
	end
	plmenu:AddSpacer()

	plmenu:AddOption("Add title with title card", function() MakepTitleChange(pl) end)
	plmenu:AddOption("Brand with title card", function() MakepTitleChange3D(pl) end)
	plmenu:AddSpacer()

	if MySelf:IsAdmin() then
		NDB.AdminMenu(plmenu, pl)
		plmenu:AddSpacer()
	end
	if GAMEMODE.IsSandboxDerived and MySelf.IsModerator and MySelf:IsModerator() then
		NDB.RightsMenu(plmenu, pl)
		plmenu:AddSpacer()
	end
	plmenu:AddOption("Nevermind...")

	if popup then
		plmenu:MakePopup()
	end

	local height = plmenu:GetTall()
	local cx, cy = plmenu:GetPos()
	local scrh = ScrH()
	if cy > scrh - height then
		plmenu:SetPos(cx, scrh - height)
	end

	return plmenu
end
NDB.GenericPlayerMenu = NDB.GeneralPlayerMenu

local function ConnectDoClick(me)
	surface.PlaySound("buttons/button15.wav")
	surface.PlaySound("ambient/machines/teleport1.wav")
	me:GetParent():Close()
	local start = CurTime()
	hook.Add("HUDPaint", "NoXiousPortalDraw", function()
		surface.SetDrawColor(255, 255, 255, math.min(255, (CurTime() - start) * 400))
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end)
	timer.SimpleEx(1.5, MySelf.ConCommand, MySelf, "connect "..me.IP)
end

function MakepPortal()
	if pServerPortal and pServerPortal:IsValid() then
		pServerPortal:Remove()
		pServerPortal = nil
	end

	LocalPlayer():EmitSound(math.random(2) == 1 and "vo/k_lab/kl_masslessfieldflux.wav" or "vo/k_lab/kl_ensconced.wav", 0, 100, 0.5)

	local wid = 400
	local halfw = wid * 0.5

	local df = vgui.Create("DEXRoundedFrame")
	df:SetSkin("Default")
	pServerPortal = df
	df:SetWide(wid)
	df:SetTitle("Server Portal")

	local y = 28

	local wb = WordBox(df, "Pick another server to join!", "DefaultFontBold", color_white)
	wb:SetPos(halfw - wb:GetWide() * 0.5, y)
	y = y + wb:GetTall() + 4

	local sillypanel = vgui.Create("DPanel", df)
	sillypanel:SetPos(8, y)
	sillypanel:SetSize(wid - 16, 100)

	local kleiner = vgui.Create("DModelPanel", sillypanel)
	kleiner:SetAnimated(true)
	kleiner:SetModel("models/kleiner.mdl")
	local tall = sillypanel:GetTall()
	kleiner:SetSize(tall, tall)
	kleiner:SetPos(sillypanel:GetWide() * 0.5 - kleiner:GetWide(), 0)
	kleiner.Entity:ResetSequence(kleiner.Entity:LookupSequence("idle_subtle"))
	kleiner.Entity:SetPoseParameter("breathing", 1)
	kleiner:SetCamPos(Vector(92, -48, 64))
	kleiner:SetLookAt(Vector(0, 0, 32))
	kleiner.LayoutEntity = function(k, ent)
		if k.bAnimated then
			k:RunAnimation()
		end
	end

	local telepad = vgui.Create("DModelPanel", sillypanel)
	telepad:SetAnimated(false)
	telepad:SetModel("models/props_lab/teleplatform.mdl")
	telepad:SetSize(tall, tall)
	telepad:SetPos(sillypanel:GetWide() * 0.5, 0)
	telepad:SetCamPos(Vector(128,64,92))
	telepad:SetLookAt(Vector(0,0,0))
	telepad.LayoutEntity = kleiner.LayoutEntity

	y = y + sillypanel:GetTall() + 8

	for i, tab in ipairs(NDB.Servers) do
		if not tab[7] then
			local but = EasyButton(df, tab[1], 0, 8)
			but:SetWide(wid - 64)
			but:SetPos(32, y)
			but:SetTooltip(tab[4])
			but.IP = tab[2]..":"..tab[3]
			but.DoClick = ConnectDoClick
			y = y + but:GetTall() + 4
		end
	end

	df:SetTall(y + 4)

	df:Center()
	df:SetSkin("Default")
	df:SetVisible(true)
	df:MakePopup()
end
concommand.Add("serverportal", MakepPortal)

function NDB.GetWikiFrame()
	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetDeleteOnClose(true)
	frame:SetSize(800, 600)
	frame:SetTitle("In-game Wiki")

	local pan = NDB.GetWikiPanel()
	pan:SetParent(frame)
	pan:SetPos(8, 600 - pan:GetTall() - 8)

	frame.WikiPanel = pan

	frame:SetSkin("Default")

	return frame
end

local NextAllowClick = 0
local function ArticleDoClick(me)
	if NextAllowClick <= SysTime() then
		NextAllowClick = SysTime() + 2
		surface.PlaySound("weapons/ar2/ar2_reload_push.wav")
		me.Output:SetHTML("<html><head></head><body bgcolor='black'><span style='text-align:center;color:red;font-decoration:bold;font-size:200%;'>Loading...</span></body></html>")
		me.Output:OpenURL("http://heavy.noxiousnet.com/wiki/index.php?title="..tostring(me.Article))
	end
end

local function ContentsDoClick(me)
	surface.PlaySound("weapons/ar2/ar2_reload_push.wav")
	me.Output:SetHTML(tostring(me.Contents))
end

local function RecursiveAdd(window, current, output, contenttab)
	for i, tab in ipairs(contenttab) do
		if tab.Contents then
			local but = current:AddNode(tab.Name)
			but.Contents = tab.Contents
			but.DoClick = ContentsDoClick
			but.Output = output
			window.Contents[tab.Name] = tab.Contents
		elseif tab.Article then
			local but = current:AddNode(tab.Name)
			but.Article = tab.Article
			but.DoClick = ArticleDoClick
			but.Output = output
		elseif tab.Name then
			local node = current:AddNode(tab.Name)
			RecursiveAdd(window, node, output, tab)
		else
			print("Garbage detected in pHelp RecursiveAdd:", i, tab, current, contenttab)
		end
	end
end

function NDB.GetWikiPanel()
	local Window = vgui.Create("DPanel")
	Window:SetSize(784, 540)
	Window:SetCursor("pointer")
	Window.Contents = {}
	pWiki = Window

	local button = EasyButton(Window, "View the ENTIRE wiki", 8, 4)
	button:SetPos(8, Window:GetTall() - button:GetTall() - 8)
	button.DoClick = function(btn)
		Window.Output:OpenURL("http://heavy.noxiousnet.com/wiki/index.php")
	end

	local tree = vgui.Create("DTree", Window)
	tree:SetSize(Window:GetWide() * 0.25 - 8, Window:GetTall() - 24 - button:GetTall())
	tree:SetPos(8, 8)
	tree:SetIndentSize(8)
	tree.Window = Window
	Window.Tree = tree

	local output = vgui.Create("DHTML", Window)
	output:SetSize(Window:GetWide() - tree:GetWide() - 24, Window:GetTall() - 16)
	output:SetPos(Window:GetWide() - output:GetWide() - 8, 8)
	output.Window = Window
	Window.Output = output

	if GAMEMODE.Wiki then
		RecursiveAdd(Window, tree, output, GAMEMODE.Wiki)
	end
	if NDB.Wiki then
		RecursiveAdd(Window, tree, output, NDB.Wiki)
	end

	return Window
end

function NDB.OpenWiki(article)
	if gamemode.Call("HandleWiki", article) then return end

	local frame = NDB.GetWikiFrame()
	frame:Center()
	frame:MakePopup()
	if article then
		if frame.WikiPanel.Contents[article] then
			frame.WikiPanel.Output:SetHTML(frame.WikiPanel.Contents[article])
		else
			frame.WikiPanel.Output:OpenURL("http://heavy.noxiousnet.com/wiki/index.php?title="..tostring(article))
		end
	end
end

function NDB.CrashRestart()
	local start = SysTime()
	hook.Add("HUDPaint", "NDB.CrashRestart", function()
		if SysTime() >= start + 5 then
			hook.Remove("HUDPaint", "NDB.CrashRestart")
			RunConsoleCommand("retry")
		end
	end)
end

net.Receive("nox_playeraccount", function(length)
	local pl = net.ReadEntity()
	local data = net.ReadTable()

	if pl:IsValid() then
		pl.AccountContents = data
	end
end)

net.Receive("nox_punishments", function(length)
	local punishments = {}

	local page = net.ReadUInt(16)
	local maxpages = net.ReadUInt(16)
	local count = net.ReadUInt(16)
	for i=1, count do
		local tab = {}
		tab.SteamID = net.ReadString()
		tab.Name = net.ReadString()
		tab.Reason = net.ReadString()
		tab.Admin = net.ReadString()
		tab.Punishment = net.ReadUInt(8)
		tab.Expires = net.ReadUInt(32)
		table.insert(punishments, tab)
	end

	NDB.Punishments = punishments

	if pPunishments and pPunishments:IsValid() and pPunishments:IsVisible() then
		NDB.PunishmentsMenu(page, maxpages)
	end
end)

net.Receive("nox_playerinventory", function(length)
	local pl = net.ReadEntity()
	local num = net.ReadUInt(16)

	if pl:IsValid() then
		local inv = {}
		for i = 1, num do
			table.insert(inv, net.ReadUInt(16))
		end
		pl.Inventory = inv
	end
end)

local rndsnds = {
"vo/Breencast/br_instinct01.wav",
"vo/Breencast/br_instinct02.wav",
"vo/Breencast/br_instinct03.wav",
"npc/stalker/go_alert2a.wav",
"npc/stalker/go_alert2a.wav",
"npc/stalker/go_alert2a.wav",
"npc/stalker/go_alert2a.wav",
"npc/stalker/go_alert2a.wav",
"npc/stalker/go_alert2a.wav",
"ambient/alarms/klaxon1.wav",
"ambient/alarms/klaxon1.wav",
"ambient/alarms/razortrain_horn1.wav",
"ambient/alarms/warningbell1.wav",
"ambient/alarms/train_horn2.wav",
"ambient/alarms/train_horn2.wav",
"ambient/alarms/train_horn2.wav",
"ambient/alarms/train_horn2.wav",
"ambient/alarms/train_horn2.wav"
}

local emeta = FindMetaTable("Entity")
emeta.PreHighEmitSound = emeta.EmitSound
local function HighEmitSound(self, snd, vol, pitch)
	local r=math.random(3)
	if r==1 then
		emeta.PreHighEmitSound(self, snd, vol, math.Clamp((pitch or 100) * math.Rand(0.5, 2), 10, 255))
	elseif r==2 then
		emeta.PreHighEmitSound(self, rndsnds[math.random(#rndsnds)], vol, math.Rand(75, 125))
	else
		emeta.PreHighEmitSound(self, snd, vol, pitch)
	end
end

local function HighFootstep(pl, pos, ifoot, snd, vol)
	emeta.PreHighEmitSound(pl, "ambient/creatures/teddy.wav", vol * 100, ifoot == 0 and math.Rand(200, 210) or math.Rand(185, 195))
	return true
end
local function HighCreateMove(cmd)
	local newang = cmd:GetViewAngles() + FrameTime() * 0.2 * cmd:GetViewAngles()
	newang.roll = CurTime() * 45 % 180 - 90
	cmd:SetViewAngles(newang)
end
local function HighCreateMoveEnd(cmd)
	local ang = cmd:GetViewAngles()
	ang.roll = 0
	cmd:SetViewAngles(ang)
	hook.Remove("CreateMove", "HighCreateMoveEnd")
end
function StartSoHighRightNow()
	emeta.EmitSound = HighEmitSound
	hook.Add("PlayerFootstep", "HighFootstep", HighFootstep)
	hook.Add("CreateMove", "HighCreateMove", HighCreateMove)
end

function EndSoHighRightNow()
	emeta.EmitSound = emeta.PreHighEmitSound
	hook.Remove("PlayerFootstep", "HighFootstep")
	hook.Remove("CreateMove", "HighCreateMove")
	hook.Add("CreateMove", "HighCreateMoveEnd", HighCreateMoveEnd)
end

net.Receive("nox_titlecards", function(pl, length)
	local cards = net.ReadUInt(16)

	if LocalPlayer():IsValid() then
		LocalPlayer():SetTitleChangeCards(cards)
	end
end)

net.Receive("nox_chatstate", function(length)
	local pl = net.ReadEntity()
	local chatting = net.ReadBit() == 1

	if pl:IsValid() then
		pl.ChattingState = chatting
	end
end)

-- Security exploit...
if not NoLanguageSetText then
	NoLanguageSetText = true

	local Panel = FindMetaTable("Panel")
	if Panel then
		function Panel:SetTextSafe(text)
			if string.sub(text, 1, 1) == "#" then
				text = "_"..string.sub(text, 2)
			end

			self:SetText(text)
		end
	end
end
