CAT_HEAD = 1
CAT_FACE = 2
CAT_ACCESSORY = 3
CAT_BODY = 4
CAT_BACK = 5
CAT_OTHER = 6
CAT_TITLE = 7
CAT_MODEL = 8
CAT_SAVEDTITLE = 9

NDB.ShopCategories = {
	[CAT_HEAD] = "Headwear",
	[CAT_FACE] = "Facewear",
	[CAT_ACCESSORY] = "Accessories",
	[CAT_BODY] = "Bodywear",
	[CAT_BACK] = "Backwear",
	[CAT_OTHER] = "Other",
	[CAT_TITLE] = "Titles",
	[CAT_MODEL] = "Player Models",
	[CAT_SAVEDTITLE] = "Custom Titles"
}

local ShopItems = {}
NDB.ShopItems = ShopItems
NDB.ShopItemList = {}

function NDB.GetShopItem(itemname)
	return ShopItems[itemname]
end

function NDB.OldPlayerHasShopItem(pl, item)
	if pl:IsAdmin() then return true end

	if ShopItems[item] and ShopItems[item].Bit then
		local b = 2 ^ ShopItems[item].Bit
		return bit.band(b, pl.ShopInventory) == b
	end

	return false
end

function NDB.PlayerHasShopItem(pl, item)
	if pl:IsAdmin() then return true end

	local shopitem = ShopItems[item]
	if shopitem and pl.Inventory then
		if shopitem.Class and costumes[shopitem.Class] and (costumes[shopitem.Class].AuthorID == pl:SteamID() or costumes[shopitem.Class].FixerID == pl:SteamID()) then
			return true
		end

		if shopitem.CanUseCallback then
			return CLIENT or shopitem.CanUseCallback(pl)
		end

		return table.HasValue(pl.Inventory, shopitem.Bit)
	end

	return false
end

do

local function ShopItem(name, bit, price, category, class, description, specialrequire, canusecallback)
	if not name then return end

	local tab = {Name = name, Money = price, Bit = bit, Category = category, Class = class, Description = description, SpecialRequire = specialrequire, CantUseMessage = cantusemessage, CanUseCallback = canusecallback}
	if category and class then
		tab[category] = class
	end

	ShopItems[name] = tab

	return tab
end

local function AddTitle(display, title, desc, requires, canuse)
	return ShopItem(display, nil, nil, CAT_TITLE, title, desc, requires, canuse)
end

local s

ShopItem("Terracotta Pot Hat", 36, 5000, CAT_HEAD, "terracotta", "At least the dirt isn't still in it.")
s = ShopItem("Cleaver-in-head", 35, 20000, CAT_HEAD, "cleaverinskull", "It's obviously not a real cleaver.")
s.Awards = {"rambo"}
ShopItem("Santa Hat", 29, 15000, CAT_HEAD, "santacap", "Dress up like Santa Claus.")
ShopItem("Aviator Glasses", 21, 40000, CAT_FACE, "aviators", "These glasses let others know that you're really stylish.")
ShopItem("Witch's Hat", 27, 20000, CAT_HEAD, "witchhat", "A must have for any aspiring witch or warlock.")
s = ShopItem("Headcrab Hat", 23, 60000, CAT_HEAD, "headcrab", "Lamarr! There you are!")
s.Awards = {"Marauder_of_Humans", "ZS_Zombie_Silver"}
ShopItem("Monitor Head", 28, nil, CAT_HEAD, "monitorhead", "A prize for active forum posters.", "Requires you to have a 90 day old forum account with at least 30 posts.", function(pl) return pl:HasFlag("forumspromotion") end)

ShopItem("Fedora", 24, 20000, CAT_HEAD, "fedora", "It's like I'm really a detective from one of those noir films and not a hipster.")
ShopItem("Afro", 22, 60000, CAT_HEAD, "afro", "People won't even be able to see past your hair.")
ShopItem("Lamp Shade", 20, 15000, CAT_HEAD, "lampshade", "Be a walking cliche!")
ShopItem("Watermelon Head", 2, 10000, CAT_HEAD, "melonhead", "No one will ever recognize you with a watermelon on your head!")
ShopItem("Cone Hat", 1, 10000, CAT_HEAD, "trafficcone", "Direct traffic with your head!")
ShopItem("Mask", 19, 10000, CAT_HEAD, "combinemask", "Your face can remain a mystery with this mask.")
ShopItem("Bucket Hat", 3, 10000, CAT_HEAD, "buckethead", "How do you see out of this thing?")
ShopItem("Baseball Cap", 8, 10000, CAT_HEAD, "baseballcap", "A plain baseball cap.")
ShopItem("Snowman Face", 10, 30000, CAT_HEAD, "snowmanhead", "Be like Frosty the Snowman with this hat.")
ShopItem("Barrel Head", 13, 20000, CAT_HEAD, "barrelhead", "Your head becomes a false explosive barrel!")
ShopItem("Chef Hat", 15, 15000, CAT_HEAD, "chefhat", "A favorite hat used by professional chefs.")
ShopItem("Pot Hat", 18, 10000, CAT_HEAD, "pothat", "You can't play 'Soldier' without this.")
s = ShopItem("Flaming Skull Head", 9, 200000, CAT_HEAD, "flamingskull", "Let others know how evil you are.")
s.Awards = {"Eradicator_Of_Humans"}
ShopItem("Light Visor", 34, 60000, CAT_FACE, "lightvisor", "This special visor glows in the dark.")
ShopItem("Mechanized Eye", 33, 30000, CAT_FACE, "mechanicaleye", "A mechanical replacement eye.")
ShopItem("Radiant Eyes", 32, 500000, CAT_FACE, "radianteyes", "Your eyes glow a radiant display of changing colors.")
ShopItem("Glowing Eyes", 11, 200000, CAT_FACE, "glowingeyes", "A set of glowing eyes. Set their color to whatever you want.")
ShopItem("Purple Eyes", 31, 500000, CAT_FACE, "glowingeyespurple", "Your eyes glow a vibrant purple.").Hidden = true
ShopItem("Poison Eyes", 30, 500000, CAT_FACE, "glowingeyesgreen", "Your eyes glow a venom green.").Hidden = true
ShopItem("Evil Eyes", 12, 500000, CAT_FACE, "glowingeyesred", "Your eyes glow an evil red.").Hidden = true
ShopItem("Sh*t Eating Grin", 26, 150000, CAT_FACE, "seg", "Let everyone know how happy (or sadistic) you are.")

ShopItem("Angelic Halo", 14, 100000, CAT_HEAD, "angelichalo", "A halo handed down from an angel.")

