local function MakePreview(target, title, width)
	return NNChat.CreateChatPanel(target:EntIndex(), title, COLOR_WHITE, "niceandfat", width)
end

local function TitleOnTextChanged(self)
	if not self.m_Target:IsValid() then return end

	local oldpreview = self.m_Preview

	local text = self:GetValue()

	local preview = MakePreview(self.m_Target, "<white>[</white>"..text.."<white>]</white>", self:GetWide())
	preview:CopyPos(oldpreview)
	preview:SetParent(oldpreview:GetParent())

	self.m_Preview = preview

	oldpreview:Remove()

	if #text == 0 then
		self.m_OK:SetText("Title is too short!")
		self.m_OK:SetTextColor(COLOR_RED)
		self.m_OK:SetDisabled(true)
	elseif #text > 160 then
		self.m_OK:SetText("Title has too many characters!")
		self.m_OK:SetTextColor(COLOR_RED)
		self.m_OK:SetDisabled(true)
	elseif preview:GetMaxLineWidth() >= 250 or preview:GetMaxLineHeight() >= 72 then
		self.m_OK:SetText("Title is too big!")
		self.m_OK:SetTextColor(COLOR_RED)
		self.m_OK:SetDisabled(true)
	elseif string.find(text, "(NN)", 1, true) ~= nil then
		self.m_OK:SetText("Title cannot contain (NN)!")
		self.m_OK:SetTextColor(COLOR_RED)
		self.m_OK:SetDisabled(true)
	else
		local offensive = false

		self.m_OK:SetText("Set that title!")
		self.m_OK:SetTextColor(color_black)
		self.m_OK:SetDisabled(false)
	end
end

local function OKDoClick(self)
	if self.m_Target:IsValid() then
		RunConsoleCommand("nox_titlechange", self.m_Target:UserID(), self.m_TextEntry:GetValue())
	end

	self:GetParent():Close()
end

function MakepTitleChange(target)
	if not target:IsValid() or not target:IsPlayer() then return end

	local wid, hei = 460, 240

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetTitle("Title change")
	frame:SetSize(wid, hei)
	frame:SetDeleteOnClose(true)
	frame:Center()

	local holder = vgui.Create("DEXRoundedPanel", frame)
	holder:SetTall(32)
	holder:DockMargin(16, 0, 16, 0)
	holder:Dock(TOP)

	local text
	if target == LocalPlayer() then
		text = "Giving yourself a title!"
	else
		text = "Anonymously giving "..target:Name().." a title!"
	end
	local namelab = EasyLabel(holder, text, "nice", color_white)
	namelab:SetContentAlignment(8)
	namelab:Dock(TOP)

	local warning = EasyLabel(holder, "No extremely offensive titles. They will be removed without refund!", "DefaultFontBold", COLOR_RED)
	warning:SetContentAlignment(8)
	warning:Dock(TOP)

	local textentry = vgui.Create("DTextEntry", frame)
	textentry:SizeToContents()
	textentry:SetWide(wid - 16)
	textentry:DockMargin(16, 16, 16, 0)
	textentry:Dock(TOP)
	textentry.OnTextChanged = TitleOnTextChanged
	textentry.m_Target = target

	local preview = MakePreview(target, "-- Preview --", textentry:GetWide())
	preview:SetParent(frame)
	preview:DockMargin(16, 16, 16, 0)
	preview:Dock(TOP)
	textentry.m_Preview = preview

	local ok = EasyButton(frame, "Set that title!", 8, 4)
	ok:SetDisabled(true)
	ok:DockMargin(32, 0, 32, 0)
	ok:Dock(BOTTOM)
	ok.UserID = target:UserID()
	ok.DoClick = OKDoClick
	ok.m_Target = target
	ok.m_TextEntry = textentry
	textentry.m_OK = ok

	local holder = vgui.Create("DEXRoundedPanel", frame)
	holder:SetTall(16)
	holder:DockMargin(16, 8, 16, 8)
	holder:Dock(BOTTOM)

	local img = vgui.Create("DImage", holder)
	img:SetImage("icon16/vcard.png")
	img:SizeToContents()
	img:Dock(LEFT)
	img:DockMargin(8, 0, 8, 0)

	local counter = EasyLabel(holder, "", "DefaultFontBold")
	counter:SetContentAlignment(4)
	counter:Dock(LEFT)
	counter.Think = function(me)
		local last = me.LastCount
		local cur = LocalPlayer():GetTitleChangeCards()

		if last ~= cur then
			me.LastCount = cur

			me:SetText("You have "..cur.." title change cards.")
			me:SetTextColor(cur > 0 and color_white or COLOR_RED)
			me:SizeToContents()
		end
	end
	counter:Think()

	local button = EasyButton(holder, "Get more cards", 8, 4)
	button:Dock(RIGHT)
	button:DockPadding(8, 4, 8, 4)
	button:DockMargin(0, 0, 8, 0)
	button.DoClick = function()
		gui.OpenURL("https://noxiousnet.com/shop")
	end

	frame:SetSkin("Default")
	frame:MakePopup()
end

