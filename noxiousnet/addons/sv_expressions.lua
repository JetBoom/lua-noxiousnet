hook.Add("PlayerSay", "expressions", function(pl, text, teamonly)
	if string.sub(text, 1, 11) ~= "/expression" then return end

	local reason = pl:CantUseExpressions()
	if reason then
		pl:PrintMessage(HUD_PRINTTALK, "You can't use expressions because "..reason)
		return ""
	end

	local expression = string.lower(string.sub(text, 13))
	local expdata = expressions.Expressions[expression]
	if expression and #expression > 0 then
		expdata = expressions.Expressions[expression]
		if not expdata and expression ~= "none" then
			pl:PrintMessage(HUD_PRINTTALK, "That expression doesn't exist. Say \"/expression\" to see the entire menu of expressions.")
			return ""
		end
	else
		pl:SendLua("expressions:OpenMenu()")
		return ""
	end

	if expression ~= "none" then
		reason = pl:CantUseExpression(expression)
		if reason then
			pl:PrintMessage(HUD_PRINTTALK, "You can't use the "..expression.." expression because "..reason)
			return ""
		end
	end

	if CurTime() < (pl.NextUseExpression or 0) then
		pl:PrintMessage(HUD_PRINTTALK, "Please wait a bit before using another expression.")
		return ""
	end

	if expression == "none" then
		pl:ClearExpression()
	else
		pl:SetExpression(expression)
	end

	return ""
end, -19)

local meta = FindMetaTable("Player")
if not meta then return end

-- From faceposer tool.
local function IsUselessFaceFlex( strName )
	if ( strName == "gesture_rightleft" ) then return true end
	if ( strName == "gesture_updown" ) then return true end
	if ( strName == "head_forwardback" ) then return true end
	if ( strName == "chest_rightleft" ) then return true end
	if ( strName == "body_rightleft" ) then return true end
	if ( strName == "eyes_rightleft" ) then return true end
	if ( strName == "eyes_updown" ) then return true end
	if ( strName == "head_tilt" ) then return true end
	if ( strName == "head_updown" ) then return true end
	if ( strName == "head_rightleft" ) then return true end

	return false
end

function meta:SetExpression(expression, silent)
	local expdata = expressions.Expressions[expression]
	if not expdata then return end

	if not silent then
		if expdata.Message then
			self:PrintMessage(HUD_PRINTTALK, expdata.Message)
		else
			self:PrintMessage(HUD_PRINTTALK, "You are now using the "..expression.." expression.")
		end
	end

	self.Expression = expression
	self.NextUseExpression = CurTime() + expressions.TimeOut

	self:SetFlexScale(expdata.Scale or 1)

	local flexdata = expdata.Flex
	for i=0, self:GetFlexNum() - 1 do
		if flexdata[i] and not IsUselessFaceFlex(self:GetFlexName(i)) then
			self:SetFlexWeight(i, flexdata[i])
		else
			self:SetFlexWeight(i, 0)
		end
	end

	--[[for flexid, weight in pairs(expdata.Flex) do
		local lookupname = expressions.FlexNames[flexid]
		if lookupname then
			local flexid = self:LookupFlex(lookupname)
			if flexid then
				self:SetFlexWeight(flexid, weight)
			end
		end
	end]]
end

function meta:LookupFlex(name)
	for i=0, self:GetFlexNum() - 1 do
		if self:GetFlexName(i) == name then return i end
	end
end

function meta:ClearExpression()
	self.Expression = nil

	self:SetFlexScale(1)
	for i=0, self:GetFlexNum() - 1 do
		self:SetFlexWeight(i, 0)
	end
end

function meta:CantUseExpression(expression)
end

function meta:CantUseExpressions()
	-- Admins can always use it.
	if self:IsAdmin() then return end

	-- Admin only?
	if expressions.AdminOnly and not self:IsAdmin() then
		return "only admins can use expressions!"
	end

	-- User group restrictions?
	if expressions.UserGroup and expressions.UserGroup ~= "" and not self:IsUserGroup(expressions.UserGroup) then
		return "you are not part of the "..expressions.UserGroup.." group!"
	end
end

-- We probably need to redo our expressions if we set our model to something else.
local oldsetmodel = meta.SetModel or FindMetaTable("Entity").SetModel
function meta:SetModel(mdl)
	oldsetmodel(self, mdl)

	if self.Expression and self.OldExpressionModel ~= mdl then
		self.OldExpressionModel = mdl
		self:SetExpression(self.Expression, true)
	end
end
