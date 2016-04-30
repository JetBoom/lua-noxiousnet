PARSER.Description = "<sound src=buttons/button2.wav>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<sound(.-)>"

local ChatBoxSoundPanel
local function CheckChatBoxSoundRemoved()
	if not ChatBoxSoundPanel or not ChatBoxSoundPanel:IsValid() then
		if MySelf._ChatBoxSound then
			MySelf._ChatBoxSound:Stop()
			MySelf._ChatBoxSound = nil
		end
		ChatBoxSoundPanel = nil
		hook.Remove("Think", "checkchatboxsoundremoved")
	end
end
local function SoundOnCursorExited(self)
	if MySelf._ChatBoxSound then
		MySelf._ChatBoxSound:Stop()
		MySelf._ChatBoxSound = nil
	end
end
local function SoundOnCursorEntered(self)
	SoundOnCursorExited(self)
	MySelf._ChatBoxSound = CreateSound(MySelf, self.Sound)
	MySelf._ChatBoxSound:PlayEx(1, self.Pitch)
	ChatBoxSoundPanel = self
	hook.Add("Think", "checkchatboxsoundremoved", CheckChatBoxSoundRemoved)
end
function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local contents = packages[1]
	local attributes = NNChat.GetAttributes(contents)

	local fil = attributes.src

	if not fil or string.find(fil, "[%c%z%^%$%(%)%%%[%]%*%+%-%?]") or string.find(fil, "..", 1, true) then return end

	local newpanel = vgui.Create("DImage", panel)
	newpanel:SetImage("icon16/sound.png")
	newpanel:SizeToContents()
	newpanel:SetMouseInputEnabled(true)
	newpanel:SetTooltip("<sound"..packages[1]..">")
	newpanel.OnCursorEntered = SoundOnCursorEntered
	newpanel.OnCursorExited = SoundOnCursorExited
	newpanel.Sound = SoundDuration(fil) > 0 and fil or "misc/null.wav"
	newpanel.Pitch = math.Clamp(tonumber(attributes.pitch or 100) or 100, 10, 255)

	return {Panel = newpanel}
end
