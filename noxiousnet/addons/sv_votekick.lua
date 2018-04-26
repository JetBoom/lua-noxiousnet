NDB.KickVotesFor = {}
NDB.BanVotesFor = {}
NDB.KickVotedAlready = {}
NDB.BanVotedAlready = {}

NDB.VoteBanIsLocked = false

hook.Add("Initialize", "AddVoteKickChatCommands", function()
	NDB.AddChatCommand("/lockvoting", function(sender, command, arguments)
		if not sender:IsModerator() then return end

		NDB.VoteBanIsLocked = not NDB.VoteBanIsLocked

		PrintMessage(HUD_PRINTTALK, "<red>"..sender:Name().." has "..(NDB.VoteBanIsLocked and "" or "un").."locked vote kicking.</red>")

		return ""
	end, "Lock or unlock kick voting.", true)

	NDB.AddChatCommand("/resetvoting", function(sender, command, arguments)
		if not sender:IsModerator() then return end

		NDB.KickVotedAlready = {}
		NDB.KickVotesFor = {}
		NDB.BanVotedAlready = {}
		NDB.BanVotesFor = {}

		PrintMessage(HUD_PRINTTALK, "<red>"..sender:Name().." has reset all kick votes.</red>")

		return ""
	end, "Reset all kick votes.", true)
end)

NDB.AddChatCommand("/votekick", function(sender, text)
	sender:PrintMessage(HUD_PRINTTALK, "<red>Votekick and voteban is disabled. Use /admin to fetch an admin.</red>")
	--[[if sender:IsPunishedNotify(PUNISHMENT_NOVOTES) then return end

	local curtime = CurTime()
	if sender.NextVoteKickBan and sender.NextVoteKickBan > curtime then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait ".. math.ceil(sender.NextVoteKickBan - curtime) .." more seconds before voting to kick or ban someone again.")
		return ""
	end

	local allplayers = player.GetAll()
	if #allplayers < 6 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Vote kick is disabled while less than 6 people in the server.</red>")
		return ""
	end

	if NDB.VoteBanIsLocked then
		for _, pl in pairs(allplayers) do
			if pl:IsModerator() then
				sender:PrintMessage(HUD_PRINTTALK, "<red>A moderator is present and has locked vote kicking.</red>")
				return ""
			end
		end
	end

	if GAMEMODE.VoteKickDisabled then
		sender:PrintMessage(HUD_PRINTTALK, "<red>This gamemode has vote kicking disabled.</red>")
		return ""
	end

	text = string.sub(text, 11)

	if text == "" then
		sender:SendLua("OpenVoteKick()")
	else
		text = string.lower(text)
		for _, pl in pairs(allplayers) do
			if string.lower(pl:Name()) == text then
				sender:ConCommand("votekick "..pl:Name())
				return ""
			end
		end
	end

	return ""]]
end, " <name> - Vote to kick a player.")

NDB.AddChatCommand("/voteban", function(sender, text)
	sender:PrintMessage(HUD_PRINTTALK, "<red>Votekick and voteban is disabled. Use /admin to fetch an admin.</red>")
	--[[if sender:IsPunishedNotify(PUNISHMENT_NOVOTES) then return end

	local curtime = CurTime()
	if sender.NextVoteKickBan and sender.NextVoteKickBan > curtime then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait ".. math.ceil(sender.NextVoteKickBan - curtime) .." more seconds before voting to kick or ban someone again.")
		return ""
	end

	local allplayers = player.GetAll()
	if #allplayers < 6 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Vote ban is disabled while less than 6 people in the server.</red>")
		return ""
	end

	if NDB.VoteBanIsLocked then
		for _, pl in pairs(allplayers) do
			if pl:IsModerator() then
				sender:PrintMessage(HUD_PRINTTALK, "<red>A moderator is present and has locked vote banning.</red>")
				return ""
			end
		end
	end

	if GAMEMODE.VoteBanDisabled then
		sender:PrintMessage(HUD_PRINTTALK, "<red>This gamemode has vote banning disabled.</red>")
		return ""
	end

	text = string.sub(text, 10)

	if text == "" then
		sender:SendLua("OpenVoteKick(true)")
	else
		text = string.lower(text)
		for _, pl in pairs(allplayers) do
			if string.lower(pl:Name()) == text then
				sender:ConCommand("voteban "..pl:Name())
				return ""
			end
		end
	end

	return ""]]
end, " <name> - Vote to ban a player.")