ShopItem("Annoying Radio", 17, nil, CAT_ACCESSORY, "annoying_radio", "Play dumb music to annoy people!", "This special item isn't available through normal methods.")
ShopItem("Caster Hands", nil, nil, CAT_BODY, "casterhands", "Your hands glow as if ready to unleash a magical spell.", "Part of the tribesrpg promotion.", function(pl) return pl:HasFlag("promo_tribesrpg") end)
ShopItem("Static Aura", nil, nil, CAT_BODY, "staticaura", "Your body emits static charges.", "Part of the tribesrpg promotion.", function(pl) return pl:HasFlag("promo_tribeswar") end)
ShopItem("Voice Distorter", 25, 2000000, CAT_OTHER, "voicechanger", "This little box distorts your voice!")

ShopItem("Super Box Head", 39, nil, CAT_HEAD, "smileybox", "This special head is for champions of Super Mario Boxes.", "You need to qualify for the SMB Champion title.", function(pl) return NDB.PlayerHasShopItem(pl, "SMB Champion") end)
s = ShopItem("Baby Face", 40, 100000, CAT_HEAD, "babyface", "Part of some kind of a giant, plastic baby costume. Looks creepy.")
s.Awards = {"nightmare_mode"}
s = ShopItem("Cigar", 41, 100000, CAT_ACCESSORY, "cigar", "It's a cigar. A puff comes out whenever your score changes.")
s.Awards = {"zs_human_1st"}
s = ShopItem("Toy Shovel", 42, 100000, CAT_BACK, "toyshovel", "It's just a toy but would probably hurt if you hit someone enough with it.")
s.Awards = {"grave_digger"}
ShopItem("Sheldon Mask", 43, 125000, CAT_HEAD, "turtlemask", "\"Property of the Sheldon Fan Club\" is written on the inside.")
ShopItem("Gnome Mask", 44, 125000, CAT_HEAD, "gnomemask", "Just in case you ever wanted to be a gnome.")
ShopItem("Pumpkin Head", 45, 50000, CAT_HEAD, "pumpkinhead", "It's a pumpkin with glowing, orange eyes.")
ShopItem("Perched Crow", 46, 150000, CAT_BACK, "perchedcrow", "A pet crow. It's just animatronic of course.")
ShopItem("Magic Horn", nil, nil, CAT_ACCESSORY, "magichorn", "Allows you to make magnificent music.", "This special item isn't available through normal methods.", function(pl) return pl:HasFlag("magichorn") end)

ShopItem("Blindfold", 48, 50000, CAT_FACE, "blindfold", "A thick blindfold.")
s = ShopItem("Devil Skull", 49, nil, CAT_HEAD, "fusrohdah", "FUS ROH DAH")
ShopItem("Brain Sucker", 50, 150000, CAT_HEAD, "brainsucker", "Not a real brain sucker.")
ShopItem("Sombrero", 51, 75000, CAT_HEAD, "sombrero")
ShopItem("Beanie", 52, 50000, CAT_HEAD, "beanie")
s = ShopItem("Pyromancer Skull", 53, 50000, CAT_HEAD, "pyromancer", "Heat can be felt pouring out of it.")
s = ShopItem("Robin Hood Hat", 54, 30000, CAT_HEAD, "robinhood", "An authentic replica.")
ShopItem("Chief Hat", 55, 400000, CAT_HEAD, "chief", "Numerous feathers adorn this wonderfully crafted hat.")
ShopItem("Spartan Helmet", 56, 75000, CAT_HEAD, "spartan", "TEAM SPARTAN")
ShopItem("Viking Helmet", 57, 75000, CAT_HEAD, "viking", "TEAM VIKING")
ShopItem("Rabbit Hat", 58, 300000, CAT_HEAD, "rabbit", "The power of jigglebones is surging!")
ShopItem("Samurai Helmet", 59, 250000, CAT_HEAD, "samurai", "GLORIOUS NIPPON!")
ShopItem("Snaggletooth Hat", 60, 250000, CAT_HEAD, "snaggletooth", "A real crocidile head.")
ShopItem("Hound Dog", 61, 100000, CAT_HEAD, "hounddog", "Ain't nothin' but a hound dog.")
ShopItem("Parasite", 62, 250000, CAT_HEAD, "parasite", "Not a real parasite.")

ShopItem("Wiki Cap", 63, 50000, CAT_HEAD, "wikihat")
ShopItem("Christmas Tree Hat", 64, 100000, CAT_HEAD, "xmasstree")
ShopItem("Voodoo Hat", 65, 50000, CAT_HEAD, "voodoohat")
ShopItem("Pumpkin Head 2", 66, 250000, CAT_HEAD, "pumpkinhat2")
ShopItem("Hallmark Hat", 67, 50000, CAT_HEAD, "hallmarkhat")
ShopItem("Inquisitor Hat", 68, 50000, CAT_HEAD, "inquisitorhat")
ShopItem("Crown", 69, 50000, CAT_HEAD, "crown")
ShopItem("Earphones", 70, 25000, CAT_HEAD, "earphones")
ShopItem("Cowboy Hat", 71, 25000, CAT_HEAD, "cowboyhat")
ShopItem("Ushanka", 72, 25000, CAT_HEAD, "ushanka")

ShopItem("Hood", 73, 400000, CAT_HEAD, "hood")
ShopItem("Mad Eye", 74, 400000, CAT_FACE, "madeye")
ShopItem("Saxton Mask", 75, 100000, CAT_HEAD, "saxtonmask")


ShopItem("Black*Rock Shooter", 76, 1500000, CAT_MODEL, "blackrockshooter", "Enables use of the Black*Rock Shooter model.").Model = "models/player/brsp.mdl"
ShopItem("Moe GlaDOS", 77, 1500000, CAT_MODEL, "moeglados", "Enables use of the Moe GlaDOS model.").Model = "models/player/moe_glados_p.mdl"

-- Holiday 2014
--ShopItem("Snow Man", 78, 25000, CAT_MODEL, "snowman", "Enables use of the Snow Man model.").Model = "models/player/snow_man_pm/snow_man_pm.mdl"
ShopItem("Snow Man", 78, 1500000, CAT_MODEL, "snowman", "Enables use of the Snow Man model.").Model = "models/player/snow_man_pm/snow_man_pm.mdl"

ShopItem("Danboard", 79, 1500000, CAT_MODEL, "danboard", "Enables use of the Danboard model.").Model = "models/player/danboard.mdl"
ShopItem("Grim", 80, 1500000, CAT_MODEL, "grim", "Enables use of the Grim model.").Model = "models/grim.mdl"
ShopItem("GabeN", 81, 1500000, CAT_MODEL, "gaben", "Enables use of the GabeN model.").Model = "Models/Jason278-Players/gabe_3.mdl"
ShopItem("Creeper", 82, 1500000, CAT_MODEL, "creeper", "Enables use of the Creeper model.").Model = "models/jessev92/player/misc/creepr.mdl"
ShopItem("Bin Laden", 83, 1500000, CAT_MODEL, "binladen", "Enables use of the Bin Laden model.").Model = "models/jessev92/player/misc/osamabl1.mdl"

