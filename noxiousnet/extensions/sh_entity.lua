local meta = FindMetaTable("Entity")
if not meta then return end

function meta:SetAlpha(a)
	local col = self:GetColor()
	col.a = a
	self:SetColor(col)
end

function meta:GetAlpha()
	return self:GetColor().a
end

function meta:GetBonePositionMatrixed(index)
	local matrix = self:GetBoneMatrix(index)
	if matrix then
		return matrix:GetTranslation(), matrix:GetAngles()
	end

	return self:GetPos(), self:GetAngles()
end

if not CLIENT then return end

function meta:SetModelScaleVector(vec)
	local bonecount = self:GetBoneCount()
	if bonecount and bonecount > 1 then
		local scale
		if type(vec) == "number" then
			scale = vec
		else
			scale = math.min(vec.x, vec.y, vec.z)
		end
		self._ModelScale = Vector(scale, scale, scale)
		self:SetModelScale(scale, 0)
	else
		if type(vec) == "number" then
			vec = Vector(vec, vec, vec)
		end

		self._ModelScale = vec
		local m = Matrix()
		m:Scale(vec)
		self:EnableMatrix("RenderMultiply", m)
	end
end

function meta:GetModelScaleVector()
	return self._ModelScale or Vector(1, 1, 1)
end
