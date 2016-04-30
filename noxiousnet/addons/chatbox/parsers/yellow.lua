PARSER.Description = "<yellow>Stuff</yellow>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<yellow>(.-)</yellow>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_YELLOW, x, maxwidth)
end
