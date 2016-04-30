PARSER.Description = "^900Short-hand for red!"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "%^(%d)(%d)(%d)"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	return {DefaultColor = Color(math.min(255, packages[1] * 28.3333333), math.min(255, packages[2] * 28.333333), math.min(255, packages[3] * 28.333333))}
end
