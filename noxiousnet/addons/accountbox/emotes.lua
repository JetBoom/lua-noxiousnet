function MakepEmotes()
	if pEmotes and pEmotes:IsValid() then
		pEmotes:SetVisible(true)
		return
	end

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetSkin("Default")
	frame:SetColor(Color(0, 0, 0, 220))
	frame:SetSize(500, 480)
	frame:Center()
	frame:SetDeleteOnClose(false)
	frame:SetVisible(true)
	frame:MakePopup()
	pEmotes = frame

	local dclickreminder = EasyLabel(frame, "Double click an emote to quickly try it out.")
	dclickreminder:Dock(TOP)
	dclickreminder:SetContentAlignment(8)

	local ListView = vgui.Create("DListView", frame)
	ListView:SetMultiSelect(false)
	ListView:Dock(FILL)
	ListView:AddColumn("Say this"):SetMinWidth(242)
	ListView:AddColumn("To get this")
	ListView.DoDoubleClick = function(me, id, line)
		if line.EmoteID then
			local soundtab = NDB.EmotesSounds[line.EmoteID]
			if soundtab and type(soundtab) == "table" then
				surface.PlaySound(soundtab[math.random(#soundtab)])
			else
				surface.PlaySound(soundtab)
			end
		elseif line.DynamicEmoteTrigger then
			NDB.PlayDynSound(line.DynamicEmoteSound, LocalPlayer())
		end
	end
	ListView.RefreshList = function(me, search)
		me:Clear(true)

		for i, emote in pairs(NDB.EmotesNames) do
			if NDB.EmotesSounds[i] and (not search or #search == 0 or string.find(emote, search, 1, true) ~= nil) then
				if type(NDB.EmotesSounds[i]) == "table" then
					me:AddLine(emote, table.concat(NDB.EmotesSounds[i], ", ")).EmoteID = i
				else
					me:AddLine(emote, NDB.EmotesSounds[i]).EmoteID = i
				end
			end
		end

		local line
		for trigger, filename in pairs(NDB.DynamicEmoteSounds) do
			line = me:AddLine(trigger, filename..".ogg")
			line.DynamicEmoteTrigger = trigger
			line.DynamicEmoteSound = filename
		end
	end
	ListView:RefreshList()

	ListView:SortByColumn(1)
	frame.ListView = ListView

	local searchbar = vgui.Create("DTextEntry", frame)
	searchbar:SizeToContents()
	searchbar:SetWide(frame:GetWide() - 80)
	searchbar:Dock(BOTTOM)
	searchbar.OnTextChanged = function(me)
		me:GetParent().ListView:RefreshList(me:GetValue())
	end

	frame:SetSkin("Default")
end
concommand.Add("noxlistemotes", MakepEmotes)
