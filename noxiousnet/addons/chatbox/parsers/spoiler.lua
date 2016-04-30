PARSER.Description = "<spoiler>Spoiler!</spoiler>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<spoiler(.-)>(.-)</spoiler>"

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, package)
	local attributes = NNChat.GetAttributes(package[1])
	local contents = package[2]

	defaultcolor = attributes.color ~= nil and NNChat.ExtractColor(attributes.color) or defaultcolor

	local result = NNChat.EasyLineWrap(panel, contents, defaultfont, defaultcolor, x, maxwidth)

	if result.Panels then
		for i, panel in pairs(result.Panels) do
			panel.m_Spoiler_OldPaint = panel.Paint
			panel.m_Spoiler_Color = defaultcolor
			panel.Paint = function(me)
				if me.m_Spoiler_Spoiled then
					if me.m_Spoiler_OldPaint then
						return me:m_Spoiler_OldPaint()
					end

					return
				end

				surface.SetDrawColor(me.m_Spoiler_Color.r, me.m_Spoiler_Color.g, me.m_Spoiler_Color.b, 255)
				surface.DrawRect(0, 0, me:GetSize())
				if not NNChat.ChatOn then return true end

				local x, y = me:ScreenToLocal(gui.MousePos())
				if 0 <= x and 0 <= y and x <= me:GetWide() and y <= me:GetTall() then
					for _, pan in pairs(me.m_Spoiler_IncludePanels) do
						pan.m_Spoiler_Spoiled = true
					end
				end

				return true
			end
			panel.m_Spoiler_IncludePanels = result.Panels
			panel:SetMouseInputEnabled(true)
		end
	end

	return result
end