if SERVER then
	player_manager.AddValidModel("blackrockshooter", "models/player/brsp.mdl")
	player_manager.AddValidModel("moeglados", "models/player/moe_glados_p.mdl")
	player_manager.AddValidModel("snowman", "models/player/snow_man_pm/snow_man_pm.mdl")
	player_manager.AddValidModel("danboard", "models/player/danboard.mdl")
	player_manager.AddValidModel("grim", "models/grim.mdl")
	player_manager.AddValidModel("gaben", "Models/Jason278-Players/gabe_3.mdl")
	player_manager.AddValidModel("creeper", "models/jessev92/player/misc/creepr.mdl")
	player_manager.AddValidModel("binladen", "models/jessev92/player/misc/osamabl1.mdl")
end


s = ShopItem("Bumper Sticker: AS:S MAN", 84, 1, CAT_BACK, "asstitle1", "For true AS:S men.")
s.Awards = {"unstoppable"}
s = ShopItem("Bumper Sticker: YOU GOT DINKIED", 85, 1, CAT_BACK, "asstitle2", "For fans of Dr. TR Dinky.")
s.Awards = {"you_got_dinkied"}
s = ShopItem("Bumper Sticker: DEFUSE THIS", 86, 1, CAT_BACK, "asstitle3", "Bomb the bomb.")
s.Awards = {"defuse_this"}
s = ShopItem("Bumper Sticker: BOMB THE LASANGA", 87, 1, CAT_BACK, "asstitle4", "THERE'S A BOMB, IN THE LASANGA?!")
s.Awards = {"bomb_the_lasanga"}
s = ShopItem("Bumper Sticker: SHANK MASTER", 88, 1, CAT_BACK, "asstitle5", "Steb steb steb.")
s.Awards = {"shank_master"}
s = ShopItem("Bumper Sticker: BERSERK", 89, 1, CAT_BACK, "asstitle6", "For eccentric sword masters.")
s.Awards = {"berserk"}
s = ShopItem("Bumper Sticker: EYES ON YOU", 90, 1, CAT_BACK, "asstitle7", "For people with eyes on their ass.")
s.Awards = {"eyes_on_you"}
s = ShopItem("Bumper Sticker: RAIL ME", 91, 1, CAT_BACK, "asstitle8", "How many innuendos can we fit here?")
s.Awards = {"rail_me"}
s = ShopItem("Bumper Sticker: AS:S PIRATE", 92, 1, CAT_BACK, "asstitle9", "ARGH!")
s.Awards = {"ass_pirate"}
s = ShopItem("Bumper Sticker: SMART ASS", 93, 1, CAT_BACK, "asstitle10", "Skill in being skilless.")
s.Awards = {"smart_ass"}
s = ShopItem("Bumper Sticker: BAT MAN", 94, 1, CAT_BACK, "asstitle11", "I'm the bat man!")
s.Awards = {"bat_man"}
ShopItem("Bumper Sticker: NICE", nil, nil, CAT_BACK, "holidaytitle1", "", "This special item is a Holiday 2014 reward.", function(pl) return pl:HasFlag("holiday2014") end)
ShopItem("Bumper Sticker: NAUGHTY", nil, nil, CAT_BACK, "holidaytitle2", "Gimme the coal!", "This special item is a Holiday 2014 reward.", function(pl) return pl:HasFlag("holiday2014") end)

ShopItem("Deus Shades", 4, 100000, CAT_FACE, "deusshades", "Preorder these shades and you get a free game. I never asked for this.")

ShopItem("Dai-Gurren Brigade Shades", 37, 100000, CAT_FACE, "glglasses", "Show them your gattai.")
ShopItem("Dai-Gurren Brigade Leader Shades", 38, 250000, CAT_FACE, "glglassesbig", "These awesome shades are only for the manliest of men.")

ShopItem("Cone Stack", 95, 150000, CAT_HEAD, "conestack", "Previously worn by a legendary construction worker.")
ShopItem("Chrome Boy", 96, 25000, CAT_HEAD, "chromeboy", "This metal hat is both stylish and probably very heavy.")
s = ShopItem("Pet Zombie", 97, 100000, CAT_HEAD, "petzombie", "A cute little zombie that hangs on to your head. Too bad it blocks your view.")
s.Awards = {"zs_zombie_1st"}
ShopItem("Nazi Arm Band", 98, nil, CAT_ACCESSORY, "naziarmband", "All administrators are encouraged to wear this.", "This special item isn't available through normal methods.")
ShopItem("Devil Guardian", 99, 200000, CAT_ACCESSORY, "condevil", "A little guardian devil to float around your head.")
ShopItem("Angel Guardian", 100, 200000, CAT_ACCESSORY, "conangel", "A little guardian angel to float around your head.")
ShopItem("Search Light", 101, 200000, CAT_HEAD, "searchlight", "This huge search light will shine whenever your flashlight is turned on.")
ShopItem("Clown Shoes", 102, nil, CAT_ACCESSORY, "clownshoes", "YOU ARE THE CLUWNE.", "This special item isn't available through normal methods.")
ShopItem("Googley Glasses", 103, 30000, CAT_FACE, "googleyglasses", "People will take you very seriously while wearing these.")
s = ShopItem("Mini Charple", 104, 500000, CAT_HEAD, "minicharple", "A stuffed charple toy to scare away all of your enemies.")
s.Awards = {"zs_human_1st"}
ShopItem("Elephant Head", 105, 75000, CAT_HEAD, "elephanthead", "You're not fooling anyone but at least you can pretend to be an elephant.")

