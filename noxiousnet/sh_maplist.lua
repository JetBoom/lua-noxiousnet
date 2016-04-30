NDB.MapList = {}

local gamemodename

-- Name, display name, minimum players to vote, REDIRECT this to a different map, RunString on map load
function NDB.AddMap(name, cleanname, minplayers, redirect, onload)
	if gamemodename then
		local tab = NDB.MapList[gamemodename]
		tab[#tab+1] = {name, cleanname, minplayers, redirect, onload}
	end
end

function NDB.AddMapType(gm)
	NDB.MapList[gm] = NDB.MapList[gm] or {}
	gamemodename = gm
end

function NDB.GetMapTable(name, gmname)
	if not NDB.GamemodeMapList[gamemodename] then return end

	for i, tab in pairs(NDB.GamemodeMapList[gmname]) do
		if tab[1] == name then return tab end
	end
end

NDB.AddMapType("default")
NDB.AddMap("gm_flatgrass", "Flat Grass")
NDB.AddMap("gm_construct", "Construct")

G = NDB.AddMapType
M = NDB.AddMap
include("maplist.lua")
G = nil
M = nil

--[[NDB.AddMapType("obby")
NDB.AddMap("nightmare", "Nightmare", "This course is a nightmare!", "Chubfish", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"nightmare\") NDB.CurrentOverrideMap=\"nightmare\"")
--NDB.AddMap("the_spirit_breaker", "The Spirit Breaker", "It's big.", "Blue.Frog and a bunch of other admins", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"the_spirit_breaker\",90) NDB.CurrentOverrideMap=\"the_spirit_breaker\"")
NDB.AddMap("easy_mountain", "Easy Mountain", "A map for people new to Obby!", "JetBoom and Steve Renalds", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"easy_mountain\") NDB.CurrentOverrideMap=\"easy_mountain\"")
NDB.AddMap("bootcamp", "Boot Camp", "A training course for Zombie Survival.", "RdJ", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"bootcamp\") NDB.CurrentOverrideMap=\"bootcamp\"")
NDB.AddMap("ravenrock", "Ravenrock", "Climb and jump through Ravenrock. Time your jumps properly or hit the ground.", "JetBoom", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"ravenrock\") NDB.CurrentOverrideMap=\"ravenrock\"")
NDB.AddMap("alans_paper_round", "Alan's Paper Round", "A challenging course for beginners.", "Chubfish", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"alans_paper_round\") NDB.CurrentOverrideMap=\"alans_paper_round\"")
NDB.AddMap("time_ascent", "Time Ascent", "A rather hard course with lots of spinners and moving platforms.", "ReXeN", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"time_ascent\") NDB.CurrentOverrideMap=\"time_ascent\"")
--NDB.AddMap("bridge", "Bridge", "A memory course.", "RdJ", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"bridge\") NDB.CurrentOverrideMap=\"bridge\"")
NDB.AddMap("avalanche", "Avalanche!", "Get to the top of the hill before anyone else. Watch out for falling junk!", "Blue.Frog", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"avalanche\") NDB.CurrentOverrideMap=\"avalanche\"")
--NDB.AddMap("swings_and_things", "Swings and Things", "A short course for beginners to learn how swings work", "nightmare", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"swings_and_things\") NDB.CurrentOverrideMap=\"swings_and_things\"")
--NDB.AddMap("clock_tower", "Clock Tower", "A moderately difficult map full of spinning clocks.", "Skiazo", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"clock_tower\") NDB.CurrentOverrideMap=\"clock_tower\"")
NDB.AddMap("crazymaze", "Crazy Maze", "This large maze has moving walls to confuse people.", "Meow", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"crazymaze\") NDB.CurrentOverrideMap=\"crazymaze\"")
NDB.AddMap("tower", "Tower", "Test your climing skills!", "RdJ", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"tower\") NDB.CurrentOverrideMap=\"tower\"")
NDB.AddMap("rainbow_city", "Rainbow City", "A colorful beginner's course.", "Overload", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"rainbow_city\") NDB.CurrentOverrideMap=\"rainbow_city\"")
NDB.AddMap("trainstation", "Trainstation", "A moderately difficult level with a trainstation theme.", "ReXeN", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"trainstation\") NDB.CurrentOverrideMap=\"trainstation\"")
--NDB.AddMap("gumdrop_mountain", "Gumdrop Mountain", "A sweets-themed level.", "Skiazo", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"gumdrop_mountain\") NDB.CurrentOverrideMap=\"gumdrop_mountain\"")
NDB.AddMap("surf-shot", "Surf-shot", "Keep up to speed and aim your jump right!", "The1Flame", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"surf-shot\") NDB.CurrentOverrideMap=\"surf-shot\"")
NDB.AddMap("industrial", "Industrial", "A large industrial-themed level with lots of moving parts.", "Meow", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"industrial\") NDB.CurrentOverrideMap=\"industrial\"")
NDB.AddMap("two_levels", "Two Levels", "A moderately difficult level with lots of jumping.", "Meow", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"two_levels\") NDB.CurrentOverrideMap=\"two_levels\"")
NDB.AddMap("the_tower_of_terror_floor_1", "The Tower of Terror, Floor 1", "Get to the top of the tower before anyone else. Tons of traps are there to stop you.", "JusticeInACan", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"the_tower_of_terror_floor_1\") NDB.CurrentOverrideMap=\"the_tower_of_terror_floor_1\"")
NDB.AddMap("mile_high", "Mile High", "A hard surfing level with spinners.", "MrSavage", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"mile_high\") NDB.CurrentOverrideMap=\"mile_high\"")
NDB.AddMap("icey_mystery", "Icey Mystery", "A small rock climbing level.", "Gormaoife", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"icey_mystery\") NDB.CurrentOverrideMap=\"icey_mystery\"")
NDB.AddMap("chubfuck", "Chubfuck", "Medium-sized jumping level.", "Exhale", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"chubfuck\") NDB.CurrentOverrideMap=\"chubfuck\"")
--NDB.AddMap("4_towers", "4 Towers", "Climb four towers to victory.", "Typhon", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"4_towers\") NDB.CurrentOverrideMap=\"4_towers\"")
NDB.AddMap("3block", "3Block", "Three blocks of climbing.", "Kris2456", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"3block\") NDB.CurrentOverrideMap=\"3block\"")
NDB.AddMap("jump_n_slide", "Jump n' Slide", "Jumping and sliding.", "Meow", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"jump_n_slide\") NDB.CurrentOverrideMap=\"jump_n_slide\"")
NDB.AddMap("air_factory", "Air Factory", "A difficult obstacle course with jumping and surfing.", "Kris2456", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"air_factory\") NDB.CurrentOverrideMap=\"air_factory\"")
NDB.AddMap("abstraction", "Abstraction", "Fine the code and beat the abstract room to win.", "Someone", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"abstraction\") NDB.CurrentOverrideMap=\"abstraction\"")
NDB.AddMap("ob_towerofterror_floor2", "The Tower of Terror, Floor 2", "Climb floor 2 of the Tower of Terror!", "Extreme56, JusticeInACan, Beastery, Gir", nil, "ob_towerofterror_floor2", "gamemode.Call(\"LoadCourse\",\"ob_towerofterror_floor2\") NDB.CurrentOverrideMap=\"ob_towerofterror_floor2\"")
NDB.AddMap("frog_pond", "Frog Pond", "Leap from platform to platform.", "JusticeInACan", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"frog_pond\") NDB.CurrentOverrideMap=\"frog_pond\"")
--NDB.AddMap("2012", "2012", "Escape the rubble of 2012.", "Alize", nil, "gm_construct", "gamemode.Call(\"LoadCourse\",\"2012\") NDB.CurrentOverrideMap=\"2012\"")
NDB.AddMap("polychromatic", "Polychromatic", "A colorful level full of jumping.", "JusticeInACan, Extreme56, Blue.Frog", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"polychromatic\") NDB.CurrentOverrideMap=\"polychromatic\"")
NDB.AddMap("christmas_memorial", "Christmas Memorial", "Relive the 2008 Christmas event.", "JetBoom, Blue.Frog", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"christmas_memorial\") NDB.CurrentOverrideMap=\"christmas_memorial\"")
NDB.AddMap("tree", "Tree", "Climb the inside of the Great Deku Tree.", "Meow", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"tree\") NDB.CurrentOverrideMap=\"tree\"")
NDB.AddMap("the_flaccid_stand", "The Flaccid Stand", "A tale of timeless adventure and climbing.", "Zetanor", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"the_flaccid_stand\") NDB.CurrentOverrideMap=\"the_flaccid_stand\"")
--NDB.AddMap("trap_path", "Trap Path", "A tale of timeless adventure and climbing.", "BlueBarr", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"trap_path\") NDB.CurrentOverrideMap=\"trap_path\"")
--NDB.AddMap("control_tower_of_power", "Control Tower of Power", "A tale of timeless adventure and climbing.", "Rolond", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"control_tower_of_power\") NDB.CurrentOverrideMap=\"control_tower_of_power\"")
--NDB.AddMap("kings_tower", "King's Tower", "A tale of timeless adventure and climbing.", "nightmare", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"kings_tower\") NDB.CurrentOverrideMap=\"kings_tower\"")
--NDB.AddMap("spins_and_sawblades", "Spins and Sawblades", "A tale of timeless adventure and climbing.", "Exhale", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"spins_and_sawblades\") NDB.CurrentOverrideMap=\"spins_and_sawblades\"")
NDB.AddMap("wave", "Wave", "A tale of timeless adventure and climbing.", "Exhale", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"wave\") NDB.CurrentOverrideMap=\"wave\"")
NDB.AddMap("wavelength", "Wavelength", "A tale of timeless adventure and climbing.", "MrSavage", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"wavelength\") NDB.CurrentOverrideMap=\"wavelength\"")
--NDB.AddMap("crushing_pain", "Crushing Pain", "A tale of timeless adventure and climbing.", "JaSeN", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"crushing_pain\") NDB.CurrentOverrideMap=\"crushing_pain\"")
NDB.AddMap("amaze", "Amaze", "A tale of timeless adventure and climbing.", "Deler$on", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"amaze\") NDB.CurrentOverrideMap=\"amaze\"")
NDB.AddMap("surf_n_turf", "Surf n' Turf", "A short surfing level.", "Shamwow", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"surf_n_turf\") NDB.CurrentOverrideMap=\"surf_n_turf\"")
--NDB.AddMap("upstream", "Upstream", "Jump upstream.", "Deler$on", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"upstream\") NDB.CurrentOverrideMap=\"upstream\"")
--NDB.AddMap("to_the_lounge", "To the Lounge", "...", "ColoredPencils", nil, "gm_flatgrass", "gamemode.Call(\"LoadCourse\",\"to_the_lounge\") NDB.CurrentOverrideMap=\"to_the_lounge\"")]]

--[[
NDB.AddMapType("reallybadroleplay")
NDB.AddMap("rp_silenthill", "Silent Hill")
NDB.AddMap("rp_flatgrass_final", "Flat Grass")
NDB.AddMap("RP_Sunvale", "Sunvale")
NDB.AddMap("rp_townsend_v2", "Town's End")
]]

local nokoth = {"KOTH"}
NDB.DisabledGameTypes = {}
NDB.DisabledGameTypes["gm_nobuild_noxctf_temple_v2"] = nokoth
NDB.DisabledGameTypes["gm_blockfort_2007_pr"] = nokoth
NDB.DisabledGameTypes["noxctfnb_parkv3"] = nokoth
NDB.DisabledGameTypes["noxnb_intersection_v2"] = nokoth
NDB.DisabledGameTypes["noxnb_fortis"] = nokoth
NDB.DisabledGameTypes["noxnb_streamline"] = nokoth
NDB.DisabledGameTypes["noxnb_infinity_f"] = nokoth
NDB.DisabledGameTypes["noxctfnb_bigdesert"] = {"HTF"}
NDB.DisabledGameTypes["gm_gabesgreasyasscrack2"] = NDB.DisabledGameTypes["noxctfnb_bigdesert"]
