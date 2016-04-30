PARSER.Description = "<lightblue>Stuff</lightblue>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<lightblue>(.-)</lightblue>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_LIGHTBLUE, x, maxwidth)
end
