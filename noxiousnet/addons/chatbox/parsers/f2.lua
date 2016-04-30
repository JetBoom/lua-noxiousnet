PARSER.Description = "<f2>"
PARSER.Type = PARSER_STANDALONE
PARSER.Pattern = "<f2>"

local function F2Click(btn)
	MySelf:ConCommand("gm_showteam")
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local newpanel = EasyButton(panel, ">> F2 Menu", 8, 4)
	newpanel.DoClick = F2Click

	newpanel:SetTooltip("Click here to view the gamemode's F2 menu.")

	return {Panel = newpanel}
end
