PARSER.Description = "<green>Stuff</green>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<green>(.-)</green>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_GREEN, x, maxwidth)
end
