NNChat = {}

include("globals.lua")
include("util.lua")
include("parsers.lua")
include("help.lua")
include("dynimg.lua")

NNChat.ValidChatFonts = {}
NNChat.NoTagUseFonts = {}

local cvarIgnoreChat = CreateClientConVar("nox_chatbox_ignoreplayers", 0, true, false)
local cvarIgnoreSystemMessages = CreateClientConVar("nox_chatbox_ignoresystem", 0, true, false)
local cvarIgnoreConnect = CreateClientConVar("nox_chatbox_ignoreconnect", 0, true, false)
local cvarIgnoreDisconnect = CreateClientConVar("nox_chatbox_ignoredisconnect", 0, true, false)
local cvarIgnoreEmotes = CreateClientConVar("nox_chatbox_ignoreemotes", 0, true, false)
local cvarNoColors = CreateClientConVar("nox_chatbox_nocolors", 0, true, false)
local cvarUseTimeStamps = CreateClientConVar("nox_chatbox_timestamps", 0, true, false)
local cvarChatBoxX = CreateClientConVar("nox_chatbox_x", 8, true, false)
local cvarChatBoxY = CreateClientConVar("nox_chatbox_y", ScrH() * 0.45, true, false)
CreateClientConVar("nox_chatbox_smallavatars", 0, true, false)

local ChatFrame
local ChatPanel

local ScrollingChat = false
--local LastChatSender
--local LastChatReceive

function NNChat.GetVerticalPadding()
	return 4
end

function NNChat.GetHorizontalPadding()
	return 8
end

