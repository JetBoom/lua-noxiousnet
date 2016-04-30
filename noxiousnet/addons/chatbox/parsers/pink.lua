PARSER.Description = "<pink>Stuff</pink>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<pink>(.-)</pink>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_PINK, x, maxwidth)
end
