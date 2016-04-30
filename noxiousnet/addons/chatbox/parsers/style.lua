PARSER.Description = "<style font=wacky color=255,0,0>Wacky red!</style>"
PARSER.Type = PARSER_ENCLOSE_ARGS
PARSER.Pattern = "<style(.-)>(.-)</style>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])
	local content = packages[2]

	if attributes.font then
		defaultfont = NNChat.SafeFont(attributes.font)
	end

	if attributes.color or attributes.a then
		defaultcolor = NNChat.ExtractColor(attributes.color)
		if attributes.a then
			defaultcolor.a = NNChat.SafeColor(attributes.a)
		end
	end

	return NNChat.EasyLineWrap(panel, content, defaultfont, defaultcolor, x, maxwidth)
end
