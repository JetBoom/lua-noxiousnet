--[[local conLastTitle = CreateClientConVar("nox_announcements_lasttitle", "0", true, false)
hook.Add("Initialize", "Announcements", function()
	http.Fetch("https://noxiousnet.com/latestnewstitle", function(contents, length, headers, returncode)
	if contents ~= "NULL" and not contents:find("<", 1, true) and length > 0 and conLastTitle:GetString() ~= contents then
		NEWNEWS = true

		RunConsoleCommand("nox_announcements_lasttitle", contents)
		timer.SimpleEx(60, function()
			chat.AddText(COLOR_WHITE, "<silkicon icon=newspaper size=200> <flash color=255,0,0 rate=5>BREAKING NEWS!</flash> "..contents.."  <news>")
			timer.CreateEx("newsblips", 0.1, 4, surface.PlaySound, "buttons/blip1.wav")
		end)
	end
end)
end)]]

function MakepNews()
	NEWNEWS = nil

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetSize(math.min(ScrW() - 32, 800), math.min(ScrH() - 32, 600))
	frame:Center()
	frame:SetTitle("Announcements")
	frame:SetDeleteOnClose(true)
	frame:SetVisible(true)
	pNews = frame

	local html = vgui.Create("DHTML", frame)
	html:StretchToParent(8, 24, 8, 8)
	html:OpenURL("https://noxiousnet.com/ingamenews")

	frame:SetSkin("Default")
	frame:MakePopup()
end
