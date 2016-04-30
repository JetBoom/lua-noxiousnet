PARSER.Description = "<news>"
PARSER.Type = PARSER_STANDALONE
PARSER.Pattern = "<news>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local newpanel = EasyButton(panel, "Click here to view the news", 8, 4)
	newpanel.DoClick = MakepNews

	newpanel:SetTooltip("<news>")

	return {Panel = newpanel}
end
