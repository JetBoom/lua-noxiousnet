NDB.LotteryFee = 2000

NDB.LotteryEntrants = {}
NDB.LotteryEntrantNames = {}
NDB.LotteryDrawingTime = 0

function NDB.LoadLottery()
	if file.Exists("lottery_entrants.txt", "DATA") then
		local cont = file.Read("lottery_entrants.txt", "DATA")
		if #cont == 0 then
			NDB.LotteryEntrants = {}
		else
			NDB.LotteryEntrants = string.Explode(",", cont)
		end
	end
	if file.Exists("lottery_entrantnames.txt", "DATA") then
		local cont = file.Read("lottery_entrantnames.txt", "DATA")
		if #cont == 0 then
			NDB.LotteryEntrantNames = {}
		else
			NDB.LotteryEntrantNames = string.Explode(",", cont)
		end
	end
	NDB.LoadLotteryDrawingTime()
end

function NDB.SaveLottery()
	file.Write("lottery_entrants.txt", table.concat(NDB.LotteryEntrants, ","))
	file.Write("lottery_entrantnames.txt", table.concat(NDB.LotteryEntrantNames, ","))
	file.Write("lottery_drawingtime.txt", tostring(NDB.LotteryDrawingTime))
end

function NDB.LoadLotteryDrawingTime()
	if file.Exists("lottery_drawingtime.txt", "DATA") then
		NDB.LotteryDrawingTime = tonumber(file.Read("lottery_drawingtime.txt", "DATA") or 0)
	end
end

