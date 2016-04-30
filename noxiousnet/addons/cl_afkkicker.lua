local KickTime = 600
local WarnTime = 60

local lastang = Angle(1, 2, 3)
local AFKKick = 0
local lastx, lasty = 0, 0
local pAFKKicker

local function AFKKickReset()
	AFKKick = SysTime() + KickTime
end

local function AFKKickRemovePanel()
	if pAFKKicker then
		if pAFKKicker:IsValid() then
			pAFKKicker:Remove()
		end
		pAFKKicker = nil
	end
end

local function AFKKickCreatePanel()
	if pAFKKicker and pAFKKicker:IsValid() then return end

	pAFKKicker = vgui.Create("DEXRoundedPanel")
	pAFKKicker:SetColor(color_black_alpha180)
	pAFKKicker:SetSize(450, 100)
	pAFKKicker:Center()

	local lab = vgui.Create("DEXChangingLabel", pAFKKicker)
	lab:SetTextColor(COLOR_RED)
	lab:SetFont("dexfont_med")
	lab:SetContentAlignment(5)
	lab:SetChangeFunction(function()
		return "You're going to be kicked for being idle in... "..math.Round(math.max(0, AFKKick - SysTime()), 1)
	end)
	lab:SetChangedFunction(function()
		if WarnTime < AFKKick - SysTime() then
			pAFKKicker:Remove()
			pAFKKicker = nil
		end
	end)
	lab:Dock(FILL)
end

local function AFKKickerThink()
	local x, y = gui.MousePos()
	local eyeang = EyeAngles()

	if x == lastx and lasty == y and lastang == eyeang then
		local ct = SysTime()
		if AFKKick <= ct then
			AFKKickReset()
			net.Start("nox_afkkick")
			net.SendToServer()
		elseif AFKKick - WarnTime <= ct then
			AFKKickCreatePanel()
		end
	else
		AFKKickRemovePanel()
		AFKKickReset()
		lastx, lasty = x, y
		lastang = eyeang
	end
end

local function AFKKickerCheckOnce()
	if NDB.MemberNoAFKKick[MySelf:GetMemberLevel()] or MySelf:IsAdmin() then
		timer.Remove("AFKKicker")
		hook.Remove("KeyPress", "AFKKickerReset")
	end

	hook.Remove("KeyPress", "AFKKickerCheckOnce")
end

hook.Add("KeyPress", "AFKKickerReset", AFKKickReset)

hook.Add("InitPostEntity", "AFKWaitTillValid", function()
	AFKKickReset()

	timer.Simple(10, function()
		timer.Create("AFKKicker", 0.2, 0, AFKKickerThink)
		hook.Add("KeyPress", "AFKKickerCheckOnce", AFKKickerCheckOnce)
	end)
end)
