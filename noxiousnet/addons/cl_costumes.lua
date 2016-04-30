hook.Add("Initialize", "CreateCostumeFonts", function()
	surface.CreateLegacyFont("arial", 64, 400, true, false, "title3dfont")
	surface.CreateLegacyFont(file.Exists("resource/fonts/hidden.ttf", "GAME") and "hidden" or "arial", 64, 400, true, false, "ASSFONT")
end)

net.Receive("nox_updatecostumes", function(length)
	local ent = net.ReadEntity()
	local costumes = {}
	local count = net.ReadUInt(8)
	for i=1, count do
		costumes[net.ReadString()] = true
	end
	local options = net.ReadTable()

	if ent:IsValid() and ent:IsPlayer() then
		ent:SyncCostumes(costumes, options)
	end
end)

net.Receive("nox_updateallcostumeoptions", function(length)
	local ent = net.ReadEntity()
	local options = net.ReadTable()

	if ent:IsValid() and ent:IsPlayer() then
		for uniqueid, tableofvalues in pairs(options) do
			for k, v in pairs(tableofvalues) do
				ent:SetCostumeOption(uniqueid, k, v, true)
			end
		end

		ent:ProcessCostumeOptions()
	end
end)

net.Receive("nox_updatecostumeoptions", function(length)
	local ent = net.ReadEntity()
	local uniqueid = net.ReadString()
	local options = net.ReadTable()

	if ent:IsValid() and ent:IsPlayer() then
		for k, v in pairs(options) do
			ent:SetCostumeOption(uniqueid, k, v, true)
		end

		ent:ProcessCostumeOptions(uniqueid)
	end
end)

local blend = 1
local SetBlend = render.SetBlend
function render.SetBlend(newblend)
	blend = newblend
	SetBlend(newblend)
end

-- This is mostly for particles on costumes.
function render.GetBlend()
	return blend
end

local function SetBlendMixed(newblend)
	SetBlend(newblend * blend)
end

local MaxRenderedPerFrame = CreateClientConVar("nox_costumemodellimit", "100", true, false):GetInt() or 100
cvars.AddChangeCallback("nox_costumemodellimit", function(cvar, oldvalue, newvalue)
	MaxRenderedPerFrame = tonumber(newvalue) or 100
	if MaxRenderedPerFrame <= 0 then
		MaxRenderedPerFrame = 99999
	end
end)

local RenderedThisFrame = 0
local function costumes_PostPlayerDraw(pl)
	if pl.Costumes ~= nil and pl.DrawCostumes and not pl.SkipDrawHooks and (RenderedThisFrame < MaxRenderedPerFrame or pl == MySelf) and pl:Alive() then
		for uniqueid in pairs(pl.Costumes) do
			if RenderedThisFrame >= MaxRenderedPerFrame and pl ~= MySelf then break end

			costumes[uniqueid]:Render(pl)
		end
	end

	render.SetBlend(1)
end

local function CostumeThink(ent)
	ent.Costume:Think(ent:GetOwner())
end

local VIRTUAL_ENTITIES = {}
function Costume:CreateElement(owner, id)
	local data = self.Elements[id]
	if not data then return end

	if data.Type == ELEMENTTYPE_MODEL then
		local ent = ClientsideModel(data.Model)
		if ent:IsValid() then
			ent:DrawShadow(false)
			ent:SetPos(owner:GetPos() + Vector(0, 0, 8))
			ent:SetParent(owner)
			ent:SetOwner(owner)
			ent:Spawn()
			ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
			ent:SetNotSolid(true)
			ent:DestroyShadow()
			if data.Scale then ent:SetModelScaleVector(data.Scale) end
			if data.Material then ent:SetMaterial(data.Material) end
			if data.Color then
				ent:SetCostumeColor(data.Color)
				if data.Color.r ~= 255 or data.Color.g ~= 255 or data.Color.b ~= 255 then
					ent.ForcedColor = true
				end
			end
			if #self.Elements > 1 then
				ent:AddEFlags(EFL_SETTING_UP_BONES)
			end

			ent:SetNoDraw(true)

			ent._IsVirtual = true
			table.insert(VIRTUAL_ENTITIES, ent)

			ent.Costume = self
			ent.UniqueID = id
			ent.Owner = owner

			if data.Invalid then ent.Invalid = true end

			owner.Costumes[self:GetUniqueID()][id] = ent

			if id == 1 and self.Think then
				hook.Add("Think", ent, CostumeThink)
			end
		end
	end
end

hook.Add("EntityRemoved", "costumes_EntityRemoved", function(ent)
	if ent._IsVirtual then
		for k, v in ipairs(VIRTUAL_ENTITIES) do
			if v == ent then
				table.remove(VIRTUAL_ENTITIES, k)
				break
			end
		end
	end
end)