function NDB.GetLotteryPot()
	return math.ceil(#NDB.LotteryEntrants * NDB.LotteryFee * 0.95)
end

function NDB.DrawLottery()
	NDB.LoadLottery()

	if #NDB.LotteryEntrants == 0 then
		opensocket.Broadcast("PrintMessage", "<silkicon icon=world> Looks like no one entered the lottery. YOU GET NOTHING. YOU LOSE. GOOD DAY SIR.", true)
		webchat.Add("<img src='/silkicons/world.png'> Looks like no one entered the lottery. YOU GET NOTHING. YOU LOSE. GOOD DAY SIR.")
	else
		math.randomseed(os.time())
		local winnerid = math.random(#NDB.LotteryEntrants)
		local winneruid = tostring(NDB.LotteryEntrants[winnerid])
		local winnername = NDB.LotteryEntrantNames[winnerid] or "nobody"
		local pot = NDB.GetLotteryPot()

		if #NDB.LotteryEntrants == 1 then
			opensocket.Broadcast("PrintMessage", "<silkicon icon=world> <noparse>"..winnername.."</noparse> has won the lottery! They have won "..tostring(pot).." Silver! Wow, it's fucking nothing!", true)
			webchat.Add("<img src='/silkicons/world.png'> "..string.Replace(string.Replace(winnername, "<", " "), ">", " ").." has won the lottery! They have won "..tostring(pot).." Silver! Wow, it's fucking nothing!")
		else
			opensocket.Broadcast("PrintMessage", "<silkicon icon=world> <noparse>"..winnername.."</noparse> has won the lottery! They have won "..tostring(pot).." Silver!", true)
			webchat.Add("<img src='/silkicons/world.png'> "..string.Replace(string.Replace(winnername, "<", " "), ">", " ").." has won the lottery! They have won "..tostring(pot).." Silver!")
		end

		file.Write("lotterywinners/"..winneruid..".txt", (tonumber(file.Read("lotterwinners/"..winneruid..".txt", "DATA") or 0) or 0) + pot)

		NDB.LotteryCashOut()
		opensocket.Broadcast("LotteryCashOut", " ")
	end

	NDB.RestartLottery()
end

function NDB.RestartLottery()
	NDB.LoadLottery()

	NDB.LotteryEntrants = {}
	NDB.LotteryEntrantNames = {}

	local date = os.date("*t")
	date.hour = 21
	date.min = 0
	date.sec = 0
	NDB.LotteryDrawingTime = os.time(date) + 60 * 60 * 24

	NDB.SaveLottery()

	opensocket.Broadcast("PrintMessage", "<silkicon icon=world> <flashhsv>A new lottery has been started!</flashhsv>", true)
	webchat.Add("<img src='/silkicons/world.png'> A new lottery has been started!")
end

function NDB.CheckLottery()
	NDB.LoadLotteryDrawingTime()
	if NDB.LotteryDrawingTime > 0 and os.time() >= NDB.LotteryDrawingTime then
		NDB.DrawLottery()
		NDB.RestartLottery()
	end
end

function NDB.LotteryCashOut(pl)
	if not pl then
		for _, p in pairs(player.GetAll()) do NDB.LotteryCashOut(p) end
		return
	end

	if pl:IsValidAccount() then
		local filename = "lotterywinners/"..pl:UniqueID()..".txt"
		if file.Exists(filename, "DATA") then
			local amount = math.max(math.ceil(tonumber(file.Read(filename, "DATA")) or 0), 0)
			file.Delete(filename)
			if amount >= 0 then
				pl:AddSilver(amount, true)
				pl:SendLua("Derma_Message(\"Your lottery winnings have been cashed out to you! You have won "..tostring(amount).." Silver!\", \"Winner!\")")
				pl:UpdateDB()
			end
		end
	end
end

local function CCEnterLottery(sender, text)
	if not sender:IsValid() or not sender:IsValidAccountNotify() then return "" end

	NDB.LoadLottery()

	if NDB.LotteryDrawingTime <= 0 then
		sender:PrintMessage(HUD_PRINTTALK, "<red>The lottery is currently being restarted. Please wait a few minutes.</red>")
		return ""
	end

	local uid = sender:UniqueID()
	if table.HasValue(NDB.LotteryEntrants, uid) then
		sender:PrintMessage(HUD_PRINTTALK, "<red>You have already entered the lottery! Drawings are every day at 9PM EST.</red>")
		return ""
	end

	if sender:GetSilver() < NDB.LotteryFee then
		sender:PrintMessage(HUD_PRINTTALK, "<red>You do not have "..tostring(NDB.LotteryFee).." Silver. You can't enter the lottery.</red>")
		return ""
	end

	local name = "<"..sender:SteamID().."> "..sender:Name()

	table.insert(NDB.LotteryEntrants, uid)
	table.insert(NDB.LotteryEntrantNames, name)

	NDB.LogLine(name.." entered the lottery.")

	local pot = NDB.GetLotteryPot()

	opensocket.Broadcast("PrintMessage", "<silkicon icon=world> <lb>"..sender:Name().."</lb> entered the lottery for "..string.CommaSeparate(NDB.LotteryFee).." Silver. The pot is now <lg>"..string.CommaSeparate(pot).."</lg> Silver. Use <red>/enterlottery</red> to enter.", true)
	webchat.Add("<img src='/silkicons/world.png'> "..sender:Name().." entered the lottery for "..string.CommaSeparate(NDB.LotteryFee).." Silver. The pot is now "..string.CommaSeparate(pot).." Silver.")

	sender:AddSilver(-NDB.LotteryFee)
	sender:UpdateDB()

	NDB.SaveLottery()

	return ""
end

local function SOCKDrawLottery(ip, port, message)
	NDB.LotteryCashOut()
end

hook.Add("Initialize", "InitializeLottery", function()
	if not game.IsDedicated() then return end

	NDB.AddChatCommand("/enterlottery", CCEnterLottery, "Enters the NoXiousNet lottery for FABULOUS prizes.")
	opensocket.AddHook("LotteryCashOut", SOCKDrawLottery) --opensocket.AddHook(OPENSOCKET_LOTTERYCASHOUT, SOCKDrawLottery)

	NDB.LoadLottery()
	NDB.CheckLottery()
	timer.CreateEx("CheckLottery", 60, 0, NDB.CheckLottery)

	if NDB.LotteryDrawingTime <= 0 then
		NDB.RestartLottery()
	end
end)

hook.Add("PostPlayerReady", "CheckLotteryPlayerReady", function(pl)
	NDB.LotteryCashOut(pl)
end)
