opensocket = {}
opensocket.ThisServerIP = GetConVarString("ip")
if opensocket.ThisServerIP == "localhost" then opensocket.ThisServerIP = "127.0.0.1" end
opensocket.ThisServerPort = tonumber(GetConVarString("hostport")) or 27015
opensocket.Phrase = "8675309"
opensocket.PortOffset = 10000
opensocket.BufferSize = 1024

opensocket.Hooks = {}

function opensocket.AddHook(hookname, func)
	opensocket.Hooks[hookname] = func
end

function opensocket.RemoveHook(hookname)
	opensocket.Hooks[hookname] = nil
end

function opensocket.CallHook(hookname, ipfrom, portfrom, msg)
	if hookname and opensocket.Hooks[hookname] then
		if msg and #msg == 0 then msg = nil end
		opensocket.Hooks[hookname](ipfrom, portfrom, msg)
	end
end

opensocket.AddHook("PrintMessage", function(ip, port, message)
	if message then
		PrintMessage(HUD_PRINTTALK, message)
		print(message)
	end
end)

opensocket.AddHook("MessageToAdmins", function(ip, port, message)
	if not message then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:IsModerator() then
			pl:PrintMessage(HUD_PRINTTALK, message)
		end
	end

	print(message)
end)

opensocket.AddHook("MessageToPlayer", function(ip, port, message)
	if not message then return end

	local steamid, msg = string.match(message, "(.+)§(.+)")

	for _, pl in pairs(player.GetAll()) do
		if pl:SteamID() == steamid then
			pl:PrintMessage(HUD_PRINTTALK, message)
			print("Message to "..pl:Name()..": "..message)
			break
		end
	end
end)

opensocket.AddHook("Heartbeat", function(ip, port, message)
	local players, maxplayers = string.match(message, "(%d+),(%d+)")
	players = tonumber(players or 0) or 0
	maxplayers = tonumber(maxplayers or 0) or 0

	for _, servertab in pairs(NDB.Servers) do
		if servertab[2] == ip and servertab[3] == port then
			servertab[5] = players
			servertab[6] = maxplayers

			return
		end
	end

	table.insert(NDB.Servers, {"IPPort"..ip..":"..port, ip, port, "IP "..ip.." Port "..port, players, maxplayers})
end)

