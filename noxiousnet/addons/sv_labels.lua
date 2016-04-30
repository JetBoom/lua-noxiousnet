hook.Add("PlayerDisconnected", "Labels.PlayerDisconnected", function(pl)
	local userid = pl:UserID()
	for _, ent in ipairs(ents.FindByClass("point_3d2dlabel")) do
		if ent:GetOwnerUserID() == userid then
			ent:Remove()
		end
	end
end)

local forbidden = {"<sound", "<model", "<wiki", "<f1>", "<f2>", "<f3>", "<f4>", "<news>", "<spoiler>", "<help>"}
timer.SimpleEx(0, function()
	NDB.AddChatCommand("/label", function(sender, text)
		if not sender:IsValid() or not sender:Alive() or sender:IsMuted() or not text then return "" end

		local maxlabels = NDB.MemberMaxLabels[sender:GetMemberLevel()] or 0
		if maxlabels <= 0 then
			sender:PrintMessage(HUD_PRINTTALK, "<defc=255,0,0>Only Gold Members and Diamond Members can use /label.")
			return ""
		end

		text = string.match(text, "/label%s(.+)")
		if not text or #text == 0 then return "" end
		local lowertext = string.lower(text)
		for k, v in pairs(forbidden) do
			if string.find(lowertext, v, 1, true) then
				sender:PrintMessage(HUD_PRINTTALK, "<red>\""..v.."\" can't be used in labels.</red>")
				return ""
			end
		end

		if GAMEMODE.PlayerCanUse3DLabel and not GAMEMODE:PlayerCanUse3DLabel(sender) then return "" end

		local eyepos = sender:EyePos()
		local filt
		if sender:IsAdmin() then
			filt = sender
		else
			filt = player.GetAll()
		end

		local tr = util.TraceLine({start = eyepos, endpos = eyepos + sender:GetAimVector() * 64, filter = filt, mask = MASK_SOLID})
		local trent = tr.Entity
		if not tr.Hit or tr.HitSky or tr.HitMaterial == MAT_CLIP or trent and trent:IsValid() and trent.CanBeLabeled and not trent:CanBeLabeled(sender) then return "" end

		local userid = sender:UserID()

		local mine = {}
		local count = 0
		for _, ent in ipairs(ents.FindByClass("point_3d2dlabel")) do
			if ent:GetOwnerUserID() == userid then
				count = count + 1
				mine[#mine + 1] = ent
			end
		end
	
		if count >= maxlabels then
			for i=0, count - maxlabels do
				mine[i + 1]:Remove()
			end
		end

		local ent = ents.Create("point_3d2dlabel")
		if ent:IsValid() then
			ent:SetPos(tr.HitPos + tr.HitNormal * 0.05)
			local ang = tr.HitNormal:Angle()
			ang:RotateAroundAxis(ang:Right(), 270)
			ang:RotateAroundAxis(ang:Up(), 90)
			ent:SetAngles(ang)
			ent:SetOwnerUserID(userid)
			ent:SetText(text)
			ent:Spawn()

			ent:EmitSound("weapons/ar2/ar2_reload_push.wav", 30, 150)

			if trent and trent:IsValid() then
				ent:SetOwner(trent)
				ent:SetParent(trent)
				ent:SetParentPhysNum(tr.HitBone or 0)
			end

			PrintMessage(HUD_PRINTCONSOLE, "<"..sender:SteamID().."> "..sender:Name().." created a 3D label: "..text)
		end

		return ""
	end, "Creates a 3D label in the world.")

	NDB.AddChatCommand("/removelabels", function(sender)
		if not sender:IsValid() then return "" end

		local userid = sender:UserID()
		for _, ent in ipairs(ents.FindByClass("point_3d2dlabel")) do
			if ent:GetOwnerUserID() == userid then
				ent:Remove()
			end
		end

		return ""
	end, "Removes all of your 3D labels.")
end)
