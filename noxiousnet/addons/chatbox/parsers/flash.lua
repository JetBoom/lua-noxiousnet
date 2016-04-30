PARSER.Description = "<flash color=255,0,0 rate=1>Flashy!</flash>"
PARSER.Type = PARSER_ENCLOSE_ARGS
PARSER.Pattern = "<flash(.-)>(.-)</flash>"

local flashpaintoverride = function(pp)
	local tim = pp.flash_tim
	local sinwav = math.abs(math.sin((RealTime() + pp.flash_seed) * tim))

	pp:SetFGColor(Color(math.max(0, sinwav * pp.flash_desr), math.max(0, sinwav * pp.flash_desg), math.max(0, sinwav * pp.flash_desb), 255))

	if pp.PreFlashPaint then
		return pp:PreFlashPaint()
	end
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])

	local col = NNChat.ExtractColor(attributes.color)
	local rate = math.Clamp(tonumber(attributes.rate or 1) or 1, 0, 1000)

	local result = NNChat.EasyLineWrap(panel, packages[2], defaultfont, color_white, x, maxwidth)
	for i, panel in pairs(result.Panels) do
		panel.flash_desr = col.r
		panel.flash_desg = col.g
		panel.flash_desb = col.b
		panel.flash_tim = rate
		panel.flash_seed = math.Rand(0, 10)
		panel.PreFlashPaint = panel.Paint
		panel.Paint = flashpaintoverride
	end

	return result
end
