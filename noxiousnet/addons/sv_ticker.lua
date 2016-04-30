local GeneralTickers = {
	"Join our Steam Community group by saying <red>/join</red>. Members receive <pink>10% extra voting power</pink> and news on updates!",
	"Say /shop to access the store. Purchase costumes and other items with Silver you earned from playing.",
	"Get more Silver by doing better. Each point you earn in a game gives a certain amount of Silver.",
	"Say /votekick or /voteban to get rid of idiots.",
	"Open your chat to show the account box.",
	"Check out our other servers by saying /portal.",
	"Want a custom emote added to the game? Visit noxiousnet.com/emoter",
	"Have ideas for costumes? Check out the forums to submit your own. Costume authors receive Silver for each costume they sell in the shop.",
	"We're funded completely by our users.",
	"Life-time Gold Member and Diamond Member available by donating. Say /donate and we'll <silkicon icon=heart> you forever.",
	--"Come play our Reign of Kings servers. More information on the forums.",
	"Cosmetic items from the /shop too expensive? Gold Members receive a 25% discount and Diamond Members receive a 60% discount.",
	"Votes for map voting are determined by how many points you get in a game. Get even more votes as a Gold or Diamond Member.",
	"Have lots of Silver? Change the loading screen message for 50,000 Silver with /changeintro.",
	"Title Change Cards available for $1. Give that special someone a nice, friendly title anonymously! <silkicon icon=heart>",
	--"Kids and squeekers will be sent to the ball pit.",
	"Please don't use your microphone to play music or noise. <silkicon icon=sound_mute>",
	"All administrators and moderators have a flashing <flashhsv rate=90>(NN)</flashhsv> tag. Anyone else is an imposter!",
	"Lottery drawings are every day at 9PM EST! Say <red>/enterlottery</red> to enter.",
	"Press F1 to get help for the gamemode you're playing.",
	"Elder Members are those who have played 1,000 or more rounds of any gamemode.",
	"We have detailed statistics and rankings for all gamemodes at noxiousnet.com/rankings",
	"Check our site out at noxiousnet.com",
	"Click on a player's name in chat to view their profile, transfer Silver, and other actions."
}

local GamemodeTickers = {}

GamemodeTickers["zombiesurvival"] = {
	"Press UNDO or ZOOM as a human to phase through barricades.",
	"Press SHIFT as most zombie classes to feign death.",
	"Press SHIFT as a headcrab to burrow under the ground.",
	"Use your flashlight as a zombie to toggle zombie vision.",
	"The fear-o-meter at the bottom of the screen is a measure of how many zombies are near you.",
	"Zombies take reduced damage as the fear-o-meter increases.",
	"New player? Try letting more experienced players create barricades for a few games to learn.",
	"Arsenal Crate owners receive a percentage of the points people use to buy weapons and items.",
	"Use the medical kit to heal yourself and others and cure poison. Heal others to receive points.",
	"Press F3 as a zombie to change classes.",
	"Press RELOAD to pry out nails with your hammer. Prying out another person's nails will give you penalties.",
	"Pack up deployed items by pressing SHIFT on them.",
	"You can remove deployables placed by other people by pressing SHIFT on them with a few other people.",
	"Press ALT to check your ammo, drop weapons, and drop ammo.",
	"Change game options by pressing F4.",
	"A boss zombie is selected every wave intermission. The most aggressive zombie player gets picked.",
	"Up to three boss zombies can be alive at any time.",
	"As a zombie, you can select which boss zombie you want to be chosen as in the F3 menu.",
	"Press USE on resupply crates to get free ammo every so often.",
	"Don't stand too close to a barricade to avoid getting hit.",
	"Zombies can be slowed for a short time by shooting them in the legs.",
	"More isn't always better. Leave small areas open in your barricades to ensure shooting space.",
	"Headcrabs can easily enter windows and small openings in barricades.",
	"Win the round to receive a huge Silver bonus.",
	"Shade is immune to bullets and can only be damaged by bright light.",
	"Ghouls attacks debuff humans causing other attacks to do more damage."
}

GamemodeTickers["extremefootballthrowdown"] = {
	"Press SHIFT to yell for teammates to pass you the ball.",
	"Press RIGHT CLICK with the ball to throw it. Hold down the button for stronger throws.",
	"Press the on-screen buttons repeatedly during power struggles. The person pressing them faster will win.",
	"Get a whopping 300 points for scoring a touch down.",
	"Players are immune to your knockdowns for a short time after being knocked down by you.",
	"Knocked down players can hit walls when knocked in to them at high enough speeds."
}

GamemodeTickers["cinema"] = {
	
}

GamemodeTickers["awesomestrike"] = {
	
}

GamemodeTickers["supermarioboxes"] = {
	
}

GamemodeTickers["deathrun"] = {
	"Getting killed by a Death Scythe will make you lose every one of your lives!",
	"Press right click while respawning to cycle check points.",
	"The blue circle on the ground when you land is you creating a new check point.",
	"Check points can only be made on solid ground. They can't be made on traps, props, or moving things.",
	"Use Blackout Grenades to confuse Deaths and trick them in to triggering traps.",
	"Move your crosshair over a button as a Death to reserve it. It will flash green and only you can press it until you move away.",
	"Players will win a round even if they are eliminated and their team wins.",
	"Players can voice chat to the other team if the round is over or starting.",
	"The Death Ray Wand is a one-hit KO.",
	"Press F3 to toggle third person view.",
	"Runner life count is based on number of traps vs. number of runners."
}

local general = math.random(2) == 1
local lastmessage
function NDB.TextTicker()
	general = not general

	local messagebase
	if general then
		messagebase = GeneralTickers
	else
		local ticker = GamemodeTickers[GAMEMODE.FolderName]
		if ticker and #ticker >= 1 then
			messagebase = ticker
		else
			messagebase = GeneralTickers
		end
	end

	local i = math.random(#messagebase)
	local message = messagebase[i]

	if not message then return end

	if message == lastmessage then
		message = messagebase[(i + 1) % #messagebase + 1]
	end

	PrintMessage(HUD_PRINTTALK, "<silkicon icon=information> <defc=30,160,255>"..message)
end

timer.Create("NDB_TextTicker", 3 * 60, 0, NDB.TextTicker)
