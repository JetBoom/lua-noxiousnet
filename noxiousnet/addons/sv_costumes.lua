hook.Add("Initialize", "NDB_SV_Costumes_Initialize", function()
	util.AddNetworkString("nox_updatecostumes")
	util.AddNetworkString("nox_updateallcostumes")
	util.AddNetworkString("nox_updatecostumeoption")
	util.AddNetworkString("nox_updatecostumeoptions")
	util.AddNetworkString("nox_updateallcostumeoptions")
end)

local meta = FindMetaTable("Player")
if not meta then return end

function meta:GetLimitedCostumeOptions()
	local coptions = {}
	if self.CostumeOptions then
		local mycostumes = self:GetCostumes()
		for uniqueid, options in pairs(self.CostumeOptions) do
			if mycostumes[uniqueid] then
				coptions[uniqueid] = options
			end
		end
	end

	return coptions
end

function meta:UpdateCostumes(filter)
	local mycostumes = self:GetCostumes()
	local options = filter == self and self.CostumeOptions or self:GetLimitedCostumeOptions()

	net.Start("nox_updatecostumes")
		net.WriteEntity(self)
		net.WriteUInt(table.Count(mycostumes), 8)
		for k in pairs(mycostumes) do
			net.WriteString(k)
		end
		net.WriteTable(options)
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

function meta:UpdateCostumeOptions(uniqueid, id, filter)
	local options = self.CostumeOptions[uniqueid] or {}

	net.Start("nox_updatecostumeoptions")
		net.WriteEntity(self)
		net.WriteString(uniqueid)
		net.WriteTable(options)
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

function meta:UpdateCostumeOptionsAll(filter)
	local options = filter == self and self.CostumeOptions or self:GetLimitedCostumeOptions()

	net.Start("nox_updateallcostumeoptions")
		net.WriteEntity(self)
		net.WriteTable(options)
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

function meta:SetCostumeOption(uniqueid, id, value, noupdate)
	if not costumes[uniqueid] then return end

	self.CostumeOptions[uniqueid] = self.CostumeOptions[uniqueid] or {}
	self.CostumeOptions[uniqueid][id] = value
	self:SetKeyDirty("CostumeOptions")

	if not noupdate then
		self:UpdateCostumeOptions(uniqueid, id)
	end
end

concommand.Add("_setcostumeoption", function(sender, command, arguments)
	if not sender:IsValidAccount() then return end

	local uniqueid = tostring(arguments[1])
	local costume = costumes[uniqueid]
	if not costume then return end

	local options = costume.Options
	if not options then return end

	local id = tonumber(arguments[2])
	if not id or not options[id] then return end

	local stored = COSTUMEOPTIONTYPES[id]
	if not stored or stored.ReadOnly then return end

	local value = arguments[3]

	local storedtype = stored.Type
	if storedtype == COSTUMEOPTION_TYPE_NUMBER then
		value = math.Round(tonumber(value) or 0)
	elseif storedtype == COSTUMEOPTION_TYPE_FLOAT then
		value = tonumber(value) or 0
	elseif storedtype == COSTUMEOPTION_TYPE_BOOL then
		value = value == "true"
	elseif storedtype == COSTUMEOPTION_TYPE_STRING then
		value = tostring(value)
	end

	sender:SetCostumeOption(uniqueid, id, value, true)
end)

concommand.Add("_forcecostumeoptionupdate", function(sender, command, arguments)
	if sender:IsValid() and sender:IsConnected() then
		local uid = arguments[1]
		if uid and #uid > 0 and costumes[uid] and sender.CostumeOptions and sender.CostumeOptions[uid] then
			sender:UpdateCostumeOptions(uid)
		else
			sender:UpdateCostumeOptionsAll()
		end
	end
end)

function meta:GetCostumesElementCount(filter)
	local count = 0

	for uid in pairs(self:GetCostumes()) do
		if not filter or uid ~= filter then
			local costume = costumes[uid]
			if costume then
				count = count + #costume.Elements
			end
		end
	end

	return count
end

function meta:AddCostume(uniqueid, dontupdate)
	local data = costumes[uniqueid]
	if not data or self:HasCostume(uniqueid) then return end

	self:GetCostumes()[uniqueid] = true

	if data.Initialize then
		data:Initialize(self)
	end

	if not dontupdate then
		self:UpdateCostumes()
	end
end

function meta:HasCostume(uniqueid)
	return self:GetCostumes()[uniqueid] ~= nil
end

function meta:RemoveCostume(uniqueid, dontupdate)
	local data = costumes[uniqueid]
	if not data or not self:HasCostume(uniqueid) then return end

	if data.OnRemove then
		data:OnRemove(self)
	end

	self:GetCostumes()[uniqueid] = nil

	if not dontupdate then
		self:UpdateCostumes()
	end
end

function meta:RemoveAllCostumes(uniqueid, dontupdate)
	for uniqueid, costume in pairs(costumes) do
		self:RemoveCostume(uniqueid, true)
	end

	if not dontupdate then
		self:UpdateCostumes()
	end
end

function meta:GetCostumes()
	return self.m_Costumes
end

function meta:GetCostumeInSlot(slot)
	return self.CostumeSlots[slot]
end

function meta:GetCostumeOptions()
	return self.CostumeOptions
end

hook.Add("PlayerInitialSpawn", "costumes_PlayerInitialSpawn", function(pl)
	pl.m_Costumes = {}
end)

hook.Add("PostPlayerReady", "costumes_PlayerReady", function(pl)
	for _, otherpl in pairs(player.GetAll()) do
		otherpl:UpdateCostumes(pl)
	end
end)
