local meta = FindMetaTable("Player")
if not meta then return end

function meta:IsAdmin()
	return self:IsSuperAdmin() or self:IsUserGroup("admin")
end

function meta:IsSuperAdmin()
	return self:IsUserGroup("superadmin")
end

function meta:IsUserGroup(name)
	return self:IsValid() and self:GetUserGroup() == name
end

function meta:GetUserGroup()
	return self:GetNWString("UserGroup", "user")
end
