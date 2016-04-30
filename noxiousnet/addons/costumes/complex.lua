local c

c = Costume("clownshoes")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_junk/Shoe001a.mdl", Vector(5, 3.5, -2), Angle(0, 330, 90), "ValveBiped.Bip01_L_Foot", Vector(2, 2, 1), "models/debug/debugwhite", Color(255, 30, 0, 255))
c:AddModel("models/props_junk/MetalBucket02a.mdl", Vector(-3, -1.5, -2.5), Angle(0, 0, 180), nil, Vector(0.3, 0.3, 0.2), "models/debug/debugwhite", Color(255, 255, 0, 255), 1)
c:AddModel("models/props_junk/Rock001a.mdl", Vector(11, -2, -1), Angle(0, 0, 0), nil, 0.5, "models/debug/debugwhite", Color(255, 0, 255, 255), 1)
c:AddModel("models/props_junk/Shoe001a.mdl", Vector(5, 3.5, -2), Angle(0, 330, 90), "ValveBiped.Bip01_R_Foot", Vector(2, 2, 1), "models/debug/debugwhite", Color(255, 30, 0, 255))
c:AddModel("models/props_junk/MetalBucket02a.mdl", Vector(-3, -1.5, -2.5), Angle(0, 0, 180), nil, Vector(0.3, 0.3, 0.2), "models/debug/debugwhite", Color(255, 255, 0, 255), 4)
c:AddModel("models/props_junk/Rock001a.mdl", Vector(11, -2, -1), Angle(0, 0, 0), nil, 0.5, "models/debug/debugwhite", Color(255, 0, 255, 255), 4)
if CLIENT then
	local function PlayerFootstep(pl, pos, ifoot, snd, vol)
		if pl._clownshoes then
			if not GAMEMODE.PlayerCanUseAnnoyingItems or GAMEMODE:PlayerCanUseAnnoyingItems(pl) then
				--pl:EmitSound("ambient/creatures/teddy.wav", vol * 50 + 50, ifoot == 0 and math.Rand(200, 210) or math.Rand(185, 195))
				pl:EmitSound("noxiousnet/clownstep"..(ifoot == 0 and "1" or "2")..".ogg", vol * 50 + 50, math.Rand(96, 104))
			end
			return true
		end
	end

	function c:Initialize(owner)
		owner._clownshoes = true
		hook.Add("PlayerFootstep", "clownshoesPlayerFootstep", PlayerFootstep)
	end

	function c:OnRemove(owner)
		owner._clownshoes = nil
		for _, pl in pairs(player.GetAll()) do
			if pl._clownshoes then return end
		end
		hook.Add("PlayerFootstep", "clownshoesPlayerFootstep")
	end
end

c = Costume("searchlight")
c:SetSlots(COSTUMESLOT_HEAD)
c:AddModel("models/props_wasteland/light_spotlight01_lamp.mdl", Vector(4.5, 1.25, 0), Angle(0, 270, 90), nil, 0.6)
c:AddColorOptions()
c.Author = "Benjy"
c.AuthorID = "STEAM_0:0:25307180"
if CLIENT then
	function c:PreDraw(owner, entities)
		local ent = entities[1]
		if ent and ent:IsValid() then
			ent:SetSkin(owner:FlashlightIsOn() and 0 or 1)
		end
	end
end

c = Costume("perchedcrow")
c:SetSlots(COSTUMESLOT_BACK)
c:AddModel("models/crow.mdl", Vector(2, -2, -6), Angle(0, 90, 90), "ValveBiped.Bip01_Spine4", 0.75)
c:AddColorOptions()
c:AddOption(COSTUMEOPTION_MATERIAL, nil, nil, {0, 2})
c:AddOption(COSTUMEOPTION_SCALE, 1, 1.5)
if CLIENT then
	function c:PreDraw(owner, entities)
		local ent = entities[1]
		if ent and ent:IsValid() then
			ent:SetCycle((CurTime() * 0.5) % 1)
			ent:SetSequence(ent:LookupSequence("Idle01"))
		end
	end
end

c = Costume("mechanicaleye")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_combine/combine_mine01.mdl", Vector(3, 4, 1.35), Angle(0, 0, 90), nil, 0.05)
c:AddColorOptions()
if CLIENT then
	local prev = 0

	function c:Initialize(owner)
		owner._mecheyedir = 0
		owner._mecheyerot = 0
		owner._mecheyenextdirchange = 0
		owner._mecheyeflashstarttime = 0
	end

	function c:PreDraw(owner, entities)
		prev = self.Elements[1].Angles.pitch

		if owner._mecheyedir ~= 0 then
			owner._mecheyerot = owner._mecheyerot + FrameTime() * owner._mecheyedir * 180
		end

		if owner._mecheyenextdirchange <= CurTime() then
			owner._mecheyenextdirchange = CurTime() + math.Rand(0.25, 1.5)
			owner._mecheyedir = math.random(0, 2) == 0 and math.random(-2, 2) or 0
		end

		self.Elements[1].Angles.pitch = owner._mecheyerot
	end

	local matGlow = Material("sprites/glow04_noz")
	local colGlow = Color(255, 20, 20, 255)
	function c:PostDraw(owner, entities)
		local ent = entities[1]
		if not ent or not ent:IsValid() then return end

		local a = render.GetBlend() * 255
		if a < 30 then return end

		local col = ent:GetColor()
		if col.r == 255 and col.g == 255 and col.b == 255 then
			col.g = 20
			col.b = 20
		end

		colGlow.r = col.r
		colGlow.g = col.g
		colGlow.b = col.b
		colGlow.a = a

		local pos = ent:GetPos() + ent:GetUp() * 0.65

		render.SetMaterial(matGlow)
		render.DrawSprite(pos, 1, 1, colGlow)

		local starttime = owner._mecheyeflashstarttime
		local curtime = CurTime()
		if curtime >= starttime then
			local endtime = starttime + 0.1
			if curtime <= endtime then
				local scale = (curtime - starttime) * 10

				colGlow.a = a * scale

				render.SetMaterial(matGlow)
				local size = (scale * 2) ^ 3
				render.DrawSprite(pos, size, size, colGlow)
			else
				owner._mecheyeflashstarttime = curtime + math.Rand(5, 10)
			end
		end

		self.Elements[1].Angles.pitch = prev
	end
