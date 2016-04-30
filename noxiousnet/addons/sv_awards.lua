function NDB.GiveAward(pl, str)
	if not (pl:IsPlayer() and pl:IsConnected()) then return end

	if pl:IsPunished(PUNISHMENT_NOAWARDS) then return end

	table.insert(pl.Awards, str)

	pl:SetKeyDirty("Awards")

	local silver = 1000
	local toaddlower = string.lower(str)
	for awardname, awardtab in pairs(NDB.Awards) do
		local lowername = string.lower(awardname)

		if toaddlower == lowername then
			if AWARDS_DIFFICULTY_HARDEST then
				silver = 5000
			elseif AWARDS_DIFFICULTY_HARD then
				silver = 2000
			end

			break
		end
	end

	pl:AddSilver(silver, true)

	PrintMessage(HUD_PRINTTALK, "<red>"..pl:Name().."</red> has been given the <red>"..string.upper(string.Replace(str, "_", " ")).."</red> award and "..string.CommaSeparate(silver).." Silver!!")
	NDB.LogLine("<"..pl:SteamID().."> "..pl:Name().." was given the <"..str.."> award.")

	local effectdata = EffectData()
		effectdata:SetEntity(pl)
		effectdata:SetOrigin(pl:EyePos())
	util.Effect("noxgetaward", effectdata, true, true)

	pl:UpdateDB()
end

hook.Add("DoPlayerDeath", "darkfall", function(pl, attacker, dmginfo)
	if pl:IsBot() then return end

	if pl.Created and CurTime() <= pl.Created + 1 and attacker ~= pl and not pl:HasAward("darkfall") then
		pl:GiveAward("darkfall")
	end
end)

--[[local awds = {}

concommand.Add("_getaward", function(sender, command, arguments)
	if sender:IsValidAccountNotify() then
		local id = arguments[1]
		if awds[id] and awds[id](sender, command, arguments) then
			NDB.GiveAward(sender, id)
		end
	end
end)]]
