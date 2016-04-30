local function Render()
	hook.Remove("PostRender", "imdumb")

	local capdata = {}
	capdata.format = "jpeg"
	capdata.quality = 5
	capdata.x = 0
	capdata.y = 0
	capdata.w = ScrW()
	capdata.h = ScrH()

	local data = render.Capture(capdata)
	if data then
		for i=1, #data, 32000 do
			local subdata = string.sub(data, i, i + 32000)
			if #subdata > 0 then
				net.Start("nox_retardchecker")
					net.WriteUInt(#subdata, 16)
					net.WriteData(subdata, #subdata)
				net.SendToServer()
			end
		end
	end
end

net.Receive("nox_retardchecker", function(length)
	hook.Add("PostRender", "imdumb", Render)
end)

local hpan
function NDB.CheckRetard(id)
	if hpan and hpan:IsValid() then
		hpan:Close()
	end

	hpan = vgui.Create("DEXRoundedFrame")
	hpan:SetSize(ScrW() - 24, ScrH() - 24)

	local html = vgui.Create("DHTML", hpan)
	html:OpenURL("http://www.noxiousnet.com/retardchecker/?id="..id)
	html:Dock(FILL)

	hpan:Center()
	hpan:MakePopup()
end
