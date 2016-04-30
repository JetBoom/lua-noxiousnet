PARSER.Description = "<ugly>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<([a-zA-Z0-9_%-]+)%s*(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	return NNChat.CreateEmoticon(packages[1], NNChat.GetAttributes(packages[2]), panel, packages)
end