ShopItem("Mad Scientist", 106, 100000, CAT_HEAD, "madscientist", "I am mad scientist. Sonofabitch.")
ShopItem("Bionic Arm", 107, 100000, CAT_BACK, "bionicarm", "Bionic technology gives you a third arm! Too bad there's no batteries.")
ShopItem("Drill Arm", 108, 100000, CAT_ACCESSORY, "drillarm", "Where are you drawing all this power from?")
ShopItem("Shoulder Cannons", 109, 225000, CAT_BACK, "shouldercannons")
ShopItem("Road Hero", 110, 50000, CAT_BODY, "roadhero", "Direct traffic with your body.")
ShopItem("Bionic Leg", 111, 200000, CAT_BODY, "bionicleg")
ShopItem("Cpt. Hazard", 112, 125000, CAT_HEAD, "captainhazard")
ShopItem("Futuristic Jetpack", 113, 200000, CAT_BACK, "futuristicjetpack")
ShopItem("Alien Burster", 114, 50000, CAT_BODY, "alienburster", "")
ShopItem("Buns", 115, 100000, CAT_BACK, "buns", "Put some pants on.")
ShopItem("Devo Hat", 116, 25000, CAT_HEAD, "devohat", "WHIP IT GOOD.")
ShopItem("Headset", 117, 25000, CAT_HEAD, "headset", "An enourmous headset for pro hardcore gamers such as yourself.")
ShopItem("Hei Mask", 118, 100000, CAT_FACE, "heimask", "Dark and edgy ...and Pizza Hut.")
ShopItem("Kappa Head", 119, 150000, CAT_HEAD, "kappahead", "A certain kappa that lives under a certain bridge.")
ShopItem("KKK Hood", 120, nil, CAT_HEAD, "kkk", "All hail the grand wizard.", "This special item isn't available through normal methods.")
ShopItem("Penguindrum", 121, nil, CAT_HEAD, "penguindrum", "Shall we start the Survival Strategy?", "This special item isn't available through normal methods.")
ShopItem("Lobotomy", 122, 125000, CAT_HEAD, "lobotomy", "Get a lobotomy today! You won't feel a thing (ever again)!")
ShopItem("PacMan Ghost", 123, 300000, CAT_HEAD, "pacmanghost", "DUKA DUKA DUKA DUKA DUKA")
ShopItem("PacMan", 124, 300000, CAT_HEAD, "pacman", "WACKA WACKA WACKA WACKA WACKA")
ShopItem("Cpt. Falcon Helmet", 125, 200000, CAT_HEAD, "cptfalcon", "Show me your moves!")
s = ShopItem("Rock Crusher", 126, 400, CAT_BACK, "rockcrusher", "Direct from the NPC vendor.")
s.Awards = {"darkfall"}
ShopItem("Shield of Zombies", 127, 30000, CAT_ACCESSORY, "shieldzombie", "A shield with the emblem of a zombie.")
ShopItem("Shield of Horses", 128, 30000, CAT_ACCESSORY, "shieldhorse", "A shield with the emblem of a horse.")
ShopItem("9-11", 129, nil, CAT_HEAD, "911", "For true patriots.", "This special item isn't available through normal methods.", function(pl) return pl:HasAward("true_patriot") end)
ShopItem("Saya no Uta Axe", 130, 30000, CAT_BACK, "sayanoutaaxe", "A perfectly normal axe.")
ShopItem("Zombie Containment Pack", 131, 60000, CAT_BACK, "zombiecontainment", "Contains a zombie in stasis. Why it's on your back is up to you to decide.")
ShopItem("Aku Aku Mask", 132, 300000, CAT_ACCESSORY, "akuakumask", "UGA BOOGA")
ShopItem("Utility Belt", 133, 100000, CAT_BODY, "utilitybelt", "A utility belt with tools needed for zombie survival.")
ShopItem("Megaman Helmet", 134, 200000, CAT_HEAD, "megamanhelmet")
ShopItem("Brazilian Flag", 135, 50000, CAT_BACK, "brflag", "GIBE MONI PLS. I REPORT U. HUEHUEHUEHUE.")
ShopItem("Bomber Man Head", 136, 65000, CAT_HEAD, "bombermanhead")
ShopItem("Plank", 137, 80000, CAT_ACCESSORY, "plank", "My best friend Plank.")
ShopItem("Shopping Basket", 138, 80000, CAT_ACCESSORY, "shoppingbasket")
ShopItem("Trash Head", 139, 80000, CAT_HEAD, "trashhead", "Put it in me!")
ShopItem("Car Slippers", 140, 200000, CAT_ACCESSORY, "carslippers")
ShopItem("Gone Fishin", 141, 30000, CAT_BACK, "gonefishing")
ShopItem("Third Reich Fury", 142, nil, CAT_HEAD, "thirdreichfury", "", "This special item isn't available through normal methods.")
ShopItem("Radio Man", 143, 100000, CAT_BACK, "radioman")
ShopItem("Babbys First Slide", 144, 30000, CAT_HEAD, "babbysfirstslide")
ShopItem("Lightsaber", 145, 100000, CAT_ACCESSORY, "lightsaber", "Use the force.")
ShopItem("Nanako Wig", 146, 100000, CAT_HEAD, "nanakohair", "Every day is great at your Junes!")
ShopItem("Dr. Robotnik Face", 147, 250000, CAT_FACE, "robotnikface", "Robotnik does not approve of these Sonic emotes.")
ShopItem("Snorkle", 148, 100000, CAT_FACE, "snorkle")
ShopItem("Hook Hand", 149, 20000, CAT_ACCESSORY, "hookhand")
ShopItem("Explosive Man", 150, 250000, CAT_BODY, "explosiveman")
ShopItem("Eye of VALVe", 151, 50000, CAT_FACE, "eyevalve")
ShopItem("Junk in the Trunk", 152, 100000, CAT_BACK, "junktrunk")
ShopItem("Slig Mask", 153, 200000, CAT_FACE, "sligmask", "SQUEEG! Whaaat?")
ShopItem("Headcrab Slippers", 154, 150000, CAT_ACCESSORY, "headcrabslippers")
ShopItem("Assault Rover Head", 155, 600000, CAT_HEAD, "roverhead")
ShopItem("Gentleman Hat and Monocle", 156, 500000, CAT_HEAD, "gentleman", "For true gentlemen.")
ShopItem("Sparx", 157, 400000, CAT_ACCESSORY, "sparx")
ShopItem("UFO", 158, 100000, CAT_ACCESSORY, "ufo")
ShopItem("Poison Headcrab Attack!", 159, 300000, CAT_BODY, "phcbody")
ShopItem("Jelly Fishing Net", 160, 75000, CAT_BACK, "jellyfishingnet", "jelly fishing jelly fishing jelly fishing jelly fishing jelly fishing!")
ShopItem("Mohawk", 161, 50000, CAT_HEAD, "mohawk")
ShopItem("Spiked Wrist Bands", 162, 30000, CAT_ACCESSORY, "spikewristbands")
ShopItem("Birthday Bash", 163, 50000, CAT_HEAD, "birthdaybash")
ShopItem("Galo Hair", 164, 200000, CAT_HEAD, "galohair", "GO GO GAL O SENGEN!!")
ShopItem("Wrist Watch", 165, 30000, CAT_ACCESSORY, "wristwatch")
ShopItem("Field Radio", 166, 200000, CAT_BACK, "fieldradio")
ShopItem("BUNS IN MY EYES", 167, 125000, CAT_HEAD, "buneyes", "HEY PAL. GET YOUR BUNS OUT OF MY EYES!")
ShopItem("Arrow to the Eye", 168, 50000, CAT_FACE, "arroweye", "Arrow to the knee xdxdxd")
ShopItem("Bug Man", 169, 100000, CAT_FACE, "bugman")
ShopItem("Arm Cannon", 170, 250000, CAT_ACCESSORY, "armcannon", "Samus would be proud.")
ShopItem("Illuminati", 171, 3000000, CAT_HEAD, "illuminati", "Maybe the price tag will let you be an Illuminati.")
ShopItem("Messenger Bag", 172, 50000, CAT_BODY, "messengerbag")
ShopItem("Holy Gear", 173, 150000, CAT_BACK, "holygear")
ShopItem("Junpei Cap", 174, 40000, CAT_HEAD, "junpeicap", "These fries are always so soggy.")
ShopItem("Sonic Head", 175, 45000, CAT_HEAD, "sonichead", "Sonic's the name, speed's my game!")
ShopItem("Sonic Spines", 176, 45000, CAT_BACK, "sonicback", "Too easy, piece of cake!")
ShopItem("Sonic Shoes", 177, 45000, CAT_ACCESSORY, "sonicshoes", "Gotta go fast!")
ShopItem("1UP Hat", 178, 100000, CAT_HEAD, "1up")
ShopItem("American Flag", 179, 100000, CAT_BACK, "americanflag")
ShopItem("Arrow Prank", 180, 100000, CAT_HEAD, "arrowprank")
ShopItem("BRS Eye", 181, 150000, CAT_FACE, "brseye")
ShopItem("Scouter", 182, 100000, CAT_HEAD, "scouter", "bro don't even...")
ShopItem("Responsible Parent", 183, 50000, CAT_BACK, "responsibleparent")
ShopItem("Party Hat", 184, 30000, CAT_HEAD, "partyhat")
ShopItem("Radiance Aura", 185, 200000, CAT_HEAD, "radiance")
ShopItem("Mr. Saturn Hair", 186, 50000, CAT_HEAD, "mrsaturnhair")
ShopItem("Party Rock Robot", 187, 250000, CAT_HEAD, "partyrockrobot")
ShopItem("Mega Buster", 188, 100000, CAT_ACCESSORY, "megabuster")
ShopItem("Life Capsule", 189, 80000, CAT_ACCESSORY, "lifecapsule")
ShopItem("9-11 part 2", 190, nil, CAT_ACCESSORY, "911p", "For true patriots.", "This special item isn't available through normal methods.", function(pl) return pl:HasAward("true_patriot") end)
ShopItem("Booze Belt", 191, 50000, CAT_BODY, "boozebelt")
ShopItem("Dazed and Confused", 192, 113580, CAT_HEAD, "dazed")
ShopItem("Brother Bobby", 193, 100000, CAT_ACCESSORY, "brotherbobby")
ShopItem("P3 Pin", 194, 25000, CAT_ACCESSORY, "p3pin")
ShopItem("Soul Reaver", 195, 250000, CAT_BACK, "soulreaver")
ShopItem("Mechanical Heart", 196, 100000, CAT_BODY, "mechheart")
ShopItem("MET Helmet", 197, 30000, CAT_HEAD, "methelmet")
ShopItem("Ballet Dress", 198, 75000, CAT_BODY, "ballet")
ShopItem("Unicorn Horn", 199, 50000, CAT_HEAD, "unicorn")
ShopItem("Risque Dancer", 200, 100000, CAT_BODY, "risquedancer")
ShopItem("Bomb Belt", 201, 200000, CAT_BODY, "bombbelt")
ShopItem("Missile Launcher", 202, 200000, CAT_HEAD, "missilelauncher")
ShopItem("Ice Cream", 203, 25000, CAT_HEAD, "icecream", "Looks like someone played a trick on you.")
ShopItem("Ness Hat", 204, 100000, CAT_HEAD, "nesshat", "PK THUNDAH")
ShopItem("Master of the Mantra", 205, 250000, CAT_BACK, "masterofthemantra")
ShopItem("LEGO Brick", 206, 50000, CAT_HEAD, "legobrick")
ShopItem("Quote Hat", 207, 150000, CAT_HEAD, "quotehat", "You must be a soldier from the surface.")
ShopItem("Clown Wig", 208, nil, CAT_HEAD, "clownwig", "YOU ARE THE CLUWNE.", "This special item isn't available through normal methods.")
ShopItem("Clown Horn", 209, nil, CAT_BODY, "clownhorn", "YOU ARE THE CLUWNE.", "This special item isn't available through normal methods.")

