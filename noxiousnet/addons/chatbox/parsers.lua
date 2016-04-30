NNChat.Parsers = {}

local function AddParser(parsername)
	PARSER = {}

	include("parsers/"..parsername..".lua")

	table.insert(NNChat.Parsers, {
		ParserName = parsername,
		ParserDesc = PARSER.Description,
		ParserType = PARSER.Type or PARSER_STANDALONE,
		ParseFunction = PARSER.Parse,
		ParseFind = PARSER.Pattern or "<"..parsername..">"
	})

	PARSER = nil
end

local function AddAlias(alias, description, find, base)
	local baseparser = NNChat.GetParserByName(base)

	if not baseparser then return end

	local copy = {}
	copy.ParserName = alias
	copy.ParserDesc = description
	copy.ParseFind = find

	copy.ParserType = baseparser.ParserType
	copy.ParseFunction = baseparser.ParseFunction

	table.insert(NNChat.Parsers, copy)
end

-- "Parserless" emoticons.
local function AddEmoticon(text, filename)
	local parser = {}
	parser.ParserName = text
	parser.ParserDesc = text
	parser.ParseFind = text
	parser.ParserType = PARSER_STANDALONE
	parser.ParseFunction = function(p, entid, t, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
		return NNChat.CreateIMG("noxemoticons/"..filename, {""}, panel, {""})
	end

	table.insert(NNChat.Parsers, parser)
end

AddParser("red")
AddParser("green")
AddParser("blue")
AddParser("yellow")
AddParser("white")
AddParser("black")
AddParser("purple")
AddParser("pink")
AddParser("limegreen")
AddAlias("lg", "<lg>Stuff</lg>", "<lg>(.-)</lg>", "limegreen")
AddParser("lightblue")
AddAlias("lb", "<lb>Stuff</lb>", "<lb>(.-)</lb>", "lightblue")
AddParser("flashhsv")
AddParser("flash")
AddParser("strobe")
AddParser("vscan")
AddParser("hscan")
AddParser("style")
AddParser("c")
AddParser("rgb")
AddParser("defstyle")
AddParser("defc")
AddParser("deffont")

AddParser("noparse")

AddParser("spoiler")
AddParser("tooltip")

AddParser("sound")

AddParser("img")
AddParser("silkicon")
AddParser("mossman")
AddParser("diamond")
AddParser("spellicon")
AddParser("award")

AddParser("info")
AddParser("avatar")

AddParser("news")
AddParser("forum")
AddParser("wiki")
AddParser("f1")
AddAlias("help", "<help>", "<help>", "f1")
AddParser("f2")
AddParser("f3")
AddParser("f4")
AddParser("connect")

-- Deprecated
AddEmoticon("coolcat", "twitch/coolcat.png")
AddEmoticon("dansgame", "twitch/dansgame.png")
AddEmoticon("dendiface", "twitch/dendiface.png")
AddEmoticon("doomguy", "twitch/doomguy.png")
AddEmoticon("elegiggle", "twitch/elegiggle.png")
AddEmoticon("failfish", "twitch/failfish.png")
AddEmoticon("frankerz", "twitch/frankerz.png")
AddEmoticon("kappa", "twitch/kappa.png")
AddEmoticon("keepo", "twitch/keepo.png")
AddEmoticon("kreygasm", "twitch/kreygasm.png")
AddEmoticon("mrdestructoid", "twitch/mrdestructoid.png")
AddEmoticon("mvgame", "twitch/mvgame.png")
AddEmoticon("ninjatroll", "twitch/ninjatroll.png")
AddEmoticon("notlikethis", "twitch/notlikethis.png")
AddEmoticon("pjsalt", "twitch/pjsalt.png")
AddEmoticon("pogchamp", "twitch/pogchamp.png")
AddEmoticon("ralpherz", "twitch/ralpherz.png")
AddEmoticon("residentsleeper", "twitch/residentsleeper.png")
AddEmoticon("shibez", "twitch/shibez.png")
AddEmoticon("smorc", "twitch/smorc.png")
AddEmoticon("smskull", "twitch/smskull.png")
AddEmoticon("swiftrage", "twitch/swiftrage.png")
AddEmoticon("trihard", "twitch/trihard.png")

AddParser("emoteold") -- Deprecated

-- The first one is a catch-all by the way
AddParser("emote")
AddParser("emote2")