end

c = Costume("smileybox")
c:SetSlots(COSTUMESLOT_HEAD)
c:AddModel("models/props_junk/wood_crate001a.mdl", Vector(6, 0, 0), Angle(180, 90, 90), nil, 0.4)
c:AddColorOptions()
if CLIENT then
	local matEye = CreateMaterial("smileybox_eye", "UnlitGeneric", {["$basetexture"] = "Decals/eye", ["$vertexcolor"] = "1", ["$vertexalpha"] = "1"})
	local matSmile = CreateMaterial("smileybox_smile", "UnlitGeneric", {["$basetexture"] = "Decals/smile", ["$vertexcolor"] = "1", ["$vertexalpha"] = "1"})
	local colFace = Color(255, 255, 255, 255)
	function c:PostDraw(owner, entities)
		local ent = entities[1]
		if not ent or not ent:IsValid() then return end

		colFace.a = render.GetBlend() * 255

		local maxs = ent:OBBMaxs()
		local ang = ent:GetAngles()
		local forward = ang:Forward()
		local up = ang:Up()
		local right = ang:Right()

		local facepos = ent:GetPos() + forward * 8.1 + up * 3

		render.SetMaterial(matEye)
		render.DrawQuadEasy(facepos + right * 4, forward, 6, 6, colFace)
		render.DrawQuadEasy(facepos + right * -4, forward, 6, 6, colFace)

		render.SetMaterial(matSmile)
		local frac = math.min(math.max(owner:Health(), 0), 100) * 0.01
		if 0.5 < frac then
			render.DrawQuadEasy(facepos + up * -6, forward, 8, math.max(0.1, frac) * 8, colFace, 180)
		else
			render.DrawQuadEasy(facepos + up * -6, forward, 8, math.max(0.1, 1 - frac) * 8, colFace)
		end
	end
end

c = Costume("annoying_radio")
c:SetSlots(COSTUMESLOT_HEAD)
c:AddModel("models/props_lab/citizenradio.mdl", Vector(13, 0, 0), Angle(0, 90, 270), "ValveBiped.Bip01_L_Hand", 0.5)
c:AddColorOptions()
c:AddOption(COSTUMEOPTION_ANNOYINGRADIOSTATION, 0, 9)
if CLIENT then
	function c:Think(owner)
		if not owner:IsValid() then return end

		local ent = self:GetFirstEntity(owner)
		if not ent or not ent:IsValid() then return end

		if ent.AmbientSound then
			if owner:GetObserverMode() == OBS_MODE_NONE and (not GAMEMODE.PlayerCanUseAnnoyingItems or GAMEMODE:PlayerCanUseAnnoyingItems(owner)) then
				ent.AmbientSound:PlayEx(0.25, 100 + math.sin(RealTime()))
			else
				ent.AmbientSound:Stop()
			end
		else
			local soundname
			if ent.Station == 1 then
				soundname = "ambient/music/dustmusic1.wav"
			elseif ent.Station == 2 then
				soundname = "ambient/music/dustmusic2.wav"
			elseif ent.Station == 3 then
				soundname = "ambient/music/dustmusic3.wav"
			elseif ent.Station == 4 then
				soundname = "ambient/music/piano1.wav"
			elseif ent.Station == 5 then
				soundname = "ambient/music/piano2.wav"
			elseif ent.Station == 6 then
				soundname = "ambient/music/cubanmusic1.wav"
			elseif ent.Station == 7 then
				soundname = "ambient/music/bongo.wav"
			elseif ent.Station == 8 then
				soundname = "ambient/music/flamenco.wav"
			elseif ent.Station == 9 then
				soundname = "ambient/music/latin.wav"
			else
				soundname = "ambient/music/looping_radio_mix.wav"
			end

			if not file.CachedExists("sound/"..soundname, "GAME") then
				soundname = "test/temp/soundscape_test/tv_music.wav"
			end

			ent.AmbientSound = CreateSound(owner, soundname)
		end
	end

	function c:OnRemove(owner)
		local ent = self:GetFirstEntity(owner)
		if ent and ent:IsValid() and ent.AmbientSound then
			ent.AmbientSound:Stop()
		end
	end
end

