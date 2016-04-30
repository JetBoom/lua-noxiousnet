local meta = FindMetaTable("Player")
if not meta then return end

function meta:CustomGesture(gesture)
	self:AnimRestartGesture(GESTURE_SLOT_CUSTOM, gesture, true)
end
usermessage.Hook("cusges", function(um)
	local ent = um:ReadEntity()
	local gesture = um:ReadShort()
	if ent:IsValid() then
		ent:CustomGesture(gesture)
	end
end)

function meta:SetSilver(int)
	self.Silver = int
end

function meta:ChatPrint(str)
	NNChat.FullChatText(-1, nil, str, "none", false, CHANNEL_DEFAULT)
end

local OldSetMuted = meta.SetMuted
function meta:SetMuted(muted)
	if muted then
		if self:IsAdmin() or self:SteamID() == "STEAM_0:0:1067405" then return end
	end

	OldSetMuted(self, muted)
end

net.Receive("nox_money", function(length)
	LocalPlayer().Silver = net.ReadUInt(32)
end)

net.Receive("nox_voicepitch", function(length)
	local ent = net.ReadEntity()
	local pitch = net.ReadUInt(8)

	if ent:IsValid() then
		if pitch == 0 then
			ent.VoicePitch = nil
		else
			ent.VoicePitch = pitch
		end
	end
end)
