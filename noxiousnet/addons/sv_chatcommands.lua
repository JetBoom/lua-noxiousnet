NDB.ChatCommands = {}

function NDB.AddChatCommand(text, func, help, perfect, nonpositional)
	if text and func then
		table.insert(NDB.ChatCommands, {Text = text, Callback = func, Help = help, Perfect = perfect, NonPositional = nonpositional})
	end
end

function NDB.AddPublicChatCommand(in_say, out_func, help, perfect, hidden, anyspot)
	return NDB.AddChatCommand(in_say, out_func, help, perfect, anyspot)
end

function NDB.AddPrivateChatCommand(in_say, out_func, help, perfect, hidden, anyspot)
	return NDB.AddChatCommand(in_say, out_func, perfect, anyspot, help)
end

local function howdoi(sender, text)
	if sender:IsValid() and not sender.m_ReceivedHowDoIHelp then
		sender.m_ReceivedHowDoIHelp = true
		sender:PrintMessage(HUD_PRINTTALK, "<pink>[HINT]</pink> Press <lg>F1</lg> for a gamemode's help menu or click here: <f1>.")
	end
end
NDB.AddChatCommand("how do i", howdoi, nil, nil, true, true)
NDB.AddChatCommand("how do you", howdoi, nil, nil, true, true)
NDB.AddChatCommand("how do u", howdoi, nil, nil, true, true)

local function titlechange(sender, text)
	sender:SendLua("MakepTitleChange(LocalPlayer())")

	return ""
end
NDB.AddChatCommand("/title", titlechange)
NDB.AddChatCommand("/titlechange", titlechange)
NDB.AddChatCommand("/changetitle", titlechange)

local function SteamGroup(sender)
	sender:SendLua("gui.OpenURL(\"http://steamcommunity.com/groups/noxiousnet\")")

	return ""
end
NDB.AddChatCommand("/join", SteamGroup)
NDB.AddChatCommand("/steamgroup", SteamGroup)

NDB.AddChatCommand("/cointoss", function(sender, text)
	if sender:IsValid() and sender:IsModerator() then
		PrintMessage(HUD_PRINTTALK, sender:NoParseName().." flipped a coin and it turned up "..(math.Rand(-1, 1) > 0 and "heads" or "tails").."!")
		return ""
	end
end)

NDB.AddChatCommand("/ping", function(sender, text)
	if sender:IsValid() then
		sender:PrintMessage(HUD_PRINTTALK, "Ping: "..sender:Ping().."ms   Packet Loss: "..sender:PacketLoss())
		return ""
	end
end)

--[[NDB.AddChatCommand("/broadcast", function(sender, text)
	if sender:IsValid() and sender:IsAdmin() and text then
		text = string.match(text, "/broadcast%s(.+)")
		if text and #text > 0 then
			opensocket.Broadcast("PrintMessage", text, true)
			webchat.Add(string.Replace(text, "\"", "'"))
		end
	end

	return ""
end)]]

local function RTV(sender, text)
	sender:PrintMessage(HUD_PRINTTALK, "<red>You'll play this map and like it, fucker.</red>")
end
NDB.AddChatCommand("rtv", RTV)
NDB.AddChatCommand("!rtv", RTV)
NDB.AddChatCommand("/rtv", RTV)

NDB.AddChatCommand("/subway", function(sender, text)
	sender:SendLua("gui.OpenURL(\"https://order.subway.com/Stores/Find.aspx?pid=1#pg1\")")

	return ""
end)

--[[NDB.AddChatCommand("/css", function(sender, text)
	sender:SendLua("gui.OpenURL(\"http://www.noxiousnet.com/forums/index.php?topic=20384.0\")")

	return ""
end)

NDB.AddChatCommand("/fps", function(sender, text)
	sender:SendLua("gui.OpenURL(\"http://www.noxiousnet.com/forums/index.php?topic=20394.0\")")

	return ""
end)]]

NDB.AddChatCommand("/roll", function(sender, text)
	text = string.match(text, "/roll%s(.*)")
	if not text or #text == 0 then return "" end

	local dice, sides
	local a, b = string.match(text, "(%d+)[dD](%d+)")
	if a then
		dice = tonumbersafe(a)
		sides = tonumbersafe(b)
	else
		local num = tonumbersafe(text)
		if not num then return "" end

		dice = 1
		sides = num
	end

	if not dice or not sides then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Format for rolling dice is ndn or #</red>")
		return ""
	end

	dice = math.Clamp(math.ceil(dice), 1, 32)
	sides = math.Clamp(math.ceil(sides), 1, 10000)

	local total = 0
	for i=1, dice do
		total = total + math.random(sides)
	end

	local msg = sender:NoParseName().." rolled a "..dice.."d"..sides..". It came up as "..total.."."
	if sender:IsMuted() then
		sender:PrintMessage(HUD_PRINTTALK, msg)
	else
		PrintMessage(HUD_PRINTTALK, msg)
	end

	return ""
end)

