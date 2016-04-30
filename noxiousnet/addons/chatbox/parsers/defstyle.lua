PARSER.Description = "<defstyle font=wacky color=255,0,0>Hello!"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<defstyle(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])

	if attributes.font then
		defaultfont = NNChat.SafeFont(attributes.font)
	end

	if attributes.color or attributes.a then
		defaultcolor = NNChat.ExtractColor(attributes.color)
		if attributes.a then
			defaultcolor.a = NNChat.SafeColor(attributes.a)
		end
	end

	if attributes.hsv then
		defaultcolor = NNChat.HSVtoRGB(NNChat.ExtractHSV(attributes.hsv))
		if attributes.a then
			defaultcolor.a = NNChat.SafeColor(attributes.a)
		end
	end

	return {DefaultColor = defaultcolor, DefaultFont = defaultfont}
end
