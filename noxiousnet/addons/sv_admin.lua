function NDB.LogAction(sAction)
	NDB.LogLine(sAction)
	PrintMessage(HUD_PRINTTALK, sAction)
end
LogAction = NDB.LogAction

concommand.Add("a_slay", function(sender, command, arguments)
	if not sender:IsModerator() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			if pl:Alive() then
				NDB.LogAction(sender:Name().." KILLED "..pl:Name().." <"..pl:SteamID()..">")

				pl:Kill()
			else
				sender:PrintMessage(HUD_PRINTTALK, "<red>They're already dead.</red>")
			end

			break
		end
	end
end)

concommand.Add("a_blowup", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id and pl:Alive() then
			NDB.LogAction(sender:Name().." BLEW UP "..pl:Name().." <"..pl:SteamID()..">")

			local effectdata = EffectData()
				effectdata:SetOrigin(pl:LocalToWorld(pl:OBBCenter()))
			util.Effect("Explosion", effectdata)

			util.BlastDamage(game.GetWorld(), game.GetWorld(), pl:GetPos(), 256, 300)

			return
		end
	end
end)

concommand.Add("a_kick", function(sender, command, arguments)
	if not sender:IsModerator() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	local reason = arguments[2] or "in the ass"

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			NDB.LogAction(sender:Name().." KICKED "..pl:Name().." <"..pl:SteamID().."> because "..reason)

			if gatekeeper then
				gatekeeper.Drop(id, "Kicked: "..reason)
			else
				--pl:Kick(reason)
				pl:SafeKick(reason)
			end
			return
		end
	end
end)

local SLAP_SOUNDS = {"physics/body/body_medium_impact_hard1.wav",
"physics/body/body_medium_impact_hard2.wav",
"physics/body/body_medium_impact_hard3.wav",
"physics/body/body_medium_impact_hard5.wav",
"physics/body/body_medium_impact_hard6.wav",
"physics/body/body_medium_impact_soft5.wav",
"physics/body/body_medium_impact_soft6.wav",
"physics/body/body_medium_impact_soft7.wav"}

concommand.Add("a_slap", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end
	local power = tonumbersafe(arguments[2] or 0)
	if not power then return end
	local dmg = tonumbersafe(arguments[3] or 0)
	if not dmg then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id and pl:Alive() then
			NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> SLAPPED "..pl:Name().." <"..pl:SteamID().."> with "..power.." power and "..dmg.." damage.")

			pl:EmitSound(SLAP_SOUNDS[math.random(#SLAP_SOUNDS)])
			pl:SetLocalVelocity(VectorRand() * power)
			if pl:Health() < dmg then
				pl:Kill()
			else
				pl:TakeDamage(dmg, NULL, NULL)
			end
			return
		end
	end
end)

concommand.Add("a_ignite", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end
	local tim = tonumbersafe(arguments[2] or 0)
	if not tim then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> IGNITED "..pl:Name().." <"..pl:SteamID().."> for "..tim.." seconds.")

			pl:Ignite(tim, 1)
			return
		end
	end
end)

concommand.Add("a_forceurl", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end
	local url = table.concat(arguments, " ", 2)
	if not url then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id and not pl:IsSuperAdmin() then
			NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> FORCED "..pl:Name().." <"..pl:SteamID().."> to go to "..url..".")

			pl:SendLua("ForceURL(\""..url.."\")")
			return
		end
	end
end)

concommand.Add("a_god", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			if tonumbersafe(arguments[2] or 0) == 1 then
				NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> ENABLED GODMODE on "..pl:Name().." <"..pl:SteamID()..">.")
				pl:GodEnable()
			else
				NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> DISABLED GODMODE on "..pl:Name().." <"..pl:SteamID()..">.")
				pl:GodDisable()
			end
			return
		end
	end
end)

concommand.Add("a_freeze", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			if tonumbersafe(arguments[2] or 0) == 1 then
				NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> FROZE "..pl:Name().." <"..pl:SteamID()..">.")
				pl:Freeze(true)
			else
				NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> UNFROZE "..pl:Name().." <"..pl:SteamID()..">.")
				pl:Freeze(false)
			end
			return
		end
	end
end)

concommand.Add("a_invisibility", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			local col = pl:GetColor()
			if tonumbersafe(arguments[2] or 0) == 1 then
				NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> ENABLED INVISIBILITY on "..pl:Name().." <"..pl:SteamID()..">.")
				col.a = 0
			else
				NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> DISABLED INVISIBILITY on "..pl:Name().." <"..pl:SteamID()..">.")
				col.a = 255
			end

			pl:SetColor(col)

			return
		end
	end
end)

concommand.Add("a_bringtome", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> BROUGHT "..pl:Name().." <"..pl:SteamID().."> to them.")
			pl:SetPos(sender:GetPos() + Vector(0,0,73))
			return
		end
	end
end)

concommand.Add("a_teleporttothem", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> TELEPORTED TO "..pl:Name().." <"..pl:SteamID()..">.")
			sender:SetPos(pl:GetPos() + Vector(0,0,73))
			return
		end
	end
end)

concommand.Add("a_teleporttotarget", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	local id = tonumbersafe(arguments[1] or 0)
	if not id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			local pos = sender:GetEyeTrace().HitPos
			NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> TELEPORTED "..pl:Name().." <"..pl:SteamID().."> to their position ("..tostring(pos)..").")
			pl:SetPos(pos)
			return
		end
	end
end)

concommand.Add("a_restartmap", function(sender, command, arguments)
	if not sender:IsAdmin() then return end

	NDB.LogAction("[Admin CMD] "..sender:Name().." <"..sender:SteamID().."> RESTARTED the map.")

	NDB.GlobalSave()

	RunConsoleCommand("changelevel", game.GetMap())
end)

local function UnSpectate(sender)
	if not sender:IsValid() then return end -- CallOnRemove, sender might not be valid by now.

	if IsValid(sender.AdminSpecEnt) then
		sender:SetViewEntity(NULL)
		sender:SendLua("NDB.StopSpectating()")
		sender.AdminSpecEnt:Remove()
		sender.AdminSpecEnt = nil
	end
end

concommand.Add("a_spectate", function(sender, command, arguments)
	if not sender:IsModerator() or sender.AdminSpecEnt then return end

	local id = tonumbersafe(arguments[1] or 0)

	if not id or sender:UserID() == id then return end

	for _, pl in pairs(player.GetAll()) do
		if pl:UserID() == id then
			local ent = ents.Create("prop_dynamic_override")
			if ent:IsValid() then
				ent:SetModel("models/editor/camera.mdl")
				ent:SetColor(Color(0, 0, 0, 0))
				ent:SetRenderMode(RENDERMODE_TRANSALPHA)
				ent:DrawShadow(false)
				ent:SetAngles(pl:EyeAngles())
				ent:SetPos(pl:EyePos() + pl:GetAimVector() * 6)
				ent:SetParent(pl)
				ent:Spawn()
				ent:SetModelScale(0, 0)
				sender:SetViewEntity(ent)
				sender.AdminSpecEnt = ent
				sender:SendLua("NDB.StartSpectating(Entity("..pl:EntIndex().."))")

				ent:CallOnRemove("UnSpectate", function() UnSpectate(sender) end)
			end
		end
	end
end)

concommand.Add("a_unspectate", function(sender, command, arguments)
	if not sender:IsModerator() then return end

	UnSpectate(sender)
end)
