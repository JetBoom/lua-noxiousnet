local CurrentMap = "none"

mapstats = {}

mapstats.Frozen = false

mapstats.Stats = {}

function mapstats.Load()
	if file.Exists(GAMEMODE.FolderName.."_mapstats.txt", "DATA") then
		mapstats.Stats = util.JSONToTable(file.Read(GAMEMODE.FolderName.."_mapstats.txt", "DATA"))
	end

	mapstats.Stats[CurrentMap] = mapstats.Stats[CurrentMap] or {}
end
mapstats.Sync = mapstats.Load

function mapstats.Save()
	file.Write(GAMEMODE.FolderName.."_mapstats.txt", util.TableToJSON(mapstats.Stats))
end

function mapstats.AddStat(statname, amount)
	if statname and amount then
		local cur = mapstats.Stats[CurrentMap][statname]

		if cur == nil then
			mapstats.StoreStat(statname, amount)
		elseif type(cur) == "number" then
			mapstats.StoreStat(statname, cur + amount)
		end
	end
end

function mapstats.GetStat(statname)
	local cur = mapstats.Stats[CurrentMap]
	if cur == nil then return 0 end
	cur = cur[statname]
	if cur == nil then return 0 end

	return cur
end

function mapstats.Pause()
	mapstats.Frozen = true
end

function mapstats.Commit()
	mapstats.Frozen = false
	mapstats.Save()
end

function mapstats.IncrementStat(statname)
	mapstats.AddStat(statname, 1)
end

function mapstats.DecrementStat(statname)
	mapstats.AddStat(statname, -1)
end

function mapstats.RemoveStat(statname, amount)
	mapstats.AddStat(statname, -amount)
end

function mapstats.StoreStat(statname, data)
	if statname and data then
		if not mapstats.Frozen then
			mapstats.Sync()
		end

		mapstats.Stats[CurrentMap][statname] = data

		if not mapstats.Frozen then
			mapstats.Save()
		end
	end
end

hook.Add("InitPostEntity", "mapstats.Initialize", function()
	CurrentMap = string.lower(game.GetMap())

	mapstats.Load()
end)
