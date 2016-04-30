PARSER.Description = "<red>Stuff</red>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<red>(.-)</red>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_RED, x, maxwidth)
end
