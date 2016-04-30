PARSER.Description = "<emote=ugly>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<emote=(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	return NNChat.CreateIMG("noxemoticons/"..packages[1], {}, panel, packages)
end