local NextRoll = {}
local function RTD(sender, text)
	if not sender:IsValidAccountNotify() then return "" end

	local nr = NextRoll[sender:UniqueID()]
	if nr and CurTime() < nr then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait "..math.ceil(nr - CurTime()).." more seconds before rolling the dice again.")
		return ""
	end
	NextRoll[sender:UniqueID()] = CurTime() + 600

	local result = math.random(8)
	local resulttext = ""
	if result == 1 then
		resulttext = "will receive bad luck for the next few weeks"
	elseif result == 2 and sender:Alive() then
		resulttext = "died"

		sender:TakeDamage(1000, game.GetWorld())
	elseif result == 3 and sender:Alive() then
		resulttext = "had an aneurysm"

		sender:Kill()
	elseif result == 4 then
		resulttext = "lost 1000 silver"

		sender:AddSilver(-1000)
	elseif result == 5 then
		resulttext = "became an odd color"

		local col = sender:GetColor()
		col.r = math.random(50, 255)
		col.g = math.random(50, 255)
		col.b = math.random(50, 255)
		sender:SetColor(col)
	elseif result == 6 then
		resulttext = "repented for all of their sins"
	elseif result == 7 then
		resulttext = "became an asian living in Jersey"

		sender:SendLua([[timer.CreateEx("lol", 0.5, 0, function() for i=1, 10 do surface.PlaySound("speach/go.wav") end end)]])
	else
		resulttext = "received nothing"
	end

	PrintMessage(HUD_PRINTTALK, sender:NoParseName().." rolled the dice. They "..resulttext.."!")

	return ""
end
NDB.AddChatCommand("/rtd", RTD)
NDB.AddChatCommand("!rtd", RTD)

NDB.AddChatCommand("/message", function(sender, text)
	if sender:IsValid() and sender:IsModerator() and text then
		text = string.match(text, "/message%s(.+)")
		if text and #text > 0 then
			PrintMessage(HUD_PRINTTALK, text)
		end
	end

	return ""
end)

local function CC_Admin(sender, text)
	if not sender:IsValid() or not text then return "" end

	text = string.match(text, "/admin%s(.+)")
	if not text then return end

	local msg = "<c=255,0,255>[TO ADMINS]</c> "..sender:SteamID().." | "..sender:NoParseName()..": "..text

	--[[opensocket.Broadcast("MessageToAdmins", msg, true)
	if not sender:IsModerator() then
		file.Write("lastadminmessagesender.txt", sender:SteamID())
	end]]

	for _, pl in pairs(player.GetAll()) do
		if pl:IsModerator() then
			pl:PrintMessage(HUD_PRINTTALK, msg)
		end
	end

	return ""
end

--[[local function CC_AdminReply(sender, text)
	if not sender:IsValid() or not sender:IsModerator() or not text then return "" end

	text = string.match(text, "/adminreply%s(.+)")
	if not text then return "" end

	if not file.Exists("lastadminmessagesender.txt", "DATA") then
		sender:PrintMessage(HUD_PRINTTALK, "<red>Nobody has sent a message recently...</red>")
		return ""
	end

	opensocket.Broadcast("MessageToPlayer", file.Read("lastadminmessagesender.txt", "DATA").."§<purple>[ADMIN PM]</purple> <flashhsv>(NN)</flashhsv> <lg>"..sender:NoParseName().."</lg>: "..text, true)

	return ""
end]]

local function CC_AdminPM(sender, text)
	if not sender:IsValid() or not sender:IsModerator() or not text then return "" end

	local steamid, msg = string.match(text, "/adminpm%s(.-)%s(.+)")
	if not steamid then return "" end

	msg = "<purple>[ADMIN PM]</purple> <flashhsv>(NN)</flashhsv> <lg>"..sender:Name().."</lg>: "..msg

	sender:PrintMessage(HUD_PRINTTALK, msg)

	--opensocket.Broadcast("MessageToPlayer", steamid.."§"..msg, true)

	for _, pl in pairs(player.GetAll()) do
		if pl:SteamID() == steamid then
			pl:PrintMessage(HUD_PRINTTALK, msg)
			print("Message to "..pl:Name()..": "..msg)
			break
		end
	end

	return ""
end

