local LOGBUFFER = ""
local LOGNAME = ""
local LOGDAY = "0"

local LOGARCHIVENAME

local function WriteOutBuffer(norestart)
	if #LOGBUFFER > 0 then
		file.Append(LOGNAME, LOGBUFFER)

		if LOGARCHIVENAME then
			file.Append(LOGARCHIVENAME, LOGBUFFER)
		end

		LOGBUFFER = ""

		if not norestart and os.date("%d") ~= LOGDAY then
			NDB.InitializeLogs()
		end
	end
end

function NDB.Logs_GetName()
	return LOGNAME
end

function NDB.GetLogArchiveName()
	return LOGARCHIVENAME or NDB.Logs_GetName()
end

function NDB.LogArchiveEnable()
	if LOGARCHIVENAME then return end

	print("Now archiving current log")

	local ThisServerIP = string.Replace(GetConVarString("ip"), ".", "_")
	local ThisServerPort = tonumber(GetConVarString("hostport")) or 27015
	local thetime = os.date("*t")
	local pref = "logs/archives/"..ThisServerIP.."_"..ThisServerPort.."_"

	local i = 1
	while file.Exists(pref..string.format("%0.3d", i)..".txt", "DATA") and i < 2500 do
		i = i + 1
	end

	LOGARCHIVENAME = pref..string.format("%0.3d", i)..".txt"

	file.Write(LOGARCHIVENAME, file.Read(LOGNAME))
end

function NDB.InitializeLogs()
	local ThisServerIP = string.Replace(GetConVarString("ip"), ".", "_")
	local ThisServerPort = tonumber(GetConVarString("hostport")) or 27015
	local thetime = os.date("*t")
	local pref = "logs/"..ThisServerIP.."_"..ThisServerPort.."/"..thetime.year.."_"..string.format("%0.2d", thetime.month).."_"..string.format("%0.2d", thetime.day)

	file.CreateDir("logs")
	file.CreateDir("logs/"..ThisServerIP.."_"..ThisServerPort)
	file.CreateDir("logs/archives")
	file.CreateDir(pref)

	local i = 1
	while file.Exists(pref.."/log"..string.format("%0.3d", i)..".txt", "DATA") and i < 2000 do
		i = i + 1
	end

	LOGBUFFER = ""
	LOGNAME = pref.."/log"..string.format("%0.3d", i)..".txt"
	LOGDAY = os.date("%d")

	NDB.LogLine(GetConVarString("hostname").." - "..game.GetMap().." - Log file started, "..string.format("%0.2d", thetime.month).."/"..string.format("%0.2d", thetime.day).."/"..thetime.year.."  "..string.format("%0.2d", thetime.hour)..":"..string.format("%0.2d", thetime.min))
	WriteOutBuffer(true)
end

function NDB.LogLine(str)
	NDB.Log(str.."\n")
end

function NDB.Log(str)
	LOGBUFFER = LOGBUFFER..os.date().." "..str
end

timer.Create("WriteLogBuffer", 30, 0, WriteOutBuffer)
hook.Add("ShutDown", "NDB_Logs_ShutDown", function() WriteOutBuffer(true) end)
hook.Add("Initialize", "NDB_Logs_Initialize", function() NDB.InitializeLogs() end)
