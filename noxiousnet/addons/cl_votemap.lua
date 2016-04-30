local VoteMap = NDB.VoteMap

hook.Add("Initialize", "ndb_votemap_cl_initialize", function()
	surface.CreateLegacyFont("coolvetica", 36, 100, true, false, "VoteHeading")
	surface.CreateLegacyFont("coolvetica", 20, 0, true, false, "VoteSelection")

	if not NDB.MapList[GAMEMODE.FolderName] then
		NDB.MapList[GAMEMODE.FolderName] = {}
	end
end)

net.Receive("nox_votemapvote", function(length)
	local uniqueid = net.ReadString()
	local mapid = net.ReadUInt(16)
	local votes = net.ReadUInt(16)

	VoteMap.SetVote(uniqueid, mapid, votes)
end)

net.Receive("nox_votemapvotes", function(length)
	local data = {}
	local count = net.ReadUInt(16)

	for i=1, count do
		local uniqueid = net.ReadString()
		local v1 = net.ReadUInt(16)
		local v2 = net.ReadUInt(16)

		data[uniqueid] = {v1, v2}
	end

	VoteMap.SetVotes(data)
end)

net.Receive("nox_votemapunlocks", function(length)
	local data = {}
	local count = net.ReadUInt(16)
	for i=1, count do
		local k = net.ReadUInt(16)
		data[k] = net.ReadUInt(8)
	end
	VoteMap.SetLocks(data)
end)

function VoteMap.UpdateAll()
	local window = VoteMap.Window
	if window and window:IsValid() then
		window:RefreshAllVotes()
	end
end

local function CloseDoClick(self)
	if file.Exists("_vmcrashed.txt", "DATA") then
		file.Delete("_vmcrashed.txt")
	end
	self:GetParent():SetVisible(false)
end

local namefilter
function NDB.OpenVoteMapMenu(endtime, filter)
	if VoteMap.RandomMap then
		chat.AddText(COLOR_RED, "Random map time! We've selected a map for you to play out of a hat.")
		surface.PlaySound("ambient/levels/citadel/portal_beam_shoot1.wav")
		return
	end

	if #VoteMap.GetMapList() == 0 then return end

	file.Write("_vmcrashed.txt", "1")

	if VoteMap.Window and VoteMap.Window:IsValid() then
		if filter then
			VoteMap.Window:Remove()
		else
			VoteMap.Window:SetVisible(true)

			if endtime then
				VoteMap.EndTime = endtime
				VoteMap.Window:SetEndTime(endtime)
			end

			return
		end
	end

	namefilter = filter

	local window = vgui.Create("VoteMapMenu")
	VoteMap.Window = window

	if endtime then
		VoteMap.EndTime = endtime
		window:SetEndTime(endtime)
	end

	window:SetKeyboardInputEnabled(false)

	window:MakePopup()

	window:RefreshAllVotes()
end
OpenVoteMenu = NDB.OpenVoteMapMenu

local PANEL = {}

local function maplistsort(a, b)
	local alock = VoteMap.GetLocks()[a.Key]
	local block = VoteMap.GetLocks()[b.Key]
	if alock ~= block then
		if alock and not block then return false end
		if not alock and block then return true end
		return alock < block
	end

	a = string.lower(a[2] or a[1])
	b = string.lower(b[2] or b[1])
	return a < b
end
local function empty() end
local function Search(str) NDB.OpenVoteMapMenu(VoteMap.Window and VoteMap.Window:IsValid() and VoteMap.Window.m_EndTime, str) end
local function SearchEntryDoClick(button)
	Derma_StringRequest("Search", "Enter a map or phrase to search for.", "",
	Search,
	empty,
	"OK",
	"Cancel")