concommand.Add("votekick", function(sender, command, arguments)
	--[[if sender:IsPunishedNotify(PUNISHMENT_NOVOTES) then return end

	local curtime = CurTime()
	if sender.NextVoteKickBan and sender.NextVoteKickBan > curtime then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait ".. math.ceil(sender.NextVoteKickBan - curtime) .." more seconds before voting to kick or ban someone again.")
		return
	end

	local allplayers = player.GetAll()
	local numplayers = #allplayers
	if numplayers <= 5 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Vote kick is disabled while less than 6 people in the server.</red>")
		return
	end

	if NDB.VoteBanIsLocked then
		for _, pl in pairs(allplayers) do
			if pl:IsModerator() then
				sender:PrintMessage(HUD_PRINTTALK, "<red>A moderator is present and has locked vote kicking.</red>")
				return
			end
		end
	end

	if GAMEMODE.VoteKickDisabled then
		sender:PrintMessage(HUD_PRINTTALK, "<red>This gamemode has votekick disabled.</red>")
		return
	end

	arguments = table.concat(arguments, " ")

	local sendersteam = sender:SteamID()

	local target

	if tonumber(arguments) then
		for _, pl in pairs(allplayers) do
			if not pl:IsBot() and not pl:IsAdmin() and pl:AccountNumber() == arguments then
				target = pl
				break
			end
		end
	else
		for _, pl in pairs(allplayers) do
			if not pl:IsBot() and not pl:IsAdmin() and pl:Name() == arguments then
				target = pl
				break
			end
		end
	end

	if target then
		if target:IsModerator() then
			sender:PrintMessage(HUD_PRINTTALK, "<red>You can't vote to kick moderators or admins.</red>")
			return
		end

		if target == sender then
			sender:PrintMessage(HUD_PRINTTALK, "<red>You can't vote to kick yourself.</red>")
			return
		end

		local targetsteam = target:SteamID()
		local votealreadystr = sendersteam.."votekicked"..targetsteam
		if NDB.KickVotedAlready[votealreadystr] then
			sender:PrintMessage(HUD_PRINTTALK, "<yellow>You already voted to kick "..target:Name()..".</yellow>")
		else
			sender.NextVoteKickBan = curtime + 30
			NDB.KickVotedAlready[votealreadystr] = true
			NDB.KickVotesFor[targetsteam] = NDB.KickVotesFor[targetsteam] or 0
			NDB.KickVotesFor[targetsteam] = NDB.KickVotesFor[targetsteam] + 1
			local total = NDB.KickVotesFor[targetsteam]
			NDB.LogLine("<"..sendersteam.."> "..sender:Name().." voted to kick <"..targetsteam.."> "..target:Name())
			if total >= 20 or total >= numplayers * 0.75 then
				PrintMessage(HUD_PRINTTALK, sender:NoParseName().." <red>voted to kick</red> "..target:NoParseName()..". <flash color=30,255,30 rate=6>VOTE PASSES</flash>.")
				NDB.LogLine("<"..targetsteam.."> "..target:Name().." was VOTEKICKED by "..total.." people")

				if gatekeeper then
					gatekeeper.Drop(target:UserID(), "Votekicked by "..total.." people.")
				else
					local concom = "kickid "..targetsteam.." Votekicked by "..total.." people.\n"
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
					game.ConsoleCommand(concom)
				end

				NDB.KickVotesFor[targetsteam] = nil
				local entry = "votekicked"..targetsteam
				for k, v in pairs(NDB.KickVotedAlready) do
					if string.find(k, entry, 1, true) then
						NDB.KickVotedAlready[k] = nil
					end
				end
			else
				PrintMessage(HUD_PRINTTALK, sender:NoParseName().." <red>voted to kick</red> "..target:NoParseName()..". Say /votekick to participate. "..math.ceil(math.min(20, numplayers * 0.75) - total).." more votes are needed.")
			end
		end
	else
		sender:PrintMessage(HUD_PRINTTALK, "<red>Player not found.</red>")
	end]]
end)

