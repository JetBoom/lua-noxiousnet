PARSER.Description = "<mossman face=angry>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<mossman(.-)>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])

	local typ = tostring(attributes.face)
	if typ == "angry" then
		fil = "angry_eyebrows"
	elseif typ == "grin" then
		fil = "grin"
	elseif typ == "squint" then
		fil = "clear"
	elseif typ == "sleep" then
		fil = "close_eyes"
	elseif typ == "stare" then
		fil = "open_eyes"
	elseif typ == "sad" then
		fil = "sad"
	elseif typ == "smile" then
		fil = "smile"
	elseif typ == "uhoh" then
		fil = "sorry_eyebrows"
	else
		fil = "normal_eyebrows"
	end

	return NNChat.CreateIMG("VGUI/face/"..fil, attributes, panel, packages)
end
