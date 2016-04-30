PARSER.Description = "<noparse><red>Hello</red></noparse>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<noparse>(.-)</noparse>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	return NNChat.NoParseFunction(packages[1], defaultcolor, defaultfont, panel, x, maxwidth)
end
