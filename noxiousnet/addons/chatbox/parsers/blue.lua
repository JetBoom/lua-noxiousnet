PARSER.Description = "<blue>Stuff</blue>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<blue>(.-)</blue>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	return NNChat.EasyLineWrap(panel, package[1], defaultfont, COLOR_BLUE, x, maxwidth)
end