function Costume:RemoveElement(owner, uniqueid)
	if owner.Costumes then
		local entlist = owner.Costumes[self:GetUniqueID()]
		if entlist and entlist[uniqueid] and entlist[uniqueid]:IsValid() then
			entlist[uniqueid]:Remove()
			entlist[uniqueid] = nil
		end
	end
end

function Costume:GetEntities(owner)
	return owner.Costumes and owner.Costumes[self:GetUniqueID()]
end

function Costume:GetFirstEntity(owner)
	local entities = self:GetEntities(owner)
	if entities then
		return entities[1]
	end
end

function Costume:CreateElements(owner)
	self:RemoveElements(owner)

	for i in pairs(self.Elements) do
		self:CreateElement(owner, i)
	end

	owner:ReparentCostume(self:GetUniqueID())
end

function Costume:RemoveElements(owner)
	if owner.Costumes then
		local entlist = owner.Costumes[self:GetUniqueID()]
		if entlist then
			for i, ent in pairs(entlist) do
				if ent:IsValid() then
					ent:Remove()
					entlist[i] = nil
				end
			end
		end
	end
end

function Costume:ProcessForcedOptions(owner)
	for attachtype, attachvalue in pairs(self.ForcedOptions) do
		local storedtype = COSTUMEOPTIONTYPES[attachtype]
		if storedtype.OwnerFunction then
			storedtype.OwnerFunction(owner, attachvalue)
		end
		if storedtype.Function then
			local entities = owner.Costumes[self:GetUniqueID()]
			for uniqueid, data in pairs(self.Elements) do
				if data.Type == ELEMENTTYPE_MODEL then
					local element = entities[uniqueid]
					if IsValid(element) then
						storedtype.Function(element, attachvalue)
					end
				end
			end
		end
	end
end

function Costume:ProcessOptions(owner, options)
	if not IsValid(owner) then return end

	for attachtype, attachvalue in pairs(options) do
		local storedtable = self.Options[attachtype]
		if storedtable then
			local storedtype = COSTUMEOPTIONTYPES[attachtype]
			if storedtype and (storedtype.Function or storedtype.OwnerFunction) and attachvalue ~= nil then
				if storedtype.Type == COSTUMEOPTION_TYPE_NUMBER then
					if tonumber(attachvalue) ~= attachvalue then continue end
					attachvalue = math.Round(attachvalue)
				elseif storedtype.Type == COSTUMEOPTION_TYPE_FLOAT then
					if tonumber(attachvalue) ~= attachvalue then continue end
				elseif storedtype.Type == COSTUMEOPTION_TYPE_BOOL then
					if type(attachvalue) ~= "boolean" then continue end
				end

				if storedtable.List then
					if not table.HasValue(storedtable.List, attachvalue) then continue end
				else
					if storedtable.Min then
						if attachvalue < storedtable.Min then continue end
					end
					if storedtable.Max then
						if attachvalue > storedtable.Max then continue end
					end
				end

				if storedtype.OwnerFunction then
					storedtype.OwnerFunction(owner, attachvalue)
				end
				if storedtype.Function then
					local entities = owner.Costumes[self:GetUniqueID()]
					for uniqueid, data in pairs(self.Elements) do
						if data.Type == ELEMENTTYPE_MODEL then
							local element = entities[uniqueid]
							if IsValid(element) then
								storedtype.Function(element, attachvalue)
							end
						end
					end
				end
			end
		end
	end
end

hook.Add("PreDrawTranslucentRenderables", "costumes_PDTR", function()
	RenderedThisFrame = 0
	--MaxRenderedPerFrame = 1 / RealFrameTime() --Max models to render = FPS
end)

local SetColorModulation = render.SetColorModulation
function Costume:Render(owner)
	local entities = owner.Costumes[self:GetUniqueID()]

	if self.PreDraw and self:PreDraw(owner, entities) then return end

	for _, element in ipairs(entities) do
		if element and element:IsValid() and not element.Invalid then
			if element._cr then
				SetColorModulation(element._cr, element._cg, element._cb)
				SetBlendMixed(element._ca)

				element:DrawModel()

				SetColorModulation(1, 1, 1)
			else
				element:DrawModel()
			end

			RenderedThisFrame = RenderedThisFrame + 1
		end
	end

	if self.PostDraw then self:PostDraw(owner, entities) end
end

