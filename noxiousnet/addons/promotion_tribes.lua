--[[hook.Add("PostPlayerReady", "TribesPlayerReady", function(pl)
	if rawio then
		local filename = "C:/dynamix/tribes/temp/silver "..string.Explode(":", string.gsub(pl:IPAddress(), "%.", "_"))[1]..".cs"
		local data = rawio.readfile(filename)
		if data and #data > 0 then
			local silver = tonumber(string.match(data, "= %\"(%d+)%\"%;"))
			if silver and silver > 0 then
				silver = math.ceil(silver)
				rawio.writefile(filename, string.Replace(data, "= \""..silver.."\";", "= \"0\";"))

				--pl:PrintMessage(HUD_PRINTTALK, "You've been given "..silver.." Silver from your adventures on Tribes RPG.")
				PrintMessage(HUD_PRINTTALK, "<lg>"..pl:Name().."</lg> has been given "..silver.." Silver from their adventures on Tribes RPG.")
				pl:AddSilver(silver, true)
				pl:UpdateDB()
			end
		end
	end
end)
]]
