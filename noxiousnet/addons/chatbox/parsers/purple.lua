PARSER.Description = "<purple>Stuff</purple>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<purple>(.-)</purple>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_PURPLE, x, maxwidth)
end
