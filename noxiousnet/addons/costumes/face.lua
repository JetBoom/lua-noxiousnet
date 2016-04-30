local c

c = Costume("aviators")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("Models/Aviator/aviator.mdl", Vector(1.25, 2.5, 0), Angle(0, -80, 270))
c:AddColorOptions()
c:AddOption(COSTUMEOPTION_MATERIAL, nil, nil, {0, 2})

c = Costume("combinemask")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/BarneyHelmet_faceplate.mdl", Vector(2.65, 0.6, 0), Angle(180, 90, 90), nil, Vector(1, 1.25, 1))
c:AddColorOptions()

c = Costume("lightvisor")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_lab/lab_flourescentlight002b.mdl", Vector(3.5, 4, 0), Angle(180, 90, 90), nil, Vector(0.5, 0.1, 0.5))
c:AddOption(COSTUMEOPTION_MATERIAL, nil, nil, {0, 2})
c:AddColorOptions()

c = Costume("glglasses")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/items/glasses/simon_glasses.mdl", Vector(3, 5.5, 0), Angle(0, 285, 270))
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)

c = Costume("glglassesbig")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/items/glasses/kamina_glasses.mdl", Vector(3, 5.5, 0), Angle(0, 285, 270))
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)

c = Costume("pyromancer")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/player/items/pyro/pyro_pyromancers_mask.mdl", Vector(-0.5, -1.5, 0), Angle(0, 270, 270))

c = Costume("blindfold")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/player/items/soldier/homefront_blindfold.mdl", Vector(0, 0, 0), Angle(0, 270, 270))
c:AddColorOptions()

c = Costume("madeye")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/player/items/engineer/mad_eye.mdl", Vector(-0.5, 0, -1.5), Angle(0, 290, 290))
c:AddColorOptions()

c = Costume("deusshades")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/player/items/all_class/dex_glasses_scout.mdl", Vector(-0.5, 1.25, 0), Angle(0, 290, 270))

