PARSER.Description = "<flashhsv rate=360>Hello!</flashhsv>"
PARSER.Type = PARSER_ENCLOSE_ARGS
PARSER.Pattern = "<flashhsv(.-)>(.-)</flashhsv>"

local flashhsvpaintoverride = function(pp)
	pp.flashhsv_hue = (pp.flashhsv_hue + FrameTime() * pp.flashhsv_rate) % 360

	pp:SetFGColor(NNChat.HSVtoRGB(pp.flashhsv_hue, 100, 100))

	if pp.PreFlashHSVPaint then
		return pp:PreFlashHSVPaint()
	end
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])

	local hue = math.Clamp(tonumber(attributes.hue or 0) or 0, 0, 360)
	local rate = math.Clamp(tonumber(attributes.rate or 360) or 360, 0, 1000)

	local result = NNChat.EasyLineWrap(panel, packages[2], defaultfont, color_white, x, maxwidth)
	for i, panel in pairs(result.Panels) do
		panel.flashhsv_hue = hue
		panel.flashhsv_rate = rate
		panel.PreFlashHSVPaint = panel.Paint
		panel.Paint = flashhsvpaintoverride
	end

	return result
end
