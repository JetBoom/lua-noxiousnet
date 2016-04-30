PARSER.Description = "<tooltip=You moused over me!>Hello</tooltip>"
PARSER.Type = PARSER_ENCLOSE_ARGS
PARSER.Pattern = "<tooltip=(.-)>(.-)</tooltip>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local wrapped = NNChat.EasyLineWrap(panel, packages[2], defaultfont, defaultcolor, x, maxwidth)
	local tooltip = packages[1]
	for _, panel in pairs(wrapped.Panels) do
		panel:SetMouseInputEnabled(true)
		panel:SetTooltip(tooltip)
	end

	return wrapped
end