end
function PANEL:Init()
	self.VoteIcons = {}

	local wid, hei = math.min(1024, ScrW() - 16), math.max(480, ScrH() * 0.5)

	self:SetSize(wid, hei)

	local closebutton = vgui.Create("DImageButton", self)
	closebutton:SetImage("icon16/delete.png")
	closebutton:SizeToContents()
	closebutton:AlignTop(8)
	closebutton:AlignRight(8)
	closebutton.DoClick = CloseDoClick

	local heading = EasyLabel(self, "Vote for the next map!", "VoteHeading", COLOR_WHITE)
	heading:SetPos(wid, 8)
	heading:SetPos(wid * 0.5 - heading:GetWide() * 0.5, 8, 0.25, 1.5, 0.5)

	local filterentry = EasyButton(self, "Search", 16, 4)
	filterentry:AlignRight(72)
	filterentry:AlignTop(8)
	filterentry.DoClick = SearchEntryDoClick

	local maplist = vgui.Create("DPanelList", self)
	maplist:EnableVerticalScrollbar()
	maplist:StretchToParent(8, 16 + heading:GetTall(), 32, 64)
	maplist:CenterHorizontal()
	maplist:MoveBelow(heading, 8)
	maplist:SetPaintBackgroundEnabled(false)
	self.m_MapListHolder = maplist

	local grid = vgui.Create("DGrid", maplist)
	grid:SetCols(2)
	maplist:AddItem(grid)
	grid:SetColWide(maplist:GetWide() * 0.5 - 8)
	grid:SetRowHeight(40)
	self.m_MapList = grid

	local infobox = vgui.Create("DEXRoundedPanel", self)
	infobox:SetColorAlpha(220)
	local info = EasyLabel(infobox, "Voting power increases by doing better in the game. Gold Members get 150% power and Diamond members get 200% power.", "VoteSelection", color_white)
	local info2 = EasyLabel(infobox, "Click here to join our Steam group and get 10% extra voting power!", "VoteSelection", Color(30, 255, 30))

	infobox:SetSize(wid - 16, info:GetTall() * 2 + 16)
	info:CenterHorizontal()
	info2:CenterHorizontal()
	info:AlignTop(8)
	info2:AlignBottom(8)
	infobox:CenterHorizontal()
	infobox:AlignBottom(8)

	info2:SetMouseInputEnabled(true)
	info2.OnMousePressed = function(p, mc)
		if mc == MOUSE_LEFT then
			gui.OpenURL("http://steamcommunity.com/groups/noxiousnet")
		end
	end

	local allmaps = table.Copy(NDB.MapList[GAMEMODE.FolderName])
	for i, tab in pairs(allmaps) do
		tab.Key = i
	end
	table.sort(allmaps, maplistsort)

	if namefilter then namefilter = string.lower(namefilter) end

	for _, maptab in ipairs(allmaps) do
		if maptab[1] and (not namefilter or string.find(string.lower(maptab[1]), namefilter, 1, true)) then
			local mappanel = vgui.Create("VoteMapMap", grid)
			mappanel:SetMapID(maptab.Key)
			mappanel:SetSize(grid:GetColWide() - 4, grid:GetRowHeight() - 4)
			grid:AddItem(mappanel)
		end
	end

	if maplist.VBar then
		timer.SimpleEx(0, function()
			local mn, mx = math.min(0, maplist.VBar.CanvasSize), math.max(0, maplist.VBar.CanvasSize)
			maplist.VBar:SetScroll(math.Clamp(math.random(mn - 32, mx + 32), mn, mx))
		end)
	end

	self:Center()
end

local function EndTimeThink(self)
	local delta = math.max(math.ceil(self.m_EndTime - CurTime()), 0)
	if delta ~= self.m_LastRefresh then
		self.m_LastRefresh = delta

		self:SetText(delta == 0 and "Next map loading soon" or "Next map in... "..delta)
		self:SizeToContents()
	end
end

function PANEL:SetEndTime(endtime)
	if self.m_EndTime then
		self.m_EndTime.m_EndTime = endtime
		return
	end

	local label = EasyLabel(self, " ", "VoteSelection", COLOR_LIMEGREEN)
	label:AlignTop(8)
	label:AlignLeft(16)
	label.m_EndTime = endtime
	label.Think = EndTimeThink
	self.m_EndTime = label
end

local colWindow = Color(5, 5, 5, 180)
function PANEL:Paint()
	draw.RoundedBox(16, 0, 0, self:GetWide(), self:GetTall(), colWindow)

	return true
end

function PANEL:GetIcon(pl)
	local uid = VoteMap.UniqueID(pl)

	for _, panel in pairs(self.VoteIcons) do
		if panel:GetUniqueID() == uid then return panel end
	end
