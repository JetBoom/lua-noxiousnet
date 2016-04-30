local PANEL = {}

PANEL.NextCycle = 0
PANEL.Cycle = 1

AccessorFunc(PANEL, "m_CycleTime", "CycleTime", FORCE_NUMBER)

function PANEL:Init()
	self:SetCycleTime(3)
end

function PANEL:Paint()
end

function PANEL:Think()
	if RealTime() < self.NextCycle then return end
	self.NextCycle = RealTime() + self:GetCycleTime()

	local children = self:GetChildren()
	local numchildren = #children

	self.Cycle = self.Cycle + 1
	if self.Cycle > numchildren then
		self.Cycle = 1
	end

	self:SetupVisibility()
end

function PANEL:Resize()
	local w, h = 4, 4

	for _, child in pairs(self:GetChildren()) do
		w = math.max(child:GetWide(), w)
		h = math.max(child:GetTall(), h)
	end

	self:SetSize(w, h)
end

function PANEL:SetupVisibility(instant)
	local children = self:GetChildren()
	local numchildren = #children

	for i, v in ipairs(children) do
		v:SetVisible(i == self.Cycle or i == self.Cycle + 1 or i == self.Cycle - 1 or i == 1 and self.Cycle == numchildren or i == numchildren and self.Cycle == 1)
		v:SetMouseInputEnabled(i == self.Cycle)

		if not instant then
			local targetalpha = i == self.Cycle and 255 or 0
			if v:GetAlpha() ~= targetalpha then
				v:AlphaTo(targetalpha, 0.5, 0)
			end
		end
	end
end

function PANEL:AddPanel(p)
	p:SetParent(self)
	p:SetPos(0, 0)

	self.Cycle = math.Clamp(self.Cycle, 1, math.max(1, #self:GetChildren()))

	self:Resize()
	self:SetupVisibility(true)
end

function PANEL:RemovePanel(p)
	p:SetParent(nil)

	self.Cycle = math.Clamp(self.Cycle, 1, math.max(1, #self:GetChildren()))

	self:Resize()
	self:SetupVisibility(true)
end

vgui.Register("DEXCyclePanel", PANEL, "Panel")