PARSER.Description = "<defc=0,255,255>Cyan!"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<defc=(%d+),(%d+),(%d+)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	return {DefaultColor = Color(math.min(255, packages[1]), math.min(255, packages[2]), math.min(255, packages[3]))}
end
