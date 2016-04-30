local DELAY = 12

local NextHeartbeat = os.time() + DELAY
local ServerRegion = 1
local Alt

hook.Add("Tick", "MasterFix", function()
	if os.time() >= NextHeartbeat then
		NextHeartbeat = os.time() + DELAY

		Alt = not Alt

		if Alt then
			RunConsoleCommand("sv_region", "0")
			RunConsoleCommand("heartbeat")
		else
			RunConsoleCommand("sv_region", tostring(ServerRegion))
			RunConsoleCommand("heartbeat")
			--print('heartbeating on', ServerRegion)

			ServerRegion = ServerRegion + 1
			if ServerRegion == 11 then
				ServerRegion = 0
			end
		end
	end
end)
