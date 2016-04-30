local PANEL = {}

PANEL.XAlign = TEXT_ALIGN_LEFT

function PANEL:Init()
	self:SetOutlineColor(color_black)
	self:SetShadowColor(color_black)
	self.ShadowFont = ""
end

function PANEL:SetFont(font)
	DLabel.SetFont(self, font)

	self.ShadowFont = font.."shadow"
end

function PANEL:SetOutline(outline)
	if not outline or outline <= 0 then
		self.Paint = nil
	else
		self.Paint = self.OutlinedPaint
		self.Outline = type(outline) == "number" and outline or 1
	end
end

function PANEL:EnableShadow()
	self.ShadowFont = self:GetFont().."shadow"
	self.Paint = self.ShadowPaint
end

function PANEL:SetOutlineColor(col)
	self.OutlineColor = col
end

function PANEL:SetShadowColor(col)
	self.ShadowColor = col
end

function PANEL:SetContentAlignment(align)
	local xalign, yalign

	if align == 7 then
		xalign = TEXT_ALIGN_LEFT
		yalign = TEXT_ALIGN_TOP
	elseif align == 8 then
		xalign = TEXT_ALIGN_CENTER
		yalign = TEXT_ALIGN_TOP
	elseif align == 9 then
		xalign = TEXT_ALIGN_RIGHT
		yalign = TEXT_ALIGN_TOP
	elseif align == 4 then
		xalign = TEXT_ALIGN_LEFT
		yalign = TEXT_ALIGN_CENTER
	elseif align == 5 then
		xalign = TEXT_ALIGN_CENTER
		yalign = TEXT_ALIGN_CENTER
	elseif align == 6 then
		xalign = TEXT_ALIGN_RIGHT
		yalign = TEXT_ALIGN_CENTER
	elseif align == 1 then
		xalign = TEXT_ALIGN_LEFT
		yalign = TEXT_ALIGN_BOTTOM
	elseif align == 2 then
		xalign = TEXT_ALIGN_CENTER
		yalign = TEXT_ALIGN_BOTTOM
	elseif align == 3 then
		xalign = TEXT_ALIGN_RIGHT
		yalign = TEXT_ALIGN_BOTTOM
	end

	self.XAlign = xalign
	self.YAlign = yalign

	FindMetaTable("Panel").SetContentAlignment(self, align)
end

function PANEL:OutlinedPaint()
	draw.SimpleTextOutlined(self:GetText(), self:GetFont(), 0, 0, self:GetTextColor(), self.XAlign, self.YAlign, self.Outline, self.OutlineColor)
end

function PANEL:ShadowPaint()
	local text = self:GetText()

	surface.DisableClipping(true) -- Part of our shadow is outside the panel!
	draw.SimpleText(text, self.ShadowFont, 0, 0, self.ShadowColor, self.XAlign, self.YAlign)
	draw.SimpleText(text, self:GetFont(), 0, 0, self:GetTextColor(), self.XAlign, self.YAlign)
	surface.DisableClipping(false)
end

vgui.Register("DEXLabel", PANEL, "DLabel")
