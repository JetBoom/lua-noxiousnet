local function GivePatriotAward(pl)
	if os.date("%m%d") == "0911" and not pl:HasAward("true_patriot") then
		pl:GiveAward("true_patriot")
	end
end

hook.Add("Initialize", "check911date", function()
	if os.date("%m%d") == "0911" then
		hook.Add("PostPlayerReady", "GivePatriotAward", GivePatriotAward)
	end
end)
