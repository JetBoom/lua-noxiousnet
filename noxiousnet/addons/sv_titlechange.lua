concommand.Add("nox_titlechange", function(sender, command, arguments)
	if not sender:IsValid() or not sender:IsConnected() or not sender:IsValidAccountNotify() then return end

	if sender:GetTitleChangeCards() <= 0 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>You don't have any Title Change Cards!</red>")
		return
	end

	local target = NULL
	local id = tonumber(arguments[1]) or 0
	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			target = pl
			break
		end
	end

	if not target:IsValid() or not target:IsPlayer() or not target:IsValidAccountNotify() then return end

	--[[if target:IsSuperAdmin() then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Sysops can't have their title changed.</red>")
		return
	end]]

	local title = arguments[2] or ""
	if #title > 160 or #title <= 0 then return end

	if string.find(title, "<deffont", 1, true) then
		sender:PrintMessage(HUD_PRINTTALK, "<red>deffont can't be used in titles.</red>")
		return
	end

	title = "<white>[</white>"..title.."<white>]</white>"

	sender:SetTitleChangeCards(sender:GetTitleChangeCards() - 1)

	if target == sender then
		target:SetTitle(title)

		target:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> Your main title has been set to \""..title.."\"")
		target:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> <red>The title is also available at any time in your /buy menu!</red>")
	else
		local time = 60 * 60 * 24 * 30 -- One month

		PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> "..target:NoParseName().." will be sporting the title \""..title.."\" for the next 30 days, thanks to an anonymous donor!")
		target:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> <red>Please enjoy your new title! You can also find the title in your /buy menu inventory!</red>")

		if #target.Titles >= NDB.MaxTitles then
			table.insert(target.Titles, 1, title)
			table.insert(target.TitleExpirations, 1, os.time() + time)
			PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> Their \""..target.Titles[#target.Titles].."\" title has been removed to make room because they already had "..NDB.MaxTitles.." titles.")
			table.remove(target.Titles, #target.Titles)
			table.remove(target.TitleExpirations, #target.TitleExpirations)
		else
			table.insert(target.Titles, title)
			table.insert(target.TitleExpirations, os.time() + time)
		end
		target:SetKeyDirty("Titles")
		target:SetKeyDirty("TitleExpirations")
		target:UpdateTitles()
	end

	sender:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> You've used a title change card. You now have "..sender:GetTitleChangeCards().." title change card"..(sender:GetTitleChangeCards() == 1 and "" or "s").." left.")

	-- Put it in their title inventory.
	if not table.HasValue(target.SavedTitles, title) then
		table.insert(target.SavedTitles, title)
		target:SetKeyDirty("SavedTitles")
		target:UpdateSavedTitles()
	end

	target:UpdateDB()
	sender:UpdateDB()
end)

concommand.Add("nox_titlechange3d", function(sender, command, arguments)
	if not sender:IsValid() or not sender:IsConnected() then return end

	if sender:GetTitleChangeCards() <= 0 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>You don't have any Title Change Cards!</red>")
		return
	end

	local target = NULL
	local id = tonumber(arguments[1]) or 0
	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			target = pl
			break
		end
	end

	if not target:IsValid() or not target:IsPlayer() or not target:IsValidAccountNotify() then return end

	if target:IsSuperAdmin() and target ~= sender then
		target:PrintMessage(HUD_PRINTTALK, "<red>Sysops can't have their title changed.</red>")
		return
	end

	local title = arguments[2] or ""
	if #title > 64 or #title == 0 then return end

	if string.find(title, "<deffont", 1, true) then
		sender:PrintMessage(HUD_PRINTTALK, "<red>deffont can't be used in titles.</red>")
		return
	end

	sender:SetTitleChangeCards(sender:GetTitleChangeCards() - 1)
	target:SetPKV("Title3D", title)
	target:SetPKV("Title3DEnd", os.time() + 2592000)

	if target == sender then
		target:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> You've been given a 3D title for the next 30 days: \"<red>"..title.."</red>\"")
	else
		PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> "..target:Name().." was given a 3D title: \"<red>"..title.."</red>\" by an anonymous donor!")
		target:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> <red>Your 3D title is there for the next 30 days. Please enjoy your new title!</red>")
	end

	target:Update3DTitle()

	sender:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> You've used a title change card. You now have "..sender:GetTitleChangeCards().." title change card"..(sender:GetTitleChangeCards() == 1 and "" or "s").." left.")

	if not table.HasValue(target.Saved3DTitles, title) then
		table.insert(target.Saved3DTitles, title)
		target:SetKeyDirty("Saved3DTitles")
		target:UpdateSaved3DTitles()
	end

	target:UpdateDB()
	sender:UpdateDB()
end)

concommand.Add("nox_usesavedtitle", function(sender, command, arguments)
	if not sender:IsValid() or not sender:IsConnected() or not sender:IsValidAccountNotify() then return end

	local id = tonumber(arguments[1])
	if not id or not sender.SavedTitles[id] then return end

	sender:ChangeTitle(sender.SavedTitles[id])
end)

--[[concommand.Add("nox_usesaved3dtitle", function(sender, command, arguments)
	if not sender:IsValid() or not sender:IsConnected() or not sender:IsValidAccountNotify() then return end

	local id = tonumber(arguments[1])
	if not id or not sender.SavedTitles[id] then return end

	sender:Change3DTitle(sender.SavedTitles[id])
end)]]

hook.Add("Initialize", "MakeLoadingScreenChangeCommands", function()
	NDB.AddChatCommand("/changeintro", function(sender, text) sender:SendLua("MakepLoadingScreenChange()") return "" end, "Change the loading screen message")
end)

concommand.Add("nox_setloadingscreenmessage", function(sender, command, arguments)
	if not sender:IsValid() or not sender:IsConnected() or not sender:IsValidAccountNotify() then return end

	if sender:GetSilver() < 50000 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>You need 50,000 Silver to change the loading screen!</red>")
		return
	end

	local title = table.concat(arguments, " ")

	if #title > 80 or #title <= 0 then return end

	file.Write("loadingmessage.txt", title)
	file.Write("loadingmessageauthor.txt", sender:Name().." - "..sender:SteamID())

	sender:AddSilver(-50000)
	PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> <lg>"..sender:Name().."</lg> has changed the loading screen.")

	sender:UpdateDB()
end)
