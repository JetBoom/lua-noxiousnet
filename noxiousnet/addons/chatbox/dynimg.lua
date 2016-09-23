NNChat.DynamicImages = {}

local RootFailure

local function Load(body)
	local filename, fileext, base
	for i, line in ipairs(string.Explode("\n", body)) do
		if i == 1 then
			base = line
		else
			filename, fileext = line:match("([a-zA-Z0-9_%-]-)%.(.+)")
			if filename then
				NNChat.DynamicImages[filename] = base..filename.."."..fileext
			end
		end
	end
end

local function RootSuccess(body, length, headers, code)
	if not body or body:sub(1, 6) ~= "DYNIMG" then RootFailure() return end

	body = body:sub(7)

	Load(body)

	file.Write("dynimgcache.txt", body)
end

RootFailure = function()
	print("dynimg server is down, trying backup")

	if file.Exists("dynimgcache.txt", "DATA") then
		local cache = file.Read("dynimgcache.txt", "DATA")
		Load(cache)
	else
		print("oh wait we have no backup... dynimg unavailable!")
	end
end

hook.Add("InitPostEntity", "dynimg", function()
	file.CreateDir("noxiousnetdynimg")
	http.Fetch("https://noxiousnet.com/api/dynimg?simple=1", RootSuccess, RootFailure)
end)