local function TitleOnTextChanged3D(self)
	if not self.m_Target:IsValid() then return end

	local text = self:GetValue()
	self.m_OK:SetDisabled(#text > 64 or #text == 0)
end

local function OKDoClick3D(self)
	if self.m_Target:IsValid() then
		RunConsoleCommand("nox_titlechange3d", self.m_Target:UserID(), self.m_TextEntry:GetValue())
	end

	self:GetParent():Close()
end

function MakepTitleChange3D(target)
	if not target:IsValid() or not target:IsPlayer() then return end

	local wid, hei = 460, 190

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetTitle("Player branding")
	frame:SetSize(wid, hei)
	frame:SetDeleteOnClose(true)
	frame:Center()

	local holder = vgui.Create("DEXRoundedPanel", frame)
	holder:SetSize(wid, 32)
	holder:DockMargin(16, 0, 16, 0)
	holder:Dock(TOP)

	local text
	if LocalPlayer() == target then
		text = "Giving yourself a branding!"
	else
		text = "Anonymously branding "..target:Name().."!"
	end
	local namelab = EasyLabel(holder, text, "nice", color_white)
	namelab:Center()

	local textentry = vgui.Create("DTextEntry", frame)
	textentry:SizeToContents()
	textentry:SetWide(wid - 16)
	textentry:DockMargin(16, 16, 16, 0)
	textentry:Dock(TOP)
	textentry.OnTextChanged = TitleOnTextChanged3D
	textentry.m_Target = target

	local ok = EasyButton(frame, "Brand that player!", 8, 4)
	ok:SetDisabled(true)
	ok:DockMargin(32, 0, 32, 0)
	ok:Dock(BOTTOM)
	ok.UserID = target:UserID()
	ok.DoClick = OKDoClick3D
	ok.m_Target = target
	ok.m_TextEntry = textentry
	textentry.m_OK = ok

	local warning = EasyLabel(frame, "No extremely offensive titles. They will be removed without refund!", "DefaultFontBold", COLOR_RED)
	warning:SetContentAlignment(8)
	warning:Dock(TOP)
	warning:DockMargin(0, 8, 0, 8)

	local holder = vgui.Create("DEXRoundedPanel", frame)
	holder:SetTall(16)
	holder:DockMargin(16, 8, 16, 8)
	holder:Dock(BOTTOM)

	local img = vgui.Create("DImage", holder)
	img:SetImage("icon16/vcard.png")
	img:SizeToContents()
	img:Dock(LEFT)
	img:DockMargin(8, 0, 8, 0)

	local counter = EasyLabel(holder, "", "DefaultFontBold")
	counter:SetContentAlignment(4)
	counter:Dock(LEFT)
	counter.Think = function(me)
		local last = me.LastCount
		local cur = LocalPlayer():GetTitleChangeCards()

		if last ~= cur then
			me.LastCount = cur

			me:SetText("You have "..cur.." title change cards.")
			me:SetTextColor(cur > 0 and color_white or COLOR_RED)
			me:SizeToContents()
		end
	end
	counter:Think()

	local button = EasyButton(holder, "Get more cards", 8, 4)
	button:Dock(RIGHT)
	button:DockPadding(8, 4, 8, 4)
	button:DockMargin(0, 0, 8, 0)
	button.DoClick = function()
		gui.OpenURL("https://noxiousnet.com/shop")
	end

	frame:SetSkin("Default")
	frame:MakePopup()
end

local function TitleOnTextChangedLS(self)
	local text = self:GetValue()
	self.m_OK:SetDisabled(#text > 80 or #text == 0)
end

local function OKDoClickLS(self)
	RunConsoleCommand("nox_setloadingscreenmessage", self.m_TextEntry:GetValue())
	self:GetParent():Close()
end

function MakepLoadingScreenChange()
	local wid, hei = 460, 150

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetTitle("Loading screen message")
	frame:SetSize(wid, hei)
	frame:SetDeleteOnClose(true)
	frame:Center()

	local holder = vgui.Create("DEXRoundedPanel", frame)
	holder:SetColorAlpha(220)
	holder:SetSize(wid, 32)
	holder:SetPos(0, 32)

	local namelab = EasyLabel(holder, "No offensive content or advertising please!", "DefaultFontBold", color_white)
	namelab:Center()

	local textentry = vgui.Create("DTextEntry", frame)
	textentry:SizeToContents()
	textentry:SetWide(wid - 16)
	textentry:MoveBelow(holder, 8)
	textentry:CenterHorizontal()
	textentry.OnTextChanged = TitleOnTextChangedLS

	local ok = EasyButton(frame, "Set that loading screen message!", 8, 4)
	ok:AlignBottom(8)
	ok:CenterHorizontal()
	ok:SetDisabled(true)
	ok.DoClick = OKDoClickLS
	ok.m_TextEntry = textentry
	textentry.m_OK = ok

	frame:SetSkin("Default")
	frame:MakePopup()
end

function NDB.MakeSetTitleFrame()
	local wid, hei = 300, 450

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetTitle(" ")
	frame:SetSize(wid, hei)
	frame:SetDeleteOnClose(true)
	frame:Center()

	local holder = vgui.Create("DEXRoundedPanel", frame)
	holder:SetColorAlpha(220)
	holder:SetSize(wid, 32)
	holder:Dock(TOP)

	local namelab = EasyLabel(holder, "Set who's title?", "DefaultFontBold", color_white)
	namelab:Center()

	local list = vgui.Create("DScrollPanel", frame)
	list:Dock(FILL)

	for _, pl in pairs(player.GetAll()) do
		if pl:IsValid() then
			local button = EasyButton(list, pl:Name(), 0, 4)
			button.DoClick = function()
				if IsValid(pl) then
					MakepTitleChange(pl)
				end
				frame:Close()
			end

			button:Dock(TOP)
			button:DockMargin(8, 3, 8, 3)
		end
	end

	frame:SetSkin("Default")
	frame:MakePopup()
end
