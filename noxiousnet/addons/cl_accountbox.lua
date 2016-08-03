include("accountbox/options.lua")
include("accountbox/emotes.lua")
include("accountbox/modelselect.lua")
include("accountbox/rules.lua")

local colText = Color(255, 255, 255, 230)

local function CloseChat()
	if NNChat.ChatFrame and NNChat.ChatFrame:IsValid() and NNChat.ChatFrame:IsVisible() then
		NNChat.ChatFrame:Close()
	end
end

local PANEL = {}

PANEL.AnimationTime = 0.3

PANEL.LastMemberLevel = MEMBER_NONE
PANEL.LastMoney = 0
PANEL.Hidden = false

function PANEL:Init()
	local screenscale = BetterScreenScale()
	local buttontall = 40 * screenscale
	local bmargin = 20 * screenscale

	local but

	self:SetMouseInputEnabled(true)

	self:SetSize(ScrW(), buttontall)
	self:DockPadding(16 * screenscale, 0, 16 * screenscale, 0)

	local moneyimage = vgui.Create("DImage", self)
	moneyimage:SetImage("icon16/ruby.png")
	moneyimage:SetSize(self:GetTall() - 8 * screenscale, self:GetTall() - 8 * screenscale)
	moneyimage:SetImageColor(Color(80, 255, 255))
	moneyimage:Dock(LEFT)

	self.SilverLabel = EasyLabel(self, "9999999999 SILVER", "noxaccountfont", colText)
	self.SilverLabel:Dock(LEFT)
	self.SilverLabel:SetContentAlignment(4)

	self.MemberLabel = EasyLabel(self, "NO MEMBERSHIP", "noxaccountfont", colText)
	self.MemberLabel:SetContentAlignment(6)
	self.MemberLabel:Dock(RIGHT)

	but = vgui.Create("NDBAccountBoxButton", self)
	but:SetButtonText("SHOP")
	but:SizeToContents()
	but.DoClick = function(me) CloseChat() RunConsoleCommand("shopmenu") end
	but:DockMargin(bmargin, 0, 0, 0)
	but:Dock(LEFT)

	but = vgui.Create("NDBAccountBoxButton", self)
	but:SetButtonText("PROFILE")
	but:SizeToContents()
	but.DoClick = function(me) CloseChat() NDB.CreateProfile(LocalPlayer()) end
	but:DockMargin(bmargin, 0, 0, 0)
	but:Dock(LEFT)

	but = vgui.Create("NDBAccountBoxButton", self)
	but:SetButtonText("MODEL")
	but:SizeToContents()
	but.DoClick = function(me) CloseChat() MakepModelSelect() end
	but:DockMargin(bmargin, 0, 0, 0)
	but:Dock(LEFT)

	but = vgui.Create("NDBAccountBoxButton", self)
	but:SetButtonText("SERVERS")
	but:SizeToContents()
	but.DoClick = function(me) CloseChat() MakepPortal() end
	but:DockMargin(bmargin, 0, 0, 0)
	but:Dock(LEFT)

	but = vgui.Create("NDBAccountBoxButton", self)
	but:SetButtonText("RULES")
	but:SizeToContents()
	but.DoClick = function(me) CloseChat() MakepRules() end
	but:DockMargin(bmargin, 0, 0, 0)
	but:Dock(LEFT)

	but = vgui.Create("NDBAccountBoxButton", self)
	but:SetButtonText("EMOTES")
	but:SizeToContents()
	but.DoClick = function(me) CloseChat() MakepEmotes() end
	but:DockMargin(bmargin, 0, 0, 0)
	but:Dock(LEFT)

	but = vgui.Create("NDBAccountBoxButton", self)
	but:SetButtonText("OPTIONS")
	but:SizeToContents()
	but.DoClick = function(me) CloseChat() MakepNoxOptions() end
	but:DockMargin(bmargin, 0, 0, 0)
	but:Dock(LEFT)

	but = vgui.Create("NDBAccountBoxButton", self)
	but:SetButtonText("DONATIONS")
	but:SizeToContents()
	but.DoClick = function(me) CloseChat() gui.OpenURL("https://noxiousnet.com/shop") end
	but:DockMargin(bmargin, 0, 0, 0)
	but:Dock(LEFT)
end

function PANEL:PerformLayout()
	self:SetWide(ScrW())
end

PANEL.LastMouseX = 0
PANEL.LastMouseY = 0
PANEL.LastMouseChange = 0

function PANEL:Think()
	local mysilver = MySelf:GetSilver()
	local memberlevel = MySelf:GetMemberLevel()

	if mysilver ~= self.LastMoney then
		self.LastMoney = mysilver
		self.SilverLabel:SetText(string.CommaSeparate(tostring(self.LastMoney)).." SILVER")
	end

	if memberlevel ~= self.LastMemberLevel then
		self.LastMemberLevel = memberlevel

		if memberlevel == MEMBER_NONE or not NDB.MemberNames[memberlevel] then
			self.MemberLabel:SetVisible(false)
		else
			self.MemberLabel:SetText(string.upper(tostring(NDB.MemberNames[memberlevel])).." MEMBERSHIP")
			if NDB.MemberColors[memberlevel] then
				local col = table.Copy(NDB.MemberColors[memberlevel])
				col.a = colText.a
				self.MemberLabel:SetTextColor(col)
			end
			self.MemberLabel:SizeToContents()
			self.MemberLabel:AlignRight(8)
		end
	end

	if self:ShouldDisplay() then
		if self.Hidden then
			self:Show()
		end
	elseif not self.Hidden then
		self:Hide()
	end
