function MakepRules()
	if pRules and pRules:IsValid() then
		return
	end

	local wid, hei = 500, 470

	local Window = vgui.Create("DEXRoundedFrame")
	Window:SetSkin("Default")
	Window:SetColor(Color(0, 0, 0, 220))
	Window:SetSize(wid, hei)
	Window:SetTitle("Server Rules")
	Window:SetDeleteOnClose(true)
	Window:SetKeyboardInputEnabled(false)
	pRules = Window

	local closebutton = EasyButton(Window, "Accept and close", 8, 4)
	closebutton:SetPos(wid * 0.5 - closebutton:GetWide() * 0.5, hei - closebutton:GetTall() - 8)
	closebutton.DoClick = function(btn)
		btn:GetParent():Remove()
	end

	local htmlpanel = vgui.Create("DHTML", Window)
	htmlpanel:SetSize(wid - 8, hei - 48 - closebutton:GetTall())
	htmlpanel:SetPos(4, 32)
	htmlpanel:SetHTML(NDB.ServerRules)

	Window:Center()
	Window:SetSkin("Default")
	Window:SetVisible(true)
	Window:MakePopup()
end
