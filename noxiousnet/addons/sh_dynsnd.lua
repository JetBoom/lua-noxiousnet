NDB.DynamicEmoteSounds = {}

local RootFailure

local function Load(body)
	local trigger, filename
	for i, line in ipairs(string.Explode("\n", body)) do
		if #line > 0 then
			if trigger then
				filename = line:match("([a-zA-Z0-9_%-]+)")
				if filename then
					NDB.DynamicEmoteSounds[trigger] = filename
				end

				trigger = nil
			else
				trigger = line
			end
		end
	end
end

local function RootSuccess(body, length, headers, code)
	if not body or body:sub(1, 8) ~= "DYNEMOTE" then RootFailure("failed to parse") return end

	body = body:sub(9)

	Load(body)

	file.Write("dynemotecache.txt", body)
end

RootFailure = function(err)
	if file.Exists("dynemotecache.txt", "DATA") then
		local cache = file.Read("dynemotecache.txt", "DATA")
		Load(cache)
	else
		print("oh wait we have no backup... dynemote unavailable!")
	end
end

hook.Add("InitPostEntity", "dynemote", function()
	http.Fetch("https://noxiousnet.com/api/dynemote", RootSuccess, RootFailure)
end)