end

function PANEL:ShouldDisplay()
	return NNChat.ChatOn or NDB.ShopPanel and NDB.ShopPanel:IsValid() and NDB.ShopPanel:IsVisible()
end

function PANEL:Hide()
	self.Hidden = true
	self:SetZPos(0)

	self:Stop()
	self:MoveTo(0, -self:GetTall() - 1, self.AnimationTime, self.AnimationTime * 0.66)

	timer.Create("HideAccountMenu", self.AnimationTime, 1.1, function()
		for _, child in pairs(self:GetChildren()) do
			child:SetVisible(false)
		end
	end)
end

function PANEL:Show()
	self.Hidden = false
	self:SetZPos(1000)

	self:Stop()
	self:MoveTo(0, 0, self.AnimationTime, self.AnimationTime * 0.66)

	timer.Remove("HideAccountMenu")
	for _, child in pairs(self:GetChildren()) do
		child:SetVisible(true)
	end
end

local BG = Color(20, 130, 20)
function PANEL:Paint(w, h)
	surface.SetDrawColor(BG)
	surface.DrawRect(0, 0, w, h)
end

vgui.Register("NDBAccountBox", PANEL, "DPanel")

PANEL = {}

PANEL.m_Text = ""

PANEL.HoveredSound = false

function PANEL:Init()
	self:SetFont("noxaccountbuttonfont")
	self:SetText("")
end

function PANEL:Think()
	if self.HoveredSound ~= self.Hovered then
		self.HoveredSound = self.Hovered
		if self.Hovered then
			surface.PlaySound("buttons/lightswitch2.wav")
		end
	end
end

local BUTBG = Color(20, 30, 20)
function PANEL:Paint(w, h)
	if self.Hovered then
		surface.SetDrawColor(BUTBG)
		surface.DrawRect(0, 0, w, h)
	end

	if self.Hovered then
		local g = 1 - math.abs(math.sin(RealTime() * 4)) * 0.25
		draw.SimpleText(self.m_Text, "noxaccountbuttonfont", w / 2, h / 2, Color(g * 255, math.min(255, g * 300), g * 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		draw.SimpleText(self.m_Text, "noxaccountbuttonfont", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function PANEL:SetButtonText(text)
	self.m_Text = text
end

function PANEL:SizeToContents()
	surface.SetFont("noxaccountbuttonfont")
	local texw, texh = surface.GetTextSize(self.m_Text)
	self:SetSize(texw + BetterScreenScale() * 16, texh)
end

vgui.Register("NDBAccountBoxButton", PANEL, "DButton")

PANEL = {}

function PANEL:Init()
	self:SetAlpha(200)
	self:ParentToHUD()
	self:DockPadding(16, 4, 16, 4)

	self.SilverImage = vgui.Create("DImage", self)
	self.SilverImage:SetImage("icon16/ruby.png")
	self.SilverImage:SetSize(16, 16)
	self.SilverImage:SetImageColor(Color(80, 255, 255))
	self.SilverImage:Dock(LEFT)
	self.SilverImage:DockMargin(0, 0, 24, 0)

	self.SilverLabel = EasyLabel(self, "9999999999 SILVER", "noxaccountfont", colText)
	self.SilverLabel:Dock(FILL)
	self.SilverLabel:SetContentAlignment(4)

	self:SetSize(self.SilverImage:GetWide() + self.SilverLabel:GetWide() + 64, 24)

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	self:AlignLeft()
	self:AlignTop(ScrH() * 0.15)
end

function PANEL:Think()
	local mysilver = MySelf:GetSilver()
	if mysilver ~= self.LastMoney then
		self.LastMoney = mysilver
		self.SilverLabel:SetText(string.CommaSeparate(tostring(self.LastMoney)).." SILVER")
	end
end

local matGradientLeft = CreateMaterial("gradient-l", "UnlitGeneric", {["$basetexture"] = "vgui/gradient-l", ["$vertexalpha"] = "1", ["$vertexcolor"] = "1", ["$ignorez"] = "1", ["$nomip"] = "1"})
function PANEL:Paint(w, h)
	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawRect(0, 0, w * 0.4, h)
	surface.SetMaterial(matGradientLeft)
	surface.DrawTexturedRect(w * 0.4, 0, w * 0.6, h)

	return true
end

vgui.Register("NDBSilverPanel", PANEL, "Panel")

hook.Add("InitPostEntity", "CreateAccountBox", function()
	local screenscale = BetterScreenScale()

	surface.CreateFont("noxaccountfont", {font = "tahoma", size = screenscale * 19, weight = 700, antialias = true, shadow = true})
	surface.CreateFont("noxaccountbuttonfont", {font = "arial", size = screenscale * 28, weight = 1000, antialias = true, shadow = false})

	NDB.CreateInternalFonts()

	local frame = vgui.Create("NDBAccountBox")
	NDB.AccountFrame = frame

	vgui.Create("NDBSilverPanel")
end)
