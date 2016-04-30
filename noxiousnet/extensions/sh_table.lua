function table.RebuildIndex(t)
	if table.IsSequential(t) then return t end

	local maximum = -1

	for i in pairs(t) do
		if i > maximum then
			maximum = i
		end
	end

	if maximum >= 1 then
		for i = 1, maximum do
			if t[i] == nil then
				for i2 = i + 1, maximum do
					if t[i2] ~= nil then
						t[i] = t[i2]
						t[i2] = nil
						return table.RebuildIndex(t)
					end
				end
			end
		end
	end

	return t
end

local allowedtypes = {}
allowedtypes["string"] = true
allowedtypes["number"] = true
allowedtypes["table"] = true
allowedtypes["Vector"] = true
allowedtypes["Angle"] = true
allowedtypes["boolean"] = true
function table.CopyNoUserdata(t, lookup_table)
	if not t then return end
	
	local copy = {}
	setmetatable(copy, getmetatable(t))
	for i, v in pairs(t) do
		if allowedtypes[type(i)] and allowedtypes[type(v)] then
			if type(v) ~= "table" then
				copy[i] = v
			else
				lookup_table = lookup_table or {}
				lookup_table[t] = copy
				if lookup_table[v] then
					copy[i] = lookup_table[v]
				else
					copy[i] = table.CopyNoUserdata(v, lookup_table)
				end
			end
		end
	end

	return copy
end
