local ENT = {}
ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:IsTranslucent()
	return true
end

function ENT:Initialize()
	self:DrawShadow(false)
	if CLIENT then
	self:SetRenderBounds(Vector(-64, -64, -64), Vector(64, 64, 64))

	self:CreateTextPanel()
	end
end

function ENT:SetText(text)
	self:SetNWString(0, string.sub(text, 1, 255))
end

function ENT:GetText()
	return self:GetNWString(0, "")
end

function ENT:SetOwnerUserID(uid)
	self:SetDTInt(0, uid)
end

function ENT:GetOwnerUserID()
	return self:GetDTInt(0)
end

if CLIENT then
function ENT:DrawTranslucent()
	local panel = self:GetTextPanel()
	if panel and panel:IsValid() then
		cam.Start3D2D(self:GetPos(), self:GetAngles(), 0.1)
			panel:SetPaintedManually(false)
			panel:PaintManual()
			panel:SetPaintedManually(true)
		cam.End3D2D()
	end
end

function ENT:Think()
	local text = self:GetText()
	if text ~= self.m_LastText then
		self:CreateTextPanel()
	end

	self:NextThink(CurTime() + 3)
	return true
end

function ENT:CreateTextPanel()
	local text = self:GetText()

	self.m_LastText = text

	local cur = self:GetTextPanel()
	if cur and cur:IsValid() then
		cur:Remove()
	end

	local entid = -1
	local userid = self:GetOwnerUserID()
	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == userid then
			entid = pl:EntIndex()
			break
		end
	end

	FROMLABEL = true
	local panel = NNChat.CreateChatPanel(entid, text, COLOR_WHITE, "DefaultFont", 300)
	if panel then
		panel:SetAlpha(160)
		panel:SetPaintedManually(true)
		panel:SetKeyboardInputEnabled(false)
		panel:SetMouseInputEnabled(false)
		panel.NoBackground = true
		self:SetTextPanel(panel)
	end
	FROMLABEL = nil
end

function ENT:SetTextPanel(panel)
	self.m_TextPanel = panel
end

function ENT:GetTextPanel()
	return self.m_TextPanel
end
end

scripted_ents.Register(ENT, "point_3d2dlabel")