c = Costume("googleyglasses")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(3.15, 5.074, 0.1), Angle(0, 90, 0), "ValveBiped.Bip01_Head1", 0.035, "models/debug/debugwhite", Color(10, 10, 10, 255))
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(1.475, 0.05, 3.275), Angle(91.599, -10.676, -2.951), nil, Vector(0.035, 0.035, 0.052), "models/debug/debugwhite", Color(10, 10, 10, 255), 1)
c:AddModel("models/props_trainstation/trainstation_clock001.mdl", Vector(-0.225, -0.151, 2.025), Angle(179.975, -9.55, -105), nil, 0.017, "models/shiny", Color(10, 10, 10, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(1.475, 0.05, -2.975), Angle(91.6, -10.676, -2.951), nil, Vector(0.035, 0.035, 0.052), "models/debug/debugwhite", Color(10, 10, 10, 255), 1)
c:AddModel("models/props_trainstation/trainstation_clock001.mdl", Vector(-0.051, -0.076, 2.075), Angle(178.475, -11.551, 10.05), nil, 0.035, "models/shiny", nil, 1)
c:AddModel("models/props_trainstation/trainstation_clock001.mdl", Vector(-0.325, 0.05, -2), Angle(179.975, -13.176, -105), nil, 0.017, "models/shiny", Color(10, 10, 10, 255), 1)
c:AddModel("models/props_trainstation/trainstation_clock001.mdl", Vector(-0.201, 0.025, -1.976), Angle(178.475, -11.551, 10.05), nil, 0.035, "models/shiny", nil, 1)
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("heimask")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_phx/construct/metal_angle90.mdl", Vector(0.393, -1.65, 0), Angle(10.543, -7.212, 0), "ValveBiped.Bip01_Head1", 0.0099999997764826, "models/debug/debugwhite", Color(247, 255, 255, 255))
c:AddModel("models/props_c17/oildrum001.mdl", Vector(5.25, 6.533, 1.429), Angle(-104.851, 31.051, -74.832), nil, Vector(0.059, 0.021, 0.021), nil, Color(0, 0, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_angle90.mdl", Vector(5.748, 4.826, -1.144), Angle(-100, 16.538, 82.707), nil, Vector(0.087, 0.157, 0.287), "models/debug/debugwhite", nil, 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(6.25, 5.9, 1.144), Angle(-9.256, -52.463, -27.737), nil, Vector(0.072, 0.021, 0.028), nil, Color(0, 0, 255, 255), 1)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(4.288, 6.763, -2.358), Angle(-104.851, 31.051, -74.832), nil, Vector(0.059, 0.021, 0.021), nil, Color(0, 0, 0, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(6.712, 5.643, 0.368), Angle(-9.256, -64.006, 80.719), nil, Vector(0.072, 0.029, 0.028), nil, Color(0, 0, 255, 255), 1)
c:AddModel("models/props_phx/construct/metal_angle90.mdl", Vector(6.31, 5.705, -0.332), Angle(79.768, 16.538, -82.708), nil, Vector(0.087, 0.157, 0.287), "models/debug/debugwhite", nil, 1)
c:AddModel("models/props_c17/door01_left.mdl", Vector(1.468, 7.538, 0), Angle(-11.839, 17.799, -180), nil, Vector(0.119, 0.009, 0.037), nil, Color(235, 0, 0, 255), 1)
c:AddModel("models/Gibs/wood_gib01e.mdl", Vector(5.081, 6.375, 1.868), Angle(-1.757, 22.038, -110.282), nil, 0.25299999117851, nil, Color(0, 0, 204, 255), 1)
c:AddModel("models/props_phx/construct/metal_angle90.mdl", Vector(2.461, 6.314, 0), Angle(124.15, 26.375, 87.132), nil, Vector(0.111, 0.111, 0.287), "models/debug/debugwhite", Color(247, 255, 255, 255), 1)
c.Author = "West Nile"
c.AuthorID = "STEAM_0:1:682450"

c = Costume("robotnikface")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(0, 0, 0), Angle(0, 0, 0), "ValveBiped.Bip01_Head1", 0.01, "models/debug/debugwhite", Color(0, 0, 0, 255))
c:AddModel("models/XQM/jetwing2.mdl", Vector(1.468, 5.406, -3.668), Angle(-16.769, -163.375, 96.175), nil, 0.109, "models/props/CS_militia/roofbeams01", Color(255, 114, 31, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(3.294, 4.969, 1.175), Angle(-65.313, 22.888, 96.751), nil, Vector(0.01, 0.016, 0.01), "models/debug/debugwhite", Color(255, 0, 0, 255), 1)
c:AddModel("models/Gibs/Antlion_gib_Large_3.mdl", Vector(2.512, 5.157, 0.169), Angle(169.487, -75.606, 94.088), nil, 0.11, "models/debug/debugwhite", Color(255, 142, 255, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(3.856, 3.125, -2.037), Angle(-120.151, 22.888, 96.751), nil, Vector(0.026, 0.051, 1.104), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/XQM/jetwing2.mdl", Vector(2.356, 4.1, 3.775), Angle(-8.182, 21.038, -93.244), nil, 0.109, "models/props/CS_militia/roofbeams01", Color(255, 114, 31, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(3.294, 5.1, -1.231), Angle(-120.151, 22.888, 96.751), nil, Vector(0.01, 0.016, 0.01), "models/debug/debugwhite", Color(255, 0, 0, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(3.869, 3.088, 1.831), Angle(-65.963, 22.888, 96.751), nil, Vector(0.026, 0.051, 1.104), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c.Author = "West Nile"
c.AuthorID = "STEAM_0:1:682450"

c = Costume("snorkle")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_phx/construct/windows/window1x1.mdl", Vector(0.075, -1.332, -0.256), Angle(5.913, -8.257, 0), "ValveBiped.Bip01_Head1", 0.01, "models/debug/debugwhite", Color(0, 255, 255, 255))
c:AddModel("models/props_canal/mattpipe.mdl", Vector(8.094, 3.555, 3.756), Angle(-94.112, 23, 0), nil, Vector(0.5, 0.5, 0.456), "models/debug/debugwhite", Color(255, 255, 0, 255), 1)
c:AddModel("models/props/CS_militia/fishriver01.mdl", Vector(6.387, 5.043, -3.075), Angle(112.925, 90.8, 83.012), nil, 0.338, nil, nil, 1)
c:AddModel("models/props_phx/construct/windows/window1x1.mdl", Vector(2.6, 2.625, 0), Angle(-95.7, 11.362, 83.012), nil, Vector(0.075, 1.231, 0.156), "models/debug/debugwhite", Color(0, 255, 255, 255), 1)
c:AddModel("models/props/CS_militia/fishriver01.mdl", Vector(2.568, 6.868, 4.381), Angle(-101.925, 86.581, 68.543), nil, 0.338, nil, nil, 1)
c.Author = "West Nile"
c.AuthorID = "STEAM_0:1:682450"

c = Costume("eyevalve")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_pipes/valvewheel001.mdl", Vector(2.8, 2, -1), Angle(25, 10, 100), "ValveBiped.Bip01_Head1", Vector(0.1, 0.1, 0.2))
c:AddModel("models/props_pipes/valve001.mdl", Vector(0, 0, -0.25), Angle(0, 0, 0), nil, Vector(0.1, 0.1, 0.125), nil, nil, 1)
c:AddColorOptions()
c.Author = "I Waste Air"
c.AuthorID = "STEAM_0:1:5288558"

c = Costume("sligmask")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(0, 0.912, 0.107), Angle(0, 0, 90), "ValveBiped.Bip01_Head1", 0.173, "models/props_combine/metal_combinebridge001")
c:AddModel("models/props_lab/binderblue.mdl", Vector(0.52, -0.024, 4.868), Angle(1.25, -90, -86.582), nil, Vector(0.463, 0.185, 0.204), "models/props_combine/metal_combinebridge001", nil, 1)
c:AddModel("models/props_c17/streetsign005b.mdl", Vector(2.631, 2.631, 3.406), Angle(-1.532, 0, -8.793), nil, Vector(0.148, 1.684, 0.163), "models/props_combine/metal_combinebridge001", nil, 1)
c:AddModel("models/props_lab/binderblue.mdl", Vector(4.275, -3.063, 2.556), Angle(90, 0, 90), nil, Vector(0.5, 0.098, 0.514), "models/props_combine/metal_combinebridge001", nil, 1)
c:AddModel("models/props_c17/SuitCase001a.mdl", Vector(1.344, -0.057, 3.382), Angle(-90, 0, 0), nil, Vector(0.106, 0.442, 0.141), "models/props_combine/metal_combinebridge001", nil, 1)
c:AddModel("models/props_c17/streetsign005b.mdl", Vector(2.65, -2.713, 3.268), Angle(-180, 0, 170.731), nil, Vector(0.148, 1.684, 0.163), "models/props_combine/metal_combinebridge001", nil, 1)
c:AddModel("models/props_c17/BriefCase001a.mdl", Vector(1.281, -0.026, 1.862), Angle(0.506, -90, 66.769), nil, Vector(0.328, 0.328, 0.503), "models/props_combine/metal_combinebridge001", nil, 1)
c:AddModel("models/props_c17/BriefCase001a.mdl", Vector(3.493, -0.018, 2.882), Angle(180, -90, 2.288), nil, Vector(0.26, 0.216, 0.228), "models/error/new light1", nil, 1)
c:AddModel("models/Combine_turrets/Floor_turret_gib5.mdl", Vector(-3.314, -0.962, 10.763), Angle(-108.162, -4.594, 0), nil, 0.5, "models/antlion/antlion_innards", Color(150, 255, 0, 255), 1)
c:AddModel("models/Combine_turrets/Floor_turret_gib5.mdl", Vector(-3.174, 1.325, 11.181), Angle(-108.162, 10.575, 0), nil, 0.5, "models/antlion/antlion_innards", Color(150, 255, 0, 255), 1)
c:AddModel("models/Combine_turrets/Floor_turret_gib5.mdl", Vector(-5.3, 0.193, 10.056), Angle(-98.887, 0, 0), nil, 0.5, "models/antlion/antlion_innards", Color(150, 255, 0, 255), 1)
c.Author = "Exhale"
c.SteamID = "STEAM_0:1:9167704"

c = Costume("arroweye")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_wasteland/rockgranite01c.mdl", Vector(3.3, 3.4, -1), Angle(79.169, 1.344, 24.869), "ValveBiped.Bip01_Head1", 0.01, "models/flesh")
c:AddModel("models/props_docks/dock01_pole01a_128.mdl", Vector(-0.275, 3.168, 0.106), Angle(85.456, -81.494, -10.162), nil, Vector(0.01, 0.01, 0.054), "models/props_wasteland/wood_fence01a_skin2", nil, 1)
c:AddModel("models/props_c17/streetsign005b.mdl", Vector(0, 0, -2.675), Angle(0, 0, 0), nil, Vector(0.068, 0.01, 0.068), "models/props/de_inferno/woodfloor008a", Color(116, 0, 0, 255), 2)
c:AddColorOptions()
c.Author = "Exhale"
c.SteamID = "STEAM_0:1:9167704"

c = Costume("bugman")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/hunter/plates/plate025x4.mdl", Vector(8.8, 1.3, -1.5), Angle(90, 90, -13), "ValveBiped.Bip01_Head1", 0.022, nil, Color(0, 0, 0, 255))
c:AddModel("models/hunter/plates/plate025x4.mdl", Vector(8.8, 1.3, 1.5), Angle(90, 90, -13), "ValveBiped.Bip01_Head1", 0.022, nil, Color(0, 0, 0, 255))
c:AddModel("models/hunter/plates/plate025x4.mdl", Vector(0, 3.575, 1.387), Angle(0, 0, -42), nil, 0.022, nil, Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/plates/plate025x4.mdl", Vector(0, 3.575, 1.387), Angle(0, 0, -42), nil, 0.022, nil, Color(0, 0, 0, 255), 2)
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(2.9, 4, 1.25), Angle(148.594, 179.894, -22.25), "ValveBiped.Bip01_Head1", 0.06)
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(2.9, 4, -1.25), Angle(90, 180, 0), "ValveBiped.Bip01_Head1", 0.06)
c.Author = "Remnic"
c.AuthorID = "STEAM_0:1:18880707"

c = Costume("brseye")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props/de_inferno/picture1.mdl", Vector(4.925, 4.2, -1.8), Angle(0, 110, 90), "ValveBiped.Bip01_Head1", 0.135, "blackrockshooter/flame_blue")
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("vuvuzela")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/hunter/tubes/tube4x4x1to2x2.mdl", Vector(0.781, 6.381, 0), Angle(0, 0, -90), "ValveBiped.Bip01_Head1", Vector(0.01, 0.01, 0.306), "models/debug/debugwhite")
c:AddModel("models/noesis/donut.mdl", Vector(0, 0, -5.038), Angle(0, 0, 0), nil, 0.078, "models/debug/debugwhite", nil, 1)
c:AddModel("models/hunter/tubes/tube4x4x1to2x2.mdl", Vector(0, 0, -14.513), Angle(0, 0, 0), nil, Vector(0.021, 0.021, 0.052), "models/debug/debugwhite", nil, 1)
c:AddModel("models/hunter/tubes/tube4x4x1to2x2.mdl", Vector(0, 0, 0), Angle(0, 0, 180), nil, Vector(0.01, 0.01, 0.041), "models/debug/debugwhite", nil, 1)
c:AddColorOptions()
c.Author = "Crucket"
c.AuthorID = "STEAM_0:1:19442508"

c = Costume("bionicbreath")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/Gibs/helicopter_brokenpiece_04_cockpit.mdl", Vector(0.3, 6, 0.2), Angle(177, 70, 90), "ValveBiped.Bip01_Head1", Vector(0.05, 0.08, 0.05))
c:AddModel("models/props_c17/metalPot001a.mdl", Vector(1.762, -0.3, -1.525), Angle(83, -179, -177), nil, Vector(0.18, 0.18, 0.255), nil, Color(130, 130, 180, 255), 1)
c:AddModel("models/XQM/cylinderx1.mdl", Vector(-4.01, 0.11, -1.6), Angle(-67.919, 5.56, 0), nil, Vector(0.1, 0.502, 0.844), nil, Color(30, 30, 50, 255), 1)
c:AddModel("models/Gibs/helicopter_brokenpiece_03.mdl", Vector(-1.8, 2.1, -1.6), Angle(-15, -170, 54), nil, Vector(0.05, 0.05, 0.07), nil, Color(130, 130, 170, 255), 1)
c:AddModel("models/Gibs/helicopter_brokenpiece_03.mdl", Vector(-1.8, -1.8, -1.6), Angle(-15, 175, -138), nil, Vector(0.05, 0.05, 0.07), nil, Color(130, 130, 170, 255), 1)
c:AddModel("models/props_c17/metalPot001a.mdl", Vector(-0.043, -0.13, 1.525), Angle(55, -179, -177), nil, Vector(0.17, 0.17, 0.275), nil, Color(130, 130, 180, 255), 1)
c:AddModel("models/props_wasteland/laundry_basket001.mdl", Vector(-0.62, -2.2, 0.6), Angle(80, -175, -90), nil, Vector(0.03, 0.03, 0.016), nil, nil, 1)
c.Author = "Skirmisher"
c.AuthorID = "STEAM_0:0:16954306"

c = Costume("lisp")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_phx/ball.mdl", Vector(0.98, 5.5, 0), Angle(91, 11, -8), "ValveBiped.Bip01_Head1", Vector(0.03, 0.07, 0.03))
c:AddModel("models/props_phx/ball.mdl", Vector(0, -0.2, -0.5), Angle(0, 0, 0), nil, Vector(0.03, 0.06, 0.02), nil, nil, 1)
c:AddColorOptions()
c.Author = "Arty"
c.AuthorID = "STEAM_0:1:31017062"

c = Costume("rudolph")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/XQM/Rails/gumball_1.mdl", Vector(2, 5, 0.065), Angle(0, 0, 0), "ValveBiped.Bip01_Head1", 0.065, "models/cs_italy/light_orange")
c:AddModel("models/props_foliage/driftwood_03a.mdl", Vector(5, -3, -6), Angle(0, 180, 90), nil, 0.1, "models/debug/debugwhite", Color(255, 255, 175, 255), 1)
c:AddModel("models/props_foliage/driftwood_03a.mdl", Vector(5, -5, 6), Angle(0, 180, -90), nil, 0.1, "models/debug/debugwhite", Color(255, 255, 175, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("cwface")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_c17/TrapPropeller_Blade.mdl", Vector(1.25, 5, 0), Angle(150, 0, 90), "ValveBiped.Bip01_Head1", 0.04, nil, Color(0, 0, 0, 255))
c:AddModel("models/props_phx/ball.mdl", Vector(0.4, 1.5, -1.5), Angle(0, 0, 0), nil, 0.025, nil, Color(255, 0, 0, 255), 1)
c:AddModel("models/props_c17/TrapPropeller_Blade.mdl", Vector(0, 0, 0.25), Angle(0, 53, 180), nil, 0.04, nil, Color(0, 0, 0, 255), 1)
c:AddModel("models/props_phx/ball.mdl", Vector(-1, -1, -1.5), Angle(0, 0, 0), nil, 0.025, nil, Color(255, 0, 0, 255), 1)
c.Author = "Kramer"
c.AuthorID = "STEAM_0:1:28979711"

c = Costume("animeeyes")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(2.7, 1.49, 1.46), Angle(92.199, -1.173, 90.415), "ValveBiped.Bip01_Head1", Vector(0.064, 0.094, 0.064), "models/debug/debugwhite")
c:AddModel("models/props_c17/oildrum001.mdl", Vector(-0.042, -0.209, 0.505), Angle(0, 0, 0), nil, Vector(0.054, 0.075, 0.054), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/props_wasteland/prison_toiletchunk01b.mdl", Vector(-0.003, -0.633, 3.009), Angle(-180, 48.384, 0), nil, Vector(0.071, 0.071, 0.009), "models/debug/debugwhite", Color(0, 255, 255, 255), 1)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(-2.681, -0.21, 0.107), Angle(180, -180, 180), nil, Vector(0.064, 0.094, 0.064), "models/debug/debugwhite", nil, 1)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(-2.701, -0.353, 0.621), Angle(0, 0, 0), nil, Vector(0.054, 0.075, 0.054), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(-2.451, 0.17, 1.82), Angle(0, 0, 0), nil, 0.029, "models/debug/debugwhite", nil, 1)
c:AddModel("models/props_wasteland/prison_toiletchunk01b.mdl", Vector(-2.586, -0.792, 3.099), Angle(-180, 48.384, 0), nil, Vector(0.071, 0.071, 0.009), "models/debug/debugwhite", Color(0, 255, 255, 255), 1)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(0.197, 0.37, 1.7), Angle(0, 0, 0), nil, 0.029, "models/debug/debugwhite", nil, 1)
c.Author = "Kolmio"
c.AuthorID = "STEAM_0:1:21756969"

c = Costume("dexterglasses")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(3.785, 4.756, 1.947), Angle(-9.452, 0, 90), "ValveBiped.Bip01_Head1", Vector(0.039, 0.039, 0.15), "models/debug/debugwhite", Color(0, 0, 0, 255))
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(1.049, 5.51, -2.711), Angle(0, 103.015, 0), nil, Vector(0.071, 0.03, 0.092), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(0.481, 3.75, 0), Angle(0, 19.688, 0), nil, Vector(0.009, 0.009, 0.168), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(-0.22, -1.841, -2.711), Angle(0, 94.771, 0), nil, Vector(0.071, 0.03, 0.092), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(0.638, 3.671, 0), Angle(0, 19.688, 0), nil, Vector(0.039, 0.039, 0.15), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(0.474, 3.75, 0), Angle(0, 19.688, 0), nil, Vector(0.03, 0.03, 0.164), "models/shiny", nil, 1)
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(-0.101, 0.002, 0), Angle(0, 0, 0), nil, Vector(0.009, 0.009, 0.168), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(-0.16, 0.002, 0), Angle(0, 0, 0), nil, Vector(0.03, 0.03, 0.164), "models/shiny", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("stigmata")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props/cs_office/Snowman_nose.mdl", Vector(1.2, 4.091, -1.364), Angle(84.886, 107.386, 5.113), "ValveBiped.Bip01_Head1", 0.89)
c:AddModel("models/props/cs_office/Snowman_nose.mdl", Vector(1.299, 4.09, 1.399), Angle(105.341, 90, 21.476), "ValveBiped.Bip01_Head1", 0.89)
c:AddColorOptions()
c.Author = "Rejax"
c.AuthorID = "STEAM_0:0:4100206"

c = Costume("pizzaface")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/XQM/panel360.mdl", Vector(2.398, 5.065, 0), Angle(0, 100.85, -0.621), "ValveBiped.Bip01_Head1", Vector(0.805, 0.199, 0.199), "models/props_c17/furnituremetal001a", Color(255, 255, 122, 255))
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(-1.201, 2.269, 1.616), Angle(0, 90, 90), nil, Vector(0.018, 0.009, 0.018), "models/props_c17/furnituremetal001a", Color(255, 0, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(-1.201, -2.108, -2.149), Angle(0, 90, 90), nil, Vector(0.018, 0.009, 0.018), "models/props_c17/furnituremetal001a", Color(255, 0, 0, 255), 1)
c:AddModel("models/Gibs/Shield_Scanner_Gib1.mdl", Vector(-0.922, -3.718, 2.066), Angle(118.288, -38, -148.098), nil, Vector(0.208, 0.226, 0.136), "models/props_c17/furnituremetal001a", Color(105, 105, 105, 255), 1)
c:AddModel("models/Gibs/Shield_Scanner_Gib1.mdl", Vector(-0.713, 3.601, -2.296), Angle(114.763, 0, 180), nil, Vector(0.208, 0.226, 0.136), "models/props_c17/furnituremetal001a", Color(105, 105, 105, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(0, 0, 0), Angle(0, 0, 0), nil, Vector(0.776, 0.214, 0.214), "models/props_c17/furnituremetal001a", Color(255, 128, 24, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(-1.201, -2.108, 2.148), Angle(0, 90, 90), nil, Vector(0.018, 0.009, 0.018), "models/props_c17/furnituremetal001a", Color(255, 0, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(-1.201, -0.667, 0.867), Angle(0, 90, 90), nil, Vector(0.018, 0.009, 0.018), "models/props_c17/furnituremetal001a", Color(255, 0, 0, 255), 1)
c:AddModel("models/props_phx/wheels/drugster_front.mdl", Vector(0.869, 0, 0), Angle(90, 0, 0), nil, Vector(0.363, 0.093, 0.363), "models/props_pipes/guttermetal01a", nil, 1)
c:AddModel("models/Gibs/Shield_Scanner_Gib1.mdl", Vector(-0.51, 3.601, 2.295), Angle(70, 0, 0.079), nil, Vector(0.208, 0.226, 0.208), "models/props_c17/furnituremetal001a", Color(105, 105, 105, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(-1.201, 2.269, -1.617), Angle(0, 90, 90), nil, Vector(0.018, 0.009, 0.018), "models/props_c17/furnituremetal001a", Color(255, 0, 0, 255), 1)
c:AddModel("models/Gibs/Shield_Scanner_Gib1.mdl", Vector(-0.733, -0.283, -3.543), Angle(69.519, -0.119, -21.216), nil, Vector(0.208, 0.226, 0.136), "models/props_c17/furnituremetal001a", Color(105, 105, 105, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(-1.201, -0.667, -1.022), Angle(0, 90, 90), nil, Vector(0.018, 0.009, 0.018), "models/props_c17/furnituremetal001a", Color(255, 0, 0, 255), 1)
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("majorasmask")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/balloons/balloon_classicheart.mdl", Vector(-3.543, 5.493, 0), Angle(-90, 0, 0), "ValveBiped.Bip01_Head1", Vector(0.467, 0.739, 0.739), "models/props_canal/canal_bridge_railing_01c", Color(134, 0, 224, 255))
c:AddModel("models/XQM/panel360.mdl", Vector(-2.698, 2.49, 8.427), Angle(0, 90, 0), nil, Vector(0.351, 0.02, 0.02), "models/weapons/v_grenade/grenadetop", Color(0, 255, 0, 255), 1)
c:AddModel("models/props/de_dust/dustteeth_1.mdl", Vector(-4.058, 0, 11.307), Angle(-7.272, 180, 0), nil, Vector(0.028, 0.027, 0.086), "models/debug/debugwhite", Color(243, 250, 202, 255), 1)
c:AddModel("models/props/de_dust/dustteeth_1.mdl", Vector(4.057, 0, 11.307), Angle(7.271, 180, 0), nil, Vector(0.028, 0.027, 0.086), "models/debug/debugwhite", Color(243, 250, 205, 255), 1)
c:AddModel("models/XQM/airplanewheel1.mdl", Vector(-2.698, 0.899, 8.427), Angle(0, 90, 0), nil, Vector(0.389, 0.204, 0.204), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props/de_dust/dustteeth_4.mdl", Vector(-5.949, 0, 7.96), Angle(134.212, 0, 0), nil, Vector(0.027, 0.027, 0.081), "models/debug/debugwhite", Color(243, 250, 205, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(2.697, 2.49, 8.427), Angle(0, 90, 0), nil, Vector(0.351, 0.02, 0.02), "models/weapons/v_grenade/grenadetop", Color(0, 255, 0, 255), 1)
c:AddModel("models/balloons/balloon_classicheart.mdl", Vector(0, 0.497, 0.95), Angle(0, 0, 0), nil, Vector(0.467, 0.624, 0.591), "models/debug/debugwhite", Color(172, 0, 44, 255), 1)
c:AddModel("models/XQM/airplanewheel1.mdl", Vector(2.697, 0.899, 8.427), Angle(0, 90, 0), nil, Vector(0.389, 0.204, 0.204), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props/de_dust/dustteeth_4.mdl", Vector(0.569, 0, 2.282), Angle(-134.213, 0, 0), nil, Vector(0.027, 0.027, 0.081), "models/debug/debugwhite", Color(243, 250, 205, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("knifeeye")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/weapons/w_knife_t.mdl", Vector(11.501, -4.283, -3.037), Angle(180, -41.506, 98.388), "ValveBiped.Bip01_Head1", Vector(0.938, 0.938, 1.019), nil, Color(254, 255, 255, 255))
c:AddModel("models/xqm/rails/gumball_1.mdl", Vector(1.018, 0.119, 15.89), Angle(0, 9.805, 0), nil, 0.058, "models/debug/debugwhite", nil, 1)
c:AddModel("models/xqm/rails/gumball_1.mdl", Vector(1.567, 0.384, 11.336), Angle(0, 0, 0), nil, 0.078, "models/flesh", Color(254, 255, 255, 255), 1)
c:AddModel("models/props_c17/clock01.mdl", Vector(0.419, 0.119, 16.511), Angle(45, 0, 0), nil, 0.03, "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(0.388, 0.119, 16.466), Angle(-43.89, 0, 0), nil, 0.015, "models/debug/debugwhite", Color(0, 125, 255, 255), 1)
c:AddModel("models/props_combine/stasisvortex.mdl", Vector(1.046, 0, 16.02), Angle(139.229, -0.584, 0), nil, 0.01, "models/flesh", Color(254, 255, 255, 255), 1)
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("dekumask")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/dav0r/thruster.mdl", Vector(2.878, 6.147, 0), Angle(0, 11.234, -90), "ValveBiped.Bip01_Head1", Vector(1.161, 1.161, 0.62), "models/props_foliage/tree_deciduous_01a_trunk")
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(0, 0, -2.55), Angle(90, 0, 0), nil, 1.379, "models/props_foliage/tree_deciduous_01a_trunk", nil, 1)
c:AddModel("models/XQM/panel180.mdl", Vector(3.878, -3.675, 0.615), Angle(-77.555, 7.431, 147.175), nil, Vector(0.086, 0.056, 0.065), "models/cs_italy/light_orange", Color(255, 255, 0, 255), 1)
c:AddModel("models/XQM/panel180.mdl", Vector(3.878, 3.674, 0.639), Angle(-77.555, -7.432, -147.176), nil, Vector(0.075, 0.075, 0.086), "models/cs_italy/light_orange", Color(255, 105, 0, 255), 1)
c:AddModel("models/props_pipes/concrete_pipe001a.mdl", Vector(0, 0, 0), Angle(-90, 0, 0), nil, Vector(0.045, 0.057, 0.057), "models/props_foliage/tree_deciduous_01a_trunk", nil, 1)
c:AddModel("models/XQM/panel180.mdl", Vector(3.878, -3.675, 0.639), Angle(-77.555, 7.431, 147.175), nil, Vector(0.075, 0.075, 0.086), "models/cs_italy/light_orange", Color(255, 105, 0, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(0, 0, -2.235), Angle(-90, 0, 0), nil, 0.093, "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/XQM/panel180.mdl", Vector(3.878, 3.674, 0.615), Angle(-77.555, -7.432, -147.176), nil, Vector(0.086, 0.056, 0.065), "models/cs_italy/light_orange", Color(255, 255, 0, 255), 1)
c:AddModel("models/props/cs_office/plant01_p1.mdl", Vector(-3.757, 0, 2.581), Angle(90, 180, 0), nil, Vector(0.189, 0.141, 0.199), nil, nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("tinkerspipe")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/props_pipes/pipe03_lcurve02_short.mdl", Vector(-0.101, 6.098, -1.201), Angle(111.97, 90, 0), "ValveBiped.Bip01_Head1", Vector(0.024, 0.025, 0.034), "models/props_lab/door_klab01")
c:AddModel("models/props_pipes/pipe03_lcurve01_short.mdl", Vector(0, -1.614, 0.479), Angle(180, 180, 0), nil, Vector(0.025, 0.014, 0.035), "models/props_lab/door_klab01", nil, 1)
c:AddModel("models/props_c17/clock01.mdl", Vector(-0.01, -0.35, 1.879), Angle(70.901, 0, 90), nil, Vector(0.086, 0.086, 0.052), "models/props_combine/prtl_sky_sheet", Color(255, 143, 0, 255), 1)
c:AddModel("models/props/de_inferno/wine_barrel_p10.mdl", Vector(0, -0.32, 1.87), Angle(0, 0, 92.097), nil, Vector(0.037, 0.037, 0.089), "models/debug/debugwhite", Color(255, 211, 193, 255), 1)
c:AddModel("models/props_pipes/pipe03_lcurve01_short.mdl", Vector(0, -1.612, 1.629), Angle(0, 180, 0), nil, Vector(0.025, 0.014, 0.035), "models/props_lab/door_klab01", nil, 1)
c:AddModel("models/props_junk/terracotta01.mdl", Vector(0.05, -1.112, 1.902), Angle(0, 0, 92.097), nil, Vector(0.076, 0.076, 0.067), "models/props_lab/door_klab01", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("nvg")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/hunter/tubes/tubebend2x2x90outer.mdl", Vector(3.181, 2.5, -1.364), Angle(1.023, 21.476, 39.886), "ValveBiped.Bip01_Head1", Vector(0.045, 0.039, 0.043), "phoenix_storms/metalset_1-2", Color(125, 125, 125, 255))
c:AddModel("models/maxofs2d/hover_plate.mdl", Vector(0, 0.4, 2.273), Angle(1.023, -3.069, 50.113), nil, Vector(0.209, 0.151, 0.662), "phoenix_storms/metalset_1-2", Color(125, 125, 125, 255), 1)
c:AddModel("models/maxofs2d/lamp_flashlight.mdl", Vector(-1, 0.455, 3.181), Angle(46.022, 86.931, -39.887), nil, Vector(0.264, 0.15, 0.151), "phoenix_storms/metalset_1-2", Color(125, 125, 125, 255), 1)
c:AddModel("models/hunter/tubes/tubebend2x2x90outer.mdl", Vector(0, -2.274, 0.455), Angle(0, -180, 0), nil, Vector(0.039, 0.009, 0.039), "phoenix_storms/metalset_1-2", Color(125, 125, 125, 255), 1)
c:AddModel("models/props_citizen_tech/guillotine001a_wheel01.mdl", Vector(0.4, -2.901, -0.456), Angle(0, -1.024, -39.887), nil, Vector(0.321, 0.36, 0.321), "rubber2", Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/tubes/tubebend2x2x90outer.mdl", Vector(-0.16, 1.363, 0.455), Angle(1.023, -180, -180), nil, Vector(0.035, 0.009, 0.009), "phoenix_storms/metalset_1-2", Color(125, 125, 125, 255), 1)
c:AddModel("models/maxofs2d/lamp_projector.mdl", Vector(-0.201, 1.49, 3.181), Angle(142.158, 82.841, 48.068), nil, 0.152, "phoenix_storms/metalset_1-2", Color(110, 110, 110, 255), 1)
c:AddModel("models/shells/shell_12gauge.mdl", Vector(-0.301, 2.273, 2.273), Angle(-144.206, -88.977, 180), nil, 1.401, "phoenix_storms/metalset_1-2", Color(125, 125, 125, 255), 1)
c:AddModel("models/props_citizen_tech/guillotine001a_wheel01.mdl", Vector(1, -2.274, -0.201), Angle(131.932, -91.024, -41.932), nil, 0.379, "rubber", Color(0, 0, 0, 255), 1)
c.Author = "Malice"
c.AuthorID = "STEAM_0:1:16245822"

c = Costume("awesomeface")
c:SetSlots(COSTUMESLOT_FACE)
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(3.477, 6.533, -2.263), Angle(180, 3.217, 86.252), "ValveBiped.Bip01_Head1", Vector(0.046, 0.026, 0.046), "models/debug/debugwhite")
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(2.038, 6.65, 0.149), Angle(0.059, 3.23, 93.813), "ValveBiped.Bip01_Head1", 0.066, "models/debug/debugwhite", Color(0, 0, 0, 255))
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(1.718, 6.711, 0.149), Angle(0.059, 3.23, 93.813), "ValveBiped.Bip01_Head1", Vector(0.05, 0.056, 0.05), "models/debug/debugwhite", Color(255, 64, 122, 255))
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(4.895, 6.468, -2.735), Angle(-1.275, 3.24, 93.813), "ValveBiped.Bip01_Head1", Vector(0.014, 0.014, 0.025), "models/debug/debugwhite", Color(0, 0, 0, 255))
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(4.844, 6.804, 1.886), Angle(-1.275, 3.24, 93.813), "ValveBiped.Bip01_Head1", Vector(0.014, 0.014, 0.029), "models/debug/debugwhite", Color(0, 0, 0, 255))
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(3.477, 6.774, 2.312), Angle(180, 3.217, 86.252), "ValveBiped.Bip01_Head1", Vector(0.046, 0.026, 0.046), "models/debug/debugwhite")
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(3.079, 6.453, -2.263), Angle(180, 3.217, 86.252), "ValveBiped.Bip01_Head1", Vector(0.065, 0.035, 0.065), "models/debug/debugwhite", Color(0, 0, 0, 255))
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(3.079, 6.079, 0), Angle(-1.275, 3.24, 93.813), "ValveBiped.Bip01_Head1", Vector(0.126, 0.12, 0.266), "models/debug/debugwhite", Color(0, 0, 0, 255))
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(0.277, 6.868, -0.251), Angle(9.678, 3.23, 93.813), "ValveBiped.Bip01_Head1", Vector(0.02, 0.035, 0.02), "models/debug/debugwhite", Color(255, 167, 255, 255))
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(3.079, 6.449, -0.08), Angle(-1.275, 3.24, 93.813), "ValveBiped.Bip01_Head1", 0.111, "models/debug/debugwhite", Color(255, 179, 0, 255))
c:AddModel("models/hunter/tubes/circle2x2c.mdl", Vector(3.079, 6.774, 2.332), Angle(180, 3.217, 86.252), "ValveBiped.Bip01_Head1", Vector(0.065, 0.035, 0.045), "models/debug/debugwhite", Color(0, 0, 0, 255))
c.Author = "Crespo"
c.AuthorID = "STEAM_0:1:8755559"
