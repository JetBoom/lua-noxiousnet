MEMBER_NONE = 0
MEMBER_GOLD = 1
MEMBER_DIAMOND = 2
MEMBER_ELDER = 3
MEMBER_DEFAULT = MEMBER_NONE

--NDB.DefaultMemberTitles = {[MEMBER_NONE] = "", [MEMBER_GOLD] = "<yellow>(G)</yellow>", [MEMBER_DIAMOND] = "<diamond>"}
NDB.DefaultMemberTitles = {[MEMBER_NONE] = "", [MEMBER_GOLD] = "<img src=noxiousnet/noxicon>", [MEMBER_DIAMOND] = "<img src=noxiousnet/noxicon c=0,255,255>"}
NDB.MemberNames = {[MEMBER_GOLD] = "Gold", [MEMBER_DIAMOND] = "Diamond", [MEMBER_ELDER] = "Elder"}
NDB.MemberColors = {[MEMBER_GOLD] = Color(255, 255, 0, 255), [MEMBER_DIAMOND] = Color(255, 255, 255, 255), [MEMBER_ELDER] = Color(200, 200, 200)}
NDB.MemberDiscounts = {[MEMBER_GOLD] = 0.75, [MEMBER_DIAMOND] = 0.4, [MEMBER_ELDER] = 0.9, [MEMBER_NONE] = 1}
NDB.MemberVotePower = {[MEMBER_NONE] = 1, [MEMBER_GOLD] = 1.5, [MEMBER_DIAMOND] = 2, [MEMBER_ELDER] = 1.15}
NDB.MemberReservedSlots = {[MEMBER_DIAMOND] = true}
NDB.MemberAvatar = {[MEMBER_DIAMOND] = true, [MEMBER_GOLD] = true}
NDB.MemberPersonalChatColors = {[MEMBER_DIAMOND] = true, [MEMBER_GOLD] = true}
NDB.MemberMaxLabels = {[MEMBER_DIAMOND] = 2, [MEMBER_GOLD] = 1}
NDB.MemberBanProtection = {[MEMBER_DIAMOND] = true, [MEMBER_GOLD] = true}
NDB.MemberNoAFKKick = {[MEMBER_DIAMOND] = true, [MEMBER_GOLD] = true}
NDB.MemberExtraCostumeModels = {[MEMBER_DIAMOND] = 4, [MEMBER_GOLD] = 2}

NDB.IdleSilver = 20
NDB.IdleSilverTime = 60

NDB.MaxTitles = 5

NDB.MaxChatSize = 400
NDB.MaxChatTimeout = 5

NDB.SuperAdminTitle = "<flashhsv rate=90>(NN)</flashhsv>"
NDB.AdminTitle = "<flash color=40,255,40 rate=3>(NN)</flash>"
NDB.ModeratorTitle = "<flash color=40,200,255 rate=3>(NN)</flash>"

NDB.ElderMemberThreshold = 1000

NDB.CostumeAuthorSilver = 1000

NDB.Servers = {
{"Zombie Survival",						"192.99.20.148",		27015, "The ONLY official Zombie Survival server. A team of humans try to survive an onslaught of player zombies. When a human dies, they respawn as a zombie.\nKill zombies to get better weapons and use barricades to slow down the oncoming undead.\nZombie players have an assortment of different classes to use each with their own special abilities.", -1, 0},
--{"Zombie Survival (Classic Mode)",	"192.99.20.148",		27016, "Zombie Survival running on Classic Mode. There is no class switching, no barricading, and things are much faster paced. All zombies are forced to use a special class designed just for this mode.", -1, 0},
{"Extreme Football Throwdown",			"167.114.207.240",		27015, "A simple game based around a ball and two goal. Take some extreme wackyness, momentum based running, and the ability to tackle other players and you get EFT.", -1, 0},
{"Retro TeamPlay",						"167.114.207.242",		27015, "The game that started it all.\nMagic and technology clash as two or more teams compete against each other to complete objectives.\nFeatures tons of classes, vehicular warfare, strategic combat, and plenty of action.", -1, 0},
{"Deathrun",							"167.114.207.244",		27015, "Traverse the level as a Runner, avoiding deadly traps activated by the Death players.\nFree your soul by killing Death himself.", -1, 0},
{"Multiplayer TV",						"167.114.207.241",		27015, "Watch videos together. Supports multiple content providers such as YouTube and Twitch.TV. Players can rent private rooms or use a video queue in public rooms. Don't like a video? Vote to skip it. Players also receive points and Silver for having their videos played without being skipped."},
{"Awesome Strike: Source",				"167.114.207.245",		27015, "Awesome Strike is an attempt to create a cooler version of Counter-Strike\nand other tactical shooters while bringing in elements from\nfast-paced action games like DMC, S4, and GunZ. Bullets are physical and take time\nto travel, players can be revived by team members, and objectives are remade\nto be in the faster-paced environment.", -1, 0},
{"Trouble in Terrorist Town",			"167.114.207.247",		27017, "Our anything-goes, vanilla Trouble in Terrorist Town server.", -1, 0},
{"Super Mayhem Boxes",					"167.114.207.246",		27015, "A 'Half-2D' physics side-scroller.\nCapture each other's fruit while using an assortment of weapons and powerups.", -1, 0},
--{"Melonbomber",							"167.114.207.247",		27015, "A clone of the classic Bomberman game. Now in GMod and multiplayer.", -1, 0},
{"Pedobear Escape 2",					"167.114.207.247",		27015, "Escape Pedobear! Throw your teammates under the bus to ensure your own survival.", -1, 0}
}

--{"REALLY BAD ROLE PLAY", "65.60.53.27", 27016, "For a limited time only! Enjoy the wonders of roleplaying your favorite sociopathic serial killers."},
--{"Obby", "65.60.53.26", 27017, "Compete against other players in player-made courses and maps.\nIt's a race to the finish or whatever the creator happens to have in mind!"},
--{"Multiplayer YouTube", "65.60.53.27", 27019, "Watch videos together. Rewards are given for playing well-liked videos."}
--{"SandBox", "65.60.53.27", 27018, "NoXiousNet's SandBox server.\nEnjoy pester-free building as new players are required to get building rights from an admin in order to do anything.\nBuilding rights and records are kept in a database so we always know who's actually playing and who's just there to be annoying.", -1, 0},
--{"Zombie Survival 2", "65.60.53.29", 27015, "An alternate Zombie Survival server.", -1, 0}

AWARDS_CAT_SPECIAL = 1
AWARDS_CAT_ZS = 2
AWARDS_CAT_OLDTP = 4
AWARDS_CAT_TP = 8
AWARDS_CAT_MARIO = 16
AWARDS_CAT_EVENT = 32
AWARDS_CAT_ASS = 64
AWARDS_CAT_DR = 128

AWARDS_DIFFICULTY_NORMAL = 0
AWARDS_DIFFICULTY_HARD = 1
AWARDS_DIFFICULTY_HARDEST = 2
AWARDS_DIFFICULTY_EVENT = 3
AWARDS_DIFFICULTY_OTHER = 4

NDB.AwardCategories = {
	[AWARDS_CAT_SPECIAL] = "Special",
	[AWARDS_CAT_ZS] = "Zombie Survival",
	[AWARDS_CAT_OLDTP] = "Retro Team Play",
	[AWARDS_CAT_TP] = "Team Play",
	[AWARDS_CAT_MARIO] = "Super Mario Boxes",
	[AWARDS_CAT_EVENT] = "Events",
	[AWARDS_CAT_ASS] = "Awesome Strike: Source"
}