c = Costume("staticaura")
c:SetSlots(COSTUMESLOT_BODY)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
if CLIENT then
	function c:Initialize(owner)
		owner._staticauranextrefresh = 0
	end

	local matBeam = Material("trails/electric")
	local matGlow = Material("effects/yellowflare")
	local colOutter = Color(30, 255, 255, 255)
	local colInner = Color(255, 255, 255, 255)
	function c:PreDraw(owner, elements)
		local segments = owner._staticaurasegments
		if segments then
			local numsegments = #segments

			colOutter.a = render.GetBlend() * 127.5
			colInner.a = colOutter.a

			local rate = FrameTime() * 10
			for i, segment in pairs(segments) do
				if segment then
					segments[i] = segment + rate * VectorRand():GetNormalized()
				end
			end

			local scroll = RealTime() * 4

			render.SetMaterial(matBeam)
			render.StartBeam(numsegments)
			for i, segment in ipairs(segments) do
				render.AddBeam(owner:LocalToWorld(segment), 4 - i * 0.5, i + scroll, colOutter)
			end
			render.EndBeam()
			render.StartBeam(numsegments)
			for i, segment in ipairs(segments) do
				render.AddBeam(owner:LocalToWorld(segment), 2 - i * 0.25, i + scroll, colInner)
			end
			render.EndBeam()

			local spritepos = owner:LocalToWorld(segments[1])
			render.SetMaterial(matGlow)
			render.DrawSprite(spritepos, 8, 8, colOutter)
			render.DrawSprite(spritepos, 4, 4, colInner)
		end

		return true
	end

	function c:Think(owner)
		if CurTime() < owner._staticauranextrefresh then return end
		owner._staticauranextrefresh = CurTime() + math.Rand(0.25, 0.5)

		if math.random(3) == 1 then
			local mins = owner:OBBMins()
			local maxs = owner:OBBMaxs()
			local pos = Vector(math.Rand(mins.x, maxs.x), math.Rand(mins.y, maxs.y), math.Rand(mins.z, maxs.z))
			local segments = {pos}
			local dir = VectorRand():Angle()
			for i=1, 8 do
				dir:RotateAroundAxis(dir:Right(), math.Rand(-15, 15))
				dir:RotateAroundAxis(dir:Up(), math.Rand(-15, 15))
				pos = pos + dir:Forward() * math.Rand(1.5, 3)
				segments[#segments + 1] = pos
			end

			owner._staticaurasegments = segments
		else
			owner._staticaurasegments = nil
		end
	end
end

c = Costume("casterhands")
c:SetSlots(COSTUMESLOT_BODY)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
if CLIENT then
	local matGlow = Material("sprites/glow04_noz")
	local matGlow2 = Material("effects/yellowflare")
	local col1 = Color(10, 80, 255, 255)
	local col2 = Color(255, 180, 20, 255)
	local colWhite = Color(255, 255, 255, 255)
	function c:PreDraw(owner, elements)
		local a = render.GetBlend() * 255
		if a < 24 then return true end

		local col = self:GetColorOption(owner)
		if col.r == 255 and col.g == 255 and col.b == 255 then
			col1.r = 10
			col1.g = 80
			col1.b = 255
			col2.r = 255
			col2.g = 180
			col2.b = 20
		else
			col1.r = col.r
			col1.g = col.g
			col1.b = col.b
			col2.r = 255 - col.r
			col2.g = 255 - col.g
			col2.b = 255 - col.b
		end

		col1.a = a
		col2.a = a
		colWhite.a = a

		render.SetMaterial(matGlow)
		local iRHBone = owner:LookupBone("ValveBiped.Bip01_R_Hand")
		local iLHBone = owner:LookupBone("ValveBiped.Bip01_L_Hand")
		if not iRHBone or not iLHBone or iRHBone == 0 or iLHBone == 0 then return true end

		local RBonePos, RBoneAng = owner:GetBonePositionMatrixed(iRHBone)
		local LBonePos, LBoneAng = owner:GetBonePositionMatrixed(iLHBone)
		if not RBonePos or not LBonePos then return true end

		render.DrawSprite(RBonePos, 16 + math.Rand(6, 10), 16 + math.Rand(6, 10), col1)
		render.DrawSprite(LBonePos, 16 + math.Rand(6, 10), 16 + math.Rand(6, 10), col2)

		local rt = RealTime() * 520
		render.SetMaterial(matGlow2)
		RBoneAng:RotateAroundAxis(RBoneAng:Right(), rt)
		render.DrawSprite(RBonePos + RBoneAng:Up() * 5, 6, 6, colWhite)
		LBoneAng:RotateAroundAxis(LBoneAng:Right(), rt)
		render.DrawSprite(LBonePos + LBoneAng:Up() * 5, 6, 6, colWhite)

		return true
	end
end

c = Costume("angelichalo")
c:SetSlots(COSTUMESLOT_HEAD)
c:AddModel("models/props_phx/construct/metal_plate_pipe.mdl", Vector(10, -2, 2.5), Angle(90, 25, 0), "ValveBiped.Bip01_Head1", Vector(0.1, 0.1, 0.015), "models/shiny")
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
if CLIENT then
	function c:PreDraw(owner, elements)
		local element = self.Elements[1]
		if element then
			local rot = CurTime() * 7
			element.Angles.yaw = 25 + math.sin(rot) * 12
			element.Angles.pitch = 90 + math.cos(rot) * 12
		end
	end
end

c = Costume("voicechanger")
c:SetSlots(COSTUMESLOT_OTHER)

c = Costume("flamingskull")
c:SetSlots(COSTUMESLOT_HEAD)
c:AddModel("models/Gibs/HGIBS.mdl", Vector(3.05, 0.5, 0), Angle(180, 90, 90), nil, 1.5)
c:AddColorOptions()
if CLIENT then
	function c:PostDraw(owner, elements)
		local ent = elements[1]
		if ent and ent:IsValid() then
			local pos = ent:GetPos()
			local a = render.GetBlend() * 255
			local col = self:GetColorOption(owner)

			local emitter = ParticleEmitter(pos)
			emitter:SetNearClip(24, 32)

			for i=1, 2 do
				local vec = VectorRand()
				vec.z = math.abs(vec.z)
				vec = vec:GetNormalized() * math.Rand(8, 32)

				local particle = emitter:Add("noxctf/sprite_flame", pos)
				particle:SetVelocity(vec)
				particle:SetDieTime(math.Rand(0.25, 0.6))
				particle:SetStartAlpha(0.6 * a)
				particle:SetEndAlpha(0)
				particle:SetStartSize(math.Rand(2, 6))
				particle:SetEndSize(0)
				particle:SetRoll(math.Rand(0, 360))
				particle:SetRollDelta(math.Rand(-15, 15))
				particle:SetColor(col.r, col.g, col.b)
			end

			emitter:Finish() emitter = nil collectgarbage("step", 64)
		end
	end
end

local eyespredraw
c = Costume("glowingeyes")
c:SetSlots(COSTUMESLOT_FACE)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
if CLIENT then
	local matGlow = Material("sprites/glow04_noz")
	function c:PreDraw(owner, elements)
		local a = render.GetBlend() * 255
		if a <= 1 then return end

		local col = self:GetColorOption(owner)
		col.a = a

		local pos, ang = self:GetPosAng(owner, Vector(2.5, 5, 0), Angle(0, 0, 90), "ValveBiped.Bip01_Head1")

		local right = ang:Right() * 1.5
		local forward = ang:Forward()

		render.SetMaterial(matGlow)
		render.DrawSprite(pos + right + forward, 3, 3, col)
		render.DrawSprite(pos - right + forward, 3, 3, col)

		return true
	end
	eyespredraw = c.PreDraw
end

c = Costume("glowingeyescyan")
c:SetSlots(COSTUMESLOT_FACE)
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
c:AddForcedOption(COSTUMEOPTION_RED, 0)
c:AddForcedOption(COSTUMEOPTION_GREEN, 255)
c:AddForcedOption(COSTUMEOPTION_BLUE, 255)
c.PreDraw = eyespredraw

c = Costume("glowingeyesred")
c:SetSlots(COSTUMESLOT_FACE)
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
c:AddForcedOption(COSTUMEOPTION_RED, 255)
c:AddForcedOption(COSTUMEOPTION_GREEN, 10)
c:AddForcedOption(COSTUMEOPTION_BLUE, 10)
c.PreDraw = eyespredraw

c = Costume("glowingeyespurple")
c:SetSlots(COSTUMESLOT_FACE)
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
c:AddForcedOption(COSTUMEOPTION_RED, 220)
c:AddForcedOption(COSTUMEOPTION_GREEN, 0)
c:AddForcedOption(COSTUMEOPTION_BLUE, 255)
c.PreDraw = eyespredraw

c = Costume("glowingeyesgreen")
c:SetSlots(COSTUMESLOT_FACE)
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
c:AddForcedOption(COSTUMEOPTION_RED, 30)
c:AddForcedOption(COSTUMEOPTION_GREEN, 255)
c:AddForcedOption(COSTUMEOPTION_BLUE, 30)
c.PreDraw = eyespredraw

c = Costume("radianteyes")
c:SetSlots(COSTUMESLOT_FACE)
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
if CLIENT then
	local matGlow = Material("sprites/glow04_noz")
	local colGlow = Color(255, 255, 255)
	local colGlow2 = Color(255, 255, 255)
	function c:PreDraw(owner, elements)
		local a = render.GetBlend() * 255
		if a <= 1 then return end

		local pos, ang = self:GetPosAng(owner, Vector(2.5, 5, 0), Angle(0, 0, 90), "ValveBiped.Bip01_Head1")

		local time = CurTime()
		colGlow.r = 200 + math.sin((time + 0.2) * 3) * 55
		colGlow.g = 200 + math.sin((time + 0.4) * 4) * 55
		colGlow.b = 200 + math.sin((time + 0.6) * 5) * 55
		colGlow.a = a
		colGlow2.r = 200 + math.sin((time + 0.8) * 6) * 55
		colGlow2.g = 200 + math.sin((time + 1) * 7) * 55
		colGlow2.b = 200 + math.sin((time + 1.2) * 8) * 55
		colGlow2.a = a

		local right = ang:Right() * 1.5
		local forward = ang:Forward()

		render.SetMaterial(matGlow)
		render.DrawSprite(pos + right + forward, 3, 3, colGlow)
		render.DrawSprite(pos - right + forward, 3, 3, colGlow)

		return true
	end
end

c = Costume("seg")
c:SetSlots(COSTUMESLOT_FACE)
c:AddColorOptions()
if CLIENT then
	local matSmile = CreateMaterial("seg_smile", "UnlitGeneric", {["$basetexture"] = "Decals/smile", ["$vertexcolor"] = "1", ["$vertexalpha"] = "1"})
	function c:PreDraw(owner, elements)
		local a = render.GetBlend() * 255
		if a <= 1 then return end

		local col = self:GetColorOption(owner)
		col.a = a

		local pos, ang = self:GetPosAng(owner, Vector(1.5, 6, 0), Angle(0, 90, 0), "ValveBiped.Bip01_Head1")

		local fwd = ang:Forward()

		render.SetMaterial(matSmile)
		render.DrawQuadEasy(pos, fwd, 4, 4, col, 180)
		render.DrawQuadEasy(pos, fwd * -1, 4, 4, col, 180)

		return true
	end
end

c = Costume("babyface")
c:SetSlots(COSTUMESLOT_HEAD)
c:AddModel("models/props_c17/doll01.mdl", Vector(-10, -3, 0), Angle(180, 90, 90), nil, Vector(3, 3, 3))
c:AddColorOptions()
if CLIENT then
	function c:PreDraw(owner, elements)
		if not render.SupportsVertexShaders_2_0() then return end

		local element = self.Elements[1]
		local pos, ang = self:GetPosAng(owner, element.Offset, element.Angles, element.BoneName)

		local normal = ang:Up()
		render.EnableClipping(true)
		render.PushCustomClipPlane(normal, normal:Dot(pos + normal * 8))
	end

	function c:PostDraw(owner, elements)
		if not render.SupportsVertexShaders_2_0() then return end

		render.PopCustomClipPlane()
		render.EnableClipping(false)
	end
end

c = Costume("turtlemask")
c:SetSlots(COSTUMESLOT_HEAD)
c:AddModel("models/props/de_tides/vending_turtle.mdl", Vector(-5, -13, 0), Angle(90, 0, 180), nil, 2.5)
c:AddColorOptions()
if CLIENT then
	function c:PreDraw(owner, elements)
		if not render.SupportsVertexShaders_2_0() then return end

		local element = self.Elements[1]
		local pos, ang = self:GetPosAng(owner, element.Offset, element.Angles, element.BoneName)

		local normal = ang:Right() * -1
		local normal2 = ang:Forward()

		render.EnableClipping(true)
		render.PushCustomClipPlane(normal, normal:Dot(pos + normal * 7))
		render.PushCustomClipPlane(normal2, normal2:Dot(pos - normal2 * 8.85))
		normal2 = normal2 * -1
		render.PushCustomClipPlane(normal2, normal2:Dot(pos - normal2 * 8.85))
	end

	function c:PostDraw(owner, elements)
		if not render.SupportsVertexShaders_2_0() then return end

		render.PopCustomClipPlane()
		render.PopCustomClipPlane()
		render.PopCustomClipPlane()
		render.EnableClipping(false)
	end
end

c = Costume("gnomemask")
c:SetSlots(COSTUMESLOT_HEAD)
c:AddModel("models/props_junk/gnome.mdl", Vector(-27, 2, 0), Angle(0, 270, 270), nil, 1.75)
c:AddColorOptions()
if CLIENT then
	function c:PreDraw(owner, elements)
		if not render.SupportsVertexShaders_2_0() then return end

		local element = self.Elements[1]
		local pos, ang = self:GetPosAng(owner, element.Offset, element.Angles, element.BoneName)

		local normal = ang:Forward()
		local normal2 = ang:Up()

		render.EnableClipping(true)
		render.PushCustomClipPlane(normal, normal:Dot(pos))
		render.PushCustomClipPlane(normal2, normal2:Dot(pos + normal2 * 15))
	end

	function c:PostDraw(owner, elements)
		if not render.SupportsVertexShaders_2_0() then return end

		render.PopCustomClipPlane()
		render.PopCustomClipPlane()
		render.EnableClipping(false)
	end
end

c = Costume("cigar")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_docks/dock01_pole01a_128.mdl", Vector(0.5, 6.5, -1.25), Angle(0, 0, 110), nil, Vector(0.05, 0.05, 0.0375))
if CLIENT then
	local vecGrav = Vector(0, 0, 40)
	function c:PostDraw(owner, elements)
		if CurTime() >= (owner._cigarendemit or 0) then return end

		local ent = self:GetFirstEntity(owner)
		if ent and ent:IsValid() then
			local element = self.Elements[1]
			local pos, ang = self:GetPosAng(owner, element.Offset, element.Angles, element.BoneName)
			local dir = ang:Up()
			pos = pos + dir * 2.5

			local emitter = ParticleEmitter(pos)
			emitter:SetNearClip(24, 32)

			local particle = emitter:Add("particles/smokey", pos)
			particle:SetVelocity(owner:GetVelocity() + dir * 100 + VectorRand():GetNormalized() * math.Rand(8, 20))
			particle:SetDieTime(math.Rand(2, 3))
			particle:SetStartAlpha(64 * render.GetBlend())
			particle:SetEndAlpha(0)
			particle:SetStartSize(1)
			particle:SetEndSize(math.Rand(3, 4.5))
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-5, 5))
			particle:SetGravity(vecGrav)
			particle:SetColor(180, 170, 170)
			particle:SetAirResistance(180)

			emitter:Finish() emitter = nil collectgarbage("step", 64)
		end
	end

	function c:Think(owner)
		if owner:IsValid() and owner:Frags() ~= owner._lastcigarfrags then
			owner._lastcigarfrags = owner:Frags()
			owner._cigarendemit = CurTime() + 0.1
		end
	end
