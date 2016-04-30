PARSER.Description = "<diamond>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<diamond(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attribs = NNChat.GetAttributes(packages[1])
	if not attribs.color then attribs.color = "80,255,255" end

	return NNChat.CreateIMG("icon16/ruby.png", attribs, panel, packages)
end
