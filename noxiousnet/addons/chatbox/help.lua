local pHelp

function NNChat.OpenHelp()
	if NNChat.ChatFrame then
		NNChat.ChatFrame:Close()
	end

	if pHelp and pHelp:IsValid() then
		pHelp:Remove()
	end

	--local wid, hei = 500, 480
	local wid, hei = math.min(ScrW(), 620), math.min(ScrH(), 550)

	pHelp = vgui.Create("DEXRoundedFrame")
	pHelp:SetSkin("Default")
	pHelp:SetSize(wid, hei)
	pHelp:SetTitle("Markup tags list - "..#NNChat.Parsers.." available tags to use")
	pHelp:SetDeleteOnClose(true)

	local list = vgui.Create("DScrollPanel", pHelp)
	list:Dock(FILL)

	local heading = vgui.Create("DEXRoundedPanel", list)
	heading:SetTall(32)
	heading:Dock(TOP)
	heading:DockMargin(0, 4, 0, 16)

	local h1 = vgui.Create("DLabel", heading)
	h1:SetFont("dexfont_med")
	h1:SetText("Parser")
	h1:SetTextColor(color_white)
	h1:SizeToContents()
	h1:SetWide(wid / 5)
	h1:SetContentAlignment(5)
	h1:Dock(LEFT)

	local h2 = vgui.Create("DLabel", heading)
	h2:SetFont("dexfont_med")
	h2:SetText("Example")
	h2:SetTextColor(color_white)
	h2:SizeToContents()
	h2:SetWide(wid * (2 / 5))
	h2:SetContentAlignment(5)
	h2:Dock(LEFT)

	local h3 = vgui.Create("DLabel", heading)
	h3:SetFont("dexfont_med")
	h3:SetText("Result")
	h3:SetTextColor(color_white)
	h3:SizeToContents()
	h3:SetContentAlignment(5)
	h3:Dock(FILL)

	for _, parsertab in pairs(NNChat.Parsers) do
		local desc = parsertab.ParserDesc or ""

		local row = vgui.Create("Panel", list)

		local name = vgui.Create("DLabel", row)
		name:SetFont("DefaultFontBold")
		name:SetText(parsertab.ParserName)
		name:SetTextColor(color_white)
		name:SizeToContents()
		name:SetWide(wid / 5)
		name:SetContentAlignment(8)
		name:Dock(LEFT)

		local plain = vgui.Create("DLabel", row)
		plain:SetFont("DefaultFont")
		plain:SetText(desc)
		plain:SetTextColor(color_white)
		plain:SizeToContents()
		plain:SetWide(wid * (3 / 5))
		plain:SetContentAlignment(8)
		plain:Dock(LEFT)

		local preview = NNChat.CreateChatPanel(LocalPlayer():EntIndex(), desc, color_white, CHAT_DEFAULT_FONT, wid / 5)
		if preview then
			preview:SetParent(row)
			preview:Dock(RIGHT)
		end

		row:SetTall(math.max(name:GetTall(), plain:GetTall(), preview and preview:GetTall() or 1))
		row:Dock(TOP)
		row:DockMargin(0, 0, 0, 12)
	end

	pHelp:Center()
	pHelp:MakePopup()
end
