NDB.GamemodeAutoExec = {}

NDB.GamemodeAutoExec["fretta13"] = function()
	hook.Add("ScoreboardPlayerPressed", "NDB", function(pl)
		NDB.GeneralPlayerMenu(pl, true)
	end)
end

NDB.GamemodeAutoExec["extremefootballthrowdown"] = NDB.GamemodeAutoExec["fretta13"]

NDB.GamemodeAutoExec["zombiesurvival"] = function()
function GAMEMODE:PlayerVoicePitch(pl, pitch)
	if pl:Team() == TEAM_UNDEAD then
		local altpitch = self.ZombieClasses[pl:GetZombieClass()].VoicePitch
		if altpitch then
			return pitch * altpitch
		end
	end
end

function GAMEMODE:ShouldDrawVirtualEntity(pl, ent)
	return not pl.FeignDeath
end

hook.Add("AddExtraOptions", "NDB_ZS_AddExtraOptions", function(list, window)
	local check = vgui.Create("DCheckBoxLabel", window)
	check:SetText("[NoXiousNet] Display player hats, auras, etc.")
	check:SetConVar("nox_displayhats")
	check:SizeToContents()
	list:AddItem(check)
end)

hook.Add("ClickedPlayerButton", "NDB_ZS_ClickedPlayerMenu", function(pl, button)
	NDB.GeneralPlayerMenu(pl, true)
end)

hook.Add("ClickedEndBoardPlayerButton", "NDB_ZS_ClickedEndBoardPlayerMenu", function(pl, button)
	NDB.GeneralPlayerMenu(pl, true)
end)

hook.Add("PlayerIsAdmin", "NDB_PlayerIsAdmin", function(pl)
	return pl:IsModerator()
end)

local function StoreClick(self)
	self:GetParent():SetVisible(false)
	RunConsoleCommand("shopmenu")
end

local function PortalClick(self)
	self:GetParent():SetVisible(false)
	RunConsoleCommand("serverportal")
end

hook.Add("BuildHelpMenu", "NDB_ZS_BuildHelpMenu", function(window)
	local button1 = EasyButton(window, "Donations", 8, 4)

	local button2 = EasyButton(window, "NoXiousNet Store", 8, 4)
	button2.DoClick = StoreClick

	local button3 = EasyButton(window, "Server Portal", 8, 4)
	button3.DoClick = PortalClick

	local maxwidth = math.max(math.max(button1:GetWide(), button2:GetWide()), button3:GetWide())
	button1:SetWide(maxwidth)
	button2:SetWide(maxwidth)
	button3:SetWide(maxwidth)

	local y = window:GetTall() - button1:GetTall() - 12
	local x = 12

	button1:SetPos(x, y)
	x = x + button1:GetWide() + 8
	button2:SetPos(x, y)
	x = x + button2:GetWide() + 8
	button3:SetPos(x, y)

	local urllabel = vgui.Create("DLabelURL", button1)
	urllabel:SetText("")
	urllabel:SetURL("https://noxiousnet.com/shop")
	urllabel:StretchToParent()
	urllabel:SetMouseInputEnabled(true)
end)
end
NDB.GamemodeAutoExec["zombiesurvival_nn"] = NDB.GamemodeAutoExec["zombiesurvival"]

hook.Add("Initialize", "NDB_Initialize_GamemodeAutoexec", function()
	if not GAMEMODE then return end

	if NDB.GamemodeAutoExec[GAMEMODE.FolderName] then
		NDB.GamemodeAutoExec[GAMEMODE.FolderName]()
	end
end)