ShopItem("Television", 210, 50000, CAT_HEAD, "television")
ShopItem("Wrist Blades", 211, 100000, CAT_ACCESSORY, "wristblades")
ShopItem("Pauldrons", 212, 100000, CAT_BODY, "pauldrons")
ShopItem("Tube Plant", 213, 200000, CAT_HEAD, "tubeplant")
ShopItem("Pea Shooter", 214, 250000, CAT_HEAD, "peashooter")
ShopItem("Pokeball", 215, 20000, CAT_ACCESSORY, "pokeball")
ShopItem("HG Halo", 216, 100000, CAT_HEAD, "hghalo")
ShopItem("Guitar", 217, 40000, CAT_BACK, "guitar")
ShopItem("Piccolo Arms", 218, 40000, CAT_ACCESSORY, "picarms", "DAILY DOSE")
ShopItem("Piccolo Dick", 219, 150000, CAT_BODY, "picdick", "DAILY DOSE")
ShopItem("Piccolo Ears", 220, 40000, CAT_HEAD, "picears", "DAILY DOSE")
ShopItem("Nunavut Flag", 221, 125000, CAT_BACK, "nunavutflag")
ShopItem("Canadian Flag", 222, 125000, CAT_BACK, "canadianflag", "America's hat")
ShopItem("July 4th Tribute", 223, 250000, CAT_BODY, "july4thtribute")
ShopItem("Vuvuzela", 224, 50000, CAT_FACE, "vuvuzela")
ShopItem("Holy Shoulders", 225, 100000, CAT_BODY, "holyshoulders")
ShopItem("Spaghetti Pocket", 226, 30000, CAT_BODY, "spaghetti", "ATELIER GAMESTOP PLEASE BUY TOTORI")
ShopItem("Israel Flag", 227, 125000, CAT_BODY, "israelflag")
ShopItem("Eli Head", 228, 300000, CAT_HEAD, "elihead", "THE BOOK OF ELI THE BOOK OF ELI THE BOOK OF ELI")
ShopItem("Ritual Blade", 229, 300000, CAT_BACK, "ritualblade", "Izanagi's legendary ritual blade.")
ShopItem("Bionic Breath", 230, 100000, CAT_FACE, "bionicbreath")
ShopItem("Nazi Banner", 231, nil, CAT_BACK, "nazibanner", "For our brave men and women of the administration team.", "This special item isn't available through normal methods.")
ShopItem("God-King Halo", 232, 300000, CAT_BACK, "godkinghalo", "PURGE EVERYTHING")
ShopItem("Alchemist Blade", 233, 60000, CAT_ACCESSORY, "alchemistblade", "Need to get some devil's panties to make some powdering powder.")
ShopItem("Cake Hat", 234, 100000, CAT_HEAD, "cakehat", "You feel like clowning around.")
ShopItem("Mossman Head", 5, 100000, CAT_HEAD, "mossmanhead")
ShopItem("GMan Head", 6, 100000, CAT_HEAD, "gmanhead")
ShopItem("Camera", 7, 30000, CAT_BODY, "camera")
ShopItem("Holy Book", 235, 25000, CAT_ACCESSORY, "holybook", "May the light of lights be with you!")
ShopItem("Zombie Kennel", 236, 75000, CAT_ACCESSORY, "zombiekennel")
ShopItem("Space Man", 237, 80000, CAT_HEAD, "spaceman")
ShopItem("Axe of Axes", 238, 300000, CAT_BACK, "axeofaxes", "So many heads to cleave, so many bodies to throw in the pile.")
ShopItem("Fractal Grenades", 239, 50000, CAT_BODY, "fractalgrenades", "FRACTALLLLS!")
ShopItem("Vanguard", 240, 50000, CAT_BODY, "vanguard")
ShopItem("Frotchet", 241, 200000, CAT_BACK, "frotchet", "This ancient relic emits an aura of cold around it.")
ShopItem("Steed Feet", 242, 60000, CAT_ACCESSORY, "steedfeet", "Now the race track can come right to you.")
ShopItem("Lisp", 243, 20000, CAT_FACE, "lisp", "you wanna wastle?")
ShopItem("Sword of Damnation", 244, 250000, CAT_BODY, "swordofdamnation")
ShopItem("Staff of the Untouchable", 245, 300000, CAT_BACK, "staffofuntouchable")
ShopItem("Rudolph", 246, 50000, CAT_FACE, "rudolph")
ShopItem("Pugna Wand", 247, 75000, CAT_ACCESSORY, "pugnawand")
ShopItem("Jolly Cooperation", 248, 100000, CAT_BODY, "jollycoop", "PRAAAAAAAAAAAIIIIIIIIIISE THE SUUUUUUUUUUUUUUUUUUUUUUUUN!")
ShopItem("Helm of the Black Legion", 249, 200000, CAT_HEAD, "blacklegion")
ShopItem("Gladradus", 250, 200000, CAT_BACK, "gladradus")
ShopItem("Dumbbell", 251, 35000, CAT_ACCESSORY, "dumbbell", "Do you even lift? Yes sir, I do.")
ShopItem("Codex of Wisdom", 252, 75000, CAT_ACCESSORY, "codexofwisdom")
ShopItem("Astronaut Helmet", 253, 100000, CAT_HEAD, "astrohelm")
ShopItem("Pugna Head", 254, 400000, CAT_HEAD, "pugnahead")
ShopItem("Clockwork Face", 255, 20000, CAT_FACE, "cwface")
ShopItem("Lua", 256, 60000, CAT_HEAD, "lua", "For all the expert L.U.A. scripters.")
ShopItem("Cremator Head", 257, 40000, CAT_HEAD, "crematorhead")
ShopItem("Moon Eye", 258, 200000, CAT_ACCESSORY, "mooneye")
ShopItem("Claptrap", 259, 75000, CAT_ACCESSORY, "claptrap")
ShopItem("Dark Hand", 260, 150000, CAT_ACCESSORY, "darkhand")
ShopItem("Decay", 261, 200000, CAT_ACCESSORY, "decay")
ShopItem("Estus Flask", 262, 75000, CAT_ACCESSORY, "estusflask", "Give me some of your flasks god dammit!")
ShopItem("RIG", 263, 100000, CAT_BACK, "rigsuit", "AURHhh ARURHHHH. SHIT. FUCK. ARUHRHRRR.")
ShopItem("Bastion Hammer", 264, 200000, CAT_BACK, "bastionhammer", "Omg best indie game ever all year")
ShopItem("Clockwork Body", 265, 200000, CAT_BODY, "cwbody")
ShopItem("Clockwork Back", 266, 150000, CAT_BACK, "cwback")
ShopItem("Tombstone", 267, 300000, CAT_BACK, "tombstone")

