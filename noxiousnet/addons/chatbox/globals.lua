CHATTYPE_SAY = 0
CHATTYPE_TEAMSAY = 1
CHATTYPE_CSC = 2
CHATTYPE_ADMIN = 3

CHANNEL_DEFAULT = 0
CHANNEL_PLAYERSAY = 1
CHANNEL_PLAYERSAY_TEAM = 2
CHANNEL_CONSOLESAY = 3

PARSER_STANDALONE = 0
PARSER_ENCLOSE = 1
PARSER_STANDALONE_ARGS = 2
PARSER_ENCLOSE_ARGS = 3

CHAT_DEFAULT_COLOR = Color(255, 255, 255, 255)
CHAT_DEFAULT_SYSTEM_COLOR = Color(180, 200, 255, 255)

CHAT_FEMALE_MODEL_SUBSTRINGS = {
	"female", "mossman", "alyx",
	"brsp.mdl",
	"moe_glados_p.mdl",
	"cirno_player.mdl",
	"pajama_p.mdl",
	"remilia_mp_pm.mdl",
	"flandre_mp_pm.mdl",
	"yuudachi.mdl",
	"bikini_p.mdl",
	"default_p.mdl"
}

CHAT_TYPES = {
	[CHATTYPE_SAY] = {Name = "SAY", Color = Color(255, 255, 255)},
	[CHATTYPE_TEAMSAY] = {Name = "TEAM", Color = Color(50, 255, 50), Command = "say_team"},
	[CHATTYPE_CSC] = {Name = "CSC", Color = Color(0, 255, 255), Prefix = "/csc "},
	[CHATTYPE_ADMIN] = {Name = "ADMINS", Color = Color(255, 20, 180), Prefix = "/admin "},
}

CHAT_DEFAULT_FONT = CreateClientConVar("nox_chatbox_defaultfont", "cool", true, false):GetString()

CHAT_MESSAGELIFETIME = CreateClientConVar("nox_chatbox_messagelifetime", 10, true, false):GetInt()

cvars.AddChangeCallback("nox_chatbox_defaultfont", function(cvar, oldvalue, newvalue)
	if not table.HasValue(NNChat.ValidChatFonts, newvalue) then
		newvalue = "cool"
	end

	CHAT_DEFAULT_FONT = newvalue

	if NNChat.ChatFrame and NNChat.ChatFrame.TextEntry then
		NNChat.ChatFrame.TextEntry:SetFontInternal(newvalue)
	end
end)

cvars.AddChangeCallback("nox_chatbox_messagelifetime", function(cvar, oldvalue, newvalue)
	CHAT_MESSAGELIFETIME = tonumber(newvalue) or 10
end)