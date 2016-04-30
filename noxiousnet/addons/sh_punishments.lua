PUNISHMENT_BAN = 1
PUNISHMENT_MUTE = 2
PUNISHMENT_NOHAMMER = 3
PUNISHMENT_NOAWARDS = 4
PUNISHMENT_BALLPIT = 5
PUNISHMENT_NOCSC = 6
PUNISHMENT_NOEVENTS = 7
PUNISHMENT_NOVOTES = 8
PUNISHMENT_NOEMOTES = 9
PUNISHMENT_DOUBLEDAMAGE = 10
PUNISHMENT_INSTANTDEATH = 11
PUNISHMENT_SNAIL = 12
PUNISHMENT_DEAF = 13
PUNISHMENT_VOICEMUTE = 14
PUNISHMENT_ICESKATES = 15
PUNISHMENT_SOHIGHRIGHTNOW = 16
PUNISHMENT_NOSPRAY = 17

NDB.Punishments = {}
NDB.PunishmentsNames = {
	[PUNISHMENT_BAN] = "ban",
	[PUNISHMENT_MUTE] = "mute",
	[PUNISHMENT_NOHAMMER] = "rubber hammer",
	[PUNISHMENT_NOAWARDS] = "awards ban",
	[PUNISHMENT_BALLPIT] = "ball pit",
	[PUNISHMENT_NOCSC] = "CSC ban",
	[PUNISHMENT_NOEVENTS] = "event ban",
	[PUNISHMENT_NOVOTES] = "democracy ban",
	[PUNISHMENT_NOEMOTES] = "emote ban",
	[PUNISHMENT_DOUBLEDAMAGE] = "double damage",
	[PUNISHMENT_SNAIL] = "snail",
	[PUNISHMENT_DEAF] = "deaf",
	[PUNISHMENT_INSTANTDEATH] = "instant death",
	[PUNISHMENT_VOICEMUTE] = "voice mute",
	[PUNISHMENT_ICESKATES] = "ice skates",
	[PUNISHMENT_SOHIGHRIGHTNOW] = "so high right now",
	[PUNISHMENT_NOSPRAY] = "no spray"
}
NDB.PunishmentsPastNames = {
	[PUNISHMENT_BAN] = "banned",
	[PUNISHMENT_MUTE] = "muted",
	[PUNISHMENT_NOHAMMER] = "given a rubber hammer",
	[PUNISHMENT_NOAWARDS] = "awards banned",
	[PUNISHMENT_BALLPIT] = "sent to the ball pit",
	[PUNISHMENT_NOCSC] = "CSC banned",
	[PUNISHMENT_NOEVENTS] = "event banned",
	[PUNISHMENT_NOVOTES] = "democracy banned",
	[PUNISHMENT_NOEMOTES] = "emote banned",
	[PUNISHMENT_DOUBLEDAMAGE] = "forced to take double damage",
	[PUNISHMENT_SNAIL] = "made a snail",
	[PUNISHMENT_DEAF] = "deafened",
	[PUNISHMENT_INSTANTDEATH] = "forced to die in one hit",
	[PUNISHMENT_VOICEMUTE] = "voice muted",
	[PUNISHMENT_ICESKATES] = "ice skated",
	[PUNISHMENT_SOHIGHRIGHTNOW] = "made really, really high right now",
	[PUNISHMENT_NOSPRAY] = "made unable to spray"
}

PUNISH_REASON_CHEATING = 1
PUNISH_REASON_SPEEDHACKING = 2
PUNISH_REASON_NOISE = 3
PUNISH_REASON_ANNOYING = 4
PUNISH_REASON_ANNOYINGAND12 = 5
PUNISH_REASON_FARMING = 6
PUNISH_REASON_DDOS = 7
PUNISH_REASON_CRASHSERVER = 8
PUNISH_REASON_CRASHCLIENT = 9
PUNISH_REASON_DUMB = 10
PUNISH_REASON_UNHELPFUL = 11
PUNISH_REASON_ADVERTISING = 12
PUNISH_REASON_IMPERSONATION = 13
PUNISH_REASON_VOTEABUSE = 14
PUNISH_REASON_MASSNAILREMOVAL = 15
PUNISH_REASON_HORRIBLESPRAY = 16
PUNISH_REASON_CPSPRAY = 17

TIME_HOUR = 60
TIME_DAY = TIME_HOUR * 24
TIME_WEEK = TIME_DAY * 7
TIME_MONTH = TIME_DAY * 30
TIME_YEAR = TIME_DAY * 365
TIME_FOREVER = 0

