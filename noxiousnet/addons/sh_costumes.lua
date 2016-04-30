COSTUMEOPTION_ROTATEPITCH = 1
COSTUMEOPTION_ROTATEYAW = 2
COSTUMEOPTION_ROTATEROLL = 3
COSTUMEOPTION_OFFSETX = 4
COSTUMEOPTION_OFFSETY = 5
COSTUMEOPTION_OFFSETZ = 6
COSTUMEOPTION_SKIN = 7
COSTUMEOPTION_SCALE = 8
COSTUMEOPTION_SCALEX = 9
COSTUMEOPTION_SCALEY = 10
COSTUMEOPTION_SCALEZ = 11
COSTUMEOPTION_RED = 12
COSTUMEOPTION_GREEN = 13
COSTUMEOPTION_BLUE = 14
COSTUMEOPTION_ALPHA = 15
COSTUMEOPTION_MATERIAL = 16
--COSTUMEOPTION_VOICEDISTORT = 17
COSTUMEOPTION_ANNOYINGRADIOSTATION = 18
COSTUMEOPTION_STRINGMODEL = 19
COSTUMEOPTION_TITLESTRING = 20
COSTUMEOPTION_MAGICHORNINSTRUMENT = 21
COSTUMEOPTION_RENDERGROUP = 22

COSTUMEOPTION_TYPE_NUMBER = 1
COSTUMEOPTION_TYPE_FLOAT = 2
COSTUMEOPTION_TYPE_BOOL = 3
COSTUMEOPTION_TYPE_BOOLEAN = COSTUMEOPTION_TYPE_BOOL
COSTUMEOPTION_TYPE_STRING = 4

ELEMENTTYPE_MODEL = 0

COSTUMESLOT_NONE = 0
COSTUMESLOT_HEAD = 1
COSTUMESLOT_FACE = 2
COSTUMESLOT_ACCESSORY = 4
COSTUMESLOT_BODY = 8
COSTUMESLOT_BACK = 16
COSTUMESLOT_OTHER = 32

COSTUMESLOTS = {
	[COSTUMESLOT_NONE] = "None",
	[COSTUMESLOT_HEAD] = "Head",
	[COSTUMESLOT_FACE] = "Face",
	[COSTUMESLOT_ACCESSORY] = "Accessory",
	[COSTUMESLOT_BODY] = "Body",
	[COSTUMESLOT_BACK] = "Back",
	[COSTUMESLOT_OTHER] = "Other"
}

COSTUMES_MAXMODELSPERPLAYER = 16

function NDB.GetMaxCostumeModels(pl)
	return COSTUMES_MAXMODELSPERPLAYER + (NDB.MemberExtraCostumeModels[pl:GetMemberLevel()] or 0)
end