NDB.Awards = {
["100_ctf_kills"] = {"Kill 100 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["250_ctf_kills"] = {"Kill 250 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["500_ctf_kills"] = {"Kill 500 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["1000_ctf_kills"] = {"Kill 1,000 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["2500_ctf_kills"] = {"Kill 2,500 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["5000_ctf_kills"] = {"Kill 5,000 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["7500_ctf_kills"] = {"Kill 7,500 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["10000_ctf_kills"] = {"Kill 10,000 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["12500_ctf_kills"] = {"Kill 12,500 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["15000_ctf_kills"] = {"Kill 15,000 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["17500_ctf_kills"] = {"Kill 17,500 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["20000_ctf_kills"] = {"Kill 20,000 people in TeamPlay.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARDEST},
["10_core_final_blows"] = {"Score the last hit on an Assault core a total of 10 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["25_core_final_blows"] = {"Score the last hit on an Assault core a total of 25 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["50_core_final_blows"] = {"Score the last hit on an Assault core a total of 50 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["50_caps"] = {"Capture the flag a total of 50 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["250_caps"] = {"Capture the flag a total of 250 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["125_caps"] = {"Capture the flag a total of 125 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["500_ctf_captures"] = {"Capture the flag a total of 500 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["750_ctf_captures"] = {"Capture the flag a total of 750 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["1000_ctf_captures"] = {"Capture the flag a total of 1000 times.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARDEST},
["250hp_cleric"] = {"Heal 250 HP for your teamates in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["500hp_cleric"] = {"Heal 500 HP for your teamates in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["750hp_cleric"] = {"Heal 750 HP for your teamates in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["1000hp_cleric"] = {"Heal 1,000 HP for your teamates in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["1500hp_cleric"] = {"Heal 1,500 HP for your teamates in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["2500hp_cleric"] = {"Heal 2,500 HP for your teamates in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARD},
["5000hp_cleric"] = {"Heal 5,000 HP for your teamates in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARDEST},
["novice_miner"] = {"Blow up 2 people with Fire Mines in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["adept_miner"] = {"Blow up 4 people with Fire Mines in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["master_miner"] = {"Blow up 8 people with Fire Mines in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["awesome_miner"] = {"Blow up 16 people with Fire Mines in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["crazy_miner"] = {"Blow up 24 people with Fire Mines in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["lunatic_miner"] = {"Blow up 32 people with Fire Mines in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARD},
["miner_fourty-niner"] = {"Blow up 49 people with Fire Mines in one game.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARDEST},
["no_flying_zone"] = {"Run over a player at a high alitutude with an air vehicle.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARDEST},
["multi-skewer"] = {"Kill 2 people with the same crossbow bolt.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["shish_kabob"] = {"Kill 3 people with the same crossbow bolt.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARDEST},
["harpwned"] = {"Kill a person with Harpoon.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["whaling_man"] = {"Kill 2 people with Harpoon in one life.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["ar_she_blows"] = {"Kill 4 people with Harpoon in one life.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["bomberman"] = {"Kill 5 people with the Vulture Heavy Bomber in one life.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["fatboy"] = {"Kill 20 people with the Vulture Heavy Bomber in one life.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARD},
["beeee_17_boamber"] = {"Kill 50 people with the Vulture Heavy Bomber in one life.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARDEST},
["hot_foot"] = {"Kill 3 people with the Burn spell in one life.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["my_hair_is_on_fire"] = {"Kill 10 people with the Burn spell in one life.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["anti_semetic"] = {"Kill 15 people with the Burn spell in one life.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARDEST},
["last-ditch_effort"] = {"Crash an air vehicle in to an enemy flag carrier within 50 feet of their flag stand.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},

["you_cant_pull_me_over"] = {"Kill 3 people by running them over with the Assault Rover in one life.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["vroom_im_a_car"] = {"Kill 8 people by running them over with the Assault Rover in one life.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_NORMAL},
["get_out_of_the_way"] = {"Kill 15 people by running them over with the Assault Rover in one life.", AWARDS_CAT_OLDTP + AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARD},
["copper_defense"] = {"Acquire 10 defense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["iron_defense"] = {"Acquire 20 defense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["steel_defense"] = {"Acquire 35 defense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["titanium_defense"] = {"Acquire 50 defense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["diamond_defense"] = {"Acquire 75 defense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["ultimate_defense"] = {"Acquire 100 defense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARDEST},
["copper_offense"] = {"Acquire 30 offense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["iron_offense"] = {"Acquire 60 offense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["steel_offense"] = {"Acquire 100 offense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["titanium_offense"] = {"Acquire 150 offense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_NORMAL},
["diamond_offense"] = {"Acquire 175 offense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARD},
["ultimate_offense"] = {"Acquire 250 offense points in one game.", AWARDS_CAT_OLDTP, AWARDS_DIFFICULTY_HARDEST},
["zs_human_bronze"] = {"Get 300 points in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zs_human_silver"] = {"Get 400 points in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zs_human_3rd"] = {"Get 500 points in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zs_human_2nd"] = {"Get 600 points in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zs_human_1st"] = {"Get 700 points in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zs_zombie_bronze"] = {"Kill 5 humans in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zs_zombie_silver"] = {"Kill 7 humans in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zs_zombie_3rd"] = {"Kill 9 humans in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["zs_zombie_2nd"] = {"Kill 11 humans in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["zs_zombie_1st"] = {"Kill 13 humans in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARDEST},
["pest_of_humans"] = {"Eat a total of 25 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["killer_of_humans"] = {"Eat a total of 50 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["marauder_of_humans"] = {"Eat a total of 100 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["butcher_of_humans"] = {"Eat a total of 250 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["exterminator_of_humans"] = {"Eat a total of 500 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["destroyer_of_humans"] = {"Eat a total of 1,000 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["annihilator_of_humans"] = {"Eat a total of 2,500 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["eradicator_of_humans"] = {"Eat a total of 5,000 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARDEST},
["bane_of_humanity"] = {"Eat a total of 10,000 human brains.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARDEST},
["zombie_assassin_-_novice"] = {"Kill 4 zombies with a knife in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zombie_assassin_-_adept"] = {"Kill 8 zombies with a knife in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["zombie_assassin_-_master"] = {"Kill 16 zombies with a knife in one game.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survivalist"] = {"Survive for 5 minutes straight while being the Last Human.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARDEST},
["stealing_first"] = {"Score a goal in Blitz or Capture the Flag within 30 seconds of the game starting.", AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARD},
["greedy"] = {"Be the one to score every goal in a game of Blitz or Capture the Flag.", AWARDS_CAT_TP, AWARDS_DIFFICULTY_HARD},
["sharpshooter"] = {"Get 10 consecutive head shot kills with the Slug Rifle.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["hellsing"] = {"Kill 6 different zombies with one crossbow bolt.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["goku"] = {"Destroy 6 enemy boxes with one Kamehameha blast.", AWARDS_CAT_MARIO, AWARDS_DIFFICULTY_NORMAL},
["goku_killer"] = {"Destroy an enemy that is charging a Kamehameha.", AWARDS_CAT_MARIO, AWARDS_DIFFICULTY_NORMAL},
["rocket_skiing"] = {"Grapple hook on to a rocket.", AWARDS_CAT_MARIO, AWARDS_DIFFICULTY_HARD},
["back_to_the_future"] = {"Destroy 6 different enemy boxes with the same Time Roller powerup.", AWARDS_CAT_MARIO, AWARDS_DIFFICULTY_NORMAL},
["breathe_this"] = {"As a zombie, kill the last human using nothing but the toxic gas damage from a Chem Zombie.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["wake_up"] = {"As a zombie, kill a human that has fallen over from fall damage.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["last_bite"] = {"As a zombie, kill the last human and end the round.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["trendsetter"] = {"Win a round of Zombie Survival on a map with an average win rate of 3% or less and that has been played at least 25 times.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARDEST},
["redeemer"] = {"Redeem from being a zombie and also survive the round.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},
["rambo"] = {"Kill 30 zombies with any melee weapon in one round.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["ocelot"] = {"Using the 'Ricochet' Magnum, kill 15 zombies with reflected bullets.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["across_the_board"] = {"Get the most amount in damage to undead, brains eaten, zombies killed, and damage to humans.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARDEST},
["heads_up_humans_down"] = {"Kill 4 humans by using props.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["piano_trick"] = {"Kill a human or zombie with a heavy prop.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["nightmare_mode"] = {"Win a round with at least 200 points while using every return.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["close_call"] = {"Win a round with 2 or less health remaining.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARDEST},
["batter_up"] = {"Kill 4 zombies by using props.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["grave_digger"] = {"Using a shovel, kill 15 zombies that are in the process of getting back up.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_NORMAL},

["darkfall"] = {"Die within a second of joining a server. Suicides don't count.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["not_that_easy"] = {"Win your very first game of Zombie Survival.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["official_zs_king"] = {"Be the king of Zombie Survival.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["verified_girl"] = {"Prove that you're a girl.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["gold_star"] = {"Do something worth mentioning.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["old_player"] = {"Be here for Advanced Fortwars on gmod9.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["ban_bait"] = {"Get banned a lot.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["complete_failure"] = {"Fail at everything.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["gigantic_faggot"] = {"Be a gigantic faggot.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["mingebag"] = {"Be a MingeBag.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["ugly_girl_friend"] = {"Have an ugly girlfriend.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},
["elder_member"] = {"Play 1,000 matches of any gamemode.", AWARDS_CAT_SPECIAL, AWARDS_DIFFICULTY_OTHER},

["won_contest"] = {"Win a minor event or contest.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["robot_war_champion"] = {"Win a Robot Wars tournament.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["worms_winner"] = {"Win the Worms event.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["trap_runner"] = {"Win a Trap Runner event.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["airship_captain"] = {"Win an Airship Captain event.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["baseball_winner"] = {"Win a baseball event.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["antguard_soccer_winner"] = {"Win an Antlion Guard Soccer event.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["zombie_herder_2007"] = {"Be on the winning team of the 2007 Zombie Herder event.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["nsl_champions"] = {"Win a NoX Soccer League tournament.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["atomic"] = {"Be radioactive.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["volley_bomb_winner"] = {"Win a Volley Bomb event.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["true_patriot"] = {"Be present on the best day of the year.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["fallen_angel"] = {"Get 50 wins as a Death in Deathrun on or before 4/30/2013.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},
["quick_runner"] = {"Get 150 wins as a Runner in Deathrun on or before 4/30/2013.", AWARDS_CAT_EVENT, AWARDS_DIFFICULTY_EVENT},

["survive_distant"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_korsakovia"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_farm"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_junkyard"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_zombo_city"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_forgotten_town"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_siege"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_pub"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_outpost_gold"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_dezecrated"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_lost_faith"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_rain_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_lost_coast_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_farm_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_sprint_trading"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_fury"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_fear_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_darkvilla_2"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_house_ruins"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_placid"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_mall"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_hamlet"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_nasty_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_overran_city"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_urban_decay"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_sector_4"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_honkers_club"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_house_outbreak"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_nestlings"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_desert_hideout"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_motel"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_the_village"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_death_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_noir"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_vulture"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_ugly_fort"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_shithole"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_village"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_abandonned_building"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_the_house_of_doom"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_dead_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_village_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_fortress"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_city_holdout"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_cabin"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_raunchy_house"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_asylum"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_cabin"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_lost_farm"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_forest_of_the_damned"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_fire_forest"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},
["survive_mines"] = {"Survival award for winning a difficult level.", AWARDS_CAT_ZS, AWARDS_DIFFICULTY_HARD},

["all_points_bulletin"] = {"Get a win streak of 10 or more against at least 4 players.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARD},
["unstoppable"] = {"Get a win streak of 20 or more against at least 4 players.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["defuse_this"] = {"Kill someone who has attempted defusing the bomb within the last 2 seconds by using the Detonator.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_NORMAL},
["you_got_dinkied"] = {"Get a 10 kill streak using nothing but the Dinky Gun.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["bomb_the_lasanga"] = {"Get a 10 kill streak using nothing but the Awesome Launcher.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["shank_master"] = {"Get a 10 kill streak using nothing but the Knife.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["berserk"] = {"Get a 10 kill streak using nothing but the Berserker Sword.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["eyes_on_you"] = {"Get a 10 kill streak using nothing but the Awesome Rifle.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["rail_me"] = {"Get a 10 kill streak using nothing but the Rail Gun.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["ass_pirate"] = {"Get a 5 kill streak using nothing but the Grapple Chain.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["smart_ass"] = {"Get a 10 kill streak using nothing but the Smart Rifle.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST},
["bat_man"] = {"Get a 10 kill streak using nothing but the Shockwave Bat.", AWARDS_CAT_ASS, AWARDS_DIFFICULTY_HARDEST}
}

NDB.MuteWords = {
	"over 9000",
	"mudkip",
	"cake is a",
	"say blah"
}

function NDB.GetServerName(ip, port)
	for _, servertab in pairs(NDB.Servers) do
		if servertab[2] == ip and servertab[3] == port then return servertab[1] end
	end
end

function NDB.GetNumberOfClients()
	if gatekeeper then
		return gatekeeper.GetNumClients().total
	end

	return #player.GetAll()
end

NDB.ServerRules = [[<html><head></head><body bgcolor="black" text="white" style="font-size:10pt;font-family:tahoma;padding-left:8px;padding-right:8px;">
<center><h3 style="color:#1f1;font-weight:bold;">Server Rules</h3>
These are the server rules, they're a lot more lax than other servers so...<br />
<b style="color:#1f1;">please take the time to read this!</b><br />
<i>Mutes, bans, and other punishments will be given out to rule breakers.</i><br /></center>
<ul>
<li><b>Don't cheat.</b> It's an instant half year ban if you're lucky.</li>
<li><b>Don't exploit glitches.</b> This includes maps where you can 'get outside' the playing area.</li>
<li><b>Don't spam.</b> There are measures put in place to prevent spamming so if you're circumventing it there's no excuses.</li>
<li><b>Don't be an ass to or harrass people</b> to the point where they can't play the game.</li>
<li><b>Don't try to trick people who are asking for help.</b> Don't tell someone to 'say blah' when they ask how to use something or play the game.</li>
<li><b>Don't pretend to be an admin or 'know' an admin.</b> Admins will not care about your personal affairs. Please report any abuse to the nearest noxiousnet security office.</li>
<li><b>Don't spray illegal content</b> such as animal abuse, child pornography, etc.</li>
<li><b>Don't be dumb.</b> Leave your idiocy, memes, lolcats, XD's, and bad spelling at the door.</li>
<li><b>Don't advertise.</b></li>
<li><b>Don't use the microphone if you're 12 years old.</b></li>
</ul>
There are no rules against obscenity. You can use the chat box options to filter chat messages.<br />
<br />
<b>Admins have a blinking green (NN) chat title. Anyone else is an imposter.</b>
</body></html>]]

function NDB.FindPlayerByName(name)
	name = string.lower(name)

	local allplayers = player.GetAll()
	for _, pl in pairs(allplayers) do
		if string.lower(pl:Name()) == name or string.lower(pl:NoParseName()) == name then return pl end
	end

	for i=1, string.len(name) do
		for _, pl in pairs(allplayers) do
			local subbed = string.sub(name, 1, i)
			if string.lower(pl:Name()) == subbed or string.lower(pl:NoParseName()) == subbed then
				return pl
			end
		end
	end
end

NDB.EmotesNames = {}
NDB.EmotesNoChat = {}

if CLIENT then
	NDB.EmotesSounds = {}
	NDB.EmotesCallbacks = {}
	NDB.EmotesVolumes = {}

	function NDB.AddEmote(name, soundtab, nochat, callback, volume)
		if name and soundtab then
			local i = #NDB.EmotesNames + 1

			NDB.EmotesNames[i] = name
			NDB.EmotesNoChat[i] = nochat
			NDB.EmotesSounds[i] = soundtab
			NDB.EmotesCallbacks[i] = callback
			NDB.EmotesVolumes[i] = volume
		end
	end
else
	function NDB.AddEmote(name, soundtab, nochat, callback, volume)
		if name and soundtab then
			local i = #NDB.EmotesNames + 1

			NDB.EmotesNames[i] = name
			NDB.EmotesNoChat[i] = nochat
		end
	end
end

NDB.AddEmote("drink a big bucket of shit", "speach/obeyyourthirstsync.ogg", true)
NDB.AddEmote("drink a big bucket of horse dick", "speach/obeyyourthirst2.ogg", true)
NDB.AddEmote("lag!", "speach/lag2.ogg", true)
NDB.AddEmote("laff", {"speach/laff1.ogg", "speach/laff2.ogg", "speach/laff3.ogg", "speach/laff4.ogg", "speach/laff5.ogg"}, true)
NDB.AddEmote("enough of your mumbo jumbo", "vo/npc/male01/vanswer01.wav", true)
NDB.AddEmote("bullshit", "vo/npc/male01/question26.wav")
NDB.AddEmote("yay", "vo/npc/Barney/ba_yell.wav")
NDB.AddEmote("shit", "vo/npc/Barney/ba_ohshit03.wav")
NDB.AddEmote("about that bear i owed ya", "vo/trainyard/ba_thatbeer02.wav", true)
NDB.AddEmote("enough of your bullshit", "vo/NovaProspekt/al_enoughbs01.wav", true)
NDB.AddEmote("hax", "vo/npc/male01/hacks01.wav", true)
NDB.AddEmote("hacks", "vo/npc/male01/hacks02.wav", true)
NDB.AddEmote("h4x", "vo/npc/male01/thehacks01.wav", true)
NDB.AddEmote("h4cks", "vo/npc/male01/thehacks02.wav", true)
NDB.AddEmote("okay", {"vo/npc/male01/ok01.wav", "vo/npc/male01/ok02.wav"})
NDB.AddEmote("derka", {"vo/npc/vortigaunt/vortigese12.wav", "vo/npc/vortigaunt/vortigese11.wav"}, true)
NDB.AddEmote("noes", "vo/npc/Alyx/ohno_startle01.wav", true)
NDB.AddEmote("get down", {"vo/npc/Barney/ba_getdown.wav", "vo/npc/male01/getdown02.wav"})
NDB.AddEmote("gtfo", "vo/npc/male01/gethellout.wav")
NDB.AddEmote("gtho", "vo/npc/male01/gethellout.wav")
NDB.AddEmote("yeah", "vo/npc/male01/yeah02.wav")
NDB.AddEmote("rofl", "vo/Citadel/br_laugh01.wav")
NDB.AddEmote("lmao", "vo/Citadel/br_laugh01.wav")
NDB.AddEmote("run", "vo/npc/male01/strider_run.wav")
NDB.AddEmote("run for your life", {"vo/npc/male01/runforyourlife01.wav", "vo/npc/male01/runforyourlife02.wav", "vo/npc/male01/runforyourlife03.wav"})
NDB.AddEmote("fantastic", {"vo/npc/male01/fantastic01.wav", "vo/npc/male01/fantastic02.wav"})
NDB.AddEmote("headcrabs", {"vo/npc/male01/headcrabs01.wav", "vo/npc/male01/headcrabs02.wav"})
NDB.AddEmote("headhumpers", "vo/npc/Barney/ba_headhumpers.wav", true)
NDB.AddEmote("hello", "vo/coast/odessa/nlo_cub_hello.wav")
NDB.AddEmote("eek", "ambient/voices/f_scream1.wav", true)
NDB.AddEmote("uh oh", "vo/npc/male01/uhoh.wav")
NDB.AddEmote("sodomy!", {"vo/ravenholm/madlaugh01.wav", "vo/ravenholm/madlaugh02.wav", "vo/ravenholm/madlaugh03.wav", "vo/ravenholm/madlaugh04.wav"}, true)
NDB.AddEmote("oops", "vo/npc/male01/whoops01.wav", true)
NDB.AddEmote("shut up", "vo/npc/male01/answer17.wav")
NDB.AddEmote("shutup", "vo/npc/male01/answer17.wav")
NDB.AddEmote("right on", "vo/npc/male01/answer32.wav", true)
NDB.AddEmote("help", "vo/npc/male01/help01.wav")
NDB.AddEmote("haxz", "vo/npc/male01/herecomehacks01.wav", true)
NDB.AddEmote("hi", {"vo/npc/male01/hi01.wav", "vo/npc/male01/hi02.wav"})
NDB.AddEmote("let's go", {"vo/npc/male01/letsgo01.wav", "vo/npc/male01/letsgo02.wav"})
NDB.AddEmote("lets go", {"vo/npc/male01/letsgo01.wav", "vo/npc/male01/letsgo02.wav"})
NDB.AddEmote("moan", {"vo/npc/male01/moan01.wav", "vo/npc/male01/moan02.wav", "vo/npc/male01/moan03.wav", "vo/npc/male01/moan04.wav", "vo/npc/male01/moan05.wav"}, true)
NDB.AddEmote("nice", "vo/npc/male01/nice.wav")
NDB.AddEmote("noo", {"vo/npc/Barney/ba_no01.wav", "vo/npc/Barney/ba_no02.wav"}, true)
NDB.AddEmote("nooo", "vo/npc/male01/no02.wav", true)
NDB.AddEmote("oh no", "vo/npc/male01/ohno.wav", "vo/npc/male01/gordead_ans05.wav")
NDB.AddEmote("joygasm", "vo/npc/female01/pain06.wav", true)
NDB.AddEmote("zombies", {"vo/npc/male01/zombies01.wav", "vo/npc/male01/zombies02.wav"}, true)
NDB.AddEmote("da man", "bot/whos_the_man.wav", true)
NDB.AddEmote("my house", "bot/this_is_my_house.wav", true)
NDB.AddEmote("party", "bot/its_a_party.wav", true)
NDB.AddEmote("watch out", "vo/npc/male01/watchout.wav")
NDB.AddEmote("excuse me", {"vo/npc/male01/excuseme01.wav", "vo/npc/male01/excuseme02.wav"})
NDB.AddEmote("you sure about that?", "vo/npc/male01/answer37.wav", true)
NDB.AddEmote("groan", "vo/npc/male01/moan04.wav", true)
NDB.AddEmote("gasp", {"vo/npc/male01/startle01.wav", "vo/npc/male01/startle02.wav"}, true)
NDB.AddEmote("sorry", {"vo/npc/male01/sorry01.wav", "vo/npc/male01/sorry02.wav", "vo/npc/male01/sorry03.wav"})
NDB.AddEmote("welcome to city 17", {"vo/Breencast/br_welcome01.wav", "vo/Breencast/br_welcome06.wav"}, true)
NDB.AddEmote("it's safer here", "vo/Breencast/br_welcome07.wav", true)
NDB.AddEmote("i'm talking to you", "vo/Breencast/br_tofreeman02.wav", true)
NDB.AddEmote("serve mankind", "vo/Breencast/br_tofreeman12.wav", true)
NDB.AddEmote("get going", {"vo/canals/shanty_go_nag03.wav", "vo/trainyard/cit_blocker_go01.wav", "vo/trainyard/cit_blocker_go03.wav"})
NDB.AddEmote("go on out", "vo/canals/gunboat_goonout.wav", true)
NDB.AddEmote("get outta here", {"vo/canals/shanty_go_nag01.wav", "vo/canals/boxcar_go_nag03.wav"})
NDB.AddEmote("go on", {"vo/canals/shanty_go_nag02.wav", "vo/trainyard/cit_blocker_go02.wav"})
NDB.AddEmote("hey", "vo/canals/shanty_hey.wav")
NDB.AddEmote("get in here hurry", "vo/canals/matt_getin.wav", true)
NDB.AddEmote("hit the road jack", "vo/canals/boxcar_go_nag04.wav", true)
NDB.AddEmote("no", "vo/Citadel/eli_notobreen.wav")
NDB.AddEmote("no!", "vo/Citadel/br_failing11.wav", true)
NDB.AddEmote("never", "vo/Citadel/eli_nonever.wav")
NDB.AddEmote("you fool", "vo/Citadel/br_youfool.wav", true)
NDB.AddEmote("good god", "vo/Citadel/eli_goodgod.wav")
NDB.AddEmote("cheer", {"vo/coast/odessa/male01/nlo_cheer01.wav", "vo/coast/odessa/male01/nlo_cheer02.wav", "vo/coast/odessa/male01/nlo_cheer03.wav", "vo/coast/odessa/male01/nlo_cheer04.wav"}, true)
NDB.AddEmote("drive safely", "vo/coast/odessa/male01/nlo_citizen_drivesafe.wav", true)
NDB.AddEmote("whoops", "vo/k_lab/ba_whoops.wav", true)
NDB.AddEmote("gee thanks", "vo/k_lab/ba_geethanks.wav", true)
NDB.AddEmote("what the hell", "vo/k_lab/ba_whatthehell.wav")
NDB.AddEmote("it's your pet the freakin headhumper", "vo/k_lab/ba_headhumper01.wav", true)
NDB.AddEmote("i'll stay here", "vo/npc/male01/illstayhere01.wav")
NDB.AddEmote("i'm sticking here", "vo/npc/male01/imstickinghere01.wav", true)
NDB.AddEmote("up there", {"vo/npc/male01/upthere01.wav", "vo/npc/male01/upthere02.wav"})
NDB.AddEmote("lead the way", {"vo/npc/male01/leadtheway02.wav", "vo/npc/male01/leadtheway01.wav"}, true)
NDB.AddEmote("over there", {"vo/npc/male01/overthere01.wav", "vo/npc/male01/overthere02.wav"})
NDB.AddEmote("ok i'm ready", {"vo/npc/male01/okimready01.wav", "vo/npc/male01/okimready02.wav", "vo/npc/male01/okimready03.wav"})
NDB.AddEmote("i'm with you", "vo/npc/male01/answer13.wav", true)
NDB.AddEmote("hey over here", "vo/npc/male01/overhere01.wav", true)
NDB.AddEmote("behind you", {"vo/npc/male01/behindyou01.wav", "vo/npc/male01/behindyou02.wav"})
NDB.AddEmote("follow me", "vo/npc/male01/squad_away03.wav")
NDB.AddEmote("pardon me", {"vo/npc/male01/pardonme01.wav", "vo/npc/male01/pardonme02.wav"})
NDB.AddEmote("got one", {"vo/npc/male01/gotone01.wav", "vo/npc/male01/gotone02.wav"}, true)
NDB.AddEmote("finally", "vo/npc/male01/finally.wav")
NDB.AddEmote("wait for me", "vo/npc/male01/squad_reinforce_single04.wav")
NDB.AddEmote("take cover", "vo/npc/male01/takecover02.wav")
NDB.AddEmote("that's a manhack", "vo/npc/male01/itsamanhack01.wav", true)
NDB.AddEmote("it's a manhack", "vo/npc/male01/itsamanhack02.wav", true)
NDB.AddEmote("incoming", "vo/npc/male01/incoming02.wav")
NDB.AddEmote("ready when you are", {"vo/npc/male01/readywhenyouare01.wav", "vo/npc/male01/readywhenyouare02.wav"}, true)
NDB.AddEmote("don't forget hawaii", "vo/npc/male01/answer34.wav", true)
NDB.AddEmote("that's enough outta you", "vo/npc/male01/answer39.wav", true)
NDB.AddEmote("wait for us", "vo/npc/male01/squad_reinforce_group04.wav")
NDB.AddEmote("we trusted you", {"vo/npc/male01/wetrustedyou01.wav", "vo/npc/male01/wetrustedyou02.wav"}, true)
NDB.AddEmote("god i'm hungry", "vo/npc/male01/question28.wav", true)
NDB.AddEmote("you're talking to yourself again", "vo/npc/male01/answer09.wav", true)
NDB.AddEmote("come on everybody", "vo/npc/male01/squad_follow02.wav", true)
NDB.AddEmote("watch what you're doing", "vo/npc/male01/watchwhat.wav", true)
NDB.AddEmote("your mind is in the gutter", "vo/npc/male01/answer20.wav", true)
NDB.AddEmote("here they come!", "vo/npc/male01/heretheycome01.wav", true)
NDB.AddEmote("same here", "vo/npc/male01/answer07.wav")
NDB.AddEmote("i wouldn't say that too loud", "vo/npc/male01/answer10.wav", true)
NDB.AddEmote("i'll put it on your tombstone", "vo/npc/male01/answer11.wav", true)
NDB.AddEmote("have you ever had an original thought?", "vo/npc/male01/answer16.wav", true)
NDB.AddEmote("let's concentrate on the task at hand", "vo/npc/male01/answer18.wav", true)
NDB.AddEmote("keep your mind on your work", "vo/npc/male01/answer19.wav", true)
NDB.AddEmote("you never know", "vo/npc/male01/answer22.wav", true)
NDB.AddEmote("you never can tell", "vo/npc/male01/answer23.wav", true)
NDB.AddEmote("why are you telling me?", "vo/npc/male01/answer24.wav", true)
NDB.AddEmote("how about that", "vo/npc/male01/answer25.wav", true)
NDB.AddEmote("want a bet?", "vo/npc/male01/answer27.wav")
NDB.AddEmote("what am i supposed to do about it?", "vo/npc/male01/answer29.wav")
NDB.AddEmote("you talking to me?", "vo/npc/male01/answer30.wav")
NDB.AddEmote("leave it alone", "vo/npc/male01/answer38.wav", true)
NDB.AddEmote("can't you see i'm busy?", "vo/npc/male01/busy02.wav", true)
NDB.AddEmote("look out below", "vo/npc/male01/cit_dropper04.wav", true)
NDB.AddEmote("shouldn't we be doing something?", "vo/npc/male01/doingsomething.wav", true)
NDB.AddEmote("let's even the odds a little", "vo/npc/male01/evenodds.wav", true)
NDB.AddEmote("hold down this spot", {"vo/npc/male01/holddownspot01.wav", "vo/npc/male01/holddownspot02.wav"}, true)
NDB.AddEmote("i'm hurt", {"vo/npc/male01/imhurt01.wav", "vo/npc/male01/imhurt02.wav"}, true)
NDB.AddEmote("im hurt", {"vo/npc/male01/imhurt01.wav", "vo/npc/male01/imhurt02.wav"}, true)
NDB.AddEmote("sometimes i dream about cheese", "vo/npc/male01/question06.wav", true)
NDB.AddEmote("i can't remember the last time i had a shower", "vo/npc/male01/question19.wav", true)
NDB.AddEmote("watch what you're doing", "vo/npc/male01/watchwhat.wav", true)
NDB.AddEmote("you got it", "vo/npc/male01/yougotit02.wav")
NDB.AddEmote("we thought you were here to help", {"vo/npc/male01/heretohelp01.wav", "vo/npc/male01/heretohelp02.wav"}, true)
NDB.AddEmote("hey doc", {"vo/npc/male01/heydoc01.wav", "vo/npc/male01/heydoc02.wav"}, true)
NDB.AddEmote("hit in the gut", {"vo/npc/male01/hitingut01.wav", "vo/npc/male01/hitingut02.wav"}, true)
NDB.AddEmote("like that?", "vo/npc/male01/likethat.wav", true)
NDB.AddEmote("my leg", {"vo/npc/male01/myleg01.wav", "vo/npc/male01/myleg02.wav"}, true)
NDB.AddEmote("my gut", "vo/npc/male01/mygut02.wav", true)
NDB.AddEmote("my arm", {"vo/npc/male01/myarm01.wav", "vo/npc/male01/myarm02.wav"}, true)
NDB.AddEmote("no no", "vo/npc/male01/no01.wav")
NDB.AddEmote("you're not the man i thought you were", {"vo/npc/male01/notthemanithought01.wav", "vo/npc/male01/notthemanithought02.wav"}, true)
NDB.AddEmote("one for me and one for me", "vo/npc/male01/oneforme.wav", true)
NDB.AddEmote("let me get out of your way", "vo/npc/male01/outofyourway02.wav", true)
NDB.AddEmote("i don't think this war is ever going to end", "vo/npc/male01/question01.wav", true)
NDB.AddEmote("to think all i used to want to do is sell insurance", "vo/npc/male01/question02.wav", true)
NDB.AddEmote("i don't dream anymore", "vo/npc/male01/question03.wav", true)
NDB.AddEmote("when this is all over ah who am i kidding", "vo/npc/male01/question04.wav", true)
NDB.AddEmote("woah deja vu", "vo/npc/male01/question05.wav", true)
NDB.AddEmote("you smell that? it's freedom", "vo/npc/male01/question07.wav", true)
NDB.AddEmote("if i ever get my hands on dr. breen", "vo/npc/male01/question08.wav", true)
NDB.AddEmote("i could eat a horse hooves and all", "vo/npc/male01/question09.wav", true)
NDB.AddEmote("i can't believe this day has finally come", "vo/npc/male01/question10.wav", true)
NDB.AddEmote("i'm pretty sure this isn't part of the plan", "vo/npc/male01/question11.wav", true)
NDB.AddEmote("looks to me like things are getting worse not better", "vo/npc/male01/question12.wav", true)
NDB.AddEmote("if i could live my life over again", "vo/npc/male01/question13.wav", true)
NDB.AddEmote("i'm not even gonna tell you what that reminds me of", "vo/npc/male01/question14.wav", true)
NDB.AddEmote("they're never gonna make a stalker outta me", "vo/npc/male01/question15.wav", true)
NDB.AddEmote("finally change is in the air", "vo/npc/male01/question16.wav", true)
NDB.AddEmote("you feel it? i feel it", "vo/npc/male01/question17.wav", true)
NDB.AddEmote("i don't feel anything anymore", "vo/npc/male01/question18.wav", true)
NDB.AddEmote("some day this will all be a bad memory", "vo/npc/male01/question20.wav", true)
NDB.AddEmote("i'm not a betting man but the odds are not good", "vo/npc/male01/question21.wav", true)
NDB.AddEmote("doesn't anyone care what i think?", "vo/npc/male01/question22.wav", true)
NDB.AddEmote("i can't get this tune outta my head", "vo/npc/male01/question23.wav", true)
NDB.AddEmote("i just knew it was gonna be one of those days", "vo/npc/male01/question25.wav", true)
NDB.AddEmote("i think i ate something bad", "vo/npc/male01/question27.wav", true)
NDB.AddEmote("when this is all over i'm gonna mate", "vo/npc/male01/question29.wav", true)
NDB.AddEmote("i'm glad there's no kids around to see this", "vo/npc/male01/question30.wav", true)
NDB.AddEmote("scanners", {"vo/npc/male01/scanners01.wav", "vo/npc/male01/scanners02.wav"}, true)
NDB.AddEmote("whatever you say", "vo/npc/male01/squad_affirm03.wav")
NDB.AddEmote("ok i'm going", "vo/npc/male01/squad_affirm04.wav", true)
NDB.AddEmote("here it goes", "vo/npc/male01/squad_affirm05.wav", true)
NDB.AddEmote("here goes nothing", "vo/npc/male01/squad_affirm06.wav", true)
NDB.AddEmote("here we come", "vo/npc/male01/squad_approach02.wav", true)
NDB.AddEmote("on our way", "vo/npc/male01/squad_approach03.wav", true)
NDB.AddEmote("coming", "vo/npc/male01/squad_approach04.wav")
NDB.AddEmote("this way gang", "vo/npc/male01/squad_away01.wav", true)
NDB.AddEmote("over here", "vo/npc/male01/squad_away02.wav")
NDB.AddEmote("let's get moving", "npc/male01/squad_follow03.wav")
NDB.AddEmote("gordon freeman, you're here", "vo/npc/male01/squad_greet01.wav", true)
NDB.AddEmote("stop it freeman", "vo/npc/male01/stopitfm.wav", true)
NDB.AddEmote("strider", "vo/npc/male01/strider.wav", true)
NDB.AddEmote("this'll do nicely", "vo/npc/male01/thislldonicely01.wav", true)
NDB.AddEmote("damn vorts", "vo/npc/male01/vanswer02.wav", true)
NDB.AddEmote("i'm not sure how to take that", "vo/npc/male01/vanswer03.wav", true)
NDB.AddEmote("should i take that personally?", "vo/npc/male01/vanswer04.wav", true)
NDB.AddEmote("speak english", "vo/npc/male01/vanswer05.wav", true)
NDB.AddEmote("you got that from me", "vo/npc/male01/vanswer06.wav", true)
NDB.AddEmote("that's why we put up with you", "vo/npc/male01/vanswer07.wav", true)
NDB.AddEmote("couldn't have put it better myself", "vo/npc/male01/vanswer08.wav", true)
NDB.AddEmote("that almost made sense", "vo/npc/male01/vanswer09.wav", true)
NDB.AddEmote("something must be wrong with me i almost understood that", "vo/npc/male01/vanswer10.wav", true)
NDB.AddEmote("i guess i'm getting used to you vorts", "vo/npc/male01/vanswer11.wav", true)
NDB.AddEmote("none of your vort philosophy", "vo/npc/male01/vanswer12.wav", true)
NDB.AddEmote("stop you're killing me", "vo/npc/male01/vanswer13.wav", true)
NDB.AddEmote("what did i do to deserve this?", "vo/npc/male01/vanswer14.wav", true)
NDB.AddEmote("stop looking at me like that", "vo/npc/male01/vquestion01.wav", true)
NDB.AddEmote("some things i just never get used to", "vo/npc/male01/vquestion02.wav", true)
NDB.AddEmote("i don't know how you things survived as long as you have", "vo/npc/male01/vquestion03.wav", true)
NDB.AddEmote("sometimes i wonder how i ended up with you", "vo/npc/male01/vquestion04.wav", true)
NDB.AddEmote("you're alright vorty", "vo/npc/male01/vquestion05.wav", true)
NDB.AddEmote("you vorts aren't half bad", "vo/npc/male01/vquestion06.wav", true)
NDB.AddEmote("if anyone ever told me i'd be pals with a vortigaunt", "vo/npc/male01/vquestion07.wav", true)
NDB.AddEmote("you waiting for somebody?", "vo/npc/male01/waitingsomebody.wav", true)
NDB.AddEmote("woops", "vo/npc/male01/whoops01.wav", true)
NDB.AddEmote("you'd better reload", "vo/npc/male01/youdbetterreload01.wav", true)
NDB.AddEmote("bring it on", "vo/npc/Barney/ba_bringiton.wav", true)
NDB.AddEmote("damnit", "vo/npc/Barney/ba_damnit.wav")
NDB.AddEmote("i don't like the looks of this", "vo/npc/Barney/ba_danger02.wav", true)
NDB.AddEmote("down you go", "vo/npc/Barney/ba_downyougo.wav", true)
NDB.AddEmote("duck", "vo/npc/Barney/ba_duck.wav")
NDB.AddEmote("come on", "vo/npc/Barney/ba_followme02.wav")
NDB.AddEmote("get away from there", "vo/npc/Barney/ba_getaway.wav")
NDB.AddEmote("get outta the way", "vo/npc/Barney/ba_getoutofway.wav")
NDB.AddEmote("you're going down", "vo/npc/Barney/ba_goingdown.wav", true)
NDB.AddEmote("grenade", {"vo/npc/Barney/ba_grenade01.wav", "vo/npc/Barney/ba_grenade02.wav"}, true)
NDB.AddEmote("here it comes!", "vo/npc/Barney/ba_hereitcomes.wav", true)
NDB.AddEmote("hurry up", "vo/npc/Barney/ba_hurryup.wav")
NDB.AddEmote("i'm with you buddy", "vo/npc/Barney/ba_imwithyou.wav", true)
NDB.AddEmote("maniacal!", {"vo/npc/Barney/ba_laugh01.wav", "vo/npc/Barney/ba_laugh02.wav", "vo/npc/Barney/ba_laugh04.wav"}, true)
NDB.AddEmote("yeaheheah", "vo/npc/Barney/ba_laugh03.wav", true)
NDB.AddEmote("let's do it", "vo/npc/Barney/ba_letsdoit.wav", true)
NDB.AddEmote("look out!", "vo/npc/Barney/ba_lookout.wav", true)
NDB.AddEmote("i haven't lost my touch", "vo/npc/Barney/ba_losttouch.wav", true)
NDB.AddEmote("ohoh yeah", "vo/npc/Barney/ba_ohyeah.wav", true)
NDB.AddEmote("soldiers!", "vo/npc/Barney/ba_soldiers.wav", true)
NDB.AddEmote("turret!", "vo/npc/Barney/ba_turret.wav", true)
NDB.AddEmote("uh oh here they come", "vo/npc/Barney/ba_uhohheretheycome.wav", true)
NDB.AddEmote("i need to get patched up", "vo/npc/Barney/ba_wounded02.wav", true)
NDB.AddEmote("i'm hurt pretty bad", "vo/npc/Barney/ba_wounded03.wav", true)
NDB.AddEmote("i know you will", "vo/NovaProspekt/eli_iknow.wav", true)
NDB.AddEmote("nevermind me save yourselves", "vo/NovaProspekt/eli_nevermindme01.wav", true)
NDB.AddEmote("i'll see you there baby", "vo/NovaProspekt/eli_notime01.wav", true)
NDB.AddEmote("so this is the combine portal it's smaller than i imagined", "vo/NovaProspekt/eli_thisisportal.wav", true)
NDB.AddEmote("but where will you go?", "vo/NovaProspekt/eli_wherewillyougo01.wav", true)
NDB.AddEmote("instinct1", "vo/Breencast/br_instinct01.wav", true)
NDB.AddEmote("instinct2", "vo/Breencast/br_instinct03.wav", true)
NDB.AddEmote("instinct3", "vo/Breencast/br_instinct08.wav", true)
NDB.AddEmote("instinct4", "vo/Breencast/br_instinct09.wav", true)
NDB.AddEmote("instinct5", "vo/Breencast/br_instinct12.wav", true)
NDB.AddEmote("instinct6", "vo/Breencast/br_instinct14.wav", true)
NDB.AddEmote("instinct7", "vo/Breencast/br_instinct15.wav", true)
NDB.AddEmote("instinct8", "vo/Breencast/br_instinct16.wav", true)
NDB.AddEmote("instinct9", "vo/Breencast/br_instinct17.wav", true)
NDB.AddEmote("instinct10", "vo/Breencast/br_instinct18.wav", true)
NDB.AddEmote("instinct11", "vo/Breencast/br_instinct19.wav", true)
NDB.AddEmote("instinct12", "vo/Breencast/br_instinct20.wav", true)
NDB.AddEmote("instinct13", "vo/Breencast/br_instinct21.wav", true)
NDB.AddEmote("instinct14", "vo/Breencast/br_instinct22.wav", true)
NDB.AddEmote("instinct15", "vo/Breencast/br_instinct23.wav", true)
NDB.AddEmote("instinct16", "vo/Breencast/br_instinct25.wav", true)
NDB.AddEmote("you have plunged humanity in to free fall", "vo/Breencast/br_tofreeman06.wav", true)
NDB.AddEmote("even if you offered your surrunder now", "vo/Breencast/br_tofreeman07.wav", true)
NDB.AddEmote("help ensure that humanity's trust in you is not misguided", "vo/Breencast/br_tofreeman10.wav", true)
NDB.AddEmote("they're shelling us", "vo/canals/male01/stn6_shellingus.wav", true)
NDB.AddEmote("incoming!", "vo/canals/male01/stn6_incoming.wav", true)
NDB.AddEmote("you can park the boat it'll be safe here", "vo/canals/male01/gunboat_parkboat.wav", true)
NDB.AddEmote("let's get a move on we gotta move out before they target us", "vo/canals/male01/gunboat_moveon.wav", true)
NDB.AddEmote("you made it just in time we gotta clear outta here before we're discovered", "vo/canals/male01/gunboat_justintime.wav", true)
NDB.AddEmote("we'd better hurry we gotta tear down this camp and get outta here", "vo/canals/male01/gunboat_hurry.wav", true)
NDB.AddEmote("be careful now", "vo/canals/boxcar_becareful.wav", true)
NDB.AddEmote("we really can't afford to get noticed", "vo/canals/boxcar_becareful_b.wav", true)
NDB.AddEmote("better get going", "vo/canals/boxcar_go_nag02.wav", true)
NDB.AddEmote("he'll help you if you let him", "vo/canals/boxcar_lethimhelp.wav", true)
NDB.AddEmote("we're just a lookout for the underground railroad", "vo/canals/boxcar_lookout.wav", true)
NDB.AddEmote("main station's right around the corner", "vo/canals/boxcar_lookout_b.wav", true)
NDB.AddEmote("they'll get you started on the right foot", "vo/canals/boxcar_lookout_d.wav", true)
NDB.AddEmote("guess those sirens are for you", "vo/canals/boxcar_sirens.wav", true)
NDB.AddEmote("come on in i'll show you what you're up against", "vo/canals/gunboat_comein.wav", true)
NDB.AddEmote("i think he's just finishing up now", "vo/canals/gunboat_finishingup.wav", true)
NDB.AddEmote("come on get in here", "vo/canals/gunboat_getin.wav", true)
NDB.AddEmote("here take a look at this", "vo/canals/gunboat_herelook.wav", true)
NDB.AddEmote("be glad you're not the guy they're looking for", "vo/canals/matt_beglad.wav", true)
NDB.AddEmote("poor bastard doesn't stand a chance", "vo/canals/matt_beglad_b.wav", true)
NDB.AddEmote("sounds like they're calling in every cp unit in city 17", "vo/canals/matt_beglad_c.wav", true)
NDB.AddEmote("that was a close call thanks for your help", "vo/canals/matt_closecall.wav", true)
NDB.AddEmote("now they're flooding the areas up ahead with manhacks", "vo/canals/matt_flood.wav", true)
NDB.AddEmote("you'd better get going before they sweep through here", "vo/canals/matt_flood_b.wav", true)
NDB.AddEmote("you'd better get going now", "vo/canals/matt_go_nag01.wav", true)
NDB.AddEmote("thanks but i'll be ok", "vo/canals/matt_go_nag02.wav", true)
NDB.AddEmote("i've got to stay and help any stragglers", "vo/canals/matt_go_nag03.wav", true)
NDB.AddEmote("you go on", "vo/canals/matt_go_nag05.wav", true)
NDB.AddEmote("good luck out there", "vo/canals/matt_goodluck.wav", true)
NDB.AddEmote("civil protection is on to us", "vo/canals/matt_tearinguprr.wav", true)
NDB.AddEmote("we're tearing up the railroad covering our tracks", "vo/canals/matt_tearinguprr_a.wav", true)
NDB.AddEmote("looks like you're gonna be the last one through", "vo/canals/matt_tearinguprr_b.wav", true)
NDB.AddEmote("thanks for the help but you better get outta here", "vo/canals/matt_thanksbut.wav", true)
NDB.AddEmote("oh shit too late", "vo/canals/matt_toolate.wav", true)
NDB.AddEmote("you got here at a bad time", "vo/canals/shanty_badtime.wav", true)
NDB.AddEmote("we got some ammo in those crates over there", "vo/canals/shanty_gotsomeammo.wav", true)
NDB.AddEmote("we got word you were coming", "vo/canals/shanty_gotword.wav", true)
NDB.AddEmote("help yourself to supplies and keep moving", "vo/canals/shanty_helpyourself.wav", true)
NDB.AddEmote("did you realize your contract was open to the highest bidder?", "vo/Citadel/br_bidder_b.wav", true)
NDB.AddEmote("that's all up to you my old friend", "vo/Citadel/br_gift_a.wav", true)
NDB.AddEmote("will you give your child a chance her mother never had?", "vo/Citadel/br_gift_c.wav", true)
NDB.AddEmote("what's this oh put it over there", "vo/Citadel/br_gravgun.wav", true)
NDB.AddEmote("guards get in here", "vo/Citadel/br_guards.wav", true)
NDB.AddEmote("you have my gratitude doctor", "vo/Citadel/br_guest_b.wav", true)
NDB.AddEmote("and then you deliver yourself?", "vo/Citadel/br_guest_d.wav", true)
NDB.AddEmote("i don't know what you can possibly hope to achieve", "vo/Citadel/br_mock05.wav", true)
NDB.AddEmote("i warned you this was futile", "vo/Citadel/br_mock06.wav", true)
NDB.AddEmote("i hope you said your farewells", "vo/Citadel/br_mock09.wav", true)
NDB.AddEmote("if only you had harnessed your boundless energy for a useful purpose", "vo/Citadel/br_mock13.wav", true)
NDB.AddEmote("i agree it's a total waste", "vo/Citadel/br_newleader_a.wav", true)
NDB.AddEmote("this one has proven to be a fine pawn", "vo/Citadel/br_newleader_c.wav", true)
NDB.AddEmote("i understand if you don't wish to discuss this in front of your friends", "vo/Citadel/br_nothingtosay_a.wav", true)
NDB.AddEmote("i'll send them on their way and then we can talk openly", "vo/Citadel/br_nothingtosay_b.wav", true)
NDB.AddEmote("impossible to describe with our limited vocabulary", "vo/Citadel/br_oheli09.wav", true)
NDB.AddEmote("oh shit", "vo/Citadel/br_ohshit.wav", true)
NDB.AddEmote("if you won't do the right thing for the good of all people", "vo/Citadel/br_playgame_b.wav", true)
NDB.AddEmote("maybe you'll do it for one of them", "vo/Citadel/br_playgame_c.wav", true)
NDB.AddEmote("thanks to you we have everything we need in that regard", "vo/Citadel/br_rabble_a.wav", true)
NDB.AddEmote("you're more than qualified to finish his research yourself", "vo/Citadel/br_rabble_b.wav", true)
NDB.AddEmote("if that's what it takes", "vo/Citadel/br_whatittakes.wav", true)
NDB.AddEmote("you need me", "vo/Citadel/br_youneedme.wav", true)
NDB.AddEmote("don't struggle honey", "vo/Citadel/eli_dontstruggle.wav", true)
NDB.AddEmote("don't worry about me", "vo/Citadel/eli_dontworryboutme.wav", true)
NDB.AddEmote("that's my girl", "vo/Citadel/eli_mygirl.wav", true)
NDB.AddEmote("save them for what", "vo/Citadel/eli_save.wav", true)
NDB.AddEmote("is it really that time again?", "vo/Citadel/gman_exit02.wav", true)
NDB.AddEmote("i'm really not at liberty to say", "vo/Citadel/gman_exit08.wav", true)
NDB.AddEmote("in the meantime", "vo/Citadel/gman_exit09.wav", true)
NDB.AddEmote("this is where i get off", "vo/Citadel/gman_exit10.wav", true)
NDB.AddEmote("they're looking for your car", "vo/coast/barn/male01/chatter.wav", true)
NDB.AddEmote("here come the dropships", "vo/coast/barn/male01/crapships.wav", true)
NDB.AddEmote("right along there and watch your step", "vo/coast/barn/male01/exit_watchstep.wav", true)
NDB.AddEmote("get your car in the barn", "vo/coast/barn/male01/getcarinbarn.wav", true)
NDB.AddEmote("get your car in the garage", "vo/coast/barn/male01/getcaringarage.wav", true)
NDB.AddEmote("get off the road", "vo/coast/barn/male01/getoffroad01.wav", true)
NDB.AddEmote("incoming dropship", "vo/coast/barn/male01/incomingdropship.wav", true)
NDB.AddEmote("it's a gunship", "vo/coast/barn/male01/lite_gunship01.wav", true)
NDB.AddEmote("gunship", "vo/coast/barn/male01/lite_gunship02.wav", true)
NDB.AddEmote("park it there", "vo/coast/barn/male01/parkit.wav", true)
NDB.AddEmote("you made it", "vo/coast/barn/male01/youmadeit.wav", true)
NDB.AddEmote("you idiot walking on the sand brings antlions after you", "vo/coast/bugbait/sandy_youidiot.wav", true)
NDB.AddEmote("you there", "vo/coast/bugbait/sandy_youthere.wav", true)
NDB.AddEmote("stop where you are stay on the rocks", "vo/coast/bugbait/sandy_stop.wav", true)
NDB.AddEmote("no! help!", "vo/coast/bugbait/sandy_help.wav", true)
NDB.AddEmote("yeah good idea hold on a sec", "vo/coast/cardock/le_goodidea.wav", true)
NDB.AddEmote("patch him up and get him to the back as soon as he's stable", "vo/coast/cardock/le_patchhim.wav", true)
NDB.AddEmote("i'll radio ahead to let the next base know you're coming", "vo/coast/cardock/le_radio.wav", true)
NDB.AddEmote("who's hurt?", "vo/coast/cardock/le_whohurt.wav", true)
NDB.AddEmote("well that's that", "vo/coast/odessa/nlo_cub_thatsthat.wav", true)
NDB.AddEmote("i couldn't have asked for a finer volunteer", "vo/coast/odessa/nlo_cub_volunteer.wav", true)
NDB.AddEmote("you'll make it through if anyone can", "vo/coast/odessa/nlo_cub_youllmakeit.wav", true)
NDB.AddEmote("good to know you", "vo/eli_lab/airlock_cit01.wav", true)
NDB.AddEmote("you'd better get going", "vo/eli_lab/airlock_cit02.wav", true)
NDB.AddEmote("awesome!", "vo/eli_lab/al_awesome.wav", true)
NDB.AddEmote("alright good you keep right on it", "vo/eli_lab/eli_goodvort.wav", true)
NDB.AddEmote("ughghgh", "vo/eli_lab/eli_handle_b.wav", true)
NDB.AddEmote("ughhh", "vo/k_lab/ba_thingaway02.wav", true)
NDB.AddEmote("feel free to look around", "vo/eli_lab/eli_lookaround.wav", true)
NDB.AddEmote("dr. breen", "vo/eli_lab/eli_vilebiz01.wav", true)
NDB.AddEmote("i can't look", "vo/k_lab/ba_cantlook.wav", true)
NDB.AddEmote("careful", "vo/k_lab/ba_careful01.wav")
NDB.AddEmote("be careful!", "vo/k_lab/ba_careful01.wav", true)
NDB.AddEmote("forget about that thing", "vo/k_lab/ba_forgetthatthing.wav", true)
NDB.AddEmote("get it off me", "vo/k_lab/ba_getitoff02.wav", true)
NDB.AddEmote("get down outta sight", "vo/k_lab/ba_getoutofsight01.wav", true)
NDB.AddEmote("i'll come find you", "vo/k_lab/ba_getoutofsight02.wav", true)
NDB.AddEmote("guh", "vo/k_lab/ba_guh.wav", true)
NDB.AddEmote("hey hey he's back", "vo/k_lab/ba_hesback01.wav", true)
NDB.AddEmote("i'm getting him outta there", "vo/k_lab/ba_hesback02.wav", true)
NDB.AddEmote("well is he here?", "vo/k_lab/ba_ishehere.wav", true)
NDB.AddEmote("you mean it's working?", "vo/k_lab/ba_itsworking01.wav", true)
NDB.AddEmote("for real this time?", "vo/k_lab/ba_itsworking02.wav", true)
NDB.AddEmote("i still have nightmares about that cat", "vo/k_lab/ba_itsworking04.wav", true)
NDB.AddEmote("i've gotta get back on my shift", "vo/k_lab/ba_myshift01.wav", true)
NDB.AddEmote("but ok", "vo/k_lab/ba_myshift02.wav")
NDB.AddEmote("yeah longer if we're lucky", "vo/k_lab/ba_longer.wav", true)
NDB.AddEmote("and not a moment too soon", "vo/k_lab/ba_nottoosoon01.wav", true)
NDB.AddEmote("that's what you said last time", "vo/k_lab/ba_saidlasttime.wav", true)
NDB.AddEmote("i can see your mit education really pays for itself", "vo/k_lab/ba_sarcastic03.wav", true)
NDB.AddEmote("i thought you got rid of that pest", "vo/k_lab/ba_thatpest.wav", true)
NDB.AddEmote("there he is", "vo/k_lab/ba_thereheis.wav", true)
NDB.AddEmote("there you are", "vo/k_lab/ba_thereyouare.wav", true)
NDB.AddEmote("here we go", "vo/k_lab/ba_thingaway01.wav", true)
NDB.AddEmote("get that thing away from me", "vo/k_lab/ba_thingaway03.wav", true)
NDB.AddEmote("what's the meaning of this?", "vo/k_lab/br_tele_02.wav", true)
NDB.AddEmote("who are you?", "vo/k_lab/br_tele_03.wav")
NDB.AddEmote("how did you get in here?", "vo/k_lab/br_tele_05.wav", true)
NDB.AddEmote("see for yourself", "vo/k_lab/eli_seeforyourself.wav", true)
NDB.AddEmote("shut it down shut it down", "vo/k_lab/eli_shutdown.wav", true)
NDB.AddEmote("ahhhh", "vo/k_lab/kl_ahhhh.wav", true)
NDB.AddEmote("there's a charger on the wall", "vo/k_lab/kl_charger01.wav", true)
NDB.AddEmote("dear me", "vo/k_lab/kl_dearme.wav", true)
NDB.AddEmote("well did it work?", "vo/k_lab/kl_diditwork.wav", true)
NDB.AddEmote("excellent!", "vo/k_lab/kl_excellent.wav", true)
NDB.AddEmote("right you are", "vo/k_lab/kl_fewmoments01.wav", true)
NDB.AddEmote("speak to you again in a few moments", "vo/k_lab/kl_fewmoments02.wav", true)
NDB.AddEmote("oh fiddlesticks what now", "vo/k_lab/kl_fiddlesticks.wav", true)
NDB.AddEmote("final sequence", "vo/k_lab/kl_finalsequence02.wav", true)
NDB.AddEmote("you must get out of here", "vo/k_lab/kl_getoutrun02.wav", true)
NDB.AddEmote("run!", "vo/k_lab/kl_getoutrun03.wav", true)
NDB.AddEmote("here my pet", "vo/k_lab/kl_heremypet01.wav", true)
NDB.AddEmote("no not up there", "vo/k_lab/kl_heremypet02.wav", true)
NDB.AddEmote("interference!", "vo/k_lab/kl_interference.wav", true)
NDB.AddEmote("lamarr", "vo/k_lab/kl_hedyno01.wav", true)
NDB.AddEmote("heady", "vo/k_lab/kl_hedyno02.wav", true)
NDB.AddEmote("is lamarr with him?", "vo/k_lab/kl_islamarr.wav", true)
NDB.AddEmote("lamarr there you are", "vo/k_lab/kl_lamarr.wav", true)
NDB.AddEmote("careful lamarr those are quite fragile", "vo/k_lab/kl_nocareful.wav", true)
NDB.AddEmote("conditions could hardly be more ideal", "vo/k_lab/kl_moduli02.wav", true)
NDB.AddEmote("my goodness", "vo/k_lab/kl_mygoodness01.wav", true)
NDB.AddEmote("it really is you isn't it?", "vo/k_lab/kl_mygoodness03.wav", true)
NDB.AddEmote("your talents surpass your loveliness", "vo/k_lab/kl_nonsense.wav", true)
NDB.AddEmote("oh dear", "vo/k_lab/kl_ohdear.wav", true)
NDB.AddEmote("indeed it is", "vo/k_lab/kl_packing01.wav", true)
NDB.AddEmote("slip in to your suit now", "vo/k_lab/kl_slipin02.wav", true)
NDB.AddEmote("i'm eager to see if your old suit still fits", "vo/k_lab/kl_suitfits02.wav", true)
NDB.AddEmote("then where is he?", "vo/k_lab/kl_thenwhere.wav", true)
NDB.AddEmote("what is it?", "vo/k_lab/kl_whatisit.wav", true)
NDB.AddEmote("i wish i knew!", "vo/k_lab/kl_wishiknew.wav", true)
NDB.AddEmote("go on get going", "vo/k_lab2/ba_getgoing.wav", true)
NDB.AddEmote("well man that's good news", "vo/k_lab2/ba_goodnews.wav", true)
NDB.AddEmote("i almost gave you guys up for lost", "vo/k_lab2/ba_goodnews_b.wav", true)
NDB.AddEmote("i'll take all the help i can get", "vo/k_lab2/ba_goodnews_c.wav", true)
NDB.AddEmote("aw crap incoming!", "vo/k_lab2/ba_incoming.wav", true)
NDB.AddEmote("so there you see?", "vo/k_lab2/kl_notallhopeless.wav", true)
NDB.AddEmote("it's not all hopeless", "vo/k_lab2/kl_notallhopeless_b.wav", true)
NDB.AddEmote("there's only one heady", "vo/k_lab2/kl_onehedy.wav", true)
NDB.AddEmote("fascinating!", "vo/k_lab2/kl_slowteleport01.wav", true)
NDB.AddEmote("aim for the head", "vo/ravenholm/aimforhead.wav", true)
NDB.AddEmote("guard yourself well", "vo/ravenholm/bucket_guardwell.wav", true)
NDB.AddEmote("there you are at last", "vo/ravenholm/bucket_thereyouare.wav", true)
NDB.AddEmote("better than better", "vo/ravenholm/cartrap_better.wav", true)
NDB.AddEmote("yes come to me come", "vo/ravenholm/engage01.wav", true)
NDB.AddEmote("come!", {"vo/ravenholm/engage02.wav", "vo/ravenholm/engage03.wav"}, true)
NDB.AddEmote("i will end your torment", "vo/ravenholm/engage04.wav", true)
NDB.AddEmote("let me end your torment", "vo/ravenholm/engage05.wav", true)
NDB.AddEmote("yes my children it is i", "vo/ravenholm/engage06.wav", true)
NDB.AddEmote("come to the light i carry come", "vo/ravenholm/engage07.wav", true)
NDB.AddEmote("it is not me you want but the light that shines through me", "vo/ravenholm/engage08.wav", true)
NDB.AddEmote("come to the light", "vo/ravenholm/engage09.wav", true)
NDB.AddEmote("go quickly", "vo/ravenholm/exit_goquickly.wav", true)
NDB.AddEmote("hurry while i hold the gate", "vo/ravenholm/exit_hurry.wav", true)
NDB.AddEmote("flee brother", "vo/ravenholm/exit_nag01.wav", true)
NDB.AddEmote("onward to the mines", "vo/ravenholm/exit_nag02.wav", true)
NDB.AddEmote("look out brother behind you", "vo/ravenholm/firetrap_lookout.wav", true)
NDB.AddEmote("well done brother", "vo/ravenholm/firetrap_welldone.wav", true)
NDB.AddEmote("stay close to me brother", "vo/ravenholm/grave_stayclose.wav", true)
NDB.AddEmote("out of my way", "vo/ravenholm/monk_blocked01.wav", true)
NDB.AddEmote("look out", "vo/ravenholm/monk_blocked02.wav")
NDB.AddEmote("stand aside brother", "vo/ravenholm/monk_blocked03.wav", true)
NDB.AddEmote("cover me brother", "vo/ravenholm/monk_coverme01.wav", true)
NDB.AddEmote("your assistance brother", "vo/ravenholm/monk_coverme02.wav", true)
NDB.AddEmote("over here brother", "vo/ravenholm/monk_coverme03.wav", true)
NDB.AddEmote("to me brother", "vo/ravenholm/monk_coverme04.wav", true)
NDB.AddEmote("i require your assistance brother", "vo/ravenholm/monk_coverme05.wav", true)
NDB.AddEmote("where art thou brother", "vo/ravenholm/monk_coverme07.wav", true)
NDB.AddEmote("beware!", "vo/ravenholm/monk_danger02.wav", true)
NDB.AddEmote("careful brother", "vo/ravenholm/monk_danger03.wav", true)
NDB.AddEmote("i am outnumbered", "vo/ravenholm/monk_helpme01.wav", true)
NDB.AddEmote("help me brother", "vo/ravenholm/monk_helpme02.wav", true)
NDB.AddEmote("i cannot fight them all alone", "vo/ravenholm/monk_helpme03.wav", true)
NDB.AddEmote("lend a hand brother", "vo/ravenholm/monk_helpme04.wav", true)
NDB.AddEmote("i need help brother", "vo/ravenholm/monk_helpme05.wav", true)
NDB.AddEmote("rest my child", "vo/ravenholm/monk_kill03.wav", true)
NDB.AddEmote("i think no worse of thee", "vo/ravenholm/monk_kill04.wav", true)
NDB.AddEmote("may the light of lights be with you", "vo/ravenholm/monk_kill05.wav", true)
NDB.AddEmote("you meant no harm", "vo/ravenholm/monk_kill06.wav", true)
NDB.AddEmote("be free my child", "vo/ravenholm/monk_kill09.wav", true)
NDB.AddEmote("the grave holds nothing worse for you", "vo/ravenholm/monk_kill10.wav", true)
NDB.AddEmote("i remember your true face", "vo/ravenholm/monk_kill11.wav", true)
NDB.AddEmote("so again i am alone", "vo/ravenholm/monk_mourn03.wav", true)
NDB.AddEmote("my advice to you is aim for the head", "vo/ravenholm/shotgun_advice.wav", true)
NDB.AddEmote("here i have a more suitable gun for you", "vo/ravenholm/shotgun_bettergun.wav", true)
NDB.AddEmote("catch!", "vo/ravenholm/shotgun_catch.wav", true)
NDB.AddEmote("come closer", "vo/ravenholm/shotgun_closer.wav", true)
NDB.AddEmote("hush", "vo/ravenholm/shotgun_hush.wav")
NDB.AddEmote("good now keep it close", "vo/ravenholm/shotgun_keepitclose.wav", true)
NDB.AddEmote("they come", "vo/ravenholm/shotgun_theycome.wav", true)
NDB.AddEmote("if you can hold them off i'm almost done here", "vo/Streetwar/tunnel/male01/c17_06_det02.wav", true)
NDB.AddEmote("stand back it's gonna blow", "vo/Streetwar/tunnel/male01/c17_06_det04.wav", true)
NDB.AddEmote("hey it's me open the door", "vo/Streetwar/tunnel/male01/c17_06_password01.wav", true)
NDB.AddEmote("what's the password?", "vo/Streetwar/tunnel/male01/c17_06_password02.wav", true)
NDB.AddEmote("password!", "vo/Streetwar/tunnel/male01/c17_06_password03.wav", true)
NDB.AddEmote("come on in", "vo/Streetwar/tunnel/male01/c17_06_password04.wav", true)
NDB.AddEmote("ok come across", "vo/Streetwar/tunnel/male01/c17_06_plank01.wav", true)
NDB.AddEmote("that damn thing haunts me", "vo/Streetwar/sniper/ba_hauntsme.wav", true)
NDB.AddEmote("did you hear a cat just now?", "vo/Streetwar/sniper/ba_hearcat.wav", true)
NDB.AddEmote("hey come on", "vo/Streetwar/sniper/ba_heycomeon.wav", true)
NDB.AddEmote("let's get going", "vo/Streetwar/sniper/ba_letsgetgoing.wav", true)
NDB.AddEmote("heeelp", "vo/Streetwar/sniper/male01/c17_09_help01.wav", true)
NDB.AddEmote("help me!", "vo/Streetwar/sniper/male01/c17_09_help02.wav", true)
NDB.AddEmote("is somebody up there?", "vo/Streetwar/sniper/male01/c17_09_help03.wav", true)
NDB.AddEmote("damnit all", "vo/Streetwar/rubble/ba_damnitall.wav", true)
NDB.AddEmote("hey help me out here", "vo/Streetwar/rubble/ba_helpmeout.wav", true)
NDB.AddEmote("well i'll be damned", "vo/Streetwar/rubble/ba_illbedamned.wav", true)
NDB.AddEmote("and if you see dr. breen tell him i said fuck you", "vo/Streetwar/rubble/ba_tellbreen.wav", true)
NDB.AddEmote("done!", "vo/Streetwar/nexus/ba_done.wav", true)
NDB.AddEmote("great i'll open this up", "vo/Streetwar/nexus/ba_illopenthis.wav", true)
NDB.AddEmote("so much for stealth we've been spotted", "vo/Streetwar/nexus/ba_spotted.wav", true)
NDB.AddEmote("we're surrounded", "vo/Streetwar/nexus/ba_surrounded.wav", true)
NDB.AddEmote("then let's go", "vo/Streetwar/nexus/ba_thenletsgo.wav", true)
NDB.AddEmote("uh oh dropships", "vo/Streetwar/nexus/ba_uhohdropships.wav", true)
NDB.AddEmote("hey let us outta here", "vo/Streetwar/nexus/male01/c17_10_letusout.wav", true)
NDB.AddEmote("let us thru!", "vo/Streetwar/barricade/male01/c17_05_letusthru.wav", true)
NDB.AddEmote("let us through!", "vo/Streetwar/barricade/male01/c17_05_letusthru.wav", true)
NDB.AddEmote("open the gate!", "vo/Streetwar/barricade/male01/c17_05_opengate.wav", true)
NDB.AddEmote("how dare you even mention her", "vo/Citadel/al_dienow_b.wav", true)
NDB.AddEmote("alyx my dear you have your mother's eyes but your father's stubborn nature", "vo/Citadel/br_stubborn.wav", true)
NDB.AddEmote("it isn't necessary", "vo/Citadel/mo_necessary.wav", true)
NDB.AddEmote("he's dead", {"vo/npc/male01/gordead_ques01.wav", "vo/npc/male01/gordead_ques07.wav"}, true)
NDB.AddEmote("oh my god it's freeman", {"vo/npc/male01/gordead_ques03a.wav", "vo/npc/male01/gordead_ques03b.wav"}, true)
NDB.AddEmote("now what?", "vo/npc/male01/gordead_ans01.wav")
NDB.AddEmote("oh god", "vo/npc/male01/gordead_ans04.wav")
NDB.AddEmote("we're done for", "vo/npc/male01/gordead_ans14.wav", true)
NDB.AddEmote("i'm ganna be sick", "vo/npc/male01/gordead_ans19.wav", true)
NDB.AddEmote("should we bury him here?", "vo/npc/male01/gordead_ans08.wav", true)
NDB.AddEmote("what's the use?", "vo/npc/male01/gordead_ans11.wav", true)
NDB.AddEmote("what's the point?", "vo/npc/male01/gordead_ans12.wav", true)
NDB.AddEmote("this is bad", "vo/npc/male01/gordead_ques10.wav", true)
NDB.AddEmote("and things were going so well", "vo/npc/male01/gordead_ans02.wav", true)
NDB.AddEmote("don't tell me", "vo/npc/male01/gordead_ans03.wav", true)
NDB.AddEmote("please no", "vo/npc/male01/gordead_ans06.wav")
NDB.AddEmote("if you dare say that's gotta hurt i'll kill you", "vo/npc/male01/gordead_ans07.wav", true)
NDB.AddEmote("i had a feeling even he couldn't help us", "vo/npc/male01/gordead_ans09.wav", true)
NDB.AddEmote("spread the word", "vo/npc/male01/gordead_ans10.wav", true)
NDB.AddEmote("why go on?", "vo/npc/male01/gordead_ans13.wav", true)
NDB.AddEmote("well, now what?", "vo/npc/male01/gordead_ans15.wav", true)
NDB.AddEmote("well now what?", "vo/npc/male01/gordead_ans15.wav", true)
NDB.AddEmote("dibs on the suit", "vo/npc/male01/gordead_ans16.wav", true)
NDB.AddEmote("wait a second that's not gordon freeman", "vo/npc/male01/gordead_ans17.wav", true)
NDB.AddEmote("he's done this before he'll be ok", "vo/npc/male01/gordead_ans18.wav", true)
NDB.AddEmote("somebody take his crowbar", "vo/npc/male01/gordead_ans20.wav", true)
NDB.AddEmote("what a way to go", "vo/npc/male01/gordead_ques02.wav", true)
NDB.AddEmote("freeman is dead?", "vo/npc/male01/gordead_ques04.wav", true)
NDB.AddEmote("that's not freeman is it?", "vo/npc/male01/gordead_ques05.wav", true)
NDB.AddEmote("this can't be", "vo/npc/male01/gordead_ques06.wav", true)
NDB.AddEmote("he came a long way from black mesa", "vo/npc/male01/gordead_ques08.wav", true)
NDB.AddEmote("i thought he was invincible", "vo/npc/male01/gordead_ques11.wav", true)
NDB.AddEmote("so much for doctor freeman", "vo/npc/male01/gordead_ques12.wav", true)
NDB.AddEmote("so much for our last hope", "vo/npc/male01/gordead_ques13.wav", true)
NDB.AddEmote("it's not supposed to end like this", "vo/npc/male01/gordead_ques14.wav", true)
NDB.AddEmote("dr. freeman can you hear me? do not go in to the light", "vo/npc/male01/gordead_ques15.wav", true)
NDB.AddEmote("what now?", "vo/npc/male01/gordead_ques16.wav")
NDB.AddEmote("any last words doc?", "vo/npc/male01/gordead_ques17.wav", true)
NDB.AddEmote("gotta reload", "vo/npc/male01/gottareload01.wav", true)
NDB.AddEmote("heads up", {"vo/npc/male01/headsup01.wav", "vo/npc/male01/headsup02.wav"}, true)
NDB.AddEmote("take this medkit", {"vo/npc/male01/health01.wav", "vo/npc/male01/health02.wav", "vo/npc/male01/health03.wav"}, true)
NDB.AddEmote("here have a medkit", "vo/npc/male01/health04.wav", true)
NDB.AddEmote("here patch yourself up", "vo/npc/male01/health05.wav", true)
NDB.AddEmote("hello dr. freeman", {"vo/npc/male01/hellodrfm01.wav", "vo/npc/male01/hellodrfm02.wav"}, true)
NDB.AddEmote("i've got my little corner and i'm sticking to it", "vo/npc/male01/littlecorner01.wav", true)
NDB.AddEmote("at ease loser", "speach/ael.ogg", true)
NDB.AddEmote("go!", "speach/go.ogg", true)
NDB.AddEmote("go go gal o sengen!", "speach/gogalo.ogg", true)
NDB.AddEmote("who's trying to sneak up on me?", "speach/wttsuom.ogg", true)
NDB.AddEmote("/taunt_04", "speach/taunt_04.ogg", true)
NDB.AddEmote("thanks", "speach/gabe_thanks.ogg")
NDB.AddEmote("worth the wait", "speach/gabe_wtw.ogg", true)
NDB.AddEmote("gaben", "speach/gabe_gaben.ogg", true)
NDB.AddEmote("oh and before i forget", "vo/trainyard/ba_crowbar01.wav", true)
NDB.AddEmote("what are we going to do?", "vo/trainyard/wife_whattodo.wav", true)
NDB.AddEmote("when is it all going to end?", "vo/trainyard/wife_end.wav", true)
NDB.AddEmote("i can't take it anymore", "vo/trainyard/wife_canttake.wav", true)
NDB.AddEmote("where are you taking me?", "vo/trainyard/man_whereyoutakingme.wav", true)
NDB.AddEmote("wait a minute", "vo/trainyard/man_whereyoutakingme.wav")
NDB.AddEmote("me?", "vo/trainyard/man_me.wav")
NDB.AddEmote("great scott", "vo/trainyard/kl_morewarn01.wav", true)
NDB.AddEmote("i expected more warning", "vo/trainyard/kl_morewarn03.wav", true)
NDB.AddEmote("it's all right", "vo/trainyard/husb_allright.wav")
NDB.AddEmote("don't worry", "vo/trainyard/husb_dontworry.wav")
NDB.AddEmote("everything's gonna be okay", "vo/trainyard/husb_okay.wav", true)
NDB.AddEmote("we'll think of something", "vo/trainyard/husb_think.wav", true)
NDB.AddEmote("don't drink the water", "vo/trainyard/cit_water.wav", true)
NDB.AddEmote("oh i thought you were a cop", "vo/trainyard/cit_window_cop.wav", true)
NDB.AddEmote("just this once i hope you're wrong", "vo/trainyard/cit_window_hope.wav", true)
NDB.AddEmote("look at em down there", "vo/trainyard/cit_window_look.wav", true)
NDB.AddEmote("he's one of us", "vo/trainyard/cit_window_stand.wav", true)
NDB.AddEmote("i told you they'd be coming for us next", "vo/trainyard/cit_window_usnext.wav", true)
NDB.AddEmote("i didn't see you get on", "vo/trainyard/cit_train_geton.wav", true)
NDB.AddEmote("well end of the line", "vo/trainyard/cit_train_endline.wav", true)
NDB.AddEmote("just be glad you don't live there", "vo/trainyard/cit_raid_use01.wav", true)
NDB.AddEmote("if you're looking for a place to stay you better keep going", "vo/trainyard/cit_raid_use02.wav", true)
NDB.AddEmote("they have no reason to come to our place", "vo/trainyard/cit_raid_reason.wav", true)
NDB.AddEmote("don't worry they'll find one", "vo/trainyard/cit_raid_findone.wav", true)
NDB.AddEmote("*ranting*", "vo/trainyard/cit_pacing.wav", true)
NDB.AddEmote("i'm working up the nerve to go on", "vo/trainyard/cit_nerve.wav", true)
NDB.AddEmote("all right i'm moving jeez", "vo/trainyard/cit_lug_allright.wav", true)
NDB.AddEmote("but this stuff it's all i have left", "vo/trainyard/cit_lug_allihave.wav", true)
NDB.AddEmote("psst hey you in here", "vo/trainyard/cit_hall_psst.wav", true)
NDB.AddEmote("head for the roof there's no time to lose", "vo/trainyard/cit_hall_roof.wav", true)
NDB.AddEmote("was that you knocking? i didn't even know we still had a door", "vo/trainyard/cit_drunk.wav", true)
NDB.AddEmote("keep moving head for the roof", "vo/trainyard/cit_blocker_roof.wav", true)
NDB.AddEmote("go on i'll hold them", "vo/trainyard/cit_blocker_holdem.wav", true)
NDB.AddEmote("get in here quick", "vo/trainyard/cit_blocker_getin.wav", true)
NDB.AddEmote("i'm thinking i'm thinking", "vo/trainyard/ba_thinking01.wav", true)
NDB.AddEmote("yeah you and me both doc", "vo/trainyard/ba_tellme01.wav", true)
NDB.AddEmote("hey sorry for the scare i had to put on a show for the cameras", "vo/trainyard/ba_sorryscare.wav", true)
NDB.AddEmote("i'll meet up with you later", "vo/trainyard/ba_meetyoulater01.wav", true)
NDB.AddEmote("sorry doc but look who's here", "vo/trainyard/ba_lookwho.wav", true)
NDB.AddEmote("good luck out there buddy", "vo/trainyard/ba_goodluck01.wav", true)
NDB.AddEmote("you're gonna need it", "vo/trainyard/ba_goodluck02.wav", true)
NDB.AddEmote("they're right outside get going", "vo/trainyard/ba_exitnag03.wav", true)
NDB.AddEmote("will you get going?", "vo/trainyard/ba_exitnag04.wav", true)
NDB.AddEmote("move it along", "vo/trainyard/ba_exitnag05.wav", true)
NDB.AddEmote("stay back you'll attract unwanted attention", "vo/trainyard/male01/cit_bench01.wav", true)
NDB.AddEmote("i can't be seen talking to you not out here", "vo/trainyard/male01/cit_bench02.wav", true)
NDB.AddEmote("don't sit near me it'll look suspicious", "vo/trainyard/male01/cit_bench03.wav", true)
NDB.AddEmote("you're scaring off the pigeons", "vo/trainyard/male01/cit_bench04.wav", true)
NDB.AddEmote("the line starts at the end", "vo/trainyard/male01/cit_foodline01.wav", true)
NDB.AddEmote("you'll have to wait your turn like everybody else", "vo/trainyard/male01/cit_foodline02.wav", true)
NDB.AddEmote("you gotta be damn hungry to wait in line for this crap", "vo/trainyard/male01/cit_foodline03.wav", true)
NDB.AddEmote("cut it out", "vo/trainyard/male01/cit_hit01.wav")
NDB.AddEmote("stop that", "vo/trainyard/male01/cit_hit02.wav")
NDB.AddEmote("watch it will ya?", "vo/trainyard/male01/cit_hit03.wav", true)
NDB.AddEmote("no more", "vo/trainyard/male01/cit_hit04.wav")
NDB.AddEmote("that's enough of that", "vo/trainyard/male01/cit_hit05.wav")
NDB.AddEmote("new in town aren't ya?", "vo/trainyard/male01/cit_pedestrian01.wav", true)
NDB.AddEmote("word to the wise keep it to yourself", "vo/trainyard/male01/cit_pedestrian02.wav", true)
NDB.AddEmote("if i talk to you out here we'll both be in trouble", "vo/trainyard/male01/cit_pedestrian03.wav", true)
NDB.AddEmote("we can't be seen talking to each other", "vo/trainyard/male01/cit_pedestrian04.wav", true)
NDB.AddEmote("i'd like to help you but it's out of the question", "vo/trainyard/male01/cit_pedestrian05.wav", true)
NDB.AddEmote("this is my third transfer this year", "vo/trainyard/male01/cit_term_ques02.wav", true)
NDB.AddEmote("oh no now we're really gonna get it", "vo/trainyard/male01/cit_tvbust05.wav", true)
NDB.AddEmote("this doesn't look good", "vo/trainyard/male01/cit_window_use01.wav", true)
NDB.AddEmote("they're definitely coming in here", "vo/trainyard/male01/cit_window_use02.wav", true)
NDB.AddEmote("it was just a matter of time", "vo/trainyard/male01/cit_window_use03.wav", true)
NDB.AddEmote("here goes the rest of the neighborhood", "vo/trainyard/male01/cit_window_use04.wav", true)
NDB.AddEmote("stop we didn't do anything", "vo/canals/arrest_stop.wav", true)
NDB.AddEmote("gladly we accompany", "vo/npc/vortigaunt/accompany.wav", true)
NDB.AddEmote("we have lost all dear to us", "vo/npc/vortigaunt/alldear.wav", true)
NDB.AddEmote("as you wish", "vo/npc/vortigaunt/asyouwish.wav")
NDB.AddEmote("this body is yours to command", "vo/npc/vortigaunt/bodyyours.wav", true)
NDB.AddEmote("certainly", "vo/npc/vortigaunt/certainly.wav", true)
NDB.AddEmote("empower us", "vo/npc/vortigaunt/empowerus.wav", true)
NDB.AddEmote("we fear we have failed you", "vo/npc/vortigaunt/fearfailed.wav", true)
NDB.AddEmote("for freedom", "vo/npc/vortigaunt/forfreedom.wav", true)
NDB.AddEmote("gladly", "vo/npc/vortigaunt/gladly.wav")
NDB.AddEmote("here we stay", "vo/npc/vortigaunt/herewestay.wav", true)
NDB.AddEmote("our cause seems hopeless", "vo/npc/vortigaunt/hopeless.wav", true)
NDB.AddEmote("with pleasure", "vo/npc/vortigaunt/pleasure.wav", true)
NDB.AddEmote("satisfaction", "vo/npc/vortigaunt/satisfaction.wav", true)
NDB.AddEmote("we have survived worse across the ages", "vo/npc/vortigaunt/seenworse.wav", true)
NDB.AddEmote("stand clear", "vo/npc/vortigaunt/standclear.wav")
NDB.AddEmote("don't rely on it", "vo/npc/vortigaunt/vanswer08.wav", true)
NDB.AddEmote("where to now? and to what end?", "vo/npc/vortigaunt/whereto.wav", true)
NDB.AddEmote("yesss", "vo/npc/vortigaunt/yes.wav", true)
NDB.AddEmote("get outta there it's gonna blow", "radio/blow.wav", true)
NDB.AddEmote("bomb has been defused", "radio/bombdef.wav", true)
NDB.AddEmote("bomb has been planted", "radio/bombpl.wav", true)
NDB.AddEmote("sector clear", "radio/clear.wav", true)
NDB.AddEmote("get in position and wait for my go", "radio/com_getinpos.wav", true)
NDB.AddEmote("report in team", "radio/com_go.wav", true)
NDB.AddEmote("affirmative", "radio/ct_affirm.wav", true)
NDB.AddEmote("cover me", "radio/ct_coverme.wav", true)
NDB.AddEmote("enemy spotted", "radio/ct_enemys.wav", true)
NDB.AddEmote("fire in the hole", "radio/ct_fireinhole.wav", true)
NDB.AddEmote("i'm in position", "radio/ct_inpos.wav", true)
NDB.AddEmote("reporting in", "radio/ct_reportingin.wav", true)
NDB.AddEmote("counter-terrorists win", "radio/ctwin.wav", true)
NDB.AddEmote("enemy down", "radio/enemydown.wav", true)
NDB.AddEmote("team fall back", "radio/fallback.wav", true)
NDB.AddEmote("taking fire need assistance", "radio/fireassis.wav", true)
NDB.AddEmote("follow me!", "radio/followme.wav", true)
NDB.AddEmote("okay let's go", "radio/go.wav", true)
NDB.AddEmote("hostage down", "radio/hosdown.wav", true)
NDB.AddEmote("lock n' load", "radio/locknload.wav", true)
NDB.AddEmote("alright let's move out", "radio/moveout.wav", true)
NDB.AddEmote("negative", "radio/negative.wav", true)
NDB.AddEmote("hold this position", "radio/position.wav", true)
NDB.AddEmote("regroup team", "radio/regroup.wav", true)
NDB.AddEmote("roger that", "radio/roger.wav", true)
NDB.AddEmote("stick together team", "radio/sticktog.wav", true)
NDB.AddEmote("storm the front", "radio/stormfront.wav", true)
NDB.AddEmote("you take the point", "radio/takepoint.wav", true)
NDB.AddEmote("terrorists win", "radio/terwin.wav", true)
NDB.AddEmote("protect the vip team", "radio/vip.wav", true)
NDB.AddEmote("you're too slow", "speach/sanic4.ogg", true)
NDB.AddEmote("come on step it up", "speach/sanic3.ogg", true)
NDB.AddEmote("too easy piece of cake", "speach/sanic2.ogg", true)
NDB.AddEmote("sonic's the name speed's my game", "speach/sanic1.ogg", true)
NDB.AddEmote("give me the butter", "speach/givemethebutter.ogg", true)
NDB.AddEmote("you broke my grill?", "speach/youbrokemygrill.ogg", true)
NDB.AddEmote("oldest trick in the book", "speach/oldesttrickinthebook.ogg", true)
NDB.AddEmote("no i don't want that", "speach/noidontwantthat.ogg", true)
NDB.AddEmote("everyday's great at your junes", "speach/greatatyourjunes.ogg", true)
NDB.AddEmote("vgta", "speach/awthatstoobad.ogg", true)
NDB.AddEmote("*honk*", "speach/bikehorn.ogg", true)
NDB.AddEmote("gank!", "speach/gank.ogg", true)
NDB.AddEmote("i'm the coolest", "speach/imthecoolest.ogg", true)
NDB.AddEmote("vgtg", "speach/imthegreatest.ogg", true)
NDB.AddEmote("vgs", "speach/shazbot.ogg", true)
NDB.AddEmote("luigi i'm home", "speach/luigiimhome.ogg", true)
NDB.AddEmote("smoked your butt", "speach/smokedyourbutt.ogg", true)
NDB.AddEmote("how's it feel to burn?", "speach/feeltoburn.ogg", true)
NDB.AddEmote("farquadd", "speach/male_farquadd.ogg", true)
NDB.AddEmote("you bastards!", "speach/youbastards.ogg", true)
NDB.AddEmote("kill them all!", "speach/killthemall.ogg", true)
NDB.AddEmote("less talking more raiding", "speach/lesstalkmoreraid.ogg", true)
NDB.AddEmote("i will drink from your skull", "speach/drinkfromyourskull.ogg", true)
NDB.AddEmote("i'm gonna break your legs nice and slow", "speach/breakyourlegs.ogg", true)
NDB.AddEmote("it's almost harvesting season", "speach/almostharvestingseason.ogg", true)
NDB.AddEmote("thanksgiving blowout", "speach/thanksgivingblowout.ogg", true)
NDB.AddEmote("easy cheesey baked potato", "speach/cheesybakedpotato.ogg", true)
NDB.AddEmote("stupid faggot little cocksucker", "speach/dynamic/sflcs.ogg", true)
NDB.AddEmote("don't resist i just wanna fuck you alright?", "speach/dynamic/dont_resist.ogg", true)

NDB.AddEmote("*spit*", "vo/Citadel/al_dienow.wav", true, function(ent, i, snds)
	local pos = ent:EyePos()
	local heading = ent:GetAimVector()
	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(16, 20)

	local particle = emitter:Add("particle/rain", pos)
	particle:SetDieTime(3)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(100)
	particle:SetStartSize(4)
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(math.Rand(-20, 20))
	particle:SetCollide(true)
	particle:SetGravity(Vector(0, 0, -600))
	particle:SetVelocity(heading * 350)
	particle:SetAirResistance(10)

	for x=1, 14 do
		particle = emitter:Add("particle/rain", pos)
		particle:SetDieTime(math.Rand(1, 2))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(100)
		particle:SetStartSize(1)
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-20, 20))
		particle:SetCollide(true)
		particle:SetGravity(Vector(0, 0, -600))
		particle:SetVelocity(heading * 300 + VectorRand():GetNormalized() * 64)
		particle:SetAirResistance(20)
	end

	emitter:Finish() emitter = nil collectgarbage("step", 64)
end)

-------- WORKSHOP EMOTES --------

-- Ownerless (testing)
NDB.AddEmote("i've lost control of my life", "speach/dynamic/lost_control.ogg", true, nil, 0.85)
NDB.AddEmote("making chocolate pudding", "speach/dynamic/pudding.ogg", true, nil, 0.85)
NDB.AddEmote("order sent", "speach/dynamic/order_sent.ogg", true, nil, 0.85)

NDB.AddEmote("mado's nyan", "speach/dynamic/mados_nyan.ogg", true, nil, 0.85)
NDB.AddEmote("oh my god", "speach/dynamic/oh_my_god.ogg", true, nil, 0.85)
NDB.AddEmote("tuturuu", "speach/dynamic/tuturuu.ogg", true, nil, 0.85)
NDB.AddEmote("you don't scare me at all", "speach/dynamic/you_dont_scare_me_at_all.ogg", true, nil, 0.85)
NDB.AddEmote("ooh banana", "speach/dynamic/ooh_banana.ogg", true, nil, 0.85)
NDB.AddEmote("on the bed?", "speach/dynamic/wwawgdotb.ogg", true, nil, 0.85)
NDB.AddEmote("we'll be fine you just have to go", "speach/dynamic/wbfyjhtg.ogg", true, nil, 0.85)
NDB.AddEmote("this is my boomstick!", "speach/dynamic/this_is_my_boomstick.ogg", true, nil, 0.85)
NDB.AddEmote("pomf", "speach/dynamic/pomf.ogg", true, nil, 0.85)
NDB.AddEmote("yeah science", "speach/dynamic/yeah_science.ogg", true, nil, 0.85)
NDB.AddEmote("owooo", "speach/dynamic/owooo.ogg", true, nil, 0.85)
NDB.AddEmote("i feel good", "speach/dynamic/i_feel_good.ogg", true, nil, 0.85)
NDB.AddEmote("you're all a bunch of fucking idiots", "speach/dynamic/yaabofi.ogg", true, nil, 0.85)
NDB.AddEmote("timotei", "speach/dynamic/timotei.ogg", true, nil, 0.85)
NDB.AddEmote("sending out an sos", "speach/dynamic/sending_out_an_sos.ogg", true, nil, 0.85)
NDB.AddEmote("kakarot!", "speach/dynamic/kakarot.ogg", true, nil, 0.85)
NDB.AddEmote("gatorade", "speach/dynamic/gatorade.ogg", true, nil, 0.85)
NDB.AddEmote("lady you've got darkness on the brain", "speach/dynamic/lygdotb.ogg", true, nil, 0.85)
NDB.AddEmote("pickup3", "speach/dynamic/i_said_pickup_the_can.ogg", true, nil, 0.85)
NDB.AddEmote("pickup2", "speach/dynamic/pick_up_the_can.ogg", true, nil, 0.85)
NDB.AddEmote("blow over", "speach/dynamic/blow_over.ogg", true, nil, 0.85)
NDB.AddEmote("out the road", "speach/dynamic/out_the_road.ogg", true, nil, 0.85)
NDB.AddEmote("ya dirty shite ya mickey", "speach/dynamic/ya_dirty_shite_ya_mickey.ogg", true, nil, 0.85)
NDB.AddEmote("sit on that", "speach/dynamic/sit_on_that.ogg", true, nil, 0.85)
NDB.AddEmote("i am the real boss", "speach/dynamic/i_am_the_real_boss.ogg", true, nil, 0.85)
NDB.AddEmote("pickup1", "speach/dynamic/pickup1.ogg", true, nil, 0.85)
NDB.AddEmote("vagina", "speach/dynamic/vagina.ogg", true, nil, 0.85)
NDB.AddEmote("*audience*", "speach/dynamic/audience.ogg", true, nil, 0.85)
NDB.AddEmote("ara ara", "speach/dynamic/ara_ara.ogg", true, nil, 0.85)
NDB.AddEmote("nippah", "speach/dynamic/nippah.ogg", true, nil, 0.85)
NDB.AddEmote("lick my balls", "speach/dynamic/lick_my_balls.ogg", true, nil, 0.85)
NDB.AddEmote("you didn't say the magic word", "speach/dynamic/ydstmw.ogg", true, nil, 0.85)
NDB.AddEmote("oh my god we're doomed", "speach/dynamic/ohmygodweredoomed.ogg", true, nil, 0.85)
NDB.AddEmote("i won!", "speach/dynamic/i_won.ogg", true, nil, 0.85)
NDB.AddEmote("this is illegal you know", "speach/dynamic/this_is_illegal_you_know.ogg", true, nil, 0.85)
NDB.AddEmote("go and kill", "speach/dynamic/go_and_kill.ogg", true, nil, 0.85)
NDB.AddEmote("the ultimate evil", "speach/dynamic/the_ultimate_evil.ogg", true, nil, 0.85)
NDB.AddEmote("outto", "speach/dynamic/outto.ogg", true, nil, 0.85)
NDB.AddEmote("you shall not pass!", "speach/dynamic/you_shall_not_pass.ogg", true, nil, 0.85)
NDB.AddEmote("i'll end you!", "speach/dynamic/ill_end_you.ogg", true, nil, 0.85)
NDB.AddEmote("leerooy", "speach/dynamic/leerooy.ogg", true, nil, 0.7)
NDB.AddEmote("do it!", "speach/dynamic/do_it.ogg", true, nil, 0.85)
NDB.AddEmote("nyanpassu", "speach/dynamic/nyanpassu.ogg", true, nil, 0.85)
NDB.AddEmote("boring around here", "speach/dynamic/boring_around_here.ogg", true, nil, 0.85)
NDB.AddEmote("it's yours my friend", "speach/dynamic/its_yours_my_friend.ogg", true, nil, 0.85)
NDB.AddEmote("real soon...", "speach/dynamic/real_soon.ogg", true, nil, 0.85)
NDB.AddEmote("faces of evil", "speach/dynamic/faces_of_evil.ogg", true, nil, 0.85)
NDB.AddEmote("buttfun", "speach/dynamic/buttfun.ogg", true, nil, 0.85)
NDB.AddEmote("marshjellow", "speach/dynamic/marshjellow.ogg", true, nil, 0.85)
NDB.AddEmote("youlose", "speach/dynamic/youlose.ogg", true, nil, 0.85)
NDB.AddEmote("no dear that's wrong", "speach/dynamic/no_dear_thats_wrong.ogg", true, nil, 0.85)
NDB.AddEmote("*hentai*", "speach/dynamic/hentai.ogg", true, nil, 0.85)
NDB.AddEmote("this is a pig stye", "speach/dynamic/this_is_a_pig_stye.ogg", true, nil, 0.85)
NDB.AddEmote("do you understand?!", "speach/dynamic/do_you_understand.ogg", true, nil, 0.85)
NDB.AddEmote("fuck_everything!", "speach/dynamic/fuck_everything.ogg", true, nil, 0.85)
NDB.AddEmote("alright mister what do you think you're doing?", "speach/dynamic/amwdytyd.ogg", true, nil, 0.85)
NDB.AddEmote("dallas?", "speach/dynamic/dallas.ogg", true, nil, 0.85)
NDB.AddEmote("sallad", "speach/dynamic/salad.ogg", true, nil, 0.85)
NDB.AddEmote("are you listening to me?!", "speach/dynamic/are_you_listening_to_me.ogg", true, nil, 0.85)
NDB.AddEmote("god-emperor takara", "speach/dynamic/god-emperor_takara.ogg", true, nil, 0.85)
NDB.AddEmote("a thousand of my brothers' dicks!", "speach/dynamic/1000_dicks.ogg", true, nil, 0.85)
NDB.AddEmote("poopy poop poop poopster poop", "speach/dynamic/ppppp.ogg", true, nil, 0.7)
NDB.AddEmote("hello my friend", "speach/dynamic/hello_my_friend.ogg", true, nil, 0.85)
NDB.AddEmote("i don't like this one bit", "speach/dynamic/i_dont_like_this.ogg", true, nil, 0.85)
NDB.AddEmote("unacceptable!", "speach/dynamic/unacceptable.ogg", true)
NDB.AddEmote("haha!", "speach/dynamic/haha.ogg", true)
NDB.AddEmote("oh no we're all doomed", "speach/dynamic/alldoomed.ogg", true)
NDB.AddEmote("you better get out!", "speach/dynamic/you_better_get_out.ogg", true)
NDB.AddEmote("what in blazes?!", "speach/dynamic/what_in_blazes.ogg", true)
NDB.AddEmote("i'm getting dizzay!", "speach/dynamic/im_getting_dizzay.ogg", true)
NDB.AddEmote("ohh too bad!", "speach/dynamic/ohh_too_bad.ogg", true)
NDB.AddEmote("whooo!", "speach/dynamic/whooo.ogg", true)
NDB.AddEmote("medic!", "speach/dynamic/medic.ogg", true)
NDB.AddEmote("saveme", "speach/dynamic/saveme.ogg", true)
NDB.AddEmote("the evil seed", "speach/dynamic/evil_seed.ogg", true)
NDB.AddEmote("gee it sure is boring around here", "speach/dynamic/it_sure_is_boring.ogg", true)
NDB.AddEmote("great i'll grab my stuff", "speach/dynamic/ill_grab_my_stuff.ogg", true)
NDB.AddEmote("zilmoan", "speach/dynamic/zilmoan.ogg", true)
NDB.AddEmote("alright!", "speach/dynamic/alright.ogg", true)
NDB.AddEmote("fantastic!", "speach/dynamic/fantastic.ogg", true)
NDB.AddEmote("get out of the way!", "speach/dynamic/get_out_of_the_way.ogg", true)
NDB.AddEmote("hey where are we?", "speach/dynamic/hey_where_are_we.ogg", true)
NDB.AddEmote("i wanna go home!", "speach/dynamic/i_wanna_go_home.ogg", true)
NDB.AddEmote("that's how dumb you sound", "speach/dynamic/thats_how_dumb_you_sound.ogg", true)
NDB.AddEmote("ahaha", "speach/dynamic/ahaha.ogg", true)
NDB.AddEmote("what's wrong? is that all you've got brother?", "speach/dynamic/wwitaygb.ogg", true)
NDB.AddEmote("what's that?!", "speach/dynamic/whats_that.ogg", true)
NDB.AddEmote("are you kidding me?!", "speach/dynamic/are_you_kidding_me.ogg", true)
NDB.AddEmote("called a target", "speach/dynamic/where_i_come_from_target.ogg", true)
NDB.AddEmote("show me your moves", "speach/dynamic/show_me_your_moves.ogg", true)
NDB.AddEmote("falcon death", "speach/dynamic/falcon_death.ogg", true)
NDB.AddEmote("naaa", "speach/dynamic/naaa.ogg", true)
NDB.AddEmote("baaarge", "speach/dynamic/baaarge.ogg", true)
NDB.AddEmote("subaluwa!", "speach/dynamic/subaluwa.ogg", true)
NDB.AddEmote("liquid's laugh", "speach/dynamic/liquids_laugh.ogg", true)
NDB.AddEmote("ocelot's laugh", "speach/dynamic/ocelots_laugh.ogg", true)
NDB.AddEmote("no problem...", "speach/dynamic/no_problem.ogg", true)
NDB.AddEmote("more more", "speach/dynamic/more_more.ogg", true)
NDB.AddEmote("eahhh", "speach/dynamic/eahhh.ogg", true)
NDB.AddEmote("w33d", "speach/dynamic/w33d.ogg", true)
NDB.AddEmote("you are a pirate", "speach/dynamic/you_are_a_pirate.ogg", true)
NDB.AddEmote("whatchasay", "speach/dynamic/watchasay.ogg", true)
NDB.AddEmote("to glory!", "speach/dynamic/to_glory.ogg", true)
NDB.AddEmote("chaaarge!", "speach/dynamic/chaaarge.ogg", true)
NDB.AddEmote("here they come lads!", "speach/dynamic/here_they_come_lads.ogg", true)
NDB.AddEmote("to me!", "speach/dynamic/to_me.ogg", true)
NDB.AddEmote("fuck you!", "speach/dynamic/fuck_you.ogg", true)
NDB.AddEmote("ladies first", "speach/dynamic/ladies_first.ogg", true)
NDB.AddEmote("tearapartlisa", "speach/dynamic/tearapartlisa.ogg", true)
NDB.AddEmote("bsheymarc", "speach/dynamic/bsheymarc.ogg", true)
NDB.AddEmote("keep up motherfucker", "speach/dynamic/keep_up_motherfucker.ogg", true)
NDB.AddEmote("nilbog", "speach/dynamic/nilbog.ogg", true)
NDB.AddEmote("watch yo profamity", "speach/dynamic/watch_yo_profamity.ogg", true)
NDB.AddEmote("nnbpd", "speach/dynamic/nnbpd.ogg", true)
NDB.AddEmote("iwishiwereabird", "speach/dynamic/iwishiwereabird.ogg", true)
NDB.AddEmote("everyone!", "speach/dynamic/everyone.ogg", true)
NDB.AddEmote("purupuru", "speach/dynamic/purupuru.ogg", true)
NDB.AddEmote("niconi", "speach/dynamic/niconi.ogg", true)
NDB.AddEmote("yarr harr", "speach/dynamic/yarr_harr.ogg", true)
NDB.AddEmote("just something i whipped up", "speach/dynamic/just_something_i_whipped_up.ogg", true)
NDB.AddEmote("medic!!", "speach/dynamic/medic2.ogg", true)
NDB.AddEmote("shesaid", "speach/dynamic/shesaid.ogg", true)
NDB.AddEmote("mattferrit", "speach/dynamic/mattferrit.ogg", true)
NDB.AddEmote("werd", "speach/dynamic/werd.ogg", true)
NDB.AddEmote("chortle", "speach/dynamic/chortle.ogg", true)
NDB.AddEmote("stfu", "speach/dynamic/stfu.ogg")
NDB.AddEmote("wtf are you doing?", "speach/dynamic/wtf_are_you_doing.ogg", true)
NDB.AddEmote("smd", "speach/dynamic/smd.ogg", true)
NDB.AddEmote("you better watch out", "speach/dynamic/you_better_watch_out.ogg", true)
NDB.AddEmote("i fucking hate you", "speach/dynamic/i_fucking_hate_you.ogg", true)
NDB.AddEmote("i am a wizard", "speach/dynamic/i_am_a_wizard.ogg", true)
NDB.AddEmote("of course!", "speach/dynamic/of_course.ogg", true)
NDB.AddEmote("get out of my sight", "speach/dynamic/get_out_of_my_sight.ogg", true)
NDB.AddEmote("crush you in to the wind", "speach/dynamic/crush_you_in_to_the_wind.ogg", true)
NDB.AddEmote("penis penis penis penis penis penis", "speach/dynamic/penisx6.ogg", true)
NDB.AddEmote("it's a valleyship", "speach/dynamic/its_a_valleyship.ogg", true)
NDB.AddEmote("cheeki breeki", "speach/dynamic/cheeki_breeki.ogg", true)
NDB.AddEmote("euheuhue", "speach/dynamic/euheuhue.ogg", true)
NDB.AddEmote("omedetou", "speach/dynamic/omedetou.ogg", true)
NDB.AddEmote("watchusaynigga", "speach/dynamic/watchusaynigga.ogg", true)
NDB.AddEmote("return the slab", "speach/dynamic/return_the_slab.ogg", true)
NDB.AddEmote("swiggity swag", "speach/dynamic/swiggity_swag.ogg", true)
NDB.AddEmote("watch where you walkin", "speach/dynamic/watch_where_you_walkin.ogg", true)
NDB.AddEmote("love coco", "speach/dynamic/love_coco.ogg", true)
NDB.AddEmote("bazinga", "speach/dynamic/bazinga.ogg", true)
NDB.AddEmote("the low low", "speach/dynamic/the_low_low.ogg", true)
NDB.AddEmote("!!!", "speach/dynamic/mg.ogg", true)
NDB.AddEmote("allahu akbar", "speach/dynamic/allahuakbar.ogg", true)
NDB.AddEmote("i'm gonna rape you", "speach/dynamic/im_gonna_rape_you.ogg", true)
NDB.AddEmote("yahoo", "speach/dynamic/yahoo.ogg", true)
NDB.AddEmote("usnavy", "speach/dynamic/usnavy.ogg", true)
NDB.AddEmote("im de best", "speach/dynamic/im_de_best.ogg", true)
NDB.AddEmote("i'm gonna fuck your ass", "speach/dynamic/im_gonna_fuck_your_ass.ogg", true)
NDB.AddEmote("aaaaah!", "speach/dynamic/aaaaah.ogg", true)
NDB.AddEmote("ah that's the stuff", "speach/dynamic/ah_thats_the_stuff.ogg", true)
NDB.AddEmote("ah yeah", "speach/dynamic/ah_yeah.ogg", true)
NDB.AddEmote("alex! alex!", "speach/dynamic/alex_alex.ogg", true)
NDB.AddEmote("dive on in", "speach/dynamic/dive_on_in.ogg", true)
NDB.AddEmote("wubba lubba dub dub", "speach/dynamic/wubba_lubba_dub_dub.ogg", true)
NDB.AddEmote("dumb stupid idiot", "speach/dynamic/dumb_stupid_idiot.ogg", true)
NDB.AddEmote("moley", "speach/dynamic/moley.ogg", true)
NDB.AddEmote("pretty gud", "speach/dynamic/pretty_gud.ogg", true)
NDB.AddEmote("you're the best around", "speach/dynamic/youre_the_best.ogg", true)
NDB.AddEmote("loser you're a loser", "speach/dynamic/loser_youre_a_loser.ogg", true)
NDB.AddEmote("send them to join their families in death", "speach/dynamic/sttjtfid.ogg", true)
NDB.AddEmote("shut the fuck up and die", "speach/dynamic/stfu_and_die.ogg", true)
NDB.AddEmote("it's time for me to go insane", "speach/dynamic/time_4_me_to_go_insane.ogg", true)
NDB.AddEmote("fuck you...", "speach/dynamic/hatred_fuck_you.ogg", true)
NDB.AddEmote("crazylaugh", "speach/dynamic/crazylaugh.ogg", true)
NDB.AddEmote("i tire of mead i thirst for blood", "speach/dynamic/tired_of_mead.ogg", true)
NDB.AddEmote("their skins for the curing barrel", "speach/dynamic/skins_4_the_curing_barrel.ogg", true)
NDB.AddEmote("heeeeeeeeelp", "speach/dynamic/long_help.ogg", true)
NDB.AddEmote("bring me their heads", "speach/dynamic/bring_me_their_heads.ogg", true)
NDB.AddEmote("fack you", "speach/dynamic/fack_you.ogg", true)
NDB.AddEmote("it's time for me to kill", "speach/dynamic/hatred_time_die_kill.ogg", true)
NDB.AddEmote("no more useless words", "speach/dynamic/no_more_useless_words.ogg", true)
NDB.AddEmote("my name is not important", "speach/dynamic/my_name_is_not_important.ogg", true)
NDB.AddEmote("blood for the blood god", "speach/dynamic/blood_4_blood_god.ogg", true)
NDB.AddEmote("sugoi", "speach/dynamic/nanako_sugoi.ogg", true)
NDB.AddEmote("a bomb's a bad choice", "speach/dynamic/a_bombs_a_bad_choice.ogg", true)
NDB.AddEmote("fuck you leatherhead", "speach/dynamic/fuck_you_leatherhood.ogg", true)
NDB.AddEmote("get out of here stalker", "speach/dynamic/get_out_of_here_stalker.ogg", true)
NDB.AddEmote("i am unstoppable!", "speach/dynamic/i_am_unstoppable.ogg", true)
NDB.AddEmote("nepu", "speach/dynamic/nepu.ogg", true)
NDB.AddEmote("once more into the fray!", "speach/dynamic/once_more_into_the_fray.ogg", true)
NDB.AddEmote("up your arse", "speach/dynamic/up_your_arse.ogg", true)
NDB.AddEmote("we are the destroyer!", "speach/dynamic/we_are_the_destroyer.ogg", true)
NDB.AddEmote("what a shame...", "speach/dynamic/what_a_shame.ogg", true)
NDB.AddEmote("oh my god jc a bomb!", "speach/dynamic/oh_my_god_jc_a_bomb.ogg", true)
NDB.AddEmote("we lost because you were all weak", "speach/dynamic/wlbywaw.ogg", true)
NDB.AddEmote("shut up!", "speach/dynamic/shut_up.ogg", true)
NDB.AddEmote("arghhhhh", "speach/dynamic/arghhhhh.ogg", true)
NDB.AddEmote("*coin*", "speach/dynamic/coin.ogg", true)
NDB.AddEmote("reset the ball!", "speach/dynamic/reset_the_ball.ogg", true)
NDB.AddEmote("johnmadden", "speach/dynamic/johnmadden.ogg", true)
NDB.AddEmote("another one!", "speach/dynamic/another_one.ogg", true)
NDB.AddEmote("oh fuck!", "speach/dynamic/oh_fuck.ogg", true)
NDB.AddEmote("*seinfeld*", "speach/dynamic/seinfeld.ogg", true)
NDB.AddEmote("teletubby", "speach/dynamic/teletubby.ogg", true)
NDB.AddEmote("oh shit i'm sorry", "speach/dynamic/oh_shit_im_sorry.ogg", true)
NDB.AddEmote("for you", "speach/dynamic/for_you.ogg", true)
NDB.AddEmote("sorry for what", "speach/dynamic/sorry_for_what.ogg", true)
NDB.AddEmote("*china*", "speach/dynamic/china.ogg", true)
NDB.AddEmote("they're bringing drugs", "speach/dynamic/theyre_bringing_drugs.ogg", true)
NDB.AddEmote("*nazi*", "speach/dynamic/nazi.ogg", true)
NDB.AddEmote("you stupid bitch", "speach/dynamic/you_stupid_bitch.ogg", true)
NDB.AddEmote("fucking screaming!", "speach/dynamic/fucking_screaming.ogg", true)
NDB.AddEmote("trump!", "speach/dynamic/trump.ogg", true)
NDB.AddEmote("you're fired", "speach/dynamic/youre_fired.ogg", true)
NDB.AddEmote("bingbong", "speach/dynamic/bingbong.ogg", true)
NDB.AddEmote("only the chosen may survive", "speach/dynamic/only_the_chosen_may_survive.ogg", true)
NDB.AddEmote("too late for laments", "speach/dynamic/too_late_for_laments.ogg", true)
NDB.AddEmote("slow.", "speach/dynamic/slow.ogg", true)
NDB.AddEmote("i'll see you again", "speach/dynamic/ill_see_you_again.ogg", true)
NDB.AddEmote("say goodbye", "speach/dynamic/say_goodbye.ogg", true)
NDB.AddEmote("that's nothing compared to my telekawhatsit powers", "speach/dynamic/tnctmtwp.ogg", true)
NDB.AddEmote("problem nigga?", "speach/dynamic/problem_nigga.ogg", true)
NDB.AddEmote("where'd u find this?", "speach/dynamic/whered_u_find_this.ogg", true)
NDB.AddEmote("not done with the props yet", "speach/dynamic/not_done_props_yet.ogg", true)
NDB.AddEmote("license please", "speach/dynamic/license_please.ogg", true)
NDB.AddEmote("duffs bad feeling", "speach/dynamic/duffs_bad_feeling.ogg", true)
NDB.AddEmote("duff can't die", "speach/dynamic/duff_cant_die.ogg", true)
NDB.AddEmote("yay it's ok", "speach/dynamic/yay_its_ok.ogg", true)
NDB.AddEmote("no way jose", "speach/dynamic/no_way_jose.ogg", true)
NDB.AddEmote("we did it!", "speach/dynamic/we_did_it.ogg", true)
NDB.AddEmote("marcdi", "speach/dynamic/marcdi.ogg", true)
NDB.AddEmote("sharkey amyeda", "speach/dynamic/sharkey_amyeda.ogg", true)
NDB.AddEmote("final flash", "speach/dynamic/final_flash.ogg", true)
NDB.AddEmote("a vote for walls is a vote for freedom", "speach/dynamic/a_vote_for_walls.ogg", true)
NDB.AddEmote("*buzz*", "speach/dynamic/buzz.ogg", true)
NDB.AddEmote("*1up*", "speach/dynamic/1up.ogg", true)
NDB.AddEmote("frenchfuwd", "speach/dynamic/frenchfuwd.ogg", true)
NDB.AddEmote("victoryscreech!", "speach/dynamic/victoryscreech.ogg", true)
NDB.AddEmote("wawawawawa woo", "speach/dynamic/wawawawawa_woo.ogg", true)
NDB.AddEmote("fucking moron", "speach/dynamic/fucking_moron.ogg", true)
