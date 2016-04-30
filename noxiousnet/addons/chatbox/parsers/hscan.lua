PARSER.Description = "<hscan color=255,0,0 rate=2>Scan me!</hscan>"
PARSER.Type = PARSER_ENCLOSE_ARGS
PARSER.Pattern = "<hscan(.-)>(.-)</hscan>"

local hscanpaintoverride = function(self)
	local wide = self:GetWide()
	local barw = math.max(1, wide * 0.2)
	local start = (((self.hscan_seed + CurTime()) * self.hscan_rate) % 1) ^ 2 * (wide + barw) - barw

	surface.SetDrawColor(self.hscan_col)
	surface.DrawRect(start, 0, barw, self:GetTall())

	if self.PreHScanPaint then
		return self:PreHScanPaint()
	end
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])

	local col = NNChat.ExtractColor(attributes.color)
	col.a = 120
	local rate = math.Clamp(tonumber(attributes.rate or 1) or 1, -4, 4)

	local result = NNChat.EasyLineWrap(panel, packages[2], defaultfont, defaultcolor, x, maxwidth)
	for i, panel in pairs(result.Panels) do
		panel.hscan_seed = math.Rand(0, 10)
		panel.hscan_col = col
		panel.hscan_rate = rate
		panel.PreHScanPaint = panel.Paint
		panel.Paint = hscanpaintoverride
	end

	return result
end