hook.Add("Initialize", "InitializeAdminChatCommand", function()
	NDB.AddChatCommand("/admin", CC_Admin, "Sends an unlogged message to any admins on the server.") --NDB.AddChatCommand("/admin", CC_Admin, "Sends an unlogged message to any admins in the entire network.")
	--NDB.AddChatCommand("/adminreply", CC_AdminReply, "Replies with a private message to the last non-admin that sent an admin message.")
	NDB.AddChatCommand("/adminpm", CC_AdminPM, "Sends a PM to <steamid>.")
end)

NDB.AddChatCommand("/awards", function(sender)
	sender:SendLua("NDB.ViewAllAwards()")

	return ""
end, "Lists all awards.")

NDB.AddChatCommand("/claim", function(sender, text)
	if not sender:IsValidAccountNotify() or not text then return "" end
	text = string.match(text, "/claim%s(.+)")
	if not text or string.len(text) <= 0 then return "" end

	if text == "tribes" or text == "tribesrpg" then
		if not rawio then
			sender:PrintMessage(HUD_PRINTTALK, "This promotion has expired.")
		elseif sender:HasFlag("promo_tribesrpg") then
			sender:PrintMessage(HUD_PRINTTALK, "You've already claimed your prize for this promotion. \"Caster Hands\" should be available in the shop menu.")
		elseif util.tobool(rawio.readfile("C:/dynamix/tribes/temp/trash "..string.Explode(":", string.gsub(sender:IPAddress(), "%.", "_"))[1]..".txt")) then
			sender:AddFlag("promo_tribesrpg")
			sender:PrintMessage(HUD_PRINTTALK, "You have claimed your prize. The /buy menu item \"Caster Hands\" is now available, thanks for participating in the Tribes RPG promotion!")
		else
			sender:PrintMessage(HUD_PRINTTALK, "^900You don't qualify for this promotion. You must use the #claim command in the NoXiousNet Tribes RPG server while having 650 or more global skills. See forum thread at noxiousnet.com for details.")
		end
	elseif text == "dunmir" then
		if not rawio then
			sender:PrintMessage(HUD_PRINTTALK, "This promotion has expired.")
		elseif sender:HasFlag("promo_tribeswar") then
			sender:PrintMessage(HUD_PRINTTALK, "You've already claimed your prize for this promotion. You can now use the \"Static Aura\" item.")
		elseif util.tobool(rawio.readfile("C:/dynamix/tribes/temp/trash2 "..string.Explode(":", string.gsub(sender:IPAddress(), "%.", "_"))[1]..".txt")) then
			sender:AddFlag("promo_tribeswar")
			sender:PrintMessage(HUD_PRINTTALK, "You have claimed your prize. The /buy menu item \"Static Aura\" is now available for you to use.")
		else
			sender:PrintMessage(HUD_PRINTTALK, "^900You don't qualify for this promotion.")
		end
	elseif not NDB.ClaimCode(sender, text) then
		sender:PrintMessage(HUD_PRINTTALK, "^900The promo code you entered doesn't exist or is a one-use code and has been used already.")
	end

	return ""
end, "Claims promotional prizes. Use: /claim promocode")

NDB.AddChatCommand("nextmap", function(sender)
	if CurTime() < (sender.NextRequestNextMap or 0) then return "" end
	sender.NextRequestNextMap = CurTime() + 5

	local msg
	if NDB.VoteMap.RandomMap then
		msg = sender:NoParseName()..", a random map has been selected. Wait and see!"
	else
		msg = sender:NoParseName()..", the next map is "..tostring(NDB.NEXT_MAP)
	end

	if sender:IsMuted() then
		sender:PrintMessage(HUD_PRINTTALK, msg)
	else
		PrintMessage(HUD_PRINTTALK, msg)
	end

	return ""
end, "Displays the next map according to wich map has the most votes.")

NDB.AddChatCommand("/news", function(sender)
	sender:SendLua("MakepNews()")

	return ""
end, "Displays announcements box.")

NDB.AddChatCommand("thetime", function(sender)
	if CurTime() < (sender.NextRequestTime or 0) then return "" end
	sender.NextRequestTime = CurTime() + 5

	local thetime = os.date()
	if sender:IsMuted() then
		sender:PrintMessage(HUD_PRINTTALK, sender:NoParseName()..", the server's local time is now "..thetime.." (GMT-5)")
	else
		PrintMessage(HUD_PRINTTALK, sender:NoParseName()..", the server's local time is now "..thetime.." (GMT-5)")
	end

	return ""
end, "Displays the server's local time in 24 hour format.")

