PARSER.Description = "<f3>"
PARSER.Type = PARSER_STANDALONE
PARSER.Pattern = "<f3>"

local function F3Click(btn)
	MySelf:ConCommand("gm_showspare1")
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local newpanel = EasyButton(panel, ">> F3 Menu", 8, 4)
	newpanel.DoClick = F3Click

	newpanel:SetTooltip("Click here to view the gamemode's F3 menu.")

	return {Panel = newpanel}
end