ShopItem("Timbersaw", 268, 100000, CAT_ACCESSORY, "timbersaw", "I told you to stop getting blood on my blades!")
ShopItem("Water Gun", 269, 75000, CAT_ACCESSORY, "watergun")
ShopItem("Molly", 270, 30000, CAT_ACCESSORY, "molly")
ShopItem("Puni", 271, 30000, CAT_ACCESSORY, "puni", "puniii puniiii~")
ShopItem("Eye of Sauron", 272, 200000, CAT_BACK, "eyeofsauron")
ShopItem("Platemail", 273, 50000, CAT_BACK, "platemail")
ShopItem("Starman Badges", 274, 20000, CAT_BODY, "starmanbadges")
ShopItem("Steel Might", 275, 50000, CAT_BODY, "steelmight")
ShopItem("Steel Might Heater", 276, 75000, CAT_BACK, "steelmightheater")
ShopItem("Horse Stick", 277, 75000, CAT_BODY, "horsestick")
ShopItem("Deku Shield", 278, 35000, CAT_BACK, "dekushield")
ShopItem("Banjo Pack", 279, 75000, CAT_BACK, "banjopack")
ShopItem("Muffin Head", 280, 40000, CAT_HEAD, "muffinhead")
ShopItem("Shredder Helmet", 281, 75000, CAT_HEAD, "shredder", "Looking sharp. Crazy sharp.")
ShopItem("Monkey Head", 282, 100000, CAT_HEAD, "monkeyhead")
ShopItem("Puni on Head", 283, 30000, CAT_HEAD, "punihead", "puni puninini")
ShopItem("Glukkon Head", 284, 75000, CAT_HEAD, "glukkon")
ShopItem("Edd Sock", 285, 30000, CAT_HEAD, "eddsock")
ShopItem("GMod Logo", 286, 50000, CAT_HEAD, "gmodlogo")
ShopItem("Lego Head", 287, 75000, CAT_HEAD, "legohead")
ShopItem("War Helmet", 288, 75000, CAT_HEAD, "warhelm")
ShopItem("Wizard Hat", 289, 50000, CAT_HEAD, "wizardhat")
ShopItem("Anime Eyes", 290, 30000, CAT_FACE, "animeeyes")
ShopItem("Fallen Angel Wings", 291, nil, CAT_BACK, "fangelwings", "Dark wings of a fallen angel.", "You must have reached 50 wins as a Death in Deathrun before 4/30/2013.", function(pl) return pl:HasAward("fallen_angel") end)
ShopItem("Runner Wrist Bands", 292, nil, CAT_BODY, "runnerwristbands", "Stylish, dyeable wrist bands.", "You must have 100 wins as a Runner in Deathrun.", function(pl) return pl.DRWonRunner3 >= 100 end)
ShopItem("Runner Shoes", 293, nil, CAT_ACCESSORY, "runnershoes", "Magical, winged shoes.", "You must have reached 150 wins as a Runner in Deathrun before 4/30/2013.", function(pl) return pl:HasAward("quick_runner") end)
ShopItem("Angel Wings", 294, nil, CAT_BACK, "angelwings", "Wings of an angel.", "You must have reached 150 wins as a Runner in Deathrun before 4/30/2013.", function(pl) return pl:HasAward("quick_runner") end)
ShopItem("Dragon Slayer", 295, 100000, CAT_BACK, "dragonslayer")
ShopItem("Cling Iron Cross", 296, 100000, CAT_BODY, "clingironcross")
ShopItem("Kain's Lance", 297, 75000, CAT_BACK, "kainlance")
ShopItem("Mirror Shield", 298, 60000, CAT_BACK, "mirrorshield")
ShopItem("Cirno's Wings", 299, 60000, CAT_BACK, "cirnowings", "Eye am the strongest.")
ShopItem("Flandre's Wings", 300, 60000, CAT_BACK, "flandrewings")
ShopItem("Dexter's Glasses", 301, 40000, CAT_FACE, "dexterglasses")
ShopItem("Stigmata", 302, 9000, CAT_FACE, "stigmata")
ShopItem("Pizza Face", 303, 30000, CAT_FACE, "pizzaface")
ShopItem("Bong", 304, 10000, CAT_ACCESSORY, "bong", "420 blaze it")
ShopItem("Campbell's Saw", 305, 50000, CAT_ACCESSORY, "campbellsaw")
ShopItem("Mana Earrings", 306, 15000, CAT_ACCESSORY, "manaearrings")
ShopItem("Psi Blades", 307, 60000, CAT_ACCESSORY, "psiblades")
ShopItem("Dark Helmet", 308, 75000, CAT_HEAD, "darkhelmet")
ShopItem("Sir Dan Skull", 309, 50000, CAT_HEAD, "sirdanskull")
ShopItem("Crest", 310, 15000, CAT_BODY, "crest")
ShopItem("Dark Templar Scythe", 311, 75000, CAT_BACK, "dtemplarscythe")
ShopItem("Storm Spirit Belt", 312, 50000, CAT_BODY, "sspiritbelt")
ShopItem("Majoras Mask", 313, 50000, CAT_FACE, "majorasmask")
ShopItem("Cyclops", 314, 40000, CAT_HEAD, "cyclops")
ShopItem("Welding Mask", 315, 25000, CAT_HEAD, "weldingmask")
ShopItem("Dragoon Cap", 316, 30000, CAT_HEAD, "dragooncap")
ShopItem("Storm Spirit Hat", 317, 25000, CAT_HEAD, "sspirithat")
ShopItem("Mirror Shield 2", 318, 60000, CAT_ACCESSORY, "mirrorshield2")
ShopItem("Devil Horns", 319, 35000, CAT_ACCESSORY, "devilhorns")
ShopItem("Identity Disk", 320, 25000, CAT_ACCESSORY, "identitydisk")
ShopItem("Ammo Hoarder", 321, 25000, CAT_BACK, "ammohoarder")
ShopItem("BMO", 322, 65000, CAT_BODY, "bmo")
ShopItem("Buster Sword", 323, 75000, CAT_BACK, "bustersword")
ShopItem("Fridge Raider", 324, 25000, CAT_BACK, "fridgeraider")
ShopItem("Ring Blade", 325, 30000, CAT_BACK, "ringblade")
ShopItem("Tiny Alchemist", 326, 50000, CAT_BACK, "tinyalchemist")
ShopItem("Assistant Blades", 327, 50000, CAT_BACK, "assistantblades")
ShopItem("Bottle Rocket", 328, 50000, CAT_BODY, "bottlerocket")
ShopItem("Bounce Bracelet and Flame Ring", 329, 20000, CAT_ACCESSORY, "bbandfr")
ShopItem("Carl Mask", 330, 50000, CAT_HEAD, "carl")
ShopItem("Cloud Strife Pauldron", 331, 10000, CAT_ACCESSORY, "cspauldron")
ShopItem("Construction Tools", 332, 12500, CAT_ACCESSORY, "constructiontools")
ShopItem("Damned Eye", 333, 25000, CAT_ACCESSORY, "damnedeye")
ShopItem("Knife Eye", 334, 25000, CAT_FACE, "knifeeye")
ShopItem("Deku Mask", 335, 35000, CAT_FACE, "dekumask")
ShopItem("Hand Drill", 336, 20000, CAT_FACE, "handdrill")
ShopItem("Dust Force Broom", 337, 25000, CAT_BACK, "dustforcebroom")
ShopItem("Fish in a Bottle", 338, 5000, CAT_ACCESSORY, "fishinabottle")
ShopItem("Hocates' Space Helmet", 339, 50000, CAT_HEAD, "hocateshelmet")
ShopItem("Commander Keen's Pogo Stick", 340, 50000, CAT_BACK, "keenpogo")
ShopItem("Commander Keen's Ray Gun", 341, 30000, CAT_ACCESSORY, "keenraygun")
ShopItem("Lantern", 342, 40000, CAT_ACCESSORY, "lantern")
ShopItem("Lens of Truth", 343, 30000, CAT_ACCESSORY, "lensoftruth")
ShopItem("Shackles", 344, 45000, CAT_ACCESSORY, "shackles")
ShopItem("Shine Sprite", 345, 60000, CAT_ACCESSORY, "shinesprite")
ShopItem("Steiner's Hat", 346, 30000, CAT_HEAD, "steinershat")
ShopItem("Tinker's Pipe", 347, 20000, CAT_ACCESSORY, "tinkerspipe")
ShopItem("Wrath and Envy", 348, 100000, CAT_BODY, "wrathandenvy")
ShopItem("Futuristic Ear Phones", 349, 10000, CAT_HEAD, "futureearphones")
ShopItem("STABO Belt", 350, 30000, CAT_BODY, "stabobelt")
ShopItem("Abyss Walker Helmet", 351, 50000, CAT_HEAD, "abysswalkerhelm")
ShopItem("Awesome Face", 352, 50000, CAT_FACE, "awesomeface")
ShopItem("Craver Head", 353, 40000, CAT_HEAD, "craverhead")
ShopItem("Crown of Cinder", 354, 50000, CAT_HEAD, "crownofcinder")
ShopItem("Heart of Tarrasque", 355, 25000, CAT_BODY, "heartoftarrasque")
ShopItem("Judge Helmet", 356, 50000, CAT_HEAD, "judgehelmet", "I am the Law.")
ShopItem("Junketsu", 357, 80000, CAT_BODY, "junketsu")
ShopItem("Senketsu", 358, 80000, CAT_BODY, "senketsu")
ShopItem("Midori", 359, 25000, CAT_ACCESSORY, "midori")
ShopItem("New Conglomerate Helmet", 360, 40000, CAT_HEAD, "nchelmet")
ShopItem("Vanu Sovereignty Helmet", 361, 40000, CAT_HEAD, "vshelmet")
ShopItem("Terran Republic Helmet", 362, 40000, CAT_HEAD, "trhelmet")
ShopItem("Sophon Helmet", 363, 40000, CAT_HEAD, "sophonhelmet")
ShopItem("Rabadon's Death Cap", 364, 60000, CAT_HEAD, "rabadondeathcap")
ShopItem("Scissor Blade", 365, 65000, CAT_BACK, "scissorblade")
ShopItem("Sol's Bulwark", 366, 50000, CAT_ACCESSORY, "solbulwark")
ShopItem("Wilfred's Hammer", 367, 100000, CAT_BACK, "wilfredhammer")
ShopItem("Yuela's Crescent Blade", 368, 60000, CAT_BODY, "crescentblade")

