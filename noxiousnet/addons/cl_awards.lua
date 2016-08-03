local colBG = Color(5, 5, 5, 220)
local colBGAchieved = Color(5, 30, 5, 220)
function NDB.CreateAwardsPanel(category, wid, hei, parent, awards)
	category = category or "All Games"

	wid = wid or 540
	hei = hei or 470

	local panel = vgui.Create("DEXRoundedPanel", parent)
	panel:SetSize(wid, hei)
	panel:SetBorderRadius(4)
	panel.Category = category
	panel.Children = {}
	panel.Awards = awards

	local dropdown = vgui.Create("DComboBox", panel)
	dropdown:SetWide(150)
	dropdown:SetPos(8, 8)
	dropdown:SetText(category)
	function dropdown:OnSelect(index, value, data)
		if value == "All Games" or table.HasValue(NDB.AwardCategories, value) then
			local thisparent = self:GetParent()
			thisparent.Category = value
			thisparent:RefreshList()
			if thisparent.PList.VBar and thisparent.PList.VBar:IsValid() then
				thisparent.PList.VBar:SetScroll(0)
			end

			surface.PlaySound("buttons/button15.wav")
		end
	end
	dropdown:AddChoice("All Games")
	for id, acategory in pairs(NDB.AwardCategories) do
		dropdown:AddChoice(acategory)
	end
	panel.DropDown = dropdown

	function panel:RefreshList()
		for _, child in pairs(self.Children) do
			child:Remove()
		end
		self.Children = {}

		local plist
		local panw
		if self.PList then
			for _, item in pairs(self.PList:GetItems()) do
				self.PList:RemoveItem(item)
			end
			plist = self.PList
			panw = plist:GetWide() - 16
		else
			plist = vgui.Create("DPanelList", self)
			panw = wid - 16
			plist:SetSize(panw, hei - 40)
			plist:SetPos(8, 32)
			plist:EnableVerticalScrollbar()
			plist:EnableHorizontal(false)
			plist:SetSpacing(2)
			self.PList = plist
		end

		local catid
		local using = {}
		local mycategory = self.Category or "All Games"
		if mycategory == "All Games" then
			catid = -1

			for awardname, awardtab in pairs(NDB.Awards) do
				if awardtab[2] ~= AWARDS_CAT_SPECIAL then
					using[#using + 1] = awardname
				end
			end
		else
			for id, catname in pairs(NDB.AwardCategories) do
				if catname == mycategory then
					catid = id
					break
				end
			end

			catid = catid or -1

			for awardname, awardtab in pairs(NDB.Awards) do
				if bit.band(awardtab[2], catid) == catid then
					using[#using + 1] = awardname
				end
			end
		end

		table.sort(using)

		local totalawards = #using
		local achieved = 0

		for _, awardname in ipairs(using) do
			local ourcount = 0
			if self.Awards then
				for _, awd in pairs(self.Awards) do
					if string.lower(awd) == awardname then
						ourcount = ourcount + 1
					end
				end
			else
				ourcount = ourcount + 1
			end

			local cleanname = string.Replace(string.upper(awardname), "_", " ")
			local awardtab = NDB.Awards[awardname]
			local awarddesc = awardtab[1]

			local Panel = vgui.Create("DEXRoundedPanel", plist)
			Panel:SetCurveTopLeft(false)
			Panel:SetCurveBottomLeft(false)
			Panel:SetSize(panw, 52)

			local diff = awardtab[3] or AWARDS_DIFFICULTY_NORMAL

			local img = vgui.Create("DImage", Panel)
			img:SetImage("icon16/star.png")
			img:SetImageColor(diff == AWARDS_DIFFICULTY_NORMAL and COLOR_LIMEGREEN
			or diff == AWARDS_DIFFICULTY_HARD and COLOR_YELLOW
			or diff == AWARDS_DIFFICULTY_HARDEST and COLOR_RED
			or diff == AWARDS_DIFFICULTY_EVENT and COLOR_PURPLE
			or diff == AWARDS_DIFFICULTY_OTHER and COLOR_BLUE)
			img:SetTooltip(diff == AWARDS_DIFFICULTY_NORMAL and "Normal"
			or diff == AWARDS_DIFFICULTY_HARD and "Hard"
			or diff == AWARDS_DIFFICULTY_HARDEST and "Very Hard"
			or diff == AWARDS_DIFFICULTY_EVENT and "Event"
			or diff == AWARDS_DIFFICULTY_OTHER and "Other")
			img:SizeToContents()
			img:AlignLeft(4)
			img:AlignTop(4)
			img:SetMouseInputEnabled(true)

			local lab
			local clab
			if ourcount == 0 then
				lab = EasyLabel(Panel, cleanname, "awardsname", color_white)

				Panel:SetColor(colBG)
			else
				Panel:SetColor(colBGAchieved)

				achieved = achieved + 1

				lab = EasyLabel(Panel, cleanname, "awardsname", COLOR_LIMEGREEN)
				if 1 < ourcount then
					clab = EasyLabel(Panel, " (x"..ourcount..")", "awardsname", COLOR_YELLOW)
					clab:AlignRight(4)
					clab:CenterVertical()
				end

				local check = vgui.Create("DImage", Panel)
				check:SetImage("icon16/award_star_gold_1.png")
				check:SizeToContents()
				check:CopyPos(img)
				check:MoveBelow(img, 4)
				check:SetTooltip("Award earned!")
				check:SetMouseInputEnabled(true)
			end
			lab:AlignTop(4)
			lab:MoveRightOf(img, 8)

			if awarddesc then
				local desclab = EasyLabel(Panel, awarddesc, "DefaultFontSmall", color_white)
				desclab:SetSize(panw - 64, 48)
				desclab:SetMultiline(true)
				desclab:SetWrap(true)
				desclab:SetContentAlignment(7)
				desclab:MoveRightOf(img, 8)
				desclab:MoveBelow(lab, 1)
			end

			plist:AddItem(Panel)
		end

		local wb
		if self.Awards and 0 < totalawards then
			wb = WordBox(self, achieved.." of "..totalawards.." awards achieved. (".. math.floor((achieved / totalawards) * 100) .."%)", nil, color_white)
		else
			wb = WordBox(self, totalawards.." total awards.", nil, COLOR_YELLOW)
		end
		wb:SetPos(self:GetWide() - 8 - wb:GetWide(), 8)
		table.insert(self.Children, wb)
	end
	panel:RefreshList()

	return panel
end

function NDB.ViewAllAwards()
	local wid, hei = 540, 470

	local frmAll = vgui.Create("DEXRoundedFrame")
	frmAll:SetSkin("Default")
	frmAll:SetSize(wid, hei)
	frmAll:Center()
	frmAll:SetTitle("Complete awards listing")
	frmAll:SetDeleteOnClose(true)
	frmAll:SetVisible(true)
	frmAll:SetKeyboardInputEnabled(false)
	frmAll:MakePopup()

	NDB.CreateAwardsPanel(nil, wid - 8, hei - 28, frmAll):SetPos(4, 24)

	frmAll:SetSkin("Default")
end

local function CreateRealProfile(player, contents)
	local wid, hei = math.min(800, ScrW()), math.min(720, ScrH())

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetTitle("Account - "..player:SteamID())
	frame:SetDeleteOnClose(true)
	frame:SetVisible(true)
	frame:MakePopup()

	local avatar = vgui.Create("AvatarImage", frame)
	avatar:SetPos(8, 32)
	avatar:SetSize(32, 32)
	avatar:SetPlayer(player)
	avatar:SetMouseInputEnabled(false)
	avatar:SetKeyboardInputEnabled(false)

	local namelabel = EasyLabel(frame, player:Name(), "DefaultFontBold", color_white)
	namelabel:MoveRightOf(avatar, 4)
	namelabel:AlignTop(32)

	local label = EasyLabel(frame, string.CommaSeparate(contents.Silver).." Silver", nil, color_white)
	label:MoveRightOf(avatar, 4)
	label:MoveBelow(namelabel)

	local memberlevel = contents.MemberLevel
	if memberlevel and memberlevel ~= 0 then
		local label2 = EasyLabel(frame, NDB.MemberNames[memberlevel].." Member", nil, NDB.MemberColors[memberlevel])
		label2:MoveRightOf(avatar, 4)
		label2:MoveBelow(label)
	end

	local htmlpan = vgui.Create("DHTML", frame)
	htmlpan:SetSize(wid - 8, hei - 342)
	htmlpan:SetPos(4, 88)
	htmlpan:OpenURL("https://noxiousnet.com/player?id="..player:SteamID().."&noheader=1&noname=1")

	NDB.CreateAwardsPanel(nil, wid - 8, 246, frame, contents.Awards or {}):SetPos(4, hei - 250)

	frame:SetSkin("Default")
end

function NDB.CreateProfile(pl)
	if not pl:IsValid() or not pl:IsPlayer() then return end

	pl.AccountContents = nil

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetTitle("Loading")
	frame:SetDeleteOnClose(true)
	frame.EndAttempt = CurTime() + 3
	frame.Player = pl
	frame.Think = function(f)
		if f.EndAttempt <= CurTime() then
			f.EndAttempt = CurTime() + 999999
			f.Think = function(a) a:Remove() end
			Derma_Message("Couldn't load account information...")
		elseif f.Player:IsValid() and f.Player.AccountContents then
			f.EndAttempt = CurTime() + 999999
			f.Think = function(a) a:Remove() end
			CreateRealProfile(f.Player, f.Player.AccountContents)
		end
	end

	local wb = WordBox(frame, "Requesting account information...", "DefaultFontBold", color_white)
	wb:SetPos(8, 32)

	frame:SetSize(wb:GetWide() + 16, wb:GetTall() + 40)
	frame:Center()
	frame:SetVisible(true)
	frame:SetSkin("Default")
	frame:MakePopup()

	net.Start("nox_requestaccount")
		net.WriteEntity(pl)
	net.SendToServer()
end

local matStar = Material("icon16/star.png")
effects.Register({Init = function(self, data)
	local pl = data:GetEntity()

	if pl and pl:IsValid() then
		self.Entity:SetRenderBounds(Vector(-256, -256, -256), Vector(256, 256, 256))

		self.DieTime = CurTime() + 3
		self.Player = pl

		local vPos = pl:GetPos()
		vPos.z = vPos.z + pl:OBBMaxs().z + 16

		pl:EmitSound("weapons/physcannon/energy_disintegrate"..math.random(4, 5)..".wav", 100, pl:GetAlpha() * 0.392)
	else
		self.DieTime = 0
	end
end,

Think = function(self)
	return CurTime() < self.DieTime
end,

Render = function(self)
	local pl = self.Player
	if pl and pl:IsValid() then
		local pos = pl:GetPos()
		pos.z = pos.z + pl:OBBMaxs().z + 16

		local a = pl:GetAlpha() * math.min(1, math.max(0, (self.DieTime - CurTime()) * 0.5))

		local scale = pl:BoundingRadius() / 42.5
		local siz = math.abs(math.sin(RealTime() * 8)) * (255 - a) * 0.2

		render.SetMaterial(matStar)
		render.DrawSprite(pos, (32 + siz) * scale, (32 + siz) * scale, Color(255, 255, 255, a * 0.5))
		render.DrawSprite(pos, 32 * scale, 32 * scale, Color(255, 255, 255, a))
	end
end}, "noxgetaward")