end

function PANEL:CreateAllIcons()
	--
	for uid in pairs(VoteMap.GetVotes()) do
		self:CreateIcon(uid)
	end
	--
end

function PANEL:CreateIcon(uid)
	--
	local cur = self:GetIcon(uid)
	if cur and cur:IsValid() then return cur end

	local icon = vgui.Create("PlayerMapVoteIcon", self.m_MapList)
	icon:SetPlayer(uid)

	table.insert(self.VoteIcons, icon)

	return icon
	--
end

function PANEL:MoveAllIcons()
	--
	for _, icon in pairs(self.VoteIcons) do
		icon:InvalidateLayout()
	end
	--
end

function PANEL:RefreshAllVotes()
	--
	self:CreateAllIcons()
	self:MoveAllIcons()
	--

	for _, item in pairs(self.m_MapList:GetItems()) do
		item:RefreshVoteCount()
	end
end

vgui.Register("VoteMapMenu", PANEL, "Panel")

PANEL = {}
PANEL.m_UniqueID = ""
PANEL.m_Player = NULL
PANEL.m_Votes = 1

function PANEL:Init()
	self.Seed = math.Rand(0, 10)
	self:SetSize(16, 16)
end

function PANEL:PerformLayout()
	local vote = VoteMap.GetVote(self:GetUniqueID())
	if not vote then return end

	local list = VoteMap.Window.m_MapList
	if list then
		for _, item in pairs(list:GetItems()) do
			if item:GetMapID() == vote[1] then
				self:SetParent(item.m_VoteHolder)
				item:RepositionIcons()

				break
			end
		end
	end
end

function PANEL:SetPlayer(pl)
	self.m_Player = VoteMap.Player(pl)
	self.m_UniqueID = VoteMap.UniqueID(pl)
	self.m_IsLocalPlayer = self.m_Player == LocalPlayer()
	self.m_IsSuperAdmin = self.m_Player:IsValid() and self.m_Player:IsSuperAdmin()

	if self.m_Player:IsValid() then
		local vote = VoteMap.GetVote(self:GetUniqueID())
		if vote then
			self:SetTooltip(self.m_Player:Name().." - ["..vote[2].."]")
			self.m_Votes = vote[2]
		end
	end

	self:InvalidateLayout()
end

function PANEL:GetUniqueID()
	return self.m_UniqueID
end

function PANEL:GetPlayer()
	return self.m_Player
end

local texStar = Material("icon16/star.png")
local texStarSuperAdmin = Material("icon16/heart.png")
local texStarSelf = Material("icon16/user.png")
function PANEL:Paint()
	surface.SetMaterial(self.m_IsLocalPlayer and texStarSelf or self.m_IsSuperAdmin and texStarSuperAdmin or texStar)

	local pl = self:GetPlayer()
	if pl and pl:IsValid() and pl.PersonalChatColor then
		surface.SetDrawColor(pl.PersonalChatColor)
	else
		surface.SetDrawColor(255, 255, 255, 255)
	end

	local wid, hei = self:GetSize()
	surface.DrawTexturedRectRotated(wid * 0.5, hei * 0.5, wid, hei, ((CurTime() + self.Seed) * self.m_Votes * 3) % 360)
end

vgui.Register("PlayerMapVoteIcon", PANEL, "Panel")

PANEL = {}

local colHolder = Color(5, 5, 5, 60)
local function VoteHolderPaint(self)
	local wide, tall = self:GetSize()
	draw.RoundedBox(8, 0, 0, wide, tall, colHolder)
end
function PANEL:Init()
	self.m_MapLabel = vgui.Create("DLabel", self)
	self.m_MapLabel:SetFont("VoteSelection")
	self.m_MapLabel:SetTextColor(color_white)

	self.m_MapFileNameLabel = vgui.Create("DLabel", self)
	self.m_MapFileNameLabel:SetFont("DefaultFontSmall")

	self.m_VoteCount = vgui.Create("DLabel", self)
	self.m_VoteCount:SetText("0")
	self.m_VoteCount:SetFont("VoteSelection")
	self.m_VoteCount:SetTextColor(COLOR_RED)

	self.m_VoteHolder = vgui.Create("DPanel", self)
	self.m_VoteHolder.Paint = VoteHolderPaint