end

local bumper = Costume("bumpersticker")
bumper:SetSlots(COSTUMESLOT_BACK)
bumper:AddColorOptions()
bumper:AddForcedOption(COSTUMEOPTION_TITLESTRING, "Untitled")
if CLIENT then
	local colBG = Color(0, 0, 0, 255)
	function bumper:PreDraw(owner, elements)
		local pos, ang = self:GetPosAng(owner, Vector(0, 0, -8), Angle(180, 0, 0), "ValveBiped.Bip01_Pelvis")

		local a = render.GetBlend() * 255
		local col = self:GetColorOption(owner)
		local title = self:GetOption(owner, COSTUMEOPTION_TITLESTRING)
		col.a = a * (0.5 + math.max(math.sin(CurTime() * 4), 0) * 0.5)
		colBG.a = a * 0.2

		surface.SetFont("ASSFONT")
		local texw, texh = surface.GetTextSize(title)
		if texw then
			local boxw = texw + 16
			local boxh = texh + 8
			cam.Start3D2D(pos, ang, 0.04)
				draw.RoundedBox(8, boxw * -0.5, 0, boxw, boxh, colBG)
				draw.SimpleText(title, "ASSFONT", 0, boxh * 0.5 - texh * 0.5, col, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end

		return true
	end
end

c = Costume("asstitle1")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "AS:S MAN")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle2")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "YOU GOT DINKIED")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle3")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "DEFUSE THIS")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle4")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "BOMB THE LASANGA")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle5")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "SHANK MASTER")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle6")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "BERSERK")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle7")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "EYES ON YOU")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle8")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "RAIL MAN")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle9")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "AS:S PIRATE")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle10")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "SMART ASS")
c.PreDraw = bumper.PreDraw