AddTitle("Grand Champion", "(<flashhsv>Grand Champion</flashhsv>)", "The ultimate title.", "You must meet the requirements of every Champion title!",
function(pl)
	return NDB.PlayerHasShopItem(pl, "SMB Champion") and NDB.PlayerHasShopItem(pl, "ZS Champion") and NDB.PlayerHasShopItem(pl, "TP Champion")
end)

AddTitle("Title Reset", "Title Reset", "Resets your title.", "None",
function(pl)
	return true
end)

AddTitle("Title Clear", "Title Clear", "Clears your title.", "None",
function(pl)
	return true
end)

AddTitle("Survivor", "(<red>Survivor</red>)", "A 1/10 chance isn't that bad.", "Requires a 10% survival rate and 100 games of Zombie Survival played.",
function(pl)
	return pl.ZSGamesSurvived / math.max(pl.ZSGamesLost, 1) >= 0.1 and pl.ZSGamesSurvived + pl.ZSGamesLost >= 100
end)

AddTitle("ZS Champion", "(<img src=zombiesurvival/humanhead> <lb>ZS Champion</lb>)", "For those who survive against all odds.", "Requires a 15% survival rate and 100 games of Zombie Survival played.",
function(pl)
	return pl.ZSGamesSurvived / math.max(pl.ZSGamesLost, 1) >= 0.15 and pl.ZSGamesSurvived + pl.ZSGamesLost >= 100
end)

