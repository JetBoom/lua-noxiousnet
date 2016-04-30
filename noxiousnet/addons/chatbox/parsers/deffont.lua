PARSER.Description = "<deffont=wacky>Using the wacky font!"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<deffont=(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	return {DefaultFont = NNChat.SafeFont(tostring(packages[1] or "ChatFont"))}
end