function NNChat.EasyLineWrap(panel, text, defaultfont, defaultcolor, x, maxwidth)
	local panelstoadd = {}

	surface.SetFont(defaultfont)

	local words = string.RegularExplode(".%s", text)
	local numberofwords = #words

	local start = 1
	local ending = start
	while start <= numberofwords and ending <= numberofwords do
		local phrase = table.concat(words, " ", start, ending)
		local texw = NNChat.GetRealTextSize(phrase)
		if not texw then texw = 1 end
		if texw + x > maxwidth then -- Adding this would overflow it.
			local previousending = ending - 1
			if previousending < start then
				if texw > maxwidth then
					-- Someone is being a naughty boy.
					local mid1 = math.floor(#phrase * 0.25)
					local mid2 = math.floor(#phrase * 0.5)
					local mid3 = math.floor(#phrase * 0.75)
					local parts = {
						string.sub(phrase, 1, mid1),
						string.sub(phrase, mid1 + 1, mid2),
						string.sub(phrase, mid2 + 1, mid3),
						string.sub(phrase, mid3 + 1)
					}

					for _, part in ipairs(parts) do
						local pan = vgui.Create("DEXLabel", panel)
						pan:SetFont(defaultfont)
						pan:SetTextColor(defaultcolor)
						pan:SetTextSafe(part)
						pan:SizeToContents()
						if pan:GetWide() > maxwidth then
							pan:SetWide(maxwidth)
						end
						table.insert(panelstoadd, pan)
					end

					start = ending + 1
					ending = start
				else
					local pan = vgui.Create("DEXLabel", panel)
					pan:SetFont(defaultfont)
					pan:SetTextColor(defaultcolor)
					pan:SetTextSafe(phrase)
					pan:SizeToContents()
					table.insert(panelstoadd, pan)

					start = ending + 1
					ending = start
				end
			else
				local pan = vgui.Create("DEXLabel", panel)
				pan:SetFont(defaultfont)
				pan:SetTextColor(defaultcolor)
				pan:SetTextSafe(table.concat(words, " ", start, previousending))
				pan:SizeToContents()
				table.insert(panelstoadd, pan)

				start = ending
				ending = start
			end
			x = 0 -- Start a brand new line.
		else -- No overflows or anything here, just keep going.
			ending = ending + 1
			if ending > numberofwords then -- End of the word list. Add anything left over.
				local pan = vgui.Create("DEXLabel", panel)
				pan:SetFont(defaultfont)
				pan:SetTextColor(defaultcolor)
				pan:SetTextSafe(phrase)
				pan:SizeToContents()
				table.insert(panelstoadd, pan)

				x = x + pan:GetWide() -- Put x at where this group of panels leave off.
			end
		end
	end

	return {Panels = panelstoadd}
end

function NNChat.AddPanelToChat(panel)
	if ChatFrame and panel and ChatFrame:IsValid() and panel:IsValid() then
		ChatFrame:AddPanel(panel)
	end
end

local function TextOnEnter(self)
	local text = self:GetValue()
	if #text > 0 then
		local chattype = CHAT_TYPES[ChatFrame.SayType or CHATTYPE_SAY]
		local realtext = string.sub((chattype.Prefix or "")..text, 1, NDB.MaxChatSize)

		if #realtext <= 120 then
			RunConsoleCommand(chattype.Command or "say", realtext)
		else
			net.Start("nox_chat")
				net.WriteBit(chattype.Command == "say_team")
				net.WriteString(realtext)
			net.SendToServer()
		end

		if self.TextHistory[1] ~= realtext then
			table.insert(self.TextHistory, 1, realtext)
			if #self.TextHistory >= 20 then
				table.remove(self.TextHistory, #self.TextHistory)
			end
		end

		self:SetText("")
	end

	ChatFrame:Close()
end

local function TextOnKeyCodeTyped(self, key)
	if key == KEY_ESCAPE then
		ChatFrame:Close()
		gui.HideGameUI()
	elseif key == KEY_ENTER then
		self:OnEnter()
	elseif key == KEY_UP then
		ChatPanel.DoPreviousHistory()
	elseif key == KEY_DOWN then
		ChatPanel.DoNextHistory()
	elseif key == KEY_TAB then
		self:SetText(gamemode.Call("OnChatTab", self:GetText()))
		self:SetCaretPos(#self:GetText())
		timer.SimpleEx(0, self.RequestFocus, self)
	elseif key == KEY_BACKQUOTE and input.LookupBinding("toggleconsole") == "`" then -- sorry non US keyboards!
		gui.HideGameUI()
	end
end

local PreviewText
local function ChatPreviewUpdate()
	if ChatFrame.Preview and ChatFrame.Preview:IsValid() then
		ChatFrame.Preview:Remove()
		ChatFrame.Preview = nil
		ChatFrame.PreviewArea:Stop()
		ChatFrame.PreviewArea:AlphaTo(0, 0.5, 0)
	end

	local newpan = NNChat.CreateChatPanel(LocalPlayer():EntIndex(), PreviewText, LocalPlayer().PersonalChatColor or color_white, CHAT_DEFAULT_FONT, -1)
	if newpan then
		if newpan.HasParsing then
			ChatFrame.Preview = newpan
			newpan:SetParent(ChatFrame.PreviewArea)
			newpan:Center()

			ChatFrame.PreviewArea:Stop()
			ChatFrame.PreviewArea:AlphaTo(255, 0.5, 0)
		else
			newpan:Remove()
		end
	end
end

local function TextOnTextChanged(self)
	local text = self:GetText()
	for saytypeid, saytype in pairs(CHAT_TYPES) do
		if saytypeid ~= ChatFrame.SayType and saytype.Prefix and string.sub(string.lower(text), 1, #saytype.Prefix) == saytype.Prefix then
			ChatFrame:SetSayType(saytypeid)
			text = string.sub(text, #saytype.Prefix)
			self:SetText(text)
		end
	end

	PreviewText = text
	timer.Create("NNChatPreviewUpdate", 0.3333, 1, ChatPreviewUpdate)
end

local function TextPaint(self, panelw, panelh)
	self:DrawTextEntryText(LocalPlayer().PersonalChatColor or color_white, COLOR_GREEN, color_white)
end

local function AddPanelToChatPanel(panel, newpanel, x, y, maxwidth, maxlinewidth, maxlineheight)
	table.insert(panel.Children, newpanel)

	local newwid = newpanel:GetWide()
	local newtal = newpanel:GetTall()

	local padding = NNChat.GetHorizontalPadding()

	if maxwidth < newwid then
		newpanel:SetPos(x, y)
		newpanel.LineNumber = panel.NumLines

		maxlinewidth = math.max(maxlinewidth, x + newwid)
		maxlineheight = math.max(maxlineheight, newtal)
		x = padding
		y = y + maxlineheight
		maxlineheight = 4

		panel.LineHeights[panel.NumLines] = maxlineheight
		panel.NumLines = panel.NumLines + 1
		panel.MultiLine = true
	elseif maxwidth < x + newwid then
		panel.LineHeights[panel.NumLines] = maxlineheight
		panel.NumLines = panel.NumLines + 1
		x = padding
		y = y + maxlineheight
		maxlineheight = 4
		newpanel:SetPos(x, y)
		newpanel.LineNumber = panel.NumLines
		maxlinewidth = math.max(maxlinewidth, x + newwid)
		maxlineheight = math.max(maxlineheight, newtal)
		x = x + newwid

		panel.MultiLine = true
	else
		newpanel:SetPos(x, y)
		newpanel.LineNumber = panel.NumLines
		maxlinewidth = math.max(maxlinewidth, x + newwid)
		x = x + newwid
		maxlineheight = math.max(maxlineheight, newtal)

		panel.LineHeights[panel.NumLines] = maxlineheight
	end

	return x, y, maxlinewidth, maxlineheight
end

local PANEL = {}

PANEL.NumLines = 1

function PANEL:Init()
	self.Children = {}
	self.LineHeights = {4}
end

local matGradientLeft = CreateMaterial("gradient-l", "UnlitGeneric", {["$basetexture"] = "vgui/gradient-l", ["$vertexalpha"] = "1", ["$vertexcolor"] = "1", ["$ignorez"] = "1", ["$nomip"] = "1"})
function PANEL:Paint(w, h)
	if NNChat.ChatOn or self.NoBackground then return true end

	surface.SetDrawColor(0, 0, 0, 90)
	surface.DrawRect(0, 0, w * 0.4, h)
	surface.SetMaterial(matGradientLeft)
	surface.DrawTexturedRect(w * 0.4, 0, w * 0.6, h)

	return true
end

function PANEL:GetMaxLineWidth()
	return self.m_MaxLineWidth or 1
end

function PANEL:GetMaxLineHeight()
	return self.m_MaxLineHeight or 1
end

vgui.Register("NNChatPanel", PANEL, "Panel")

local function pack(...) return {...} end
function NNChat.CreateChatPanel(entid, text, defaultcolor, defaultfont, maxwidth, titles)
	local fitwidth = maxwidth == -1

	local panel = vgui.Create("NNChatPanel")
	if fitwidth then
		maxwidth = 99999
	elseif not maxwidth then
		maxwidth = ChatPanel:GetWide() - 40
	end

	-- Special case for cyclic titles. Just make an entire chat panel and parent it to this one.
	local cyclepanel
	if titles and #titles > 0 then
		cyclepanel = vgui.Create("DEXCyclePanel", panel)
		for i, v in ipairs(titles) do
			local p = NNChat.CreateChatPanel(entid, v.." ", color_white, defaultfont, -1)
			if p then
				cyclepanel:AddPanel(p)
			end
		end
	end

	local x, y, maxlinewidth, maxlineheight = NNChat.GetHorizontalPadding(), 0, 0, 0

	if cyclepanel then
		x, y, maxlinewidth, maxlineheight = AddPanelToChatPanel(panel, cyclepanel, x, y, maxwidth, maxlinewidth, maxlineheight)
	end

	while #text > 0 do
		local parser
		local start
		local minstart = math.huge

		for _, p in pairs(NNChat.Parsers) do
			if p.ParseFunction then
				start = string.find(text, p.ParseFind)
				if start and start < minstart then
					minstart = start
					parser = p
				end
			end
		end

		if parser then
			local packedstuff = pack(string.find(text, parser.ParseFind))
			local findmin, findmax = packedstuff[1], packedstuff[2]
			table.remove(packedstuff, 1)
			table.remove(packedstuff, 1)

			if findmin then
				local result = parser:ParseFunction(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff) or NNChat.NoParseFunction(string.sub(text, findmin, findmax), defaultcolor, defaultfont, panel, x, maxwidth)

				local behindtext = string.sub(text, 0, findmin - 1)
				if #behindtext > 0 then
					for i, newpanel in ipairs(NNChat.EasyLineWrap(panel, behindtext, defaultfont, defaultcolor, x, maxwidth).Panels) do
						x, y, maxlinewidth, maxlineheight = AddPanelToChatPanel(panel, newpanel, x, y, maxwidth, maxlinewidth, maxlineheight)
					end
				end

				if result.Panels then
					for q, newpanel in ipairs(result.Panels) do
						if newpanel and newpanel:IsValid() then
							x, y, maxlinewidth, maxlineheight = AddPanelToChatPanel(panel, newpanel, x, y, maxwidth, maxlinewidth, maxlineheight)
						end
					end
				elseif result.Panel and result.Panel:IsValid() then
					x, y, maxlinewidth, maxlineheight = AddPanelToChatPanel(panel, result.Panel, x, y, maxwidth, maxlinewidth, maxlineheight)
				end

				text = string.sub(text, findmax + 1)

				if result.DefaultColor then
					defaultcolor = result.DefaultColor
				end
				if result.DefaultFont then
					defaultfont = result.DefaultFont
				end

				panel.HasParsing = true
			end
		else
			break
		end
	end

	if #text > 0 then
		for i, newpanel in ipairs(NNChat.EasyLineWrap(panel, text, defaultfont, defaultcolor, x, maxwidth).Panels) do
			x, y, maxlinewidth, maxlineheight = AddPanelToChatPanel(panel, newpanel, x, y, maxwidth, maxlinewidth, maxlineheight)
		end
	end

	local biggesttall = 2
	for i, testpanel in pairs(panel.Children) do
		local _, py = testpanel:GetPos()
		biggesttall = math.max(py + testpanel:GetTall(), biggesttall)
	end

	if fitwidth then
		local mw = 8

		for i, testpanel in ipairs(panel.Children) do
			mw = mw + testpanel:GetWide()
		end

		panel:SetWide(mw)
	else
		panel:SetWide(maxwidth)
	end

	local padding = NNChat.GetVerticalPadding()

	panel:SetTall(biggesttall + padding)

	-- Now center each element vertically on each line.
	y = 0
	for line=1, #panel.LineHeights do
		local lineheight = panel.LineHeights[line] + padding

		for _, child in pairs(panel.Children) do
			if child.LineNumber == line then
				child:AlignTop(y + (lineheight - child:GetTall()) / 2)
			end
		end

		y = y + lineheight
	end

	panel.m_MaxHeight = biggesttall
	panel.m_MaxLineHeight = maxlineheight
	panel.m_MaxLineWidth = maxlinewidth

	return panel
end

PANEL = {}

function PANEL:Init()
	self:SetTitle(" ")
	self:SetDeleteOnClose(false)
	self:SetScreenLock(true)
	self:ShowCloseButton(false)

	self:DockMargin(0, 0, 0, 0)
	self:DockPadding(9, 9, 9, 0)
end

function PANEL:Close()
	if not NNChat.ChatOn then return end

	ScrollingChat = false

	net.Start("nox_chatstate")
		net.WriteBit(false)
	net.SendToServer()

	NNChat.ChatOn = false
	gamemode.Call("NDBChatOff")

	local vbar = ChatPanel:GetVBar()
	if vbar and vbar:IsValid() then
		vbar:SetVisible(false)
	end

	ChatPanel:UpdatePanelLayout()

	local chatframex, chatframey = self:GetPos()
	local chatpanelx, chatpanely = ChatPanel:GetPos()
	ChatPanel.OldPosX = chatpanelx
	ChatPanel.OldPosY = chatpanely
	ChatPanel:Dock(NODOCK)
	ChatPanel:SetParent()
	ChatPanel:SetPos(chatframex + chatpanelx, chatframey + chatpanely)

	ChatFrame.TextEntry:SetText("")

	hook.Remove("Think", "CheckForEscape")

	self:SetVisible(false)

	ChatPanel:SetMouseInputEnabled(false)
	ChatPanel:SetKeyboardInputEnabled(false)

	if ChatFrame.Preview and ChatFrame.Preview:IsValid() then
		ChatFrame.Preview:Remove()
		ChatFrame.Preview = nil
		ChatFrame.PreviewArea:Stop()
		ChatFrame.PreviewArea:SetAlpha(0)
	end
end

local function UpdatePanelLayout()
	if ChatPanel and ChatPanel:IsValid() then
		ChatPanel:UpdatePanelLayout()
	end
end
local function CheckForEscape()
	if input.IsKeyDown(KEY_ESCAPE) then
		ChatFrame:Close()
		gui.HideGameUI()
	elseif input.IsKeyDown(KEY_BACKQUOTE) and input.LookupBinding("toggleconsole") == "`" then
		gui.HideGameUI()
	end
end
function PANEL:Open(saytype)
	if NNChat.ChatOn then return end

	ScrollingChat = false

	self:SetVisible(true)
	self:MakePopup()

	net.Start("nox_chatstate")
		net.WriteBit(true)
	net.SendToServer()

	NNChat.ChatOn = true
	gamemode.Call("NDBChatOn")

	ChatPanel:SetMouseInputEnabled(true)
	ChatPanel:SetKeyboardInputEnabled(true)

	self:SetSayType(saytype or CHATTYPE_SAY)

	ChatPanel:Dock(FILL)
	ChatPanel:SetParent(self)
	if ChatPanel.OldPosX then
		ChatPanel:SetPos(ChatPanel.OldPosX, ChatPanel.OldPosY)
		ChatPanel.OldPosX = nil
		ChatPanel.OldPosY = nil
	end

	ChatPanel:UpdatePanelLayout()

	local vbar = ChatPanel:GetVBar()
	if vbar and vbar:IsValid() then
		vbar:SetVisible(true)
		vbar:SetScroll(vbar.CanvasSize)
	end

	hook.Add("Think", "CheckForEscape", CheckForEscape)

	self.TextEntry.TextHistorySlot = nil
	self.TextEntry:RequestFocus()

	if ChatFrame.Preview and ChatFrame.Preview:IsValid() then
		ChatFrame.Preview:Remove()
		ChatFrame.Preview = nil
		ChatFrame.PreviewArea:Stop()
		ChatFrame.PreviewArea:AlphaTo(0, 0.5, 0)
	end
end

function PANEL:AddPanel(panel)
	panel:SetParent(ChatPanel)
	panel:Dock(TOP)

	local children = ChatPanel:GetCanvas():GetChildren()
	if #children >= 40 then
		children[2]:Remove() -- We don't want to remove the first child because it's the dummy panel used for spacing.
		ChatPanel:InvalidateLayout()
	end

	ChatPanel:UpdatePanelLayout()
end

function PANEL:OnMouseReleased()
	local ret = DFrame.OnMouseReleased(self)

	local x, y = self:GetPos()
	RunConsoleCommand("nox_chatbox_x", x)
	RunConsoleCommand("nox_chatbox_y", y)

	return ret
end

function PANEL:SetSayType(saytype)
	saytype = saytype or CHATTYPE_SAY
	self.SayType = saytype

	local chattype = CHAT_TYPES[saytype] or CHAT_TYPES[CHATTYPE_SAY]
	self.SayTypeText:SetText(chattype.Name..":")
	self.SayTypeText:SetTextColor(chattype.Color)
	self.SayTypeText:SizeToContents()
end

function PANEL:Paint(w, h)
	if NNChat.ChatOn then
		h = h - 32

		surface.SetDrawColor(0, 0, 0, 90)
		surface.DrawRect(0, 0, w, h)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
end

vgui.Register("NNChatFrame", PANEL, "DFrame")

function chat.AddTextStamped(...)
	if cvarUseTimeStamps:GetBool() then
		chat.AddText(true, "<style font=tiny c=255,0,0>["..os.date("%I:%M:%S %p").."]</style> ", ...)
	else
		chat.AddText(true, ...)
	end
end

-- Hacky shit.
local OldAddText = chat.AddText
function chat.AddText(...)
	local arg = {...}
	if arg[1] and type(arg[1]) == "boolean" then -- true as the first argument means only print to the console.
		table.remove(arg, 1)
		OldAddText(unpack(arg))
	else
		OldAddText(unpack(arg))

		local curcolor = CHAT_DEFAULT_SYSTEM_COLOR
		local text = ""
		for k, v in ipairs(arg) do
			if type(v) == "table" and v.r and v.g and v.b then
				curcolor = v
			else
				text = text.."<defc="..curcolor.r..","..curcolor.g..","..curcolor.b..">"..tostring(v)
			end
		end

		if #text > 0 and ChatPanel then
			NNChat.FullChatText(0, nil, text, "", false, CHANNEL_DEFAULT)
		end
	end
end

function NNChat.FullChatText(entid, name, text, filter, teamonly, channel)
	if not ChatPanel then return end

	local defaultcolor = CHAT_DEFAULT_COLOR
	local defaultfont = CHAT_DEFAULT_FONT
	local defaulttext = text
	local titles

	name = name or ""

	if text and 0 < #text then
		if channel == CHANNEL_PLAYERSAY then
			local ent = Entity(entid)
			if ent:IsValid() and ent:IsPlayer() then
				if not cvarNoColors:GetBool() then
					defaultcolor = ent.PersonalChatColor or defaultcolor -- See if they have a default chat color.
				end

				local blocktext = false
				local nextemote = ent.NextEmote or 0
				local emotenotallowed = cvarIgnoreEmotes:GetBool() or ent:GetNWBool("noemotes")
				or nextemote > CurTime() and not ent:IsSuperAdmin() or ent:GetObserverMode() ~= 0
				or gamemode.Call("PlayerCantUseEmotes", ent) or gamemode.Call("PlayerCantVoiceEmote", ent)

				local emotetext = GAMEMODE.GetEmoteSay and GAMEMODE:GetEmoteSay(defaulttext) or defaulttext

				local playeddyn = false

				if emotenotallowed then
					blocktext = true
				else
					local filename = NDB.DynamicEmoteSounds[emotetext]
					if filename then
						if trigger == ent.LastEmote and CurTime() < nextemote + 3 and not ent:IsAdmin() then
							blocktext = true
						else
							local pitch = ent.VoicePitch or 100
							pitch = gamemode.Call("PlayerVoicePitch", ent, pitch) or pitch
							if pitch ~= 100 then
								pitch = pitch + ent:UserID() % 8 - 4 -- Slight variable pitch for each player.
							end
							pitch = math.Clamp(pitch, 10, 255)

							ent.NextEmote = CurTime() + 7
							ent.LastEmote = emotetext
							NDB.PlayDynSound(filename, ent, pitch / 100, ent:HasCostume("voicechanger"))
							blocktext = true
							playeddyn = true
						end
					end
				end

				if not playeddyn then
					for i, nam in pairs(NDB.EmotesNames) do
						if emotetext == nam then
							if emotenotallowed then
								blocktext = NDB.EmotesNoChat[i]
							else
								local snds = NDB.EmotesSounds[i]
								if snds then
									if snds == ent.LastEmote and CurTime() < nextemote + 3 and not ent:IsSuperAdmin() then
										blocktext = true
										break
									end

									local snd

									if type(snds) == "string" then
										snd = snds
									else
										snd = snds[math.random(#snds)]
									end

									local mdlname = string.lower(ent:GetModel())
									for _, str in pairs(CHAT_FEMALE_MODEL_SUBSTRINGS) do
										if string.match(mdlname, str) then
											local femsnd = string.gsub(snd, "/male", "/female")
											if SoundDuration(femsnd) > 0 then
												snd = femsnd
											end
											break
										end
									end

									snd = gamemode.Call("PlayerVoiceEmote", ent, snd) or snd

									local pitch = ent.VoicePitch or 100
									pitch = gamemode.Call("PlayerVoicePitch", ent, pitch) or pitch
									if pitch ~= 100 then
										pitch = pitch + ent:UserID() % 8 - 4 -- Slight variable pitch for each player.
									end
									pitch = math.Clamp(pitch, 10, 255)

									local length = SoundDuration(snd)
									if ent:HasCostume("voicechanger") and file.Exists("sound/"..snd, "GAME") then
										if ent.VoiceSound then
											ent.VoiceSound:Stop()
											ent.VoiceSound = nil
										end

										local volume = 0.7 * (NDB.EmotesVolumes[i] or 1)
										ent.VoiceSound = CreateSound(ent, snd)
										ent.VoiceSound:PlayEx(volume, pitch)
										ent.VoiceSoundKillTime = CurTime() + length
										local timername = ent:EntIndex().."VoiceDistort"
										timer.Create(timername, 0, 0, function()
											if not ent.VoiceSound then
												timer.Remove(timername)
											elseif CurTime() >= ent.VoiceSoundKillTime then
												ent.VoiceSound:Stop()
												ent.VoiceSound = nil
												timer.Remove(timername)
											else
												ent.VoiceSound:PlayEx(volume, math.Clamp(pitch + math.sin(RealTime() * 5) * 60, 10, 255))
											end
										end)
									else
										ent:EmitSound(snd, 70, pitch, NDB.EmotesVolumes[i])
										length = length + length * (100 - pitch) * 0.005
									end
									ent.NextEmote = CurTime() + length + 3

									ent.LastEmote = snds
								end

								blocktext = NDB.EmotesNoChat[i]

								if NDB.EmotesCallbacks[i] then
									NDB.EmotesCallbacks[i](ent, i, snds)
								end
							end

							break
						end
					end
				end

				if blocktext then
					defaulttext = ""
				else
					local col = team.GetColor(ent:Team()) or color_white
					chat.AddTextStamped(col, tostring(name), color_white, ": "..tostring(text))

					if cvarIgnoreChat:GetBool() then return end

					chat.PlaySound()

					--[[if LastChatSender == ent and (SysTime() < LastChatReceive + CHAT_MESSAGELIFETIME + 1 or NNChat.ChatOn) then
						local arrowcolor = defaultcolor ~= CHAT_DEFAULT_COLOR and defaultcolor or col
						defaulttext = "<c="..arrowcolor.r..","..arrowcolor.g..","..arrowcolor.b..">></c> "..text
					else]]
						titles = NNChat.GetTitles(ent)
						defaulttext = "<defc="..col.r..","..col.g..","..col.b.."><info>"..name.."</info><defc="..defaultcolor.r..","..defaultcolor.g..","..defaultcolor.b.."><white>:</white> "..text
					--end

					--LastChatSender = ent
					--LastChatReceive = SysTime()
				end
			elseif name == "" then
				defaulttext = text
			else
				defaulttext = name..": "..text
			end
		elseif channel == CHANNEL_PLAYERSAY_TEAM then
			local ent = Entity(entid)
			if ent:IsValid() and ent:IsPlayer() then
				defaultcolor = ent.PersonalChatColor or defaultcolor

				local col = team.GetColor(ent:Team()) or color_white
				chat.AddTextStamped(color_white, "[TEAM] ", col, tostring(name), color_white, ": "..tostring(text))

				if cvarIgnoreChat:GetBool() then return end

				chat.PlaySound()

				titles = NNChat.GetTitles(ent)

				defaulttext = "<vscan color="..col.r..","..col.g..","..col.b..">[TEAM]</vscan> <defc="..col.r..","..col.g..","..col.b.."><info>"..name.."</info><defc="..defaultcolor.r..","..defaultcolor.g..","..defaultcolor.b..">: "..text
			elseif name == "" then
				defaulttext = "<vscan>[TEAM]</vscan> "..text
			else
				defaulttext = "<vscan>[TEAM]</vscan> "..name..": "..text
			end
		elseif channel == CHANNEL_CONSOLESAY then
			if filter == "chat" then
				chat.AddTextStamped(COLOR_RED, tostring(name), color_white, ": "..tostring(text))

				if cvarIgnoreSystemMessages:GetBool() then return end

				chat.PlaySound()
				defaulttext = "<flash color=255,0,0 rate=10>"..name.."</flash>: "..text
			else
				if cvarIgnoreSystemMessages:GetBool() then return end

				local nam = string.match(text, "Player (.-) has")
				if nam then
					if cvarIgnoreConnect:GetBool() then return end
					text = "<silkicon icon=user> "..string.Replace(text, nam, "<lg>"..nam.."</lg>")
					if MySelf:IsValid() then
						MySelf:EmitSound("garrysmod/content_downloaded.wav", 100, 100, 0.33)
					end
				else
					nam = string.match(text, "Player (.-) left")
					if nam then
						if cvarIgnoreDisconnect:GetBool() then return end
						text = "<silkicon icon=status_offline> "..string.Replace(text, nam, "<red>"..nam.."</red>")
						if MySelf:IsValid() then
							MySelf:EmitSound("ambient/materials/smallwire_pluck3.wav", 100, 100, 0.33)
						end
					end
				end
				defaulttext = text
			end
		end
	end

	if defaulttext and 0 < string.len(defaulttext) then
		if cvarUseTimeStamps:GetBool() then
			defaulttext = "<style font=tiny c=255,0,0>["..os.date("%I:%M:%S %p").."]</style> "..defaulttext
		end

		local panel = NNChat.CreateChatPanel(entid, defaulttext, defaultcolor, defaultfont, nil, titles)

		if panel then
			panel.DieTime = panel.DieTime or (CurTime() + CHAT_MESSAGELIFETIME)
			panel:SetAlpha(0)
			panel:AlphaTo(255, 0.4, 0)
			timer.Simple(CHAT_MESSAGELIFETIME, UpdatePanelLayout)
			NNChat.AddPanelToChat(panel)
		end
	end
end

local colVBarBG = Color(35, 35, 35, 175)
local colVBar = Color(225, 225, 225, 75)
local colVBarHov = Color(225, 225, 225, 180)
local colVBarHL = Color(225, 225, 225)

local function PaintVBar(self, w, h)
	surface.SetDrawColor(colVBarBG)
	surface.DrawRect(w / 2 - 4, 16, 8, h - 32)

	return true
end

local matArrowUp = Material("noxiousnet/chatbox_arrow_up.png")
local matArrowDown = Material("noxiousnet/chatbox_arrow_down.png")
local function PaintVBarUp(self, w, h)
	if self.Depressed then
		surface.SetDrawColor(colVBarHL)
	elseif self.Hovered then
		surface.SetDrawColor(colVBarHov)
	else
		surface.SetDrawColor(colVBar)
	end

	surface.SetMaterial(matArrowUp)
	surface.DrawTexturedRect(0, 0, w, 22)
end

local function PaintVBarDown(self, w, h)
	if self.Depressed then
		surface.SetDrawColor(colVBarHL)
	elseif self.Hovered then
		surface.SetDrawColor(colVBarHov)
	else
		surface.SetDrawColor(colVBar)
	end

	surface.SetMaterial(matArrowDown)
	surface.DrawTexturedRect(0, h - 22, w, 22)
end

local function PaintVBarBar(self, w, h)
	if self.Depressed or self.Hovered then
		surface.SetDrawColor(colVBarHL)
	else
		surface.SetDrawColor(colVBar)
	end

	surface.DrawRect(2, h / 2 - 4, w - 4, 8)
end

local function PerformLayoutVBar(self)
	local Wide = self:GetWide()
	local Scroll = self:GetScroll() / self.CanvasSize
	local BarSize = 8
	local Track = self:GetTall() - (Wide * 2) - BarSize
	Track = Track + 1

	Scroll = Scroll * Track

	self.btnGrip:SetPos( 0, Wide + Scroll )
	self.btnGrip:SetSize( Wide, BarSize )

	self.btnUp:SetPos( 0, 0, Wide, Wide )
	self.btnUp:SetSize( Wide, Wide )

	self.btnDown:SetPos( 0, self:GetTall() - Wide, Wide, Wide )
	self.btnDown:SetSize( Wide, Wide )
end

function NNChat.CreateChatBox()
	local w, h = ScrW(), ScrH()
	local wid, hei = math.Clamp(w * 0.35, 480, 900), math.Clamp(h * 0.45, 320, 520)

	ChatFrame = vgui.Create("NNChatFrame")
	NNChat.ChatFrame = ChatFrame
	ChatFrame:SetSkin("Default")
	ChatFrame:SetPos(math.Clamp(cvarChatBoxX:GetFloat(), 0, w - wid), math.Clamp(cvarChatBoxY:GetFloat(), 0, h - hei))
	ChatFrame:SetSize(wid, hei)

	local toparea = vgui.Create("Panel", ChatFrame)
	toparea:SetTall(24)
	toparea:Dock(TOP)
	toparea:DockPadding(8, 4, 8, 4)

	local logo = vgui.Create("DImage", toparea)
	logo:SetImage("noxiousnet/noxicon.png")
	logo:SetSize(16, 16)
	logo:SetAlpha(120)
	logo:Dock(LEFT)

	local verybottomarea = vgui.Create("DEXRoundedPanel", ChatFrame)
	verybottomarea:SetTall(32)
	verybottomarea:SetCurveTopLeft(false)
	verybottomarea:SetCurveTopRight(false)
	verybottomarea:SetAlpha(0)
	verybottomarea:Dock(BOTTOM)
	ChatFrame.PreviewArea = verybottomarea

	local bottomarea = vgui.Create("Panel", ChatFrame)
	bottomarea:SetTall(36)
	bottomarea:DockPadding(0, 6, 0, 6)
	bottomarea:DockMargin(0, 9, 0, 9)
	bottomarea:Dock(BOTTOM)
	bottomarea.Paint = function(self, panelw, panelh)
		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawRect(0, 0, panelw, panelh)
		surface.DrawOutlinedRect(0, 0, panelw, panelh)
	end

	ChatPanel = vgui.Create("DScrollPanel", ChatFrame)
	ChatPanel:SetSize(wid, hei - toparea:GetTall() - bottomarea:GetTall() - verybottomarea:GetTall() - 16 - 18) -- This is needed for when we're not actually docked to the chat frame.
	ChatPanel:Dock(FILL)
	ChatPanel.Think = function(self)
		if not NNChat.ChatOn or not ScrollingChat then
			local vbar = ChatPanel:GetVBar()
			if vbar and vbar:IsValid() and vbar:GetScroll() ~= vbar.CanvasSize then
				vbar:SetScroll(vbar.CanvasSize)
			end
		end
	end
	ChatPanel.AddItem = function(self, pnl)
		pnl:SetParent(self:GetCanvas())
	end
	ChatPanel.PerformLayout = function(self)
		local Wide = self:GetWide()
		local YPos = 0

		self:Rebuild()

		self.VBar:SetUp(self:GetTall(), self.pnlCanvas:GetTall())
		YPos = self.VBar:GetOffset()

		if self.VBar.Enabled then Wide = Wide - self.VBar:GetWide() end

		self.pnlCanvas:SetPos(0, YPos)
		self.pnlCanvas:SetWide(Wide)

		self:Rebuild()
	end
	ChatPanel.VBar.SetScroll = function(self, scrll)
		if not self.Enabled then self.Scroll = 0 return end

		self.Scroll = math.Clamp(scrll, 0, self.CanvasSize)

		if self.Scroll < self.CanvasSize and NNChat.ChatOn then
			ScrollingChat = true
		end

		self:InvalidateLayout()

		local func = self:GetParent().OnVScroll
		if func then
			func(self:GetParent(), self:GetOffset())
		else
			self:GetParent():InvalidateLayout()
		end
	end
	ChatPanel.VBar.SetUp = function(self, _barsize_, _canvassize_)
		self.BarSize 	= _barsize_
		self.CanvasSize = math.max( _canvassize_ - _barsize_, 1 )

		self:SetEnabled( true )

		self:InvalidateLayout()
	end
	ChatPanel.VBar.SetEnabled = function(self, b)
		if not b then
			self.Offset = 0
			self:SetScroll(99999)
			self.HasChanged = true
		end

		self:SetMouseInputEnabled(b)
		self:SetVisible(b and NNChat.ChatOn)

		if self.Enabled ~= b then
			self:GetParent():InvalidateLayout()

			if self:GetParent().OnScrollbarAppear then
				self:GetParent():OnScrollbarAppear()
			end
		end

		self.Enabled = b
	end

	ChatPanel.VBar.Paint = PaintVBar
	ChatPanel.VBar.btnUp.Paint = PaintVBarUp
	ChatPanel.VBar.btnDown.Paint = PaintVBarDown
	ChatPanel.VBar.btnGrip.Paint = PaintVBarBar
	ChatPanel.VBar.PerformLayout = PerformLayoutVBar
	ChatPanel.VBar:SetWide(22)

	-- Fuck it all
	local dummy = vgui.Create("Panel", ChatPanel)
	dummy:SetTall(ChatPanel:GetTall())
	dummy:SetPaintBackgroundEnabled(false)
	dummy:Dock(TOP)

	ChatPanel.UpdatePanelLayout = function(self)
		for _, panel in ipairs(self:GetCanvas():GetChildren()) do
			if panel and panel:IsValid() and panel.DieTime and panel.DieTime <= CurTime() then
				panel:SetVisible(NNChat.ChatOn)
			end
		end

		self:InvalidateLayout()
	end

	local pan = vgui.Create("Panel", bottomarea)
	pan:SetWide(64)
	pan:Dock(LEFT)
	pan:SetMouseInputEnabled(true)
	pan.OnMousePressed = function(self)
		local saytype = ChatFrame.SayType
		if CHAT_TYPES[saytype + 1] then
			ChatFrame:SetSayType(saytype + 1)
		else
			ChatFrame:SetSayType(CHATTYPE_SAY)
		end
		ChatFrame.TextEntry:RequestFocus()
	end
	ChatFrame.SayTypeText = vgui.Create("DLabel", pan)
	ChatFrame.SayTypeText:SetFont("DefaultFontBold")
	ChatFrame.SayTypeText:SetMouseInputEnabled(false)
	ChatFrame.SayTypeText:SetContentAlignment(5)
	ChatFrame.SayTypeText:Dock(FILL)

	local tex = vgui.Create("DTextEntry", bottomarea)
	ChatFrame.TextEntry = tex
	tex:Dock(FILL)
	tex:SetEditable(true)
	tex:SetEnterAllowed(true)
	tex:SetKeyboardInputEnabled(true)
	tex:SetMouseInputEnabled(true)
	tex:SetTextInset(2, 0)
	tex:SetAllowNonAsciiCharacters(true)
	tex:SetFont(CHAT_DEFAULT_FONT)
	tex:SetFontInternal(CHAT_DEFAULT_FONT)
	tex.OnEnter = TextOnEnter
	tex.OnKeyCodeTyped = TextOnKeyCodeTyped
	tex.OnTextChanged = TextOnTextChanged
	tex.Paint = TextPaint
	tex.TextHistory = {}

	ChatPanel.DoPreviousHistory = function()
		local slot = (tex.TextHistorySlot or 0) + 1
		if tex.TextHistory[slot] then
			tex.TextHistorySlot = slot
			tex:SetTextSafe(tex.TextHistory[slot])
			tex:OnTextChanged()
			tex:SetCaretPos(#tex:GetText())
		end
		tex:RequestFocus()
	end

	ChatPanel.DoNextHistory = function()
		local slot = (tex.TextHistorySlot or 0) - 1
		if tex.TextHistory[slot] then
			tex.TextHistorySlot = slot
			tex:SetTextSafe(tex.TextHistory[slot])
			tex:OnTextChanged()
			tex:SetCaretPos(#tex:GetText())
		else
			tex.TextHistorySlot = nil
			tex:SetText("")
		end
		tex:RequestFocus()
	end

	ChatPanel.Paint = function(self, panelw, panelh)
		if NNChat.ChatOn then
			surface.SetDrawColor(0, 0, 0, 180)
			surface.DrawRect(0, 0, panelw, panelh)
			surface.DrawOutlinedRect(0, 0, panelw, panelh)
		end
	end

	local fontdropdown = vgui.Create("DComboBox", toparea)
	fontdropdown:SetWide(120)
	fontdropdown:SetMouseInputEnabled(true)
	fontdropdown:SetKeyboardInputEnabled(true)
	fontdropdown:SetTooltip("Changes the default font.")
	for k, v in ipairs(NNChat.ValidChatFonts) do
		fontdropdown:AddChoice(v)
	end
	fontdropdown:SetConVar("nox_chatbox_defaultfont")
	fontdropdown:SetText(CHAT_DEFAULT_FONT)
	fontdropdown:Dock(RIGHT)
	fontdropdown:DockMargin(0, 0, 32, 0)
	fontdropdown.Think = fontdropdown.ConVarStringThink
	fontdropdown.OnSelect = function(me, index, value, data)
		surface.SetFont(value)
		local tw = surface.GetTextSize("w")
		RunConsoleCommand("nox_chatbox_defaultfont", tw == nil and NNChat.ValidChatFonts[1] or value)
	end

	local newsbutton = vgui.Create("DImageButton", toparea)
	newsbutton:SetImage("icon16/newspaper.png")
	newsbutton:SizeToContents()
	newsbutton:Dock(LEFT)
	newsbutton:SetTooltip("Displays the latest news and announcements!")
	newsbutton.DoClick = function() MakepNews() end
	newsbutton.OldPaint = newsbutton.Paint
	newsbutton.FlashColor = Color(255, 255, 255, 255)
	newsbutton.Whited = true
	newsbutton.Paint = function(bb)
		if bb.OldPaint then
			bb:OldPaint()
		end

		if NEWNEWS then
			bb.Whited = nil

			local col = bb.FlashColor
			local sat = math.abs(math.sin(RealTime() * 20)) * 200 + 55
			col.g = sat
			col.b = sat
			bb.m_Image:SetImageColor(col)
		elseif not bb.Whited then
			bb.Whited = true
			bb.m_Image:SetImageColor(color_white)
		end
	end

	local tagsbutton = vgui.Create("DImageButton", toparea)
	tagsbutton:SetImage("gui/info")
	tagsbutton:SizeToContents()
	tagsbutton:SetTooltip("Chat box help.")
	tagsbutton:Dock(LEFT)
	tagsbutton.DoClick = NNChat.OpenHelp

	local forumsbutton = vgui.Create("DImageButton", toparea)
	forumsbutton:SetImage("icon16/table_edit.png")
	forumsbutton:SizeToContents()
	forumsbutton:SetTooltip("Forums")
	forumsbutton:Dock(LEFT)
	forumsbutton.DoClick = function()
		gui.OpenURL("http://www.noxiousnet.com/forums")
	end

	ChatFrame:SetSkin("Default")

	timer.Simple(0, function()
		NNChat.ChatOn = true
		ChatFrame:Close()
	end)
end

local function ChatText(entid, name, text, filter)
	if entid == 0 then
		NNChat.FullChatText(entid, name, text, filter, false, CHANNEL_CONSOLESAY)
	else
		NNChat.FullChatText(entid, name, text, filter, false, CHANNEL_DEFAULT)
	end

	return true
end

local function PlayerBindPress(pl, bind, down)
	if down then
		if bind == "messagemode" then
			if IsValid(pl.Instrument) then return end -- Special case for theater instruments...

			ChatFrame:Open(CHATTYPE_SAY)
			return true
		elseif bind == "messagemode2" then
			if IsValid(pl.Instrument) then return end

			ChatFrame:Open(CHATTYPE_TEAMSAY)
			return true
		end
	end
end

local function OnPlayerChat(pl, text, teamonly, isdead)
	if pl:IsValid() and pl:IsPlayer() then
		if GAMEMODE.PreOnPlayerChat then
			local preteamonly = teamonly
			text, teamonly = GAMEMODE:PreOnPlayerChat(pl, text, teamonly, isdead)
			if teamonly == nil then teamonly = preteamonly end
		end

		if #text > 0 then
			NNChat.FullChatText(pl:EntIndex(), pl:Name(), text, "chat", teamonly, teamonly and CHANNEL_PLAYERSAY_TEAM or CHANNEL_PLAYERSAY)
		end
	end

	return true
end

hook.Add("Initialize", "NNChat", function()
	hook.Add("OnPlayerChat", "NNChat", OnPlayerChat)
	hook.Add("ChatText", "NNChat", ChatText)
	hook.Add("PlayerBindPress", "NNChat", PlayerBindPress)

	GAMEMODE.NDBChatOn  = GAMEMODE.NDBChatOn  or function() end
	GAMEMODE.NDBChatOff = GAMEMODE.NDBChatOff or function() end

	NNChat.CreateChatBoxFont("niceandfat",	"tahoma",		16,		700)
	NNChat.CreateChatBoxFont("nice",		"tahoma",		16,		0)
	NNChat.CreateChatBoxFont("easy",		"arial",		16,		0)
	NNChat.CreateChatBoxFont("cool",		"coolvetica",	20,		0)
	NNChat.CreateChatBoxFont("verd",		"verdana",		16,		0)
	NNChat.CreateChatBoxFont("wacky",		"akbar",		22,		0)
	NNChat.CreateChatBoxFont("console",		"courier new",	16,		0)
	NNChat.CreateChatBoxFont("tiny",		"tahoma",		11,		0)
	NNChat.CreateChatBoxFont("huge",		"tahoma",		24,		0,	true)

	NDB.CreateInternalFonts()

	if not table.HasValue(NNChat.ValidChatFonts, CHAT_DEFAULT_FONT) then
		CHAT_DEFAULT_FONT = "nice"
	end

	NNChat.CreateChatBox()
end)

hook.Add("HUDShouldDraw", "NoXChat_HUDShouldDraw", function(name)
	if name == "CHudChat" then return false end
end)

hook.Add("StartChat", "NoXChat_StartChat", function()
	return true
end)

net.Receive("nox_chat", function(length)
	local teamonly = net.ReadBit() == 1
	local sender = net.ReadEntity()
	local text = net.ReadString()
	local isdead = false

	if sender:IsValid() and sender:IsPlayer() and not sender:Alive() then
		isdead = true
	end

	gamemode.Call("OnPlayerChat", sender, text, teamonly, isdead)
end)