AddTitle("TP Slayer", "(<red>TP Slayer</red>)", "You need to be efficient to get this title.", "Requires a Team Play K/D ratio of 2.0 or above as well as 100 kills.",
function(pl)
	return pl.CTFKills >= 100 and pl.CTFKills / math.max(1, pl.CTFDeaths) >= 2
end)

AddTitle("TP Defender", "(<lg>TP Defender</lg>)", "", "Requires a Team Play Defense/Offense ratio of 5.0 or above as well as have at least 100 defense points.",
function(pl)
	return pl.AssaultDefense >= 100 and pl.AssaultDefense / math.max(1, pl.AssaultOffense) >= 5
end)

AddTitle("TP Destroyer", "(<lg>TP Destroyer</lg>)", "", "Requires at least 100 Team Play offense points and at least a 5.0 Team Play Offense/Defense ratio.",
function(pl)
	return pl.AssaultOffense >= 100 and pl.AssaultOffense / math.max(1, pl.AssaultDefense) >= 5
end)

AddTitle("TP Apprentice", "(TP Apprentice)", "", "Requires a Team Play Kill/Death ratio of 2.0 or above, a Win/Lose ratio of 1.0 or above, and 50 matches played.",
function(pl)
	return pl.CTFKills / math.max(pl.CTFDeaths, 1) >= 2 and pl.AssaultWins / math.max(pl.AssaultLosses, 1) >= 1 and pl.AssaultWins + pl.AssaultLosses >= 50
end)

AddTitle("TP Master", "(TP Master)", "", "Requires a Team Play Kill/Death ratio of 3.0 or above, a Win/Lose ratio of 1.5 or above, and 50 matches played.",
function(pl)
	return pl.CTFKills / math.max(pl.CTFDeaths, 1) >= 3 and pl.AssaultWins / math.max(pl.AssaultLosses, 1) >= 1.5 and pl.AssaultWins + pl.AssaultLosses >= 50
end)

AddTitle("TP Champion", "(TP Champion)", "", "Requires a Team Play Kill/Death ratio of 5.0 or above, a Win/Lose ratio of 2.0 or above, and 50 matches played.",
function(pl)
	return pl.CTFKills / math.max(pl.CTFDeaths, 1) >= 5 and pl.AssaultWins / math.max(pl.AssaultLosses, 1) >= 2 and pl.AssaultWins + pl.AssaultLosses >= 50
end)

AddTitle("SMB Knight", "(SMB Knight)", "", "Requires a Mario Boxes Win/Lose ratio of 1.5 or above and have at least 30 games played.",
function(pl)
	return pl.MarioBoxesWins / math.max(pl.MarioBoxesLosses, 1) >= 1.5 and pl.MarioBoxesWins + pl.MarioBoxesLosses >= 30
end)

AddTitle("SMB Hero", "(SMB Hero)", "", "Requires a Mario Boxes Win/Lose ratio of 1.5 or above and have at least 40 games played.",
function(pl)
	return pl.MarioBoxesWins / math.max(pl.MarioBoxesLosses, 1) >= 2 and pl.MarioBoxesWins + pl.MarioBoxesLosses >= 40
end)

AddTitle("Box Killer", "(Box Killer)", "", "Requires a Mario Boxes Kill/Death ratio of 0.75 or above and have at least 50 kills.",
function(pl)
	return pl.MarioBoxesKills / math.max(pl.MarioBoxesDeaths, 1) >= 0.75 and pl.MarioBoxesKills >= 50
end)

AddTitle("Box Destroyer", "(Box Destroyer)", "", "Requires a Mario Boxes Kill/Death ratio of 1.0 or above and have at least 100 kills.",
function(pl)
	return pl.MarioBoxesKills / math.max(pl.MarioBoxesDeaths, 1) >= 1 and pl.MarioBoxesKills >= 100
end)

AddTitle("SMB Champion", "(SMB Champion)", "", "You must meet the requirements of both Box Destroyer and SMB Hero.",
function(pl)
	return NDB.PlayerHasShopItem(pl, "SMB Hero") and NDB.PlayerHasShopItem(pl, "Box Destroyer")
end)

AddTitle("Verified Girl", "<pink>(Verified</pink> <silkicon icon=heart> <pink>Girl)</pink>", "Pass the test before you can use this one.", "If you have passed the vigorous \"are they female?\" test, you can freely use this title.",
function(pl)
	return pl:HasAward("Verified_Girl")
end)

AddTitle("I Love Obby", "<pink>(I</pink> <silkicon icon=heart> <pink>Obby)</pink>", "If you really love Obby...", "You must submit and publish two Obby levels.",
function(pl)
	return pl:HasFlag("obbypromo1")
end)

AddTitle("Death Runner", "(<flash color=60,60,255>Death Runner</flash>)", "", "You must have a Deathrun win percent of 10% and 20 rounds played or more while playing as a Runner.",
function(pl)
	return pl.DRPlayedRunner3 >= 20 and pl.DRWonRunner3 / pl.DRPlayedRunner3 >= 0.1
end)

AddTitle("Runner Killer", "(<img src=HUD/killicons/default color=255,0,0> <red>Runner Killer</red>)", "", "You must have a Deathrun win percent of 90% and 20 rounds played or more while playing as a Death.",
function(pl)
	return pl.DRPlayedDeath3 >= 20 and pl.DRWonDeath3 / pl.DRPlayedDeath3 >= 0.9
end)

end
