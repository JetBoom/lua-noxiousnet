PARSER.Description = "<c=30,255,30>Lime green color here!</c>"
PARSER.Type = PARSER_ENCLOSE_ARGS
PARSER.Pattern = "<c=(%d+),(%d+),(%d+)>(.-)</c>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	return NNChat.EasyLineWrap(panel, packages[4], defaultfont, Color(math.min(255, packages[1]), math.min(255, packages[2]), math.min(255, packages[3])), x, maxwidth)
end