concommand.Add("voteban", function(sender, command, arguments)
	--[[if sender:IsPunishedNotify(PUNISHMENT_NOVOTES) then return end

	local curtime = CurTime()
	if sender.NextVoteKickBan and sender.NextVoteKickBan > curtime then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait ".. math.ceil(sender.NextVoteKickBan - curtime) .." more seconds before voting to kick or ban someone again.")
		return
	end

	local allplayers = player.GetAll()
	local numplayers = #allplayers
	if numplayers <= 5 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Vote ban is disabled while less than 6 people in the server.</red>")
		return
	end

	if NDB.VoteBanIsLocked then
		for _, pl in pairs(allplayers) do
			if pl:IsModerator() then
				sender:PrintMessage(HUD_PRINTTALK, "<red>A moderator is present and has locked vote banning.</red>")
				return
			end
		end
	end

	if GAMEMODE.VoteBanDisabled then
		sender:PrintMessage(HUD_PRINTTALK, "<red>This gamemode has voteban disabled.</red>")
		return
	end

	arguments = table.concat(arguments, " ")

	local sendersteam = sender:SteamID()

	local target

	if tonumber(arguments) then
		for _, pl in pairs(allplayers) do
			if not pl:IsBot() and not pl:IsAdmin() and pl:AccountNumber() == arguments then
				target = pl
				break
			end
		end
	else
		for _, pl in pairs(allplayers) do
			if not pl:IsBot() and not pl:IsAdmin() and pl:Name() == arguments then
				target = pl
				break
			end
		end
	end

	if target then
		if target:IsModerator() then
			sender:PrintMessage(HUD_PRINTTALK, "<red>You can't vote to ban moderators or admins.</red>")
			return
		end

		if target == sender then
			sender:PrintMessage(HUD_PRINTTALK, "<red>You can't vote to ban yourself.</red>")
			return
		end

		local targetsteam = target:SteamID()
		local votealreadystr = sendersteam.."votebanned"..targetsteam
		if NDB.BanVotedAlready[votealreadystr] then
			sender:PrintMessage(HUD_PRINTTALK, "<yellow>You already voted to ban "..target:Name()..".</yellow>")
		else
			sender.NextVoteKickBan = curtime + 30
			NDB.BanVotedAlready[votealreadystr] = true
			NDB.BanVotesFor[targetsteam] = NDB.BanVotesFor[targetsteam] or 0
			NDB.BanVotesFor[targetsteam] = NDB.BanVotesFor[targetsteam] + 1
			local total = NDB.BanVotesFor[targetsteam]
			NDB.LogLine("<"..sendersteam.."> "..sender:Name().." voted to ban <"..targetsteam.."> "..target:Name())
			if 20 <= total or numplayers * 0.75 <= total then
				PrintMessage(HUD_PRINTTALK, sender:NoParseName().." <red>voted to ban</red> "..target:NoParseName().." for an hour. <flash color=30,255,30 rate=6>VOTE PASSES</flash>.")
				NDB.LogLine("<"..targetsteam.."> "..target:Name().." was VOTEBANNED by "..total.." people for 1 hour")
				NDB.InstantBan(target, "VOTEBANNED by "..total.." people", 60, "Democracy")

				NDB.BanVotesFor[targetsteam] = nil
				local entry = "votebanned"..targetsteam
				for k, v in pairs(NDB.BanVotedAlready) do
					if string.find(k, entry, 1, true) then
						NDB.BanVotedAlready[k] = nil
					end
				end
			else
				PrintMessage(HUD_PRINTTALK, sender:NoParseName().." <red>voted to ban</red> "..target:NoParseName().." for an hour. Say /voteban to participate. "..math.ceil(math.min(20, numplayers * 0.75) - total).." more votes are needed.")
			end
		end
	else
		sender:PrintMessage(HUD_PRINTTALK, "<red>Player not found.</red>")
	end]]
end)