local function costumes_Think()
	local eyepos = EyePos()

	local lp = LocalPlayer()
	if lp:IsValid() then
		lp.DrawCostumes = lp:ShouldDrawLocalPlayer()
	end

	local time = RealTime()
	for _, pl in pairs(player.GetAll()) do
		if pl ~= lp then
			pl.DrawCostumes = pl:GetPos():DistToSqr(eyepos) <= 2560000 -- 1600^2
		end

		if time >= (pl._nextbonecache or 0) then
			pl._nextbonecache = time + 3.5
			pl:CacheBoneInfo()
		end

		if pl.Costumes then
			for id, entities in pairs(pl.Costumes) do
				local firstent = entities[1]
				if firstent and firstent:IsValid() and firstent:GetParent() ~= pl then
					pl:ReparentCostume(id)
				end
			end
		end
	end
end

local DISPLAYHATS = CreateClientConVar("nox_displayhats", "1", true, false):GetBool()
-- We want to save as many cycles as possible.
local function DisplayCVARChanged(startup)
	if DISPLAYHATS then
		hook.Add("PostPlayerDraw", "costumes_PostPlayerDraw", costumes_PostPlayerDraw)
		hook.Add("Think", "costumes_Think", costumes_Think)
		hook.Add("PrePlayerDraw", "costumes_PrePlayerDraw", costumes_PrePlayerDraw)

		if not startup then
			for _, pl in pairs(player.GetAll()) do
				pl:CreateAllCostumeEntities()
			end
		end
	else
		hook.Remove("PostPlayerDraw", "costumes_PostPlayerDraw")
		hook.Remove("Think", "costumes_Think")
		hook.Remove("PrePlayerDraw", "costumes_PrePlayerDraw")

		if not startup then
			for _, pl in pairs(player.GetAll()) do
				pl:RemoveAllCostumeEntities()
			end
		end
	end
end
cvars.AddChangeCallback("nox_displayhats", function(cvar, oldvalue, newvalue)
	DISPLAYHATS = tonumber(newvalue) == 1

	DisplayCVARChanged()
end)
DisplayCVARChanged(true)

local meta = FindMetaTable("Player")
if not meta then return end

function meta:CreateAllCostumeEntities()
	if not self.Costumes then return end

	self:RemoveAllCostumeEntities()

	for uniqueid in pairs(self.Costumes) do
		self.Costumes[uniqueid] = nil
		self:AddCostume(uniqueid)
	end
end

function meta:RemoveAllCostumeEntities()
	if not self.Costumes then return end

	for uniqueid, elements in pairs(self.Costumes) do
		local data = costumes[uniqueid]
		if data and data.OnRemove then
			data:OnRemove(self)
		end

		for i, element in pairs(elements) do
			if element and element:IsValid() then
				element:Remove()
				elements[i] = nil
			end
		end
	end
end

function meta:RemoveCostume(uniqueid)
	local data = costumes[uniqueid]
	if not data or not self:HasCostume(uniqueid) then return end

	if data.OnRemove then
		data:OnRemove(self)
	end

	data:RemoveElements(self)

	self.Costumes[uniqueid] = nil
end

function meta:GetCostumesElementCount(filter)
	local count = 0

	if self.Costumes then
		for uid in pairs(self.Costumes) do
			if not filter or uid ~= filter then
				local costume = costumes[uid]
				if costume then
					count = count + #costume.Elements
				end
			end
		end
	end

	return count
end

local BoneTranslates = NDB.BoneTranslates
function meta:CacheBoneInfo()
	local mdl = string.lower(self:GetModel())
	if self.LastBoneCacheModel == mdl then return end

	self.m_BoneCache = self.m_BoneCache or {}
	self.m_BoneTranslations = BoneTranslates[mdl]

	if self:Name() == "unconnected" then return end -- No idea... but we can't validate this stuff if we're unconnected

	local bonename0 = self:GetBoneName(0)
	if bonename0 ~= "__INVALIDBONE__" then
		self.LastBoneCacheModel = mdl

		self.m_BoneCache[bonename0] = 0
		for i = 1, self:GetBoneCount() - 1 do
			self.m_BoneCache[self:GetBoneName(i)] = i
		end

		-- Our model or bones or something changed, need to reparent everything!
		self:ReparentAllCostumes()
	end
end

function meta:ReparentAllCostumes()
	if not self.Costumes then return end

	for uniqueid in pairs(self.Costumes) do
		self:ReparentCostume(uniqueid)
	end
end

local function MoveOffset(pos, ang, offset)
	pos:Set(pos + offset.x * ang:Forward() + offset.y * ang:Right() + offset.z * ang:Up())
end

