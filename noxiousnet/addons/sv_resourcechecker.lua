if true then return end

local added = {}

local old = resource.AddFile
function resource.AddFile(filename)
	if not file.Exists(filename, "GAME") then
		print("Doesn't exist locally: "..filename)
	end

	added[#added + 1] = filename

	old(filename)
end

local old2 = resource.AddSingleFile
function resource.AddSingleFile(filename)
	if not file.Exists(filename, "GAME") then
		print("Doesn't exist locally: "..filename)
	end

	added[#added + 1] = filename

	old2(filename)
end

function CheckMapExists()
	for gamemodename, gamemodetab in pairs(NDB.MapList) do
		for _, maptab in pairs(gamemodetab) do
			local filename = "maps/"..maptab[1]..".bsp"
			if not file.Exists(filename, "GAME") then
				print("Doesn't exist locally: "..filename)
			end
		end
	end
end

function GetDirectory(filename)
	return string.match(filename, "(.+%/)") or "/"
end

function GetFile(filename)
	return string.match(filename, ".+%/(.+)") or ""
end

local basedir = "http://heavy.noxiousnet.com/downloadurl/"

function CheckUnusedMaps()
	http.Fetch(basedir.."maps", function(contents, length)
		contents = string.lower(contents)

		local pointer = 1

		for ___=1, 10000 do
			local st, en, match = string.find(contents, "(.-)%.bsp%.bz2", pointer)
			if match then
				pointer = en

				local found = false
				for gamemodename, lis in pairs(NDB.MapList) do
					for i, tab in ipairs(lis) do
						if string.lower(tab[1]) == match then
							found = true
							break
						end
					end
					if found then break end
				end
				if not found then
					MsgN(match)
				end
			else
				break
			end
		end
	end)
end

function RemoteCheckDirectory(dir)
	dir = dir or ""
	http.Fetch(basedir..dir, function(contents, length)
		contents = string.lower(contents)
		for _, filename in ipairs(added) do
			filename = string.lower(filename)
			if GetDirectory(filename) == dir then
				if not string.find(contents, GetFile(filename)..".bz2") then
					print("Doesn't exist remotely: "..filename)
				end
			end
		end
	end)
end

local addedmaps
function RemoteCheckAllDirectories()
	if not addedmaps then
		addedmaps = true

		for gamemodename, gamemodetab in pairs(NDB.MapList) do
			for _, maptab in pairs(gamemodetab) do
				added[#added + 1] = "maps/"..maptab[1]..".bsp"
			end
		end
	end

	local tocheck = {}
	for _, filename in pairs(added) do
		tocheck[GetDirectory(filename)] = true
	end

	local i = 0
	for directory in pairs(tocheck) do
		timer.SimpleEx(i, RemoteCheckDirectory, directory)
		i = i + 0.5
	end
end