end

function PANEL:DoClick()
	RunConsoleCommand("nnvotemap", self:GetMapID())
	surface.PlaySound("buttons/lightswitch2.wav")
end

local colPanel = Color(45, 45, 45, 180)
local colPanelHover = Color(90, 90, 90, 180)
local colPanelDepressed = Color(60, 60, 60, 180)
local texWhite = surface.GetTextureID("VGUI/white")
function PANEL:Paint()
	draw.RoundedBox(8, 0, 0, self:GetWide(), self:GetTall(), self.Depressed and colPanelDepressed or self.Hovered and colPanelHover or colPanel)

	local mapid = self:GetMapID()
	local lock = VoteMap.GetMapLockState(mapid)

	if lock <= 1 then
		local gmtab = NDB.MapList[GAMEMODE.FolderName]
		local maptab = gmtab and gmtab[mapid]
		if maptab and maptab[3] and #player.GetAll() < maptab[3] then
			lock = 2
		end
	end

	if lock == 0 then return true end

	if lock == 2 then
		surface.SetDrawColor(255, 0, 0, 120)
	else
		surface.SetDrawColor(255, 255, 0, 30)
	end

	surface.SetTexture(texWhite)
	local wid, hei = self:GetWide(), self:GetTall()
	local barw = wid / 30
	local x = -((barw * CurTime() * 2) % (barw * 2))

	for i = -2, 30, 2 do
		x = x + barw * 2
		surface.DrawTexturedRectRotated(x - barw * 0.5, hei * 0.5, barw, hei + 100, -45)
	end

	return true
end

function PANEL:RepositionIcons()
	local x = 2

	local voteholder = self.m_VoteHolder
	for _, icon in pairs(VoteMap.Window.VoteIcons) do
		if icon:GetParent() == voteholder then
			icon:SetPos(x, 0)
			icon:CenterVertical()
			x = x + icon:GetWide()
		end
	end
end

function PANEL:PerformLayout()
	self.m_MapLabel:AlignLeft(8)
	self.m_MapLabel:AlignTop(4)

	self.m_MapFileNameLabel:AlignLeft(8)
	self.m_MapFileNameLabel:AlignBottom(4)

	self.m_VoteCount:SetPos(self:GetWide() * 0.4, 0)
	self.m_VoteCount:CenterVertical()

	self.m_VoteHolder:SetSize(self:GetWide() * 0.5, 20)
	self.m_VoteHolder:AlignRight(8)

	self.m_VoteHolder:CenterVertical()
end

function PANEL:SetMapID(mapid)
	self.m_MapID = mapid

	local gmtab = NDB.MapList[GAMEMODE.FolderName]
	local maptab = gmtab and gmtab[mapid]
	if maptab then
		self.m_MapLabel:SetText(maptab[2] or maptab[1])
		self.m_MapLabel:SizeToContents()

		if maptab[3] then
			self.m_MapFileNameLabel:SetText(maptab[1].." | "..maptab[3].."+ players")
		else
			self.m_MapFileNameLabel:SetText(maptab[1])
		end
		self.m_MapFileNameLabel:SizeToContents()

		self:InvalidateLayout()
	end
end

function PANEL:GetMapID()
	return self.m_MapID or 0
end

function PANEL:RefreshVoteCount()
	local votes = VoteMap.GetTotalVotes(self:GetMapID())
	self.m_VoteCount:SetText(votes)
	self.m_VoteCount:SetTextColor(votes == 0 and COLOR_RED or VoteMap.GetTopMap() == self:GetMapID() and COLOR_LIMEGREEN or color_white)
	self.m_VoteCount:SizeToContents()
end

vgui.Register("VoteMapMap", PANEL, "Button")










local numgtvotes = {}

usermessage.Hook("recgtnumvotes", function(um)
	numgtvotes[um:ReadString()] = um:ReadShort()
end)

function GetMostGTVotes()
	local most = 0
	local gtname = "this one"
	for name, num in pairs(numgtvotes) do
		if most < num then
			most = num
			gtname = name
		end
	end

	return gtname, most
end

function NDB.GetGTVotes()
	return numgtvotes
end

