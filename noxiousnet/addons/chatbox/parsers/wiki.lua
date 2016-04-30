PARSER.Description = "<wiki article=Zombie_Survival>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<wiki(.-)>"

local function WikiClick(me)
	NDB.OpenWiki(me.Article)
end
function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])
	local fil = attributes.article
	if not fil or string.find(fil, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") then return end

	fil = string.sub(fil, 1, 60)
	local newpanel = EasyButton(panel, "Wiki: "..fil, 8, 4)
	newpanel.Article = fil
	newpanel.DoClick = WikiClick

	newpanel:SetTooltip("Click here to view the in-game wiki for "..fil)

	return {Panel = newpanel}
end