local function RotateAngles(ang, offset)
	if offset.yaw ~= 0 then ang:RotateAroundAxis(ang:Up(), offset.yaw) end
	if offset.pitch ~= 0 then ang:RotateAroundAxis(ang:Right(), offset.pitch) end
	if offset.roll ~= 0 then ang:RotateAroundAxis(ang:Forward(), offset.roll) end
end

local function TranslateBonePosAng(owner, pos, ang, bonename)
	local translation
	local translations = owner.m_BoneTranslations
	if translations then
		translation = translations[bonename]
		if translation then
			bonename = translation[1]
		end
	end

	local boneid = owner:GetCachedBoneIndex(bonename)
	if not boneid then return end

	if translation then
		MoveOffset(pos, ang, translation[2])
		RotateAngles(ang, translation[3])
	end

	return boneid
end

local localpos = Vector()
local localang = Angle()
function meta:ReparentCostume(costumename)
	if not self:HasCostume(costumename) then return end

	local mypos = self:GetPos()
	local myang = self:EyeAngles()
	if self ~= LocalPlayer() then -- wat?
		myang.pitch = 0
		myang.yaw = 0
	end

	local entities = self.Costumes[costumename]
	for i, element in ipairs(costumes[costumename].Elements) do
		local ent = entities[i]
		if ent and ent:IsValid() then
			if element.Base then
				local baseent = entities[element.Base]
				if baseent and baseent:IsValid() then
					localpos:Set(baseent:GetPos())
					localang:Set(baseent:GetAngles())

					ent:SetParent(baseent)
				else
					localpos:Set(mypos)
					localang:Set(myang)

					ent:SetParent(self)
				end

				MoveOffset(localpos, localang, element.Offset)
				RotateAngles(localang, element.Angles)

				ent:SetPos(localpos)
				ent:SetAngles(localang)
			else
				localpos:Set(mypos)
				localang:Set(myang)

				local boneid = TranslateBonePosAng(self, localpos, localang, element.BoneName)

				if boneid then
					ent:SetParent(NULL)
					ent:FollowBone(self, boneid == 0 and 1 or boneid)
				else
					ent:SetParent(self)
				end

				MoveOffset(localpos, localang, element.Offset)
				RotateAngles(localang, element.Angles)

				ent:SetPos(localpos)
				ent:SetAngles(localang)
			end
		end
	end
end

function meta:SyncCostumes(data, options)
	self:RemoveAllCostumes()

	self.CostumeOptions = options
	for uniqueid in pairs(data) do
		self:AddCostume(uniqueid)
	end
	self:ProcessCostumeOptions()
end

function meta:GetCachedBoneIndex(bonename)
	if not self.m_BoneCache then
		self:CacheBoneInfo()
	end

	return self.m_BoneCache[bonename]
end

function meta:AddCostume(uniqueid)
	local data = costumes[uniqueid]
	if not data or self:HasCostume(uniqueid) then return end

	self.Costumes = self.Costumes or {}
	self.Costumes[uniqueid] = {}

	if DISPLAYHATS then
		data:CreateElements(self)

		if data.Initialize then
			data:Initialize(self, self.Costumes[uniqueid])
		end

		data:ProcessForcedOptions(self)
		self:ProcessCostumeOptions(uniqueid)
	end
end

function meta:HasCostume(uniqueid)
	return self.Costumes and self.Costumes[uniqueid]
end

function meta:RemoveCostume(uniqueid)
	local data = costumes[uniqueid]
	if not data or not self:HasCostume(uniqueid) then return end

	if data.OnRemove then
		data:OnRemove(self)
	end

	data:RemoveElements(self)

	self.Costumes[uniqueid] = nil
end

function meta:RemoveAllCostumes()
	if not self.Costumes then return end

	for uniqueid in pairs(costumes) do
		self:RemoveCostume(uniqueid)
	end

	self.Costumes = nil
end

function meta:SetCostumeOption(uniqueid, id, value, noprocess)
	if not costumes[uniqueid] then return end

	self.CostumeOptions = self.CostumeOptions or {}
	self.CostumeOptions[uniqueid] = self.CostumeOptions[uniqueid] or {}
	self.CostumeOptions[uniqueid][id] = value

	if not noprocess then
		self:ProcessCostumeOptions(uniqueid)
	end
end

function meta:ProcessCostumeOptions(uniqueid)
	if not self.Costumes or not self.CostumeOptions then return end

	if not uniqueid then
		for uid in pairs(self.Costumes) do
			self:ProcessCostumeOptions(uid)
		end

		return
	end

	if self.Costumes[uniqueid] then
		local c = costumes[uniqueid]
		local o = self.CostumeOptions[uniqueid]
		if c and o then
			c:ProcessOptions(self, o)
		end
	end
end
