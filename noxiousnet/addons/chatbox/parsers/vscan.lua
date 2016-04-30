PARSER.Description = "<vscan color=255,0,0 rate=2>Scan me!</vscan>"
PARSER.Type = PARSER_ENCLOSE_ARGS
PARSER.Pattern = "<vscan(.-)>(.-)</vscan>"

local vscanpaintoverride = function(self)
	local tall = self:GetTall()
	surface.SetDrawColor(self.vscan_col)
	surface.DrawRect(0, -tall + (tall * 2) * (((self.vscan_seed + CurTime()) * self.vscan_rate) % 1) ^ 2, self:GetWide(), tall)

	if self.PreVScanPaint then
		return self:PreVScanPaint()
	end
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local attributes = NNChat.GetAttributes(packages[1])

	local col = NNChat.ExtractColor(attributes.color)
	col.a = 120
	local rate = math.Clamp(tonumber(attributes.rate or 1) or 1, -4, 4)

	local result = NNChat.EasyLineWrap(panel, packages[2], defaultfont, defaultcolor, x, maxwidth)
	for i, panel in pairs(result.Panels) do
		panel.vscan_seed = math.Rand(0, 10)
		panel.vscan_col = col
		panel.vscan_rate = rate
		panel.PreVScanPaint = panel.Paint
		panel.Paint = vscanpaintoverride
	end

	return result
end