c = Costume("asstitle11")
c:SetSlots(COSTUMESLOT_BACK)
c:AddColorOptions()
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "BAT MAN")
c.PreDraw = bumper.PreDraw

c = Costume("holidaytitle1")
c:SetSlots(COSTUMESLOT_BACK)
c:AddForcedOption(COSTUMEOPTION_RED, 255)
c:AddForcedOption(COSTUMEOPTION_GREEN, 0)
c:AddForcedOption(COSTUMEOPTION_BLUE, 0)
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "NAUGHTY")
c.PreDraw = bumper.PreDraw

c = Costume("holidaytitle2")
c:SetSlots(COSTUMESLOT_BACK)
c:AddForcedOption(COSTUMEOPTION_RED, 10)
c:AddForcedOption(COSTUMEOPTION_GREEN, 255)
c:AddForcedOption(COSTUMEOPTION_BLUE, 10)
c:AddForcedOption(COSTUMEOPTION_TITLESTRING, "NICE")
c.PreDraw = bumper.PreDraw

c = Costume("title3d")
c:SetSlots(COSTUMESLOT_NONE)
c:AddOption(COSTUMEOPTION_TITLESTRING)
if CLIENT then
	local col = Color(255, 255, 255, 255)
	local colBG = Color(0, 0, 0, 255)
	function c:PreDraw(owner, elements)
		local title = self:GetOption(owner, COSTUMEOPTION_TITLESTRING)
		if not title or #title == 0 then return true end

		local pos, ang = self:GetPosAng(owner, Vector(0, -9, -9), Angle(180, 0, 0), "ValveBiped.Bip01_Pelvis")

		local a = render.GetBlend() * 255
		col.a = a
		colBG.a = a * 0.2

		surface.SetFont("title3dfont")
		local texw, texh = surface.GetTextSize(title)
		if texw then
			local boxw = texw + 16
			local boxh = texh + 8
			cam.Start3D2D(pos, ang, math.Clamp((256 / math.max(texw, 1)) * 0.075, 0.02, 0.15))
				draw.RoundedBox(8, boxw * -0.5, 0, boxw, boxh, colBG)
				draw.SimpleText(title, "title3dfont", 0, boxh * 0.5 - texh * 0.5, col, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end

		return true
	end
end

c = Costume("magichorn")
c:AddModel("models/props_combine/portalball.mdl", Vector(0, 0, 0), Angle(0, 270, 0), nil, Vector(0.15, 0.05, 0.05))
c:AddOption(COSTUMEOPTION_MAGICHORNINSTRUMENT, 0, 1)
c:AddColorOptions()
if SERVER then
	function c:Initialize(owner)
		owner._OldDuckSpeed = owner:GetDuckSpeed()
		owner._OldUnDuckSpeed = owner:GetUnDuckSpeed()
		owner:SetDuckSpeed(0)
		owner:SetUnDuckSpeed(0)
	end

	function c:OnRemove(owner)
		if owner._OldDuckSpeed then
			owner:SetDuckSpeed(owner._OldDuckSpeed)
			owner._OldDuckSpeed = nil
		end
		if owner._OldUnDuckSpeed then
			owner:SetUnDuckSpeed(owner._OldUnDuckSpeed)
			owner._OldUnDuckSpeed = nil
		end
	end
end
if CLIENT then
	function c:PostDraw(owner, elements)
		if owner:Crouching() and owner:Alive() and CurTime() >= (owner._nextmagichornemit or 0) then
			owner._nextmagichornemit = CurTime() + 0.05

			local pitchalter = (math.Clamp(owner:GetAimVector().z, -1, 1) + 1) * 0.5
			local r, g, b = pitchalter * 255, 30, (1 - pitchalter) * 255
			local ent = self:GetFirstEntity(owner)
			if ent and ent:IsValid() then
				local element = self.Elements[1]
				local pos, ang = self:GetPosAng(owner, element.Offset, element.Angles, element.BoneName)

				local emitter = ParticleEmitter(pos)
				emitter:SetNearClip(16, 24)

				local particle = emitter:Add("sprites/glow04_noz", pos)
				particle:SetDieTime(math.Rand(1, 2))
				particle:SetStartAlpha(255)
				particle:SetStartSize(2)
				particle:SetColor(r, g, b)
				particle:SetVelocity((pitchalter * 2 + 1) * 64 * (owner:GetAimVector() * (2 + pitchalter * 4) + VectorRand():GetNormalized()):GetNormalized())
				particle:SetAirResistance(16)
				particle:SetRollDelta(math.Rand(-30, 30))

				emitter:Finish() emitter = nil collectgarbage("step", 64)
			end
		end
	end

	function c:OnRemove(owner)
		local ent = self:GetFirstEntity(owner)
		if ent and ent:IsValid() then
			if ent.AmbientSound then
				ent.AmbientSound:Stop()
			end
		end
	end

	function c:Think(owner)
		local ent = self:GetFirstEntity(owner)
		if not ent or not ent:IsValid() then return end

		local playing = false
		if ent.AmbientSound then
			if owner:Alive() and owner:GetObserverMode() == OBS_MODE_NONE and owner:Crouching() and (not GAMEMODE.PlayerCanUseAnnoyingItems or GAMEMODE:PlayerCanUseAnnoyingItems(owner)) then
				playing = true
				ent.AmbientSound:PlayEx(0.25, 130 + math.Clamp(owner:GetAimVector().z, -1, 1) * 100)
			else
				ent.AmbientSound:Stop()
			end
		else
			local instrument = self:GetOption(owner, COSTUMEOPTION_MAGICHORNINSTRUMENT)
			local soundname = instrument == 1 and "synth/saw.wav" or instrument == 2 and "synth/sine.wav" or "synth/square.wav"

			if not file.CachedExists("sound/"..soundname, "GAME") then
				soundname = "test/temp/soundscape_test/tv_music.wav"
			end

			ent.AmbientSound = CreateSound(owner, soundname)
		end

		ent._ScaleAdd = math.Approach(ent._ScaleAdd or 0, playing and 1 or 0, FrameTime() * 5)
		ent:SetModelScaleVector(Vector(0.05, 0.05, 0.15 + ent._ScaleAdd * 0.35))
	end
end

c = Costume("_talking")
c:SetSlots(COSTUMESLOT_NONE)
c:AddModel("models/extras/info_speech.mdl", Vector(3, 8, 3), Angle(270, 140, 0), nil, 0.15)

c = Costume("fangelwings")
c:SetSlots(COSTUMESLOT_BACK)
c:AddModel("models/crow.mdl", Vector(0, -4, 0), Angle(0, -30, 90), "ValveBiped.Bip01_Spine4")
if CLIENT then
	function c:PreDraw(owner, entities)
		local ent = entities[1]
		if ent and ent:IsValid() then
			if not ent._FlapTime then
				ent._FlapTime = 0
				ent._FlapPower = 0
			end

			ent._FlapPower = math.Approach(ent._FlapPower, owner:OnGround() and 0 or 1, FrameTime() * 1.75)
			ent._FlapTime = ent._FlapTime + (0.5 + 6 * ent._FlapPower) * FrameTime()

			ent:SetSequence(ent:LookupSequence("Fly01"))
			ent:SetCycle(math.abs(math.sin(ent._FlapTime)) * (0.05 + 0.035 * ent._FlapPower))
		end
	end

	local featherGravity = Vector(0, 0, -300)
	function c:PostDraw(owner, entities)
		local ent = entities[1]
		if ent and ent:IsValid() then
			if CurTime() < (ent.NextEmit or 0) then return end
			ent.NextEmit = CurTime() + math.Rand(0.5, 1) * (owner:OnGround() and 1 or 0.2)

			local element = self.Elements[1]
			local pos, ang = self:GetPosAng(owner, element.Offset, element.Angles, element.BoneName)
			local sideout = math.Rand(-24, 24)
			local size = math.Rand(1, 3)

			local emitter = ParticleEmitter(pos)
			emitter:SetNearClip(24, 32)

			local particle = emitter:Add("Effects/fleck_antlion"..math.random(2), pos + math.abs(sideout) * 0.7 * ang:Up() + ang:Right() * sideout)
			particle:SetDieTime(4)
			particle:SetVelocity(owner:GetVelocity())
			particle:SetAirResistance(300)
			particle:SetGravity(featherGravity)
			particle:SetStartAlpha(220 * render.GetBlend())
			particle:SetEndAlpha(0)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-10, 10))
			particle:SetCollide(true)
			particle:SetColor(30, 30, 30)
			particle:SetStartSize(size)
			particle:SetEndSize(size)

			emitter:Finish() emitter = nil collectgarbage("step", 64)
		end
	end
	local NotZero = {
		"Crow.Phalanges1_L",
		"Crow.Phalanges2_L",
		"Crow.Phalanges3_L",
		"Crow.Phalanges1_R",
		"Crow.Phalanges2_R",
		"Crow.Phalanges3_R"
	}
	function c:Initialize(owner, entities)
		local ent = self:GetFirstEntity(owner)
		if ent and ent:IsValid() then
			local vsmall = Vector(0.01, 0.01, 0.01)
			for i=0, ent:GetBoneCount() do
				ent:ManipulateBoneScale(i, vsmall)
			end
			local vnotsmall = Vector(2, 2, 2)
			for _, bonename in pairs(NotZero) do
				local boneid = ent:LookupBone(bonename)
				if boneid and boneid > 0 then
					ent:ManipulateBoneScale(boneid, vnotsmall)
				end
			end
		end
	end