hook.Add("Initialize", "GameTypeVotingInitialize", function()
	hook.Remove("Initialize", "GameTypeVotingInitialize")

	if not GAMEMODE.GameTypes then return end

	function OpenGTVoteMenu()
		if pVoteMap then
			pVoteMap:SetVisible(false)
		end

		if pGTVote and pGTVote:IsValid() then
			return
		end

		local wid = 340
		local halfwid = wid * 0.5

		local Window = vgui.Create("DEXRoundedFrame")
		Window:SetSkin("Default")
		Window:SetWide(wid)
		Window:SetTitle("Vote for a Game Type!")
		Window:SetDeleteOnClose(true)
		Window:SetKeyboardInputEnabled(false)
		Window:SetScreenLock(true)
		pGTVote = Window

		local y = 32

		local wb = WordBox(Window, "Vote for a Game Type to be played next!", "DefaultFontBold", color_white)
		wb:SetPos(halfwid - wb:GetWide() * 0.5, y)
		y = y + wb:GetTall() + 8

		local lab = EasyLabel(Window, "The next map is")
		lab:SetPos(8, y)
		lab.Think = function(me)

			local mapdata = VoteMap.GetMapList()[VoteMap.GetTopMap()]
			if mapdata and me.MapName ~= mapdata[1] then
				me.MapName = mapdata[1]
				me:SetText("The next map is "..me.MapName..".")
				me:SizeToContents()
			end
		end
		y = y + lab:GetTall() + 2

		lab = EasyLabel(Window, "The next game type is")
		lab:SetPos(8, y)
		lab.Think = function(me)
			local gtname, numvotes = GetMostGTVotes()
			if me.MostVotes ~= numvotes or me.GTName ~= gtname then
				me.MostVotes = numvotes
				me.GTName = gtname
				me:SetText("The next game type is "..gtname.." with "..numvotes.." votes.")
				me:SizeToContents()
			end
		end
		y = y + lab:GetTall() + 16

		for i, gt in ipairs(GAMEMODE.GameTypes) do
			local but = EasyButton(Window, GAMEMODE.GameTranslates[gt] or gt, 0, 4)
			but:SetWide(wid - 16)
			but:SetPos(8, y)
			if GAMEMODE.NoGameTypeTwiceInRow and 1 < #GAMEMODE.GameTypes and GAMEMODE.GameType == gt then
				but:SetDisabled(true)
			end
			but.GameType = gt
			but.Votes = -1
			but.OldThink = but.Think
			but.Think = function(me)
				local votes = numgtvotes[me.GameType] or 0

				if votes ~= me.Votes then
					me:SetText((GAMEMODE.GameTranslates[me.GameType] or me.GameType).." - "..votes.." votes")
				end
			end
			if GAMEMODE.GameTypeDescriptions and GAMEMODE.GameTypeDescriptions[gt] then
				but:SetTooltip(GAMEMODE.GameTypeDescriptions[gt])
			end
			but.DoClick = function()
				RunConsoleCommand("votegt", gt)
			end

			y = y + but:GetTall() + 4
		end

		Window:SetTall(y + 4)
		Window:Center()
		Window:SetSkin("Default")
		Window:SetVisible(true)
		Window:MakePopup()
	end
	concommand.Add("votegtopen", OpenGTVoteMenu)
end)


local function enable()
	RunConsoleCommand("mat_queue_mode", "0")
	RunConsoleCommand("retry")
end
local function disable()
	file.Write("_vmcrasheddisable.txt", "1")
end
hook.Add("HookGetLocal", "VMHookGetLocal", function()
	if file.Exists("_vmcrashed.txt", "DATA") then
		file.Delete("_vmcrashed.txt")

		if GetConVar("mat_queue_mode"):GetInt() ~= 0 and not file.Exists("_vmcrasheddisable.txt", "DATA") then
			timer.SimpleEx(2, Derma_Query, "Disable multicore rendering? This can stop you from crashing on the map vote menu.", "Protip", "YES", enable, "NO", function() end, "DON'T ASK AGAIN I LOVE CRASHING", disable)
		end
	end
end)
hook.Add("ShutDown", "VMShutDown", function()
	if file.Exists("_vmcrashed.txt", "DATA") then
		file.Delete("_vmcrashed.txt")
	end
end)
