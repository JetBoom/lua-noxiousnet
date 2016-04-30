PARSER.Description = "<f1>"
PARSER.Type = PARSER_STANDALONE
PARSER.Pattern = "<f1>"

local function F1Click(btn)
	MySelf:ConCommand("gm_showhelp")
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local newpanel = EasyButton(panel, ">> Help Menu", 8, 4)
	newpanel.DoClick = F1Click

	newpanel:SetTooltip("Click here to view the gamemode's help menu.")

	return {Panel = newpanel}
end
