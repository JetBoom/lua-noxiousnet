local PANEL = {}

AccessorFunc(PANEL, "m_tColor", "Color")

function PANEL:Init()
	self:SetColor(Color(5, 5, 5, 180))
end

function PANEL:SetColorAlpha(a)
	self:GetColor().a = a
end

local triangle = {
	{x = 0, y = 0},
	{x = 0, y = 0},
	{x = 0, y = 0}
}

function PANEL:Paint(w, h)
	triangle[2].x = w
	triangle[3].x = w
	triangle[3].y = h

	draw.NoTexture()
	surface.SetDrawColor(self:GetColor())
	surface.DrawPoly(triangle)

	--[[surface.SetDrawColor(120, 120, 120, self:GetColor().a)
	surface.DrawLine(0, 0, w, h)]]
end

vgui.Register("DEXTriangle", PANEL, "DPanel")
