PARSER.Description = "<white>Stuff</white>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<white>(.-)</white>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_WHITE, x, maxwidth)
end
