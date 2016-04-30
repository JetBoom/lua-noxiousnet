PARSER.Description = "<info>View my profile!</info>"
PARSER.Type = PARSER_ENCLOSE
PARSER.Pattern = "<info>(.-)</info>"

local function profileopen(self, mousecode)
	if mousecode == MOUSE_LEFT and not (self.Menu and self.Menu:IsValid()) then
		local player = self.Player
		if player:IsValid() then
			self.Menu = NDB.GeneralPlayerMenu(player, true)
		end
	end
end
function PARSER:Parse(entid, text, defaultcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packages)
	local result = NNChat.EasyLineWrap(panel, packages[1], defaultfont, defaultcolor, x, maxwidth)

	if result.Panels then
		local ent = Entity(entid)
		if ent:IsValid() and ent:IsPlayer() then
			for i, pnl in pairs(result.Panels) do
				pnl:SetMouseInputEnabled(true)
				pnl:SetTooltip("Click for more options")
				pnl.Player = ent
				pnl.OnMousePressed = profileopen
			end
		end
	end

	return result
end
