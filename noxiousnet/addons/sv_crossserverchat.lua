hook.Add("Initialize", "InitializeCSC", function()
	NDB.AddChatCommand("/csc", function(sender, text)
		if sender:IsPunishedNotify(PUNISHMENT_MUTE) or sender:IsPunishedNotify(PUNISHMENT_NOCSC) or GAMEMODE.PlayerCanCSC and not gamemode.Call("PlayerCanCSC", sender) then return end

		local message = string.match(text, "/csc%s(.+)")
		if not message then return "" end
		message = string.Trim(message)
		if #message == 0 then return "" end

		if sender:CheckChatSpamming() then return "" end

		sender.LastChat = SysTime() + 1

		NDB.LogLine("<"..sender:SteamID().."> "..sender:Name().." sent a CSC message: "..message)

		opensocket.Broadcast("PrintMessage", "<lightblue>[CSC]</lightblue> "..sender:NoParseName()..": "..message, true)

		local ip = sender:IPAddress()
		ip = string.match(ip, "(.+):") or ip
		webchat.Add(message, sender:Name(), ip)

		return ""
	end, "Sends a message to every NoXiousNet server.")
end)
