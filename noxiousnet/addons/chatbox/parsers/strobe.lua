PARSER.Description = "<strobe rate=1>Strobe!</strobe>"
PARSER.Type = PARSER_ENCLOSE_ARGS
PARSER.Pattern = "<strobe(.-)>(.-)</strobe>"

local strobepaintoverride = function(pp)
	if RealTime() >= pp.strobe_time then
		pp.strobe_time = RealTime() + pp.strobe_rate
		pp:SetFGColor(Color(math.Rand(30, 255), math.Rand(30, 255), math.Rand(30, 255), 255))
	end

	if pp.PreStrobePaint then
		return pp:PreStrobePaint()
	end
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])

	local rate = 1 / math.Clamp(tonumber(attributes.rate or 10) or 10, 0.1, 1000)

	local result = NNChat.EasyLineWrap(panel, packages[2], defaultfont, color_white, x, maxwidth)
	for i, panel in pairs(result.Panels) do
		panel.strobe_time = 0
		panel.strobe_rate = rate
		panel.PreStrobePaint = panel.Paint
		panel.Paint = strobepaintoverride
	end

	return result
end
