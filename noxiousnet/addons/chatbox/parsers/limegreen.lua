PARSER.Description = "<limegreen>Stuff</limegreen>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<limegreen>(.-)</limegreen>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_LIMEGREEN, x, maxwidth)
end
