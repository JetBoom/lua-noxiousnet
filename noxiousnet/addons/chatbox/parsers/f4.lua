PARSER.Description = "<f4>"
PARSER.Type = PARSER_STANDALONE
PARSER.Pattern = "<f4>"

local function F4Click(btn)
	MySelf:ConCommand("gm_showspare2")
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local newpanel = EasyButton(panel, ">> F4 Menu", 8, 4)
	newpanel.DoClick = F4Click

	newpanel:SetTooltip("Click here to view the gamemode's F4 menu.")

	return {Panel = newpanel}
end