end

c = Costume("angelwings")
c:SetSlots(COSTUMESLOT_BACK)
c:AddModel("models/pigeon.mdl", Vector(0, -4, 0), Angle(0, -30, 90), "ValveBiped.Bip01_Spine4")
c:AddColorOptions()
if CLIENT then
	function c:PreDraw(owner, entities)
		local ent = entities[1]
		if ent and ent:IsValid() then
			if not ent._FlapTime then
				ent._FlapTime = 0
				ent._FlapPower = 0
			end

			ent._FlapPower = math.Approach(ent._FlapPower, owner:OnGround() and 0 or 1, FrameTime() * 1.75)
			ent._FlapTime = ent._FlapTime + (0.5 + 6 * ent._FlapPower) * FrameTime()

			ent:SetSequence(ent:LookupSequence("Fly01"))
			ent:SetCycle(math.abs(math.sin(ent._FlapTime)) * (0.05 + 0.035 * ent._FlapPower))
		end
	end

	local featherGravity = Vector(0, 0, -300)
	function c:PostDraw(owner, entities)
		local ent = entities[1]
		if ent and ent:IsValid() then
			if CurTime() < (ent.NextEmit or 0) then return end
			ent.NextEmit = CurTime() + math.Rand(0.5, 1) * (owner:OnGround() and 1 or 0.2)

			local element = self.Elements[1]
			local pos, ang = self:GetPosAng(owner, element.Offset, element.Angles, element.BoneName)
			local sideout = math.Rand(-24, 24)
			local size = math.Rand(1, 3)

			local emitter = ParticleEmitter(pos)
			emitter:SetNearClip(24, 32)

			local particle = emitter:Add("sprites/glow04_noz", pos + math.abs(sideout) * 0.7 * ang:Up() + ang:Right() * sideout)
			particle:SetDieTime(4)
			particle:SetVelocity(owner:GetVelocity())
			particle:SetAirResistance(300)
			particle:SetGravity(featherGravity)
			particle:SetStartAlpha(220 * render.GetBlend())
			particle:SetEndAlpha(0)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-10, 10))
			particle:SetCollide(true)
			particle:SetStartSize(size)
			particle:SetEndSize(size)

			emitter:Finish() emitter = nil collectgarbage("step", 64)
		end
	end
	local NotZero = {
		"Crow.Phalanges1_L",
		"Crow.Phalanges2_L",
		"Crow.Phalanges3_L",
		"Crow.Phalanges1_R",
		"Crow.Phalanges2_R",
		"Crow.Phalanges3_R"
	}
	function c:Initialize(owner, entities)
		local ent = self:GetFirstEntity(owner)
		if ent and ent:IsValid() then
			local vsmall = Vector(0.01, 0.01, 0.01)
			for i=0, ent:GetBoneCount() do
				ent:ManipulateBoneScale(i, vsmall)
			end
			local vnotsmall = Vector(2, 2, 2)
			for _, bonename in pairs(NotZero) do
				local boneid = ent:LookupBone(bonename)
				if boneid and boneid > 0 then
					ent:ManipulateBoneScale(boneid, vnotsmall)
				end
			end
		end
	end
