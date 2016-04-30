local PlayerVoicePanels = {}
local g_VoicePanelList

local PANEL = {}

PANEL.Player = NULL
PANEL.Volume = 0

function PANEL:Init()
    --self.BallPitColor = Color(math.random(120, 255), math.random(120, 255), math.random(120, 255), 220)

    self.Avatar = vgui.Create("AvatarImage", self)
    self.Avatar:Dock(LEFT)
    self.Avatar:SetSize(32, 32)

    self.NameLabel = vgui.Create("DLabel", self)
    self.NameLabel:SetFont("GModNotify")
    self.NameLabel:SetTextColor(color_white)
    self.NameLabel:Dock(LEFT)
    self.NameLabel:DockMargin(16, 0, 0, 0)

    self:SetSize(250, 40)
    self:DockPadding(4, 4, 4, 4)
    self:DockMargin(2, 2, 2, 2)
    self:Dock(BOTTOM)
end

function PANEL:Setup(pl)
    self.Player = pl

    if pl:IsValid() then
        self.Avatar:SetPlayer(pl, 64)

        self.NameLabel:SetText(pl:Name())
        self.NameLabel:SizeToContents()
        self.NameLabel:SetWide(math.min(self.NameLabel:GetWide(), self:GetWide() * 0.5))
    end

    self:InvalidateLayout()
end

function PANEL:Paint(w, h)
    local pl = self.Player
    if not pl:IsValid() then return end

    local col = team.GetColor(pl:Team())
    local voicevolume = math.Clamp(pl:VoiceVolume() * 4, 0, 1)
    if pl == LocalPlayer() and voicevolume == 0 then
        voicevolume = 1
    end

    self.Volume = math.Approach(self.Volume, voicevolume, FrameTime() * 2)

    surface.SetDrawColor(col.r * 0.55, col.g * 0.55, col.b * 0.55, 255)
    surface.DrawRect(0, 0, w, h)

    if self.Volume > 0 then
        surface.SetDrawColor(col.r, col.g, col.b, 255)
        surface.DrawRect(0, 0, w * self.Volume, h)

        surface.SetDrawColor(math.min(col.r + 60, 255), math.min(col.g + 60, 255), math.min(col.b + 60, 255), 255)
        surface.DrawRect(w * self.Volume - 6, 0, 6, h)
    end

    surface.SetDrawColor(10, 10, 10, 255)
    surface.DrawOutlinedRect(0, 0, w, h)
    surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
end

function PANEL:Think()
end

function PANEL:AnimFinished(pan)
    if pan and pan:IsValid() then
        pan:Remove()
    end
end

function PANEL:OnDeletion()
    if PlayerVoicePanels[self.Player] then
        PlayerVoicePanels[self.Player] = nil
    end
end

derma.DefineControl("VoiceNotify", "", PANEL, "DPanel")



hook.Add("PlayerStartVoice", "PlayerStartVoiceGUI", function(ply)
    if not IsValid(g_VoicePanelList) then return end

    -- There'd be an exta one if voice_loopback is on, so remove it.
    gamemode.Call("PlayerEndVoice", ply)

    local pan = PlayerVoicePanels[ply]
    if pan and pan:IsValid(pan) then
        PlayerVoicePanels[ply]:Stop()
        PlayerVoicePanels[ply]:SetAlpha(255)

        return
    end

    if not IsValid(ply) then return end

    local pnl = g_VoicePanelList:Add("VoiceNotify")
    pnl:Setup(ply)

    PlayerVoicePanels[ply] = pnl
end)

timer.Create("VoiceClean", 10, 0, function()
    for k, v in pairs(PlayerVoicePanels) do
        if not IsValid(k) then
            gamemode.Call("PlayerEndVoice", k)
        end
    end
end)

hook.Add("PlayerEndVoice", "PlayerEndVoiceVGUI", function(pl)
    local pan = PlayerVoicePanels[pl]
    if pan and pan:IsValid() then
        pan:Stop()
        pan:AlphaTo(0, 2, 0.25, pan.AnimFinished)
    end
end)

hook.Add("InitPostEntity", "CreateVoiceVGUI", function()
    g_VoicePanelList = vgui.Create( "DPanel" )

    g_VoicePanelList:ParentToHUD()
    g_VoicePanelList:SetPos( ScrW() - 300, 100 )
    g_VoicePanelList:SetSize( 250, ScrH() - 200 )
    g_VoicePanelList:SetDrawBackground( false )
end)
