function string.RegularExplode(seperator, str)
	if seperator == "" then
		return string.ToTable(str)
	end

	local tble = {}
	local x = 1

	for ___=1, 10000 do
		local findmin, findmax = string.find(str, seperator, x)

		if findmin then
			table.insert(tble, string.sub(str, x, findmin))
			x = findmax + 1
		else
			table.insert(tble, string.sub(str, x))
			break
		end
	end

	return tble
end

function string.CommaSeparate(num)
	local k
	for ___=1, 10000 do
		num, k = string.gsub(num, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then break end
	end
	return num
end

function string.Replace(str, tofind, toreplace)
	if 0 < #tofind then
		local start = 1
		for ___=1, 10000 do
			local pos = string.find(str, tofind, start, true)

			if not pos then break end

			local left = string.sub(str, 1, pos - 1)
			local right = string.sub(str, pos + #tofind)

			str = left..toreplace..right
			start = pos + #toreplace
		end
	end

	return str
end

function string.ToPercentageMultiplier(multiplier)
	if multiplier > 1 then
		return "-".. (multiplier - 1) * 100 .."%"
	elseif multiplier < 1 then
		return (1 - multiplier) * 100 .."%"
	else
		return "0%"
	end
end

function util.ToMinutesSeconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

    return string.format("%02d:%02d", minutes, math.floor(seconds))
end

function util.ToMinutesSecondsMilliseconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	local milliseconds = math.floor(seconds % 1 * 100)

    return string.format("%02d:%02d.%02d", minutes, math.floor(seconds), milliseconds)
end
