util.AddNetworkString("nox_retardchecker")

local function OutputScreenData(pl)
	local checker = pl._RequestedScreen
	pl._RequestedScreen = nil

	local id = pl:AccountID()

	local filename = "retardchecker/"..id..".txt"
	if file.Exists(filename, "DATA") then file.Delete(filename) end

	local f = file.Open(filename, "wb", "DATA")
	if f then
		f:Write(pl._RequestedScreenData)
		f:Close()

		timer.Create("DeleteRetard"..id, 60, 1, function()
			if file.Exists(filename, "DATA") then file.Delete(filename) end
		end)
	end

	pl._RequestedScreenData = nil

	PrintToModerators(HUD_PRINTTALK, "Check generated for "..pl:NoParseName()..".")

	if checker and checker:IsValid() and checker:IsPlayer() then
		checker:SendLua("timer.Simple(1, function() NDB.CheckRetard("..id..") end)")
	end
end

net.Receive("nox_retardchecker", function(length, pl)
	local len = net.ReadUInt(16)
	local data = net.ReadData(len)

	if not pl._RequestedScreen then return end

	pl._RequestedScreenData = (pl._RequestedScreenData or "")..data

	timer.Create("outputscreendata"..pl:UniqueID(), 3, 1, function()
		OutputScreenData(pl)
	end)
end)

concommand.Add("a_screencapture", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsConnected() and sender:IsModerator()) then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			sender:PrintMessage(HUD_PRINTTALK, "Generating... we'll tell you when it's done. If it isn't done in 10 seconds then assume shenanigans.")

			pl._RequestedScreen = sender
			pl._RequestedScreenData = nil

			net.Start("nox_retardchecker")
			net.Send(pl)

			break
		end
	end
end)
