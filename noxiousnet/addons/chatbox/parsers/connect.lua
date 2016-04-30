PARSER.Description = "<connect=Zombie Survival>"
PARSER.Type = PARSER_STANDALONE_ARGS
PARSER.Pattern = "<connect=(.-)>"

local function ConnectClick(self)
	local address = self.Address
	if address then
		Derma_Query("Connect to "..self.ServerName.."?", "Confirm", "OK", function(btn) MySelf:ConCommand("connect "..address) end, "Cancel", function() end)
	end
end

function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local servername = packages[1]
	if servername then
		local lowerservername = string.lower(servername)
		for _, servertab in pairs(NDB.Servers) do
			--if not servertab[7] and lowerservername == string.lower(servertab[1]) then
			if lowerservername == string.lower(servertab[1]) then
				local newpanel = vgui.Create("DImageButton", panel)
				newpanel:SetImage("noxemoticons/overworld")
				newpanel:SizeToContents()
				newpanel:SetTooltip("Connect to "..servertab[1])
				newpanel.ServerName = servertab[1]
				newpanel.Address = servertab[2]..":"..servertab[3]
				newpanel.DoClick = ConnectClick

				return {Panel = newpanel}
			end
		end
	end
end