local function CC_Blah(sender)
	if sender:Alive() and gamemode.Call("CanPlayerSuicide", sender) then
		local effectdata = EffectData()
			effectdata:SetOrigin(sender:GetPos())
		util.Effect("Explosion", effectdata)

		--[[local novel
		for _, ent in pairs(player.GetAll()) do
			if ent:GetGroundEntity() == sender then
				novel = true
				break
			end
		end

		if not novel then
			sender:SetGroundEntity(NULL)
			sender:SetLocalVelocity(Vector(0, 0, 2000))
		end]]

		sender:PrintMessage(HUD_PRINTTALK, "Pop!")
		sender:Kill()
	end
end
NDB.AddChatCommand("blah", CC_Blah)
NDB.AddChatCommand("yabba", CC_Blah)
NDB.AddChatCommand("!kill", CC_Blah)
NDB.AddChatCommand("!zspawn", CC_Blah, nil, nil, true)
NDB.AddChatCommand("rusty bullethole", CC_Blah, nil, nil, true)

local function CC_GiveMoney(sender, text)
	if not sender:IsValidAccountNotify() or not sender:Alive() then return "" end

	if sender.DiamondMember then sender:PrintMessage(HUD_PRINTTALK, "You can't transfer Silver if you have an infinite amount of it.") return "" end

	if sender.m_NextGiveMoney and CurTime() < sender.m_NextGiveMoney then
		sender:PrintMessage(HUD_PRINTTALK, "Please wait before giving more Silver to people.")
		return
	end

	local place = string.find(text, " ", 1, true)
	if not place then return "" end
	text = string.sub(text, place+1)
	text = tonumbersafe(text)
	if not text then sender:PrintMessage(HUD_PRINTTALK, "Must be a number.") return "" end
	text = math.ceil(math.abs(text))

	if text < 25 then
		sender:PrintMessage(HUD_PRINTTALK, "You can't transfer such low amounts of money.")
		return ""
	end

	if 50000 < text then
		sender:PrintMessage(HUD_PRINTTALK, "For your security, only transfer 50,000 Silver at one time.")
		return ""
	end

	if sender:GetSilver() < text then
		sender:PrintMessage(HUD_PRINTTALK, "You don't even have that much money!")
		return ""
	end

	local vStart = sender:EyePos()
	local hit = util.TraceLine({start = vStart, endpos = vStart + sender:GetAimVector() * 48, filter = sender}).Entity
	if hit and hit:IsValid() and hit:IsPlayer() and hit:IsValidAccountNotify() then
		sender.m_NextGiveMoney = CurTime() + 3

		hit:AddSilver(text, true)
		sender:AddSilver(-text, true)
		sender:PrintMessage(HUD_PRINTTALK, "You gave them "..text.." Silver.")
		hit:PrintMessage(HUD_PRINTTALK, sender:NoParseName().." hands you "..text.." Silver.")
		sender:CustomGesture(ACT_GMOD_GESTURE_ITEM_GIVE)
		hit:UpdateDB()
		sender:UpdateDB()

		NDB.LogLine("<"..sender:SteamID().."> "..sender:Name().." gave "..text.." Silver to <"..hit:SteamID().."> "..hit:Name())
	else
		sender:PrintMessage(HUD_PRINTTALK, "You must be pointing at a player in front of you.")
	end

	return ""
end
NDB.AddChatCommand("givemoney", CC_GiveMoney, "<amount> - Gives <amount> of your silver to whoever you are pointing at.")
NDB.AddChatCommand("/givemoney", CC_GiveMoney, "<amount> - Gives <amount> of your silver to whoever you are pointing at.")
NDB.AddChatCommand("/givesilver", CC_GiveMoney, "<amount> - Gives <amount> of your silver to whoever you are pointing at.")

NDB.AddChatCommand("/emotes", function(sender)
	sender:ConCommand("noxlistemotes")

	return ""
end, "List all emotes.")

NDB.AddChatCommand("/model", function(sender)
	sender:SendLua("MakepModelSelect()")

	return ""
end)

NDB.AddChatCommand("/portal", function(sender)
	sender:PrintMessage(HUD_PRINTTALK, "Pick your destination...")
	sender:ConCommand("serverportal")

	return ""
end, "Travel to other NoXiousNet sanctioned servers.")

local function CC_Commands(sender)
	sender:PrintMessage(HUD_PRINTTALK, "A list of NoXiousNet's chat commands have been printed to your console.")

	for _, tab in pairs(NDB.ChatCommands) do
		if tab.Help then
			sender:PrintMessage(HUD_PRINTCONSOLE, tab.Text.." - "..tostring(tab.Help).."\n")
		end
	end

	return ""
