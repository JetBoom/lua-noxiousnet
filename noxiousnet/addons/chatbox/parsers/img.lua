PARSER.Description = "<img src=icon16/shield.png>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<img(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])
	return NNChat.CreateIMG(attributes.src or attributes.icon or "", attributes, panel, packages)
end