--[[timer.CreateEx("NDB_Server_Heartbeat", 15, 0, function()
	opensocket.Broadcast("Heartbeat", (gatekeeper and gatekeeper.GetNumClients().total or #player.GetAll())..","..game.MaxPlayers(), true)
end)]]

function opensocket.SendData()
end

function opensocket.Broadcast()
end

function opensocket.Send()
end

pcall(require, "glsock2")
if GLSock == nil then return end

local GLSockErrorCodes = 
{
	[GLSOCK_ERROR_SUCCESS] = "GLSOCK_ERROR_SUCCESS",
	[GLSOCK_ERROR_ACCESSDENIED] = "GLSOCK_ERROR_ACCESSDENIED",
	[GLSOCK_ERROR_ADDRESSFAMILYNOTSUPPORTED] = "GLSOCK_ERROR_ADDRESSFAMILYNOTSUPPORTED",
	[GLSOCK_ERROR_ADDRESSINUSE] = "GLSOCK_ERROR_ADDRESSINUSE",
	[GLSOCK_ERROR_ALREADYCONNECTED] = "GLSOCK_ERROR_ALREADYCONNECTED",
	[GLSOCK_ERROR_ALREADYSTARTED] = "GLSOCK_ERROR_ALREADYSTARTED",
	[GLSOCK_ERROR_BROKENPIPE] = "GLSOCK_ERROR_BROKENPIPE",
	[GLSOCK_ERROR_CONNECTIONABORTED] = "GLSOCK_ERROR_CONNECTIONABORTED",
	[GLSOCK_ERROR_CONNECTIONREFUSED] = "GLSOCK_ERROR_CONNECTIONREFUSED",
	[GLSOCK_ERROR_CONNECTIONRESET] = "GLSOCK_ERROR_CONNECTIONRESET",
	[GLSOCK_ERROR_BADDESCRIPTOR] = "GLSOCK_ERROR_BADDESCRIPTOR",
	[GLSOCK_ERROR_BADADDRESS] = "GLSOCK_ERROR_BADADDRESS",
	[GLSOCK_ERROR_HOSTUNREACHABLE] = "GLSOCK_ERROR_HOSTUNREACHABLE",
	[GLSOCK_ERROR_INPROGRESS] = "GLSOCK_ERROR_INPROGRESS",
	[GLSOCK_ERROR_INTERRUPTED] = "GLSOCK_ERROR_INTERRUPTED",
	[GLSOCK_ERROR_INVALIDARGUMENT] = "GLSOCK_ERROR_INVALIDARGUMENT",
	[GLSOCK_ERROR_MESSAGESIZE] = "GLSOCK_ERROR_MESSAGESIZE",
	[GLSOCK_ERROR_NAMETOOLONG] = "GLSOCK_ERROR_NAMETOOLONG",
	[GLSOCK_ERROR_NETWORKDOWN] = "GLSOCK_ERROR_NETWORKDOWN",
	[GLSOCK_ERROR_NETWORKRESET] = "GLSOCK_ERROR_NETWORKRESET",
	[GLSOCK_ERROR_NETWORKUNREACHABLE] = "GLSOCK_ERROR_NETWORKUNREACHABLE",
	[GLSOCK_ERROR_NODESCRIPTORS] = "GLSOCK_ERROR_NODESCRIPTORS",
	[GLSOCK_ERROR_NOBUFFERSPACE] = "GLSOCK_ERROR_NOBUFFERSPACE",
	[GLSOCK_ERROR_NOMEMORY] = "GLSOCK_ERROR_NOMEMORY",
	[GLSOCK_ERROR_NOPERMISSION] = "GLSOCK_ERROR_NOPERMISSION",
	[GLSOCK_ERROR_NOPROTOCOLOPTION] = "GLSOCK_ERROR_NOPROTOCOLOPTION",
	[GLSOCK_ERROR_NOTCONNECTED] = "GLSOCK_ERROR_NOTCONNECTED",
	[GLSOCK_ERROR_NOTSOCKET] = "GLSOCK_ERROR_NOTSOCKET",
	[GLSOCK_ERROR_OPERATIONABORTED] = "GLSOCK_ERROR_OPERATIONABORTED",
	[GLSOCK_ERROR_OPERATIONNOTSUPPORTED] = "GLSOCK_ERROR_OPERATIONNOTSUPPORTED",
	[GLSOCK_ERROR_SHUTDOWN] = "GLSOCK_ERROR_SHUTDOWN",
	[GLSOCK_ERROR_TIMEDOUT] = "GLSOCK_ERROR_TIMEDOUT",
	[GLSOCK_ERROR_TRYAGAIN] = "GLSOCK_ERROR_TRYAGAIN",
	[GLSOCK_ERROR_WOULDBLOCK] = "GLSOCK_ERROR_WOULDBLOCK"
}

local function GetError(err)
	local erstr = GLSockErrorCodes[err or -1]
	if erstr then return erstr end

	return tostring(err)
end

function opensocket.GetDatagram(hookname, msg)
	msg = msg or ""
	hookname = string.Replace(hookname, "\0", "\2")
	msg = string.Replace(msg, "\0", "\2")

	return string.sub(opensocket.Phrase.."§"..opensocket.ThisServerIP.."§"..opensocket.ThisServerPort.."§"..hookname.."§"..msg, 1, opensocket.BufferSize - 1)
end

function opensocket.GetBuffer(hookname, msg)
	local buffer = GLSockBuffer()
	buffer:WriteString(opensocket.GetDatagram(hookname, msg))
	return buffer
end

local function IDONTCARE(socket, bytes, err)
	--print(socket, bytes, err)
	if err ~= GLSOCK_ERROR_SUCCESS then
		print("GLSOCK: SendTo FAILED! "..GetError(err))
	end
end
function opensocket.SendData(ip, port, hookname, msg)
	local sock = GLSock(GLSOCK_TYPE_UDP)
	if sock then
		sock:SendTo(opensocket.GetBuffer(hookname, msg), ip, port, IDONTCARE)
	end
end

function opensocket.GetDestIP(ip, port)
	return ip
end

function opensocket.GetDestPort(ip, port)
	for k, v in ipairs(NDB.Servers) do
		if v[2] == ip and v[3] == port then
			return k + opensocket.PortOffset
		end
	end

	return opensocket.PortOffset --port + opensocket.PortOffset
end

function opensocket.Send(ip, port, hookname, msg)
	if ip == opensocket.ThisServerIP and port == opensocket.ThisServerPort then
		opensocket.CallHook(hookname, ip, port, msg)
	else
		opensocket.SendData(opensocket.GetDestIP(ip, port), opensocket.GetDestPort(ip, port), hookname, msg)
	end
end

function opensocket.Broadcast(hookname, msg, includeself)
	if includeself then
		opensocket.CallHook(hookname, opensocket.ThisServerIP, opensocket.ThisServerPort, msg)
	end

	local buffer = opensocket.GetBuffer(hookname, msg)
	local sock = GLSock(GLSOCK_TYPE_UDP)
	for k, tab in ipairs(NDB.Servers) do
		if tab[2] ~= opensocket.ThisServerIP or tab[3] ~= opensocket.ThisServerPort then
			sock:SendTo(buffer, opensocket.GetDestIP(tab[2], tab[3]), opensocket.GetDestPort(tab[2], tab[3]), IDONTCARE)
		end
	end
end

function opensocket.CloseReceiver()
	if opensocket.Connection then
		opensocket.Connection:Cancel()
		opensocket.Connection:Close()
		opensocket.Connection = nil

		print("GLSOCK: Socket closed and destroyed")
	end
end

local function Callback_ReadFrom(socket, peer, peerPort, buffer, err)
	if err == GLSOCK_ERROR_SUCCESS then
		local len, data = buffer:ReadString()
		data = tostring(data)

		--print("GLSOCK: ReadFrom SUCCESS! Got '" .. data .. "' (length "..len..")")

		local datatable = string.Explode("§", data)
		local phrase = datatable[1]
		local fromip = datatable[2]
		local fromport = tonumber(datatable[3])
		local hookname = datatable[4]
		local msg = datatable[5]

		if fromip and hookname and phrase == opensocket.Phrase then
			--print("opensocket: CallHook "..hookname.." SUCCESS!")
			opensocket.CallHook(hookname, fromip, fromport or 1, msg)
		--[[else
			print("opensocket: CallHook FAILED! "..data)]]
		end
	--[[else
		print("GLSOCK: ReadFrom FAILED! "..GetError(err))]]
	end

	socket:ReadFrom(opensocket.BufferSize, Callback_ReadFrom)
end

local function Callback_Bind(socket, err)
	opensocket.Connection = socket

	if err == GLSOCK_ERROR_SUCCESS then
		print("GLSOCK: Socket bound")
		socket:ReadFrom(opensocket.BufferSize, Callback_ReadFrom)
	else
		print("GLSOCK: Socket NOT bound: "..GetError(err))
		opensocket.CloseReceiver()
		timer.CreateEx("CreateReceiver", 4, 1, opensocket.CreateReceiver)
	end
end

function opensocket.CreateReceiver()
	opensocket.CloseReceiver()

	opensocket.Connection = GLSock(GLSOCK_TYPE_UDP)
	opensocket.Connection:Bind(opensocket.ThisServerIP, opensocket.GetDestPort(opensocket.ThisServerIP, opensocket.ThisServerPort), Callback_Bind)

	print("GLSOCK: Socket created")
end

hook.Add("Initialize", "OpenSocketCreateReceiver", opensocket.CreateReceiver)
hook.Add("ShutDown", "OpenSocketShutDown", opensocket.CloseReceiver)

if true then return end

opensocket = {}
opensocket.ThisServerIP = GetConVarString("ip")
if opensocket.ThisServerIP == "localhost" then opensocket.ThisServerIP = "127.0.0.1" end
opensocket.ThisServerPort = tonumber(GetConVarString("hostport")) or 27015
opensocket.Phrase = 8675309
opensocket.StartPort = 10000
opensocket.PortOffsetPerIP = 32
opensocket.PortOffsetPerPort = 1
opensocket.BufferSize = 1024

opensocket.Hooks = {}

OPENSOCKET_PRINTMESSAGE = 1
OPENSOCKET_MESSAGETOADMINS = 2
OPENSOCKET_MESSAGETOPLAYER = 3
--OPENSOCKET_HEARTBEAT = 4
OPENSOCKET_LOTTERYCASHOUT = 5

function opensocket.AddHook(hookname, func)
	opensocket.Hooks[hookname] = func
end

function opensocket.RemoveHook(hookname)
	opensocket.Hooks[hookname] = nil
end

function opensocket.CallHook(hookname, ipfrom, portfrom, msg)
	if hookname and opensocket.Hooks[hookname] then
		if msg and #msg == 0 then msg = nil end
		opensocket.Hooks[hookname](ipfrom, portfrom, msg)
	end
end

opensocket.AddHook(OPENSOCKET_PRINTMESSAGE, function(ip, port, message)
	if message then
		PrintMessage(HUD_PRINTTALK, message)
		print(message)
	end
end)

opensocket.AddHook(OPENSOCKET_MESSAGETOADMINS, function(ip, port, message)
	if not message then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:IsModerator() then
			pl:PrintMessage(HUD_PRINTTALK, message)
		end
	end

	print(message)
end)

opensocket.AddHook(OPENSOCKET_MESSAGETOPLAYER, function(ip, port, message)
	if not message then return end

	local steamid, msg = string.match(message, "(.+)§(.+)")

	for _, pl in pairs(player.GetAll()) do
		if pl:SteamID() == steamid then
			pl:PrintMessage(HUD_PRINTTALK, message)
			print("Message to "..pl:Name()..": "..message)
			break
		end
	end
end)

--[[opensocket.AddHook(OPENSOCKET_HEARTBEAT, function(ip, port, message)
	local players, maxplayers = string.match(message, "(%d+),(%d+)")
	players = tonumber(players or 0) or 0
	maxplayers = tonumber(maxplayers or 0) or 0

	for _, servertab in pairs(NDB.Servers) do
		if servertab[2] == ip and servertab[3] == port then
			servertab[5] = players
			servertab[6] = maxplayers

			return
		end
	end

	table.insert(NDB.Servers, {"IPPort"..ip..":"..port, ip, port, "IP "..ip.." Port "..port, players, maxplayers})
end)

timer.Create("NDB_Server_Heartbeat", 60, 0, function()
	opensocket.Broadcast("Heartbeat", (gatekeeper and gatekeeper.GetNumClients().total or #player.GetAll())..","..game.MaxPlayers(), true)
end)]]

function opensocket.SendData()
end

function opensocket.Broadcast()
end

function opensocket.Send()
end

pcall(require, "bromsock")
if BromSock == nil then return end

function opensocket.GetBuffer(hookname, msg)
	local buffer = BromPacket()

	buffer:WriteUInt(opensocket.Phrase)

	local a, b, c, d = string.match(opensocket.ThisServerIP, "(%d+)%.(%d+)%.(%d+)%.(%d+)")
	if a then
		buffer:WriteByte(tonumber(a))
		buffer:WriteByte(tonumber(b))
		buffer:WriteByte(tonumber(c))
		buffer:WriteByte(tonumber(d))
	else
		buffer:WriteByte(0)
		buffer:WriteByte(0)
		buffer:WriteByte(0)
		buffer:WriteByte(0)
	end

	buffer:WriteUShort(opensocket.ThisServerPort)
	buffer:WriteByte(hookname)
	buffer:WriteStringRaw(msg)

	return buffer
end

local function CallbackSendTo(socket, bytes, ip, port)
	--print(socket, bytes, err)
	socket:Close()
end

function opensocket.SendData(ip, port, hookname, msg)
	local sock = BromSock(BROMSOCK_UDP)
	if sock then
		sock:SetTimeout(1000)
		sock:SetCallbackSendTo(CallbackSendTo)
		sock:SendTo(opensocket.GetBuffer(hookname, msg), ip, port)
	end
end

function opensocket.GetDestIP(ip, port)
	for k, v in ipairs(NDB.Servers) do
		if v[2] == ip then
			return NDB.Servers[1][2] -- First server IP (main IP)
		end
	end

	return ip
end

function opensocket.GetDestPort(ip, port)
	for k, v in ipairs(NDB.Servers) do
		if v[2] == ip and v[3] == port then
			return opensocket.StartPort + opensocket.PortOffsetPerIP * k + opensocket.PortOffsetPerPort * (port - 27015)
		end
	end

	return opensocket.StartPort
end

function opensocket.Send(ip, port, hookname, msg)
	if ip == opensocket.ThisServerIP and port == opensocket.ThisServerPort then
		opensocket.CallHook(hookname, ip, port, msg)
	else
		opensocket.SendData(opensocket.GetDestIP(ip, port), opensocket.GetDestPort(ip, port), hookname, msg)
	end
end

local function CallbackSendToBroadcast(sock, length, ip, port)
	timer.Simple(1, function() sock:Close() end)
end

function opensocket.Broadcast(hookname, msg, includeself)
	if includeself then
		opensocket.CallHook(hookname, opensocket.ThisServerIP, opensocket.ThisServerPort, msg)
	end

	local sock = BromSock(BROMSOCK_UDP)
	if sock then
		sock:SetTimeout(2000)

		local buffer = opensocket.GetBuffer(hookname, msg)
		for i = 1, #NDB.Servers do
			local tab = NDB.Servers[i]
			if tab[2] ~= opensocket.ThisServerIP or tab[3] ~= opensocket.ThisServerPort then
				if i == #NDB.Servers then
					sock:SetCallbackSendTo(CallbackSendToBroadcast)
				end
				sock:SendTo(buffer, opensocket.GetDestIP(tab[2], tab[3]), opensocket.GetDestPort(tab[2], tab[3]))
			end
		end
	end
end

function opensocket.CloseReceiver()
	if opensocket.Connection then
		opensocket.Connection:Disconnect()
		opensocket.Connection:Close()
		opensocket.Connection = nil

		print("OpenSocket: Socket closed and destroyed")
	end
end

local function CallbackReceiveFrom(socket, buffer, ip, port)
	local phrase = buffer:ReadUInt()
	local fromip_a = buffer:ReadByte()
	local fromip_b = buffer:ReadByte()
	local fromip_c = buffer:ReadByte()
	local fromip_d = buffer:ReadByte()
	local fromport = buffer:ReadUShort()
	local hookname = buffer:ReadByte()
	local msg = buffer:ReadStringAll()

	if phrase == opensocket.Phrase then
		local fromip = fromip_a.."."..fromip_b.."."..fromip_c.."."..fromip_d
		
		--print("OpenSocket: ReadFrom SUCCESS! Got '"..hookname..":"..msg.."' from "..fromip..":"..fromport)

		if fromip and fromport and hookname then
			--print("OpenSocket: CallHook "..hookname.." SUCCESS!")
			opensocket.CallHook(hookname, fromip, fromport, msg)
		else
			print("OpenSocket: CallHook FAILED! "..hookname..":"..msg)
		end
	end

	socket:ReceiveFrom()
end

function opensocket.CreateReceiver()
	opensocket.CloseReceiver()

	opensocket.Connection = BromSock(BROMSOCK_UDP)
	if opensocket.Connection:Bind(opensocket.GetDestPort(opensocket.ThisServerIP, opensocket.ThisServerPort), Callback_Bind) then
		print("OpenSocket: Socket bound")
		opensocket.Connection:SetCallbackReceiveFrom(CallbackReceiveFrom)
		opensocket.Connection:ReceiveFrom()
	else
		print("OpenSocket: Socket NOT bound!")
	end
end

hook.Add("Initialize", "OpenSocketCreateReceiver", opensocket.CreateReceiver)
hook.Add("ShutDown", "OpenSocketShutDown", opensocket.CloseReceiver)

--[[pcall(require, "glsock2")
if GLSock == nil then return end

local GLSockErrorCodes = 
{
	[GLSOCK_ERROR_SUCCESS] = "GLSOCK_ERROR_SUCCESS",
	[GLSOCK_ERROR_ACCESSDENIED] = "GLSOCK_ERROR_ACCESSDENIED",
	[GLSOCK_ERROR_ADDRESSFAMILYNOTSUPPORTED] = "GLSOCK_ERROR_ADDRESSFAMILYNOTSUPPORTED",
	[GLSOCK_ERROR_ADDRESSINUSE] = "GLSOCK_ERROR_ADDRESSINUSE",
	[GLSOCK_ERROR_ALREADYCONNECTED] = "GLSOCK_ERROR_ALREADYCONNECTED",
	[GLSOCK_ERROR_ALREADYSTARTED] = "GLSOCK_ERROR_ALREADYSTARTED",
	[GLSOCK_ERROR_BROKENPIPE] = "GLSOCK_ERROR_BROKENPIPE",
	[GLSOCK_ERROR_CONNECTIONABORTED] = "GLSOCK_ERROR_CONNECTIONABORTED",
	[GLSOCK_ERROR_CONNECTIONREFUSED] = "GLSOCK_ERROR_CONNECTIONREFUSED",
	[GLSOCK_ERROR_CONNECTIONRESET] = "GLSOCK_ERROR_CONNECTIONRESET",
	[GLSOCK_ERROR_BADDESCRIPTOR] = "GLSOCK_ERROR_BADDESCRIPTOR",
	[GLSOCK_ERROR_BADADDRESS] = "GLSOCK_ERROR_BADADDRESS",
	[GLSOCK_ERROR_HOSTUNREACHABLE] = "GLSOCK_ERROR_HOSTUNREACHABLE",
	[GLSOCK_ERROR_INPROGRESS] = "GLSOCK_ERROR_INPROGRESS",
	[GLSOCK_ERROR_INTERRUPTED] = "GLSOCK_ERROR_INTERRUPTED",
	[GLSOCK_ERROR_INVALIDARGUMENT] = "GLSOCK_ERROR_INVALIDARGUMENT",
	[GLSOCK_ERROR_MESSAGESIZE] = "GLSOCK_ERROR_MESSAGESIZE",
	[GLSOCK_ERROR_NAMETOOLONG] = "GLSOCK_ERROR_NAMETOOLONG",
	[GLSOCK_ERROR_NETWORKDOWN] = "GLSOCK_ERROR_NETWORKDOWN",
	[GLSOCK_ERROR_NETWORKRESET] = "GLSOCK_ERROR_NETWORKRESET",
	[GLSOCK_ERROR_NETWORKUNREACHABLE] = "GLSOCK_ERROR_NETWORKUNREACHABLE",
	[GLSOCK_ERROR_NODESCRIPTORS] = "GLSOCK_ERROR_NODESCRIPTORS",
	[GLSOCK_ERROR_NOBUFFERSPACE] = "GLSOCK_ERROR_NOBUFFERSPACE",
	[GLSOCK_ERROR_NOMEMORY] = "GLSOCK_ERROR_NOMEMORY",
	[GLSOCK_ERROR_NOPERMISSION] = "GLSOCK_ERROR_NOPERMISSION",
	[GLSOCK_ERROR_NOPROTOCOLOPTION] = "GLSOCK_ERROR_NOPROTOCOLOPTION",
	[GLSOCK_ERROR_NOTCONNECTED] = "GLSOCK_ERROR_NOTCONNECTED",
	[GLSOCK_ERROR_NOTSOCKET] = "GLSOCK_ERROR_NOTSOCKET",
	[GLSOCK_ERROR_OPERATIONABORTED] = "GLSOCK_ERROR_OPERATIONABORTED",
	[GLSOCK_ERROR_OPERATIONNOTSUPPORTED] = "GLSOCK_ERROR_OPERATIONNOTSUPPORTED",
	[GLSOCK_ERROR_SHUTDOWN] = "GLSOCK_ERROR_SHUTDOWN",
	[GLSOCK_ERROR_TIMEDOUT] = "GLSOCK_ERROR_TIMEDOUT",
	[GLSOCK_ERROR_TRYAGAIN] = "GLSOCK_ERROR_TRYAGAIN",
	[GLSOCK_ERROR_WOULDBLOCK] = "GLSOCK_ERROR_WOULDBLOCK"
}

local function GetError(err)
	local erstr = GLSockErrorCodes[err or -1]
	if erstr then return erstr end

	return tostring(err)
end

function opensocket.GetDatagram(hookname, msg)
	msg = msg or ""
	hookname = string.Replace(hookname, "\0", "\2")
	msg = string.Replace(msg, "\0", "\2")

	return string.sub(opensocket.Phrase.."§"..opensocket.ThisServerIP.."§"..opensocket.ThisServerPort.."§"..hookname.."§"..msg, 1, opensocket.BufferSize - 1)
end

function opensocket.GetBuffer(hookname, msg)
	local buffer = GLSockBuffer()
	buffer:WriteString(opensocket.GetDatagram(hookname, msg))
	return buffer
end

local function IDONTCARE(socket, bytes, err)
	--print(socket, bytes, err)
	if err ~= GLSOCK_ERROR_SUCCESS then
		print("GLSOCK: SendTo FAILED! "..GetError(err))
	end
end
function opensocket.SendData(ip, port, hookname, msg)
	local sock = GLSock(GLSOCK_TYPE_UDP)
	if sock then
		sock:SendTo(opensocket.GetBuffer(hookname, msg), ip, port, IDONTCARE)
	end
end

function opensocket.GetDestIP(ip, port)
	return ip
end

function opensocket.GetDestPort(ip, port)
	for k, v in ipairs(NDB.Servers) do
		if v[2] == ip and v[3] == port then
			return k + opensocket.PortOffset
		end
	end

	return opensocket.PortOffset --port + opensocket.PortOffset
end

function opensocket.Send(ip, port, hookname, msg)
	if ip == opensocket.ThisServerIP and port == opensocket.ThisServerPort then
		opensocket.CallHook(hookname, ip, port, msg)
	else
		opensocket.SendData(opensocket.GetDestIP(ip, port), opensocket.GetDestPort(ip, port), hookname, msg)
	end
end

function opensocket.Broadcast(hookname, msg, includeself)
	if includeself then
		opensocket.CallHook(hookname, opensocket.ThisServerIP, opensocket.ThisServerPort, msg)
	end

	local buffer = opensocket.GetBuffer(hookname, msg)
	local sock = GLSock(GLSOCK_TYPE_UDP)
	for k, tab in ipairs(NDB.Servers) do
		if tab[2] ~= opensocket.ThisServerIP or tab[3] ~= opensocket.ThisServerPort then
			sock:SendTo(buffer, opensocket.GetDestIP(tab[2], tab[3]), opensocket.GetDestPort(tab[2], tab[3]), IDONTCARE)
		end
	end
end

function opensocket.CloseReceiver()
	if opensocket.Connection then
		opensocket.Connection:Cancel()
		opensocket.Connection:Close()
		opensocket.Connection = nil

		print("GLSOCK: Socket closed and destroyed")
	end
end

local function Callback_ReadFrom(socket, peer, peerPort, buffer, err)
	if err == GLSOCK_ERROR_SUCCESS then
		local len, data = buffer:ReadString()
		data = tostring(data)

		--print("GLSOCK: ReadFrom SUCCESS! Got '" .. data .. "' (length "..len..")")

		local datatable = string.Explode("§", data)
		local phrase = datatable[1]
		local fromip = datatable[2]
		local fromport = tonumber(datatable[3])
		local hookname = datatable[4]
		local msg = datatable[5]

		if fromip and hookname and phrase == opensocket.Phrase then
			--print("opensocket: CallHook "..hookname.." SUCCESS!")
			opensocket.CallHook(hookname, fromip, fromport or 1, msg)
		--else
			--print("opensocket: CallHook FAILED! "..data)
		end
	--else
		--print("GLSOCK: ReadFrom FAILED! "..GetError(err))
	end

	socket:ReadFrom(opensocket.BufferSize, Callback_ReadFrom)
end

local function Callback_Bind(socket, err)
	opensocket.Connection = socket

	if err == GLSOCK_ERROR_SUCCESS then
		print("GLSOCK: Socket bound")
		socket:ReadFrom(opensocket.BufferSize, Callback_ReadFrom)
	else
		print("GLSOCK: Socket NOT bound: "..GetError(err))
		opensocket.CloseReceiver()
		timer.CreateEx("CreateReceiver", 4, 1, opensocket.CreateReceiver)
	end
end

function opensocket.CreateReceiver()
	opensocket.CloseReceiver()

	opensocket.Connection = GLSock(GLSOCK_TYPE_UDP)
	opensocket.Connection:Bind(opensocket.ThisServerIP, opensocket.GetDestPort(opensocket.ThisServerIP, opensocket.ThisServerPort), Callback_Bind)

	print("GLSOCK: Socket created")
end

hook.Add("Initialize", "OpenSocketCreateReceiver", opensocket.CreateReceiver)
hook.Add("ShutDown", "OpenSocketShutDown", opensocket.CloseReceiver)]]
