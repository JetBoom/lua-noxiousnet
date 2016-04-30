PARSER.Description = "<award=gold_star>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<award(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local package1 = packages[1]
	if package1 and package1:sub(1, 1) == "=" then
		return NNChat.CreateIMG("noxiousnet/awards/"..package1:sub(2), {}, panel, packages)
	end

	local attributes = NNChat.GetAttributes(package1)
	local icon = tostring(attributes.icon or "gold_star")

	return NNChat.CreateIMG("noxiousnet/awards/"..icon, attributes, panel, packages)
end
