local function QUERY_CheckForumsPromotion(query, result, pl)
	if not pl:IsValidAccount() or pl:HasFlag("forumspromotion") or not result[1] then return end

	pl:GiveFlag("forumspromotion")
	pl:AddSilver(30000, true)
	pl:PrintMessage(HUD_PRINTTALK, "<silkicon icon=world> <defstyle color=30,255,30>You have been given 30,000 Silver and a special hat for being active on our forums!")
	pl:UpdateDB()

	mysql_query(
		string.format(
			"UPDATE smf.smf_members SET warning = 1 WHERE id_member = %d LIMIT 1",
			result[1]
		)
	)
end

function NDB.CheckForumsPromotion(pl)
	if not pl:IsValidAccount() or pl:HasFlag("forumspromotion") then return end

	local ip = pl:IPAddressNoPort()
	mysql_query(
		string.format(
			"SELECT id_member FROM smf.smf_members WHERE posts >= 30 AND warning = 0 AND (%d - date_registered) >= 7776000 AND (member_ip = %q OR member_ip2 = %q) LIMIT 1",
			os.time(),
			ip,
			ip
		),
		QUERY_CheckForumsPromotion, pl
	)
end

hook.Add("PostPlayerReady", "NDB.CheckForumsPromotion", function(pl)
	NDB.CheckForumsPromotion(pl)
end)
