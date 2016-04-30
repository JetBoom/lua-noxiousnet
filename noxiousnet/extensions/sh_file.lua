local Cached = {}
Cached["DATA"] = {}
Cached["LUA"] = {}
Cached["MOD"] = {}
Cached["GAME"] = {}
function file.CachedExists(fil, fol)
	local cached = Cached[fol][fil]
	if cached ~= nil then
		return cached
	end

	cached = file.Exists(fil, fol)
	Cached[fol][fil] = cached

	return cached
end
