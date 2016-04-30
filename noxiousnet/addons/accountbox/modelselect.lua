local function SwitchPlayerModel(self)
	surface.PlaySound("buttons/button14.wav")
	RunConsoleCommand("cl_playermodel", self.m_ModelName)
	chat.AddText(COLOR_LIMEGREEN, "You've changed your desired player model to "..tostring(self.m_ModelName))

	self.Frame:Close()
end

function MakepModelSelect()
	local numcols = 8
	local wid = numcols * 68 + 24
	local hei = 472

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetColor(Color(0, 0, 0, 220))
	frame:SetTitle("Player model selection")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetDeleteOnClose(true)

	local list = vgui.Create("DPanelList", frame)
	list:StretchToParent(8, 24, 8, 8)
	list:EnableVerticalScrollbar()

	local grid = vgui.Create("DGrid", frame)
	grid:SetCols(numcols)
	grid:SetColWide(68)
	grid:SetRowHeight(68)
	
	for name, mdl in pairs(player_manager.AllValidModels()) do
		local button = vgui.Create("SpawnIcon", grid)
		button:SetPos(0, 0)
		button:SetModel(mdl)
		button.m_ModelName = name
		button.OnMousePressed = SwitchPlayerModel
		button.Frame = frame
		grid:AddItem(button)
	end
	grid:SetSize(wid - 16, math.ceil(table.Count(player_manager.AllValidModels()) / numcols) * grid:GetRowHeight())

	list:AddItem(grid)

	list:AddItem(EasyLabel(list, "Player color"))

	local colpicker = vgui.Create("DColorMixer", list)
	colpicker:SetAlphaBar(false)
	colpicker:SetPalette(false)
	colpicker.UpdateConVars = function(me, color)
		me.NextConVarCheck = SysTime() + 0.2
		RunConsoleCommand("cl_playercolor", color.r / 100 .." ".. color.g / 100 .." ".. color.b / 100)
	end
	local r, g, b = string.match(GetConVarString("cl_playercolor"), "(%g+) (%g+) (%g+)")
	if r then
		colpicker:SetColor(Color(r * 100, g * 100, b * 100))
	end
	colpicker:SetTall(72)
	list:AddItem(colpicker)

	list:AddItem(EasyLabel(list, "Weapon color"))

	local colpicker = vgui.Create("DColorMixer", list)
	colpicker:SetAlphaBar(false)
	colpicker:SetPalette(false)
	colpicker.UpdateConVars = function(me, color)
		me.NextConVarCheck = SysTime() + 0.2
		RunConsoleCommand("cl_weaponcolor", color.r / 100 .." ".. color.g / 100 .." ".. color.b / 100)
	end
	local r, g, b = string.match(GetConVarString("cl_weaponcolor"), "(%g+) (%g+) (%g+)")
	if r then
		colpicker:SetColor(Color(r * 100, g * 100, b * 100))
	end
	colpicker:SetTall(72)
	list:AddItem(colpicker)

	frame:SetSkin("Default")
	frame:MakePopup()

	return frame
end