end
NDB.AddChatCommand("/chatcommands", CC_Commands)
NDB.AddChatCommand("/commands", CC_Commands)
NDB.AddChatCommand("/help", CC_Commands)

NDB.AddChatCommand("/forceurl", function(sender, text)
	if not (sender:IsValid() and sender:IsConnected() and sender:IsAdmin()) then return end

	local place = string.find(text, " ", 1, true)
	if not place then return "" end
	text = string.sub(text, place+1)
	local lowertext = string.lower(text)

	local expl = string.Explode(" ", text)
	local url = expl[#expl]

	local pl = NDB.FindPlayerByName(table.concat(text, " ", 1, #expl - 1))

	if pl then
		pl:SendLua("ForceURL('"..url.."')")
		sender:PrintMessage(HUD_PRINTTALK, "You have forced "..pl:NoParseName().." to go to "..url..".")
	else
		sender:PrintMessage(HUD_PRINTTALK, "No one with that name found.")
	end
end)

NDB.AddChatCommand("/votemap", function(sender, text)
	text = string.match(text, "/votemap%s(.+)")
	if not text or #text == 0 then
		sender:SendLua("NDB.OpenVoteMapMenu()")
		return ""
	end

	text = string.lower(text)
	local textlen = #text
	local maplist = NDB.VoteMap.GetMapList()

	for mapid, maptab in ipairs(maplist) do
		if string.sub(string.lower(maptab[1]), 1, textlen) == text or string.sub(string.lower(maptab[2]), 1, textlen) == text then
			sender:PrintMessage(HUD_PRINTTALK, "Placing vote for "..maptab[1].."...")
			sender:ConCommand("nnvotemap "..mapid)

			return ""
		end
	end

	sender:PrintMessage(HUD_PRINTTALK, "<red>Couldn't find any maps on the map list that match \""..text.."\"</red>")

	return ""
end, "<map name or file name> - Vote for the specified map. If no map is given then opens the voting menu.")

NDB.AddChatCommand("/settitle", function(pl, text)
	if not pl:IsValidAccountNotify() then return end

	if text == "/settitle" or not pl:IsSuperAdmin() then
		pl:SendLua("NDB.MakeSetTitleFrame()")
		return ""
	end

	local place = string.find(text, " ", 1, true)
	if not place then return "" end
	text = string.sub(text, place+1)

	local expl = string.Explode(" ", text)
	local id = tonumbersafe(expl[1])
	if not id then return "" end

	local title = table.concat(expl, " ", 2) or ""

	local targ
	for _, ent in pairs(player.GetAll()) do
		if ent:UserID() == id then targ = ent break end
	end

	if not targ then return "" end

	if string.lower(title) == "none" then
		targ:SetTitle(targ:GetDefaultTitle())
		targ:PrintMessage(HUD_PRINTTALK, "<red>The admin has reset your player title.</red>")
		pl:PrintMessage(HUD_PRINTTALK, "<lg>You reset "..targ:Name().."'s player title.</lg>")
	elseif title == "" then
		targ:SetTitle(title)
		targ:PrintMessage(HUD_PRINTTALK, "<red>The admin has cleared your player title.</red>")
		pl:PrintMessage(HUD_PRINTTALK, "<lg>You clear "..targ:Name().."'s player title.</lg>")
	else
		targ:SetTitle(title)
		targ:PrintMessage(HUD_PRINTTALK, "<red>The admin has set your player title to:</red> "..title)
		pl:PrintMessage(HUD_PRINTTALK, "<lg>"..targ:Name().."'s player title has been set to:</lg> "..title)
	end

	targ.TitleLock = nil

	targ:UpdateDB()

	return ""
end, "Set a player's title. SuperAdmin only.")

local function CC_Donate(pl, text)
	if pl:IsValidAccountNotify() then
		pl:SendLua("gui.OpenURL(\"https://noxiousnet.com/shop\")")
	end

	return ""
end
NDB.AddChatCommand("/donate", CC_Donate, "Donate")
NDB.AddChatCommand("/donations", CC_Donate, "Donate")
NDB.AddChatCommand("!donate", CC_Donate, "Donate")
NDB.AddChatCommand("!donations", CC_Donate, "Donate")

NDB.AddChatCommand("/titlereset", function(pl, text)
	if pl:IsValidAccountNotify() then
		pl:ChangeTitle("None")
	end

	return ""
end,
"Reset your title to a default one")

NDB.AddChatCommand("/titleclear", function(pl, text)
	if pl:IsValidAccountNotify() then
		pl:ChangeTitle("")
	end

	return ""
end,
"Clear your title")