NDB.PreMadePunishments = {
	[PUNISH_REASON_CHEATING] = {
		"Cheating",
		PUNISHMENT_BAN,
		{TIME_MONTH * 6, TIME_FOREVER}
	},
	[PUNISH_REASON_SPEEDHACKING] = {
		"Speedhacking",
		PUNISHMENT_BAN,
		{TIME_FOREVER}
	},
	[PUNISH_REASON_NOISE] = {
		"Noise / jukeboxing / voice spam",
		PUNISHMENT_VOICEMUTE,
		{TIME_HOUR, TIME_WEEK, TIME_YEAR, TIME_FOREVER}
	},
	[PUNISH_REASON_ANNOYING] = {
		"Annoying / dumb on the mic",
		PUNISHMENT_VOICEMUTE,
		{TIME_HOUR, TIME_DAY * 3, TIME_MONTH}
	},
	[PUNISH_REASON_ANNOYINGAND12] = {
		"Squeeky kid voice",
		PUNISHMENT_BALLPIT,
		{TIME_YEAR}
	},
	[PUNISH_REASON_FARMING] = {
		"Farming awards",
		PUNISHMENT_NOAWARDS,
		{TIME_WEEK, TIME_MONTH, TIME_FOREVER}
	},
	[PUNISH_REASON_DDOS] = {
		"DDoS / hack / whatever threat #"..math.random(2000, 12000),
		PUNISHMENT_BAN,
		{TIME_FOREVER}
	},
	[PUNISH_REASON_CRASHSERVER] = {
		"Using an exploit to crash the server on purpose",
		PUNISHMENT_BAN,
		{TIME_MONTH * 3, TIME_FOREVER}
	},
	[PUNISH_REASON_CRASHCLIENT] = {
		"Using an exploit to crash clients on purpose",
		PUNISHMENT_BAN,
		{TIME_WEEK, TIME_MONTH, TIME_FOREVER}
	},
	[PUNISH_REASON_DUMB] = {
		"Too dumb for chat",
		PUNISHMENT_MUTE,
		{TIME_HOUR * 2, TIME_DAY * 2, TIME_WEEK * 2, TIME_MONTH * 6, TIME_YEAR}
	},
	[PUNISH_REASON_UNHELPFUL] = {
		"Unhelpful when people ask for help",
		PUNISHMENT_MUTE,
		{TIME_DAY, TIME_WEEK, TIME_MONTH, TIME_YEAR}
	},
	[PUNISH_REASON_ADVERTISING] = {
		"Advertising",
		PUNISHMENT_MUTE,
		{TIME_DAY * 7, TIME_MONTH * 3, TIME_FOREVER}
	},
	[PUNISH_REASON_IMPERSONATION] = {
		"Impersonation",
		PUNISHMENT_BAN,
		{TIME_DAY * 3, TIME_WEEK, TIME_MONTH * 6}
	},
	[PUNISH_REASON_VOTEABUSE] = {
		"Abusing the vote system / bandwagon voting",
		PUNISHMENT_NOVOTES,
		{TIME_WEEK, TIME_MONTH}
	},
	[PUNISH_REASON_MASSNAILREMOVAL] = {
		"Ruining barricades",
		PUNISHMENT_NOHAMMER,
		{TIME_DAY * 2, TIME_WEEK * 2, TIME_MONTH * 6, TIME_FOREVER}
	},
	[PUNISH_REASON_HORRIBLESPRAY] = {
		"Horrible, offensive spray",
		PUNISHMENT_NOSPRAY,
		{TIME_WEEK, TIME_MONTH, TIME_FOREVER}
	},
	[PUNISH_REASON_CPSPRAY] = {
		"CP spray",
		PUNISHMENT_NOSPRAY,
		{TIME_FOREVER}
	}
}


function NDB.SnailMove(pl, mv)
	if CLIENT or pl:IsPunished(PUNISHMENT_SNAIL) then
		if pl:OnGround() or pl:WaterLevel() >= 2 then
			mv:SetMaxSpeed(math.min(mv:GetMaxSpeed(), 22))
			mv:SetMaxClientSpeed(math.min(mv:GetMaxSpeed(), 22))
		else
			mv:SetMaxSpeed(0)
			mv:SetMaxClientSpeed(0)
		end
	end
end

function TimeToEnglish(delta)
	local delta = math.max(0, delta)
	local strTime = ""
	if delta < 60 then
		strTime = delta .." seconds"
	elseif delta < 3600 then
		strTime = math.ceil(delta / 60) .." minutes"
	elseif delta < 86400 then
		strTime = math.ceil(delta / 3600) .." hours"
	else
		strTime = math.ceil(delta / 86400) .." days"
	end

	return strTime
end

if CLIENT then
	scripted_ents.Register({Type = "anim", Draw = function(self) self:DrawModel() end}, "bantrain")

	local SetPunishedCB = {}
	SetPunishedCB[PUNISHMENT_SNAIL] = function(pl, punished)
		if punished then
			hook.Add("Move", "NDB.SnailMove", NDB.SnailMove)
		else
			hook.Remove("Move", "NDB.SnailMove")
		end
	end

	net.Receive("nox_localplayerpunished", function(length)
		local punishment = net.ReadUInt(8)
		local punished = net.ReadBit() == 1

		if SetPunishedCB[punishment] then
			SetPunishedCB[punishment](LocalPlayer(), punished)
		end
	end)
end