local BoneTranslates = {}
NDB.BoneTranslates = BoneTranslates
BoneTranslates["models/jessev92/player/misc/creepr.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0, 0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/jason278-players/gabe_3.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(2, 1, 0), Angle(0, 0, 0)}}
BoneTranslates["models/zombie/classic.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.HC_Body_Bone", Vector(-2, 5.5, 0), Angle(180, -45, 160)}}
BoneTranslates["models/player/zombie_classic.mdl"] = BoneTranslates["models/zombie/classic.mdl"]
BoneTranslates["models/zombie/poison.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Spine4", Vector(4, 0, -1), Angle(-90, 0, -90)}}
BoneTranslates["models/zombie/fast.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.HC_BodyCube", Vector(-3, -1, -4), Angle(90, 0, 0)}}
BoneTranslates["models/player/classic.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-3, -2, 0), Angle(0, 60, 0)}}
BoneTranslates["models/player/zombiefast.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-1.5, 0, 0), Angle(0,50, 0)}}
BoneTranslates["models/humans/group01/male_01.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0.25, 0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group01/male_01.mdl"] = BoneTranslates["models/humans/group01/male_01.mdl"]
BoneTranslates["models/humans/group03/male_01.mdl"] = BoneTranslates["models/humans/group01/male_01.mdl"]
BoneTranslates["models/player/group03/male_01.mdl"] = BoneTranslates["models/humans/group03/male_01.mdl"]
BoneTranslates["models/humans/group03/female_02.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.75, 0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group03/female_02.mdl"] = BoneTranslates["models/humans/group03/female_02.mdl"]
BoneTranslates["models/player/police.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0, 1.75, 0), Angle(0, 0, 0)}}
BoneTranslates["models/police.mdl"] = BoneTranslates["models/player/police.mdl"]
BoneTranslates["models/humans/group03/female_04.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.75, 0.25, 0), Angle(0, 0, 0)}}
BoneTranslates["models/humans/group03/female_04.mdl"] = BoneTranslates["models/player/group03/female_04.mdl"]
BoneTranslates["models/player/combine_soldier_prisonguard.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(1, 0.25, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/combine_super_soldier.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(2, -0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/soldier_stripped.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-1, -1, 0), Angle(0, 0, 0)}}
BoneTranslates["models/humans/group03/male_03.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0.4, 0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group03/male_03.mdl"] = BoneTranslates["models/humans/group03/male_03.mdl"]
BoneTranslates["models/humans/group01/male_03.mdl"] = BoneTranslates["models/humans/group03/male_03.mdl"]
BoneTranslates["models/players/group01/male_03.mdl"] = BoneTranslates["models/humans/group01/male_03.mdl"]
BoneTranslates["models/humans/group03/female_03.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.75, 0.25, 0), Angle(0, 0, 0)}}
BoneTranslates["models/players/group03/female_03.mdl"] = BoneTranslates["models/humans/group03/female_03.mdl"]
BoneTranslates["models/mossman.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.5, -0.25, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/mossman.mdl"] = BoneTranslates["models/mossman.mdl"]
BoneTranslates["models/player/gman_high.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(1, 0, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/magnusson.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.5, -0.75, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group01/female_03.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-1, 0.25, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group01/female_03.mdl"] = BoneTranslates["models/humans/group01/female_03.mdl"]
BoneTranslates["models/player/monk.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0.75, 0, 0), Angle(0, 0, 0)}}
BoneTranslates["models/monk.mdl"] = BoneTranslates["models/player/monk.mdl"]
BoneTranslates["models/player/breen.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.45, 0, 0), Angle(0, 0, 0)}}
BoneTranslates["models/breen.mdl"] = BoneTranslates["models/player/breen.mdl"]
BoneTranslates["models/player/group01/female_04.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.5, 0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/humans/group01/female_04.mdl"] = BoneTranslates["models/player/group01/female_04.mdl"]
BoneTranslates["models/humans/group03/male_06.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0.5, 0.74, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group03/male_06.mdl"] = BoneTranslates["models/humans/group03/male_06.mdl"]
BoneTranslates["models/player/charple01.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-1.5, -1.25, 0), Angle(0, 0, 0)}}
BoneTranslates["models/humans/group01/female_07.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.75, 0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group01/female_07.mdl"] = BoneTranslates["models/humans/group01/female_07.mdl"]
BoneTranslates["models/humans/group03/female_07.mdl"] = BoneTranslates["models/humans/group01/female_07.mdl"]
BoneTranslates["models/player/group03/female_07.mdl"] = BoneTranslates["models/humans/group03/female_07.mdl"]
BoneTranslates["models/player/alyx.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.5, -0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/alyx.mdl"] = BoneTranslates["models/player/alyx.mdl"]
BoneTranslates["models/wraith_zsv1.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-4, 0, -1), Angle(0, 0, 270)}}
BoneTranslates["models/headcrabclassic.mdl"] = {["ValveBiped.Bip01_Head1"] = {"HeadcrabClassic.SpineControl", Vector(2.5, -1, 0), Angle(0, 60, 0)}}
BoneTranslates["models/headcrab.mdl"] = {["ValveBiped.Bip01_Head1"] = {"HCfast.chest", Vector(0, -2, -1), Angle(90, 45, 0)}}
BoneTranslates["models/headcrabblack.mdl"] = {["ValveBiped.Bip01_Head1"] = {"HCblack.body", Vector(0, 0, 2.5), Angle(90, 70, 0)}}
BoneTranslates["models/player/hostage/hostage_02.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0.5, 1, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/hostage/hostage_04.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0, 0.25, 0), Angle(0, 0, 0)}}
BoneTranslates["models/humans/group01/female_01.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-1, 0.35, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group01/female_01.mdl"] = BoneTranslates["models/humans/group01/female_01.mdl"]
BoneTranslates["models/humans/group03/female_01.mdl"] = BoneTranslates["models/humans/group01/female_01.mdl"]
BoneTranslates["models/player/group03/female_01.mdl"] = BoneTranslates["models/humans/group03/female_01.mdl"]
BoneTranslates["models/humans/group03/female_06.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(-0.6, 0.3, 0), Angle(0, 0, 0)}}
BoneTranslates["models/players/group03/female_06.mdl"] = BoneTranslates["models/humans/group03/female_06.mdl"]
BoneTranslates["models/odessa.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0, 0.4, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/odessa.mdl"] = BoneTranslates["models/odessa.mdl"]
BoneTranslates["models/eli.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0.25, -0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/eli.mdl"] = BoneTranslates["models/eli.mdl"]
BoneTranslates["models/barney.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0, 0.3, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/barney.mdl"] = BoneTranslates["models/barney.mdl"]
BoneTranslates["models/humans/group03/male_04.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(0.75, 0, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/group03/male_04.mdl"] = BoneTranslates["models/humans/group03/male_04.mdl"]
BoneTranslates["models/player/urban.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(2, 0.5, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/guerilla.mdl"] = {["ValveBiped.Bip01_Head1"] = {"ValveBiped.Bip01_Head1", Vector(2, 0.25, 0), Angle(0, 0, 0)}}
BoneTranslates["models/player/swat.mdl"] = BoneTranslates["models/player/urban.mdl"]
BoneTranslates["models/player/gasmask.mdl"] = BoneTranslates["models/player/urban.mdl"]
BoneTranslates["models/player/riot.mdl"] = BoneTranslates["models/player/urban.mdl"]
BoneTranslates["models/player/leet.mdl"] = BoneTranslates["models/player/urban.mdl"]
BoneTranslates["models/player/guerilla.mdl"] = BoneTranslates["models/player/urban.mdl"]
BoneTranslates["models/player/phoenix.mdl"] = BoneTranslates["models/player/urban.mdl"]
BoneTranslates["models/player/arctic.mdl"] = BoneTranslates["models/player/urban.mdl"]
BoneTranslates["models/player/brsp.mdl"] = {["ValveBiped.Bip01_Pelvis"] = {"ValveBiped.Bip01_Pelvis", Vector(0, 0, -4), Angle(0, 0, 0)}}
BoneTranslates["models/antlion_guard.mdl"] = {["ValveBiped.Bip01_Head1"] = {"Antlion_Guard.head", Vector(0, 8, 0), Angle(0, 270, 180)}}

COSTUMEMATERIALS = {"", "models/debug/debugwhite", "models/shiny"}
local COSTUMEMATERIALS = COSTUMEMATERIALS
COSTUMEOPTIONTYPES = {
	[COSTUMEOPTION_ROTATEPITCH] = {Name = "Rotate Pitch",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldAngles = ent.OldAngles or ent.Angles * 1
			ent.Angles.pitch = ent.OldAngles.pitch + value
		end
	},
	[COSTUMEOPTION_ROTATEYAW] = {Name = "Rotate Yaw",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldAngles = ent.OldAngles or ent.Angles * 1
			ent.Angles.yaw = ent.OldAngles.yaw + value
		end
	},
	[COSTUMEOPTION_ROTATEROLL] = {Name = "Rotate Roll",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldAngles = ent.OldAngles or ent.Angles * 1
			ent.Angles.roll = ent.OldAngles.roll + value
		end
	},
	[COSTUMEOPTION_OFFSETX] = {Name = "Offset X",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldOffset = ent.OldOffset or ent.Offset * 1
			ent.Offset.x = ent.OldOffset.x + value
		end
	},
	[COSTUMEOPTION_OFFSETY] = {Name = "Offset Y",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldOffset = ent.OldOffset or ent.Offset * 1
			ent.Offset.y = ent.OldOffset.y + value
		end
	},
	[COSTUMEOPTION_OFFSETZ] = {Name = "Offset Z",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldOffset = ent.OldOffset or ent.Offset * 1
			ent.Offset.z = ent.OldOffset.z + value
		end
	},
	[COSTUMEOPTION_SKIN] = {Name = "Skin",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value) ent.SkinID = value end
	},
	[COSTUMEOPTION_SCALE] = {Name = "Scale",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldModelScale = ent.OldModelScale or ent:GetModelScaleVector()
			ent:SetModelScaleVector(ent.OldModelScale * value)
		end,
		Default = 1
	},
	[COSTUMEOPTION_SCALEX] = {Name = "Scale X",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldModelScale = ent.OldModelScale or ent:GetModelScaleVector()
			ent:SetModelScaleVector(Vector(ent.OldModelScale.x * value, ent.OldModelScale.y, ent.OldModelScale.z))
		end,
		Default = 1
	},
	[COSTUMEOPTION_SCALEY] = {Name = "Scale Y",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldModelScale = ent.OldModelScale or ent:GetModelScaleVector()
			ent:SetModelScaleVector(Vector(ent.OldModelScale.x, ent.OldModelScale.y * value, ent.OldModelScale.z))
		end,
		Default = 1
	},
	[COSTUMEOPTION_SCALEZ] = {Name = "Scale Z",
		Type = COSTUMEOPTION_TYPE_FLOAT,
		Function = function(ent, value)
			ent.OldModelScale = ent.OldModelScale or ent:GetModelScaleVector()
			ent:SetModelScaleVector(Vector(ent.OldModelScale.x, ent.OldModelScale.y, ent.OldModelScale.z * value))
		end,
		Default = 1
	},
	[COSTUMEOPTION_RED] = {Name = "Red",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value)
			if not ent.ForcedColor then
				local col = ent:GetColor()
				col.r = value
				ent:SetCostumeColor(col)
			end
		end,
		Default = 255
	},
	[COSTUMEOPTION_GREEN] = {Name = "Green",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value)
			if not ent.ForcedColor then
				local col = ent:GetColor()
				col.g = value
				ent:SetCostumeColor(col)
			end
		end,
		Default = 255
	},
	[COSTUMEOPTION_BLUE] = {Name = "Blue",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value)
			if not ent.ForcedColor then
				local col = ent:GetColor()
				col.b = value
				ent:SetCostumeColor(col)
			end
		end,
		Default = 255
	},
	[COSTUMEOPTION_ALPHA] = {Name = "Alpha",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value)
			if not ent.ForcedColor then
				local col = ent:GetColor()
				col.a = math.max(1, value)
				ent:SetCostumeColor(col)
			end
		end,
		Default = 255
	},
	[COSTUMEOPTION_MATERIAL] = {Name = "Material",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value)
			ent:SetMaterial(COSTUMEMATERIALS[value] or "")
		end,
		Default = 0
	},
	[COSTUMEOPTION_ANNOYINGRADIOSTATION] = {Name = "Station",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value)
			ent.Station = value
			if ent.AmbientSound then
				ent.AmbientSound:Stop()
				ent.AmbientSound = nil
			end
		end,
		Default = 0
	},
	[COSTUMEOPTION_STRINGMODEL] = {Name = "Model",
		Type = COSTUMEOPTION_TYPE_STRING,
		Function = function(ent, value)
			if util.IsValidModel(value) then
				ent:SetModel(value)
			end
		end,
		Default = "models/error.mdl"
	},
	[COSTUMEOPTION_TITLESTRING] = {Name = "Title",
		Type = COSTUMEOPTION_TYPE_STRING,
		ReadOnly = true,
		Function = function(ent, value)
			ent.Title = value
		end,
		Default = ""
	},
	[COSTUMEOPTION_MAGICHORNINSTRUMENT] = {Name = "Instrument",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value)
			ent.Instrument = value
			if ent.AmbientSound then
				ent.AmbientSound:Stop()
				ent.AmbientSound = nil
			end
		end,
		Default = 0
	},
	[COSTUMEOPTION_RENDERGROUP] = {Name = "Render group",
		Type = COSTUMEOPTION_TYPE_NUMBER,
		Function = function(ent, value)
			ent.RenderGroup = value
		end,
		Default = RENDERGROUP_OPAQUE
	}
}

local COSTUMEOPTIONTYPES = COSTUMEOPTIONTYPES

costumes = {}
Costume = {}
local costumes = costumes
local meta = {__index = Costume}

function Costume.IsCostume(object)
	return getmetatable(object) == meta
end

function meta:__tostring()
	return "Costume ["..self:GetUniqueID().."]"
end

function meta:__eq(other)
	return other ~= nil and Costume.IsCostume(other) and other:GetUniqueID() == self:GetUniqueID()
end

function meta:__gc()
end

function Costume:new(uniqueid)
	if costumes[uniqueid] then return costumes[uniqueid] end

	local obj = {}
	setmetatable(obj, meta)

	obj:SetUniqueID(uniqueid)
	obj.Elements = {}
	obj.Options = {}
	obj.ForcedOptions = {}
	obj.Slots = 0

	costumes[uniqueid] = obj
	return obj
end

function Costume:SetUniqueID(uid)
	self.m_UniqueID = uid
end

function Costume:GetUniqueID()
	return self.m_UniqueID or "INVALID"
end

function Costume:AddModel(model, pos, ang, bonename, scale, material, color, base)
	local uniqueid = #self.Elements + 1
	local data = {}

	model = model or "models/error.mdl"

	data.Type = ELEMENTTYPE_MODEL
	data.Model = model
	data.Offset = pos or Vector(0, 0, 0)
	data.Angles = ang or Angle(0, 0, 0)
	data.BoneName = bonename or "ValveBiped.Bip01_Head1"
	data.UniqueID = uniqueid or 1
	data.Scale = scale
	data.Material = material
	data.Color = color
	data.Base = base

	if CLIENT then
		if file.CachedExists(model, "GAME") then
			--util.PrecacheModel(model)
		else
			data.Invalid = true -- Model won't draw.
		end
	end

	self.Elements[data.UniqueID] = data
end

function Costume:SetSlots(slots)
	self.Slots = slots
end

function Costume:AddSlot(slot)
	self.Slots = bit.bor(self.Slots, slot)
end

function Costume:HasSlot(slot)
	return bit.band(self.Slots, slot) ~= 0
end

function Costume:AddOption(optionid, minvalue, maxvalue, listofvalues)
	self.Options[optionid] = {Min = minvalue, Max = maxvalue, List = listofvalues}
end

function Costume:AddForcedOption(optionid, value)
	self.ForcedOptions[optionid] = value
end

function Costume:RemoveOption(optionid)
	self.Options[optionid] = nil
end

function Costume:RemoveForcedOption(optionid)
	self.ForcedOptions[optionid] = nil
end

function Costume:AddColorOptions()
	self:AddOption(COSTUMEOPTION_RED, 0, 255)
	self:AddOption(COSTUMEOPTION_GREEN, 0, 255)
	self:AddOption(COSTUMEOPTION_BLUE, 0, 255)
end

function Costume:GetOption(owner, optionid)
	if self.ForcedOptions[optionid] then return self.ForcedOptions[optionid] end

	local uid = self:GetUniqueID()
	local options = owner.CostumeOptions and owner.CostumeOptions[uid]
	if options then
		return options[optionid]
	end
end

function Costume:GetColorOption(owner)
	return Color(self:GetOption(owner, COSTUMEOPTION_RED) or 255, self:GetOption(owner, COSTUMEOPTION_GREEN) or 255, self:GetOption(owner, COSTUMEOPTION_BLUE) or 255)
end

local function MoveOffset(pos, ang, offset)
	return pos + offset.x * ang:Forward() + offset.y * ang:Right() + offset.z * ang:Up()
end
local function RotateAngles(ang, offset)
	if offset.yaw ~= 0 then ang:RotateAroundAxis(ang:Up(), offset.yaw) end
	if offset.pitch ~= 0 then ang:RotateAroundAxis(ang:Right(), offset.pitch) end
	if offset.roll ~= 0 then ang:RotateAroundAxis(ang:Forward(), offset.roll) end
end
function Costume:GetPosAng(owner, offset, angles, bonename)
	local translations = owner.m_BoneTranslations
	local translation

	if translations then
		translation = translations[bonename]
		if translation then
			bonename = translation[1]
		end
	end

	local boneid = owner:GetCachedBoneIndex(bonename)
	if not boneid then return owner:GetPos(), owner:GetAngles() end

	local pos, ang = owner:GetBonePositionMatrixed(boneid)

	if translation then
		pos = MoveOffset(pos, ang, translation[2])
		RotateAngles(ang, translation[3])
	end

	pos = MoveOffset(pos, ang, offset)
	RotateAngles(ang, angles)

	return pos, ang
end

setmetatable(Costume, {__call = Costume.new})

local meta = FindMetaTable("Entity")
if meta then
	-- The whole point of this is to cut down on shitting out tons of tables every render.
	-- These values are only manipulated when spawning or performing option setting.
	-- Divided by 255 to plug directly in to render.SetColorModulation

	function meta:SetCostumeColor(col)
		self._cr = col.r / 255
		self._cg = col.g / 255
		self._cb = col.b / 255
		self._ca = col.a / 255

		-- Set the entity color because why not.
		self:SetColor(col)
	end
end

NDB.CostumeOptions = {}

for _, filename in pairs(file.Find("noxiousnet/addons/costumes/*.lua", "LUA")) do
	include("costumes/"..filename)
	if SERVER then
		AddCSLuaFile("costumes/"..filename)
	end
end

_INC_ = true
if SERVER then include("sv_costumes.lua") end
if CLIENT then include("cl_costumes.lua") end
_INC_ = nil
