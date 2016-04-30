PARSER.Description = "<silkicon icon=shield>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<silkicon(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])
	return NNChat.CreateIMG("icon16/"..tostring(attributes.icon)..".png", attributes, panel, packages)
end
