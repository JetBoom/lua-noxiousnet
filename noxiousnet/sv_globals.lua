-- Important keys no matter what gamemode.
NDB.PlayerKeys = {
	"Silver",
	"MemberLevel",
	"Awards",
	"NewTitle",
	"PersonalChatColor",
	"Inventory",
	"Flags",
	"SilverEarned",
	"TimeOnline",
	"TitleChangeCards",
	"SavedTitles",
	"Title3D",
	"Title3DEnd",
	"Saved3DTitles",
	"Titles",
	"TitleExpirations",
	"CostumeSlots",
	"CostumeOptions",
	"TimesPunished",
	"VoicePitch"
}

-- Keys that we care about only in the specified gamemode.
NDB.PlayerKeysForGamemode = {}
NDB.PlayerKeysForGamemode["zombiesurvival"] = {
	"ZSBrainsEaten",
	"ZSZombiesKilled",
	"ZSGamesSurvived",
	"ZSGamesLost",
	"ZSPoints"
}
NDB.PlayerKeysForGamemode["noxctf"] = {
	"CTFKills",
	"CTFDeaths",
	"TeamPlayAssists",
	"CTFCaptures",
	"AssaultDefense",
	"AssaultOffense",
	"AssaultWins",
	"AssaultLosses"
}
NDB.PlayerKeysForGamemode["supermarioboxes"] = {
	"MarioBoxesWins",
	"MarioBoxesLosses",
	"MarioBoxesKills",
	"MarioBoxesDeaths"
}
NDB.PlayerKeysForGamemode["awesomestrike"] = {
	"ASSKills",
	"ASSDeaths",
	"ASSWins",
	"ASSPlayed"
}
NDB.PlayerKeysForGamemode["terrortown"] = {
	"TTTKarma",
	"TTTInnocentKills",
	"TTTTraitorKills",
	"TTTRoundsPlayed",
	"TTTTeamKills"
}
NDB.PlayerKeysForGamemode["extremefootballthrowdown"] = {
	"EFTRoundsPlayed",
	"EFTWins",
	"EFTTouchDowns",
	"EFTKnockDowns",
	"EFTKnockedDown",
	"EFTKills",
	"EFTDeaths",
	"EFTStruggleWins",
	"EFTStruggles"
}
NDB.PlayerKeysForGamemode["cinema"] = {
	"MPYTPoints",
	"MPYTVideos"
}
NDB.PlayerKeysForGamemode["deathrun"] = {
	"DRPlayedDeath3",
	"DRPlayedRunner3",
	"DRWonDeath3",
	"DRWonRunner3"
}

-- Strings that are separated by commas to make a table.
NDB.PlayerKeysStringTables = {
	["Awards"] = true,
	["Flags"] = true
}

NDB.PlayerKeysNumberTables = {
	["Inventory"] = true
}

-- Strings that are Serialized and Deserialized.
NDB.PlayerKeysStringTablesSRL = {
	["CostumeSlots"] = true,
	["CostumeOptions"] = true,
	["SavedTitles"] = true,
	["Saved3DTitles"] = true,
	["Titles"] = true,
	["TitleExpirations"] = true,
	["TimesPunished"] = true
}

-- String keys.
NDB.PlayerKeysString = {
	["SteamID"] = true,
	["Name"] = true,
	["IPAddress"] = true,
	["NewTitle"] = true,
	["Title3D"] = true
}

-- Number keys that can be negative.
NDB.PlayerKeysSigned = {
	["Silver"] = true
}

-- Keys that are special and should be hardcoded. The function is a callback for the SELECT statement.
NDB.PlayerKeysSpecial = {}
NDB.PlayerKeysSpecial["SteamID"] = function() end
NDB.PlayerKeysSpecial["IPAddress"] = function(pl, val)
	pl._LASTIPADDRESS = val
end
NDB.PlayerKeysSpecial["Name"] = function(pl, val)
	pl._LASTNAME = val
end

-- Keys from game -> SQL which may have different key names.
NDB.PlayerKeysAliasSQL = {
	["Silver"] = "Money",
	["SilverEarned"] = "MoneyEarned",
	["NewTitle"] = "Title",
	["ZSBrainsEaten"] = "BrainsEaten",
	["ZSZombiesKilled"] = "ZombiesKilled",
	["DRPlayedDeath3"] = "DRPlayedDeath",
	["DRPlayedRunner3"] = "DRPlayedRunner",
	["DRWonDeath3"] = "DRWonDeath",
	["DRWonRunner3"] = "DRWonRunner"
}

-- Keys from SQL -> game which may have different key names.
NDB.PlayerKeysAliasGame = {
	["Money"] = "Silver",
	["MoneyEarned"] = "SilverEarned",
	["Title"] = "NewTitle",
	["BrainsEaten"] = "ZSBrainsEaten",
	["ZombiesKilled"] = "ZSZombiesKilled",
	["DRPlayedDeath"] = "DRPlayedDeath3",
	["DRPlayedRunner"] = "DRPlayedRunner3",
	["DRWonDeath"] = "DRWonDeath3",
	["DRWonRunner"] = "DRWonRunner3"
}

-- Sum up these keys to determine elder membership.
NDB.PlayedKeys = {
	"AssaultWins", "AssaultLosses",
	"ZSGamesSurvived", "ZSGamesLost",
	"MarioBoxesWins", "MarioBoxesLosses",
	"ASSPlayed",
	"TTTRoundsPlayed",
	"EFTRoundsPlayed",
	"DRPlayedDeath2", "DRPlayedRunner2"
}
