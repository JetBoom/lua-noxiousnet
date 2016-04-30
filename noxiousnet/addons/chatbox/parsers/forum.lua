PARSER.Description = "<forum topic=4538>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<forum(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])
	local id = attributes.topic
	if not id then return end
	id = tonumber(id)
	if not id then return end

	id = math.ceil(id)
	local newpanel = vgui.Create("DLabelURL", panel)
	newpanel:SetText("forum topic "..id)
	newpanel:SetURL("http://www.noxiousnet.com/forums/index.php?topic="..id..".0")
	newpanel:SizeToContents()

	return {Panel = newpanel}
end