end

c = Costume("runnershoes")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_junk/Shoe001a.mdl", Vector(1.603, 2.368, -0.562), Angle(-6.075, -30.064, 90), "ValveBiped.Bip01_R_Foot", 1.2)
c:AddModel("models/props_junk/Shoe001a.mdl", Vector(1.917, 2.368, -1.525), Angle(6.074, -30.064, 90), "ValveBiped.Bip01_L_Foot", 1.2)
c:AddModel("models/pigeon.mdl", Vector(-0.456, -1.078, -8.836), Angle(0.243, 0.727, 0), nil, nil, nil, nil, 1)
c:AddModel("models/pigeon.mdl", Vector(-0.456, -1.078, -8.836), Angle(0.243, -0.824, 0), nil, nil, nil, nil, 2)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"
if CLIENT then
	function c:PreDraw(owner, entities)
		local ent = entities[3]
		if ent and ent:IsValid() then
			if not ent._FlapTime then
				ent._FlapTime = 0
				ent._FlapPower = 0
			end

			ent._FlapPower = math.Approach(ent._FlapPower, owner:OnGround() and 0 or 1, FrameTime() * 1.75)
			ent._FlapTime = ent._FlapTime + (0.5 + 6 * ent._FlapPower) * FrameTime()

			local seq = ent:LookupSequence("Fly01")
			local cycle = math.abs(math.sin(ent._FlapTime)) * (0.05 + 0.035 * ent._FlapPower)

			ent:SetSequence(seq)
			ent:SetCycle(cycle)

			local ent2 = entities[4]
			if ent2 and ent2:IsValid() then
				ent2:SetSequence(seq)
				ent2:SetCycle(cycle)
			end
		end
	end

	local NotZero = {
		"Crow.Phalanges1_L",
		"Crow.Phalanges2_L",
		"Crow.Phalanges3_L",
		"Crow.Phalanges1_R",
		"Crow.Phalanges2_R",
		"Crow.Phalanges3_R"
	}
	function c:DoScales(ent)
		if ent and ent:IsValid() then
			local vsmall = Vector(0.01, 0.01, 0.01)
			for i=0, ent:GetBoneCount() do
				ent:ManipulateBoneScale(i, vsmall)
			end
			local vnotsmall = Vector(1, 1, 1)
			for _, bonename in pairs(NotZero) do
				local boneid = ent:LookupBone(bonename)
				if boneid and boneid > 0 then
					ent:ManipulateBoneScale(boneid, vnotsmall)
				end
			end
		end
	end

	function c:Initialize(owner, entities)
		self:DoScales(entities[3])
		self:DoScales(entities[4])
	end
end