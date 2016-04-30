local menu

local function CalcView(pl, origin, angles, fov, znear, zfar)
	if menu and menu:IsValid() then
		angles:RotateAroundAxis(angles:Up(), 180)

		local attachid = pl:LookupAttachment("eyes")
		if attachid and attachid > 0 then
			local attach = pl:GetAttachment(attachid)
			if attach and attach.Pos then
				origin = attach.Pos
			end
		end

		local view = {}
		view.origin = origin - angles:Forward() * 12
		view.angles = angles
		return view
	end

	hook.Remove("CalcView", "expressions")
end

local function ShouldDrawLocalPlayer(pl)
	if menu and menu:IsValid() then
		return true
	end

	hook.Remove("ShouldDrawLocalPlayer", "expressions")
end

function expressions:OpenMenu()
	if menu and menu:IsValid() then return end

	hook.Add("CalcView", "expressions", CalcView)
	hook.Add("ShouldDrawLocalPlayer", "expressions", ShouldDrawLocalPlayer)

	menu = vgui.Create("DEXRoundedFrame")
	menu:SetTitle("Expressions")
	menu:SetSize(300, 480)
	menu:SetDeleteOnClose(true)

	local panellist = vgui.Create("DScrollPanel", menu)
	panellist:Dock(FILL)

	local clearbutton = vgui.Create("DButton", menu)
	clearbutton:SetText("Reset expression")
	clearbutton:SizeToContents()
	clearbutton:SetTall(clearbutton:GetTall() + 8)
	clearbutton:Dock(BOTTOM)
	clearbutton:DockMargin(0, 16, 0, 0)
	clearbutton.DoClick = function()
		RunConsoleCommand("say", "/expression none")
	end

	for name in pairs(expressions.Expressions) do
		local button = vgui.Create("DButton", panellist)
		button:SetText(string.upper(name))
		button:SizeToContents()
		button:SetTall(button:GetTall() + 8)
		button:Dock(TOP)
		button:DockMargin(2, 2, 2, 2)

		button.DoClick = function()
			RunConsoleCommand("say", "/expression "..string.lower(name))
		end
	end

	menu:CenterVertical()
	menu:AlignLeft(32)
	menu:MakePopup()
end
