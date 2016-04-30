PARSER.Description = "<black>Stuff</black>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<black>(.-)</black>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_BLACK, x, maxwidth)
end
