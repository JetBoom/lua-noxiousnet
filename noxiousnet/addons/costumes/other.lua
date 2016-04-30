local c

c = Costume("naziarmband")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_phx/construct/concrete_pipe01.mdl", Vector(2, 0, -0.7), Angle(0, 270, 270), "ValveBiped.Bip01_L_UpperArm", Vector(0.08, 0.05, 0.044), nil, Color(255, 0, 0, 255))
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(-1.351, 2.3, 3.4), Angle(0, 90, 0), nil, Vector(0.025, 0.025, 0.025), nil, Color(10, 10, 10, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(1.2, 2.3, 1.7), Angle(0, 90, 0), nil, Vector(0.025, 0.025, 0.025), nil, Color(10, 10, 10, 255), 1)
c:AddModel("models/props_phx/construct/metal_angle360.mdl", Vector(0, 2.3, 2.5), Angle(0, 0, 270), nil, Vector(0.05, 0.02, 0.05), "models/props_debris/plasterwall034a", Color(220, 220, 220, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(0.8, 2.3, 4), Angle(0, 90, 90), nil, Vector(0.025, 0.025, 0.025),  nil, Color(10, 10, 10, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(0, 2.3, 3.4), Angle(0, 90, 0), nil, Vector(0.025, 0.025, 0.025),  nil, Color(10, 10, 10, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(0.6, 2.3, 2.4), Angle(0, 90, 90), nil, Vector(0.025, 0.025, 0.025), nil, Color(10, 10, 10, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(-0.75, 2.3, 1), Angle(0, 90, 90), nil, Vector(0.025, 0.025, 0.025), nil, Color(10, 10, 10, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(-0.75, 2.3, 2.4), Angle(0, 90, 90), nil, Vector(0.025, 0.025, 0.025), nil, Color(10, 10, 10, 255), 1)
c:AddModel("models/props_phx/construct/concrete_pipe01.mdl", Vector(0, 0, -0.5), Angle(0, 0, 0), nil, Vector(0.075, 0.045, 0.05), nil, Color(10, 10, 10, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(0, 2.3, 1.6), Angle(0, 90, 0), nil, Vector(0.025, 0.025, 0.025), nil, Color(10, 10, 10, 255), 1)

c = Costume("condevil")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/doll01.mdl", Vector(2, -2, -7), Angle(180, 90, 90), "ValveBiped.Bip01_Head1", 0.5, nil, Color(200, 0, 0, 255))
c:AddModel("models/props_c17/tools_wrench01a.mdl", Vector(0, 0.47, 0.5), Angle(-9.8, 90, 90), nil, 0.35, nil, Color(0, 0, 0, 255), 1)
c:AddModel("models/Gibs/HGIBS_rib.mdl", Vector(-0.8, 0, 0), Angle(0, 0, 90), nil, 0.3, nil, Color(0, 0, 0, 255), 1)
c.Author = "Benjy"
c.AuthorID = "STEAM_0:0:25307180"

c = Costume("conangel")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/doll01.mdl", Vector(2, -2, 7), Angle(180, 90, 90), "ValveBiped.Bip01_Head1", 0.5, "models/debug/debugwhite")
c:AddModel("models/props_vehicles/carparts_tire01a.mdl", Vector(0, 0, 5), Angle(0, 0, 90), nil, 0.05, "models/shiny", Color(255, 255, 0, 255), 1)
c.Author = "Benjy"
c.AuthorID = "STEAM_0:0:25307180"

c = Costume("drillarm")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/misc/cone2x2.mdl", Vector(-0.782, 0, 0), Angle(-106.75, -10.707, 0), "ValveBiped.Bip01_L_Hand", Vector(0.1, 0.1, 0.247), "phoenix_storms/MetalSet_1-2")
c:AddModel("models/props_vehicles/tire001c_car.mdl", Vector(-0.026, 0.168, 0), Angle(90, 178.768, 0), 1, 0.3, "models/debug/debugwhite", Color(32, 32, 32, 255), 1)
c:AddColorOptions()
c.Author = "Rexen"
c.AuthorID = "STEAM_0:1:17453284"

c = Costume("shieldzombie")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(5.818, -0.038, 3.413), Angle(0, 0, 0), "ValveBiped.Bip01_L_Forearm", 0.194, "models/props_pipes/GutterMetal01a", Color(100, 126, 184, 255))
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(0, 0, 0.324), Angle(0, 45, 0), nil, Vector(0.17, 0.17, 0.009), "models/props_pipes/GutterMetal01a", Color(255, 0, 0, 255), 1)
c:AddModel("models/Zombie/Classic_torso.mdl", Vector(0.643, -1.226, 0.349), Angle(0, -110.031, 0), nil, Vector(0.272, 0.272, 0.003), nil, Color(155, 155, 155, 255), 1)
c:AddModel("models/hunter/tubes/tube2x2x05c.mdl", Vector(0, 0, 0), Angle(90, 0, 0), nil, Vector(0.131, 0.082, 0.131), "models/props_c17/FurnitureMetal001a", Color(75, 75, 75, 255), 1)
c.Author = "Dick Santorum"
c.AuthorID = "STEAM_0:0:14898858"

c = Costume("shieldhorse")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(5.819, -0.038, 3.413), Angle(0, 0, 0), "ValveBiped.Bip01_L_Forearm", 0.194, "models/props_pipes/GutterMetal01a", Color(100, 126, 184, 255))
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(0, 0, 0.325), Angle(0, 45, 0), nil, Vector(0.17, 0.17, 0.01), "models/props_pipes/GutterMetal01a", Color(255, 0, 0, 255), 1)
c:AddModel("models/props_c17/statue_horse.mdl", Vector(3.781, 1.156, 0.363), Angle(0, -110.031, 90), nil, Vector(0.041, 0.001, 0.041), nil, Color(200, 150, 100, 255), 1)
c:AddModel("models/hunter/tubes/tube2x2x05c.mdl", Vector(0, 0, 0), Angle(90, 0, 0), nil, Vector(0.132, 0.082, 0.132), "models/props_c17/FurnitureMetal001a", Color(75, 75, 75, 255), 1)
c.Author = "Dick Santorum"
c.AuthorID = "STEAM_0:0:14898858"

c = Costume("akuakumask")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/Items/item_item_crate_chunk02.mdl", Vector(5.5, -5, 10), Angle(-80, 115, 10), "ValveBiped.Bip01_Head1", Vector(1.25, 0.3, 1))
c:AddModel("models/props_borealis/mooring_cleat01.mdl", Vector(0, 2, 0), Angle(180, 80, 0), nil, Vector(0.125, 0.113, 0.025), "models/debug/debugwhite", Color(255, 115, 0, 255), 1)
c:AddModel("models/props_interiors/Furniture_Couch01a.mdl", Vector(0, -3.25, -0.531), Angle(-167.5, -77.5, 0), nil, Vector(0.06, 0.073, 0.03), "models/debug/debugwhite", Color(150, 30, 0, 255), 1)
c:AddModel("models/props_foliage/tree_poplar_01.mdl", Vector(-1.75, 4.35, 0), Angle(-100, 0, 120), nil, 0.01, "models/debug/debugwhite", Color(0, 255, 255, 255), 1)
c:AddModel("models/Items/item_item_crate_chunk02.mdl", Vector(1.25, 0.25, 0.5), Angle(0, 1, 0), nil, Vector(0.2, 0.235, 0.425), "models/debug/debugwhite", Color(150, 30, 0, 255), 2)
c:AddModel("models/props_foliage/tree_poplar_01.mdl", Vector(0, -4, -0.5), Angle(0, 0, -90), nil, Vector(0.007, 0.007, 0.003), "models/debug/debugwhite", Color(0, 255, 0, 255), 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(-0.175, 0, 0), Angle(75, 0, 0), nil, Vector(0.1, 0.3, 0.025), "models/props_wasteland/wood_fence01a_skin2", nil, 3)
c:AddModel("models/props/cs_office/Snowman_nose.mdl", Vector(0, -0.3, -1.8), Angle(0, 170, -90), nil, Vector(2, 1.325, 2), "models/debug/debugwhite", Color(150, 30, 0, 255), 1)
c:AddModel("models/props_foliage/tree_poplar_01.mdl", Vector(0, 4.75, -0.075), Angle(-180, 0, 100), nil, 0.01, "models/debug/debugwhite", Color(255, 0, 0, 255), 1)
c:AddModel("models/props_foliage/tree_poplar_01.mdl", Vector(2, 4.45, 0), Angle(-90, 0, 60), nil, 0.01, "models/debug/debugwhite", Color(0, 255, 0, 255), 1)
c.Author = "PseudoHorse"
c.AuthorID = "STEAM_0:1:42272799"

c = Costume("plank")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(6.1, 2, 1), Angle(-175, -110, 180), "ValveBiped.Bip01_L_Hand", Vector(0.5, 0.325, 0.3), "phoenix_storms/fender_wood")
c:AddModel("models/props_c17/streetsign002b.mdl", Vector(0.5, -1.2, 5.65), Angle(0, 90, 0), nil, 0.01, "models/debug/debugwhite", Color(0, 230, 255, 255), 1)
c:AddModel("models/props_c17/streetsign002b.mdl", Vector(0.5, 0.85, 6.5), Angle(0, 90, 0), nil, 0.01, "models/debug/debugwhite", Color(0, 230, 255, 255), 1)
c:AddModel("models/props_debris/rebar001a_32.mdl", Vector(0.36, 0, 3), Angle(0, 5, 40), nil, Vector(0.23, 0.425, 0.125), "models/debug/debugwhite", Color(0, 210, 255, 255), 1)
c:AddModel("models/props_vehicles/tire001b_truck.mdl", Vector(0.045, 0.85, 6.75), Angle(0, 0, 1.5), nil, Vector(0.075, 0.045, 0.075), "models/debug/debugwhite", Color(255, 0, 0, 255), 1)
c:AddModel("models/props_vehicles/tire001b_truck.mdl", Vector(0.045, -1.2, 5.6), Angle(0, 0, -85), nil, Vector(0.075, 0.023, 0.035), "models/debug/debugwhite", Color(255, 0, 0, 255), 1)
c.Author = "Chubfish"
c.AuthorID = "STEAM_0:1:10177246"

c = Costume("shoppingbasket")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/playground_swingset01.mdl", Vector(-0.382, -6.813, 0.837), Angle(-89.981, -80.838, -21.625), "ValveBiped.Bip01_L_Forearm", Vector(0.08, 0.13, 0.08), nil, Color(0, 255, 0, 255))
c:AddModel("models/props_junk/food_pile02.mdl", Vector(0.6, 0.444, -2.213), Angle(0, 0, 0), nil, 0.2, nil, nil, 1)
c:AddModel("models/props_junk/garbage_milkcarton002a.mdl", Vector(-2.481, -4.738, -0.619), Angle(0, 0, 0), nil, 0.356, nil, Color(254, 255, 255, 255), 1)
c:AddModel("models/props_junk/garbage128_composite001d.mdl", Vector(2.943, 0.163, -3.044), Angle(0, 0, 0), nil, 0.098, nil, nil, 1)
c:AddModel("models/props_junk/watermelon01.mdl", Vector(0, 1.7, -1.856), Angle(9.006, -80.737, 0), nil, 0.238, nil, nil, 1)
c:AddModel("models/props_junk/GlassBottle01a.mdl", Vector(2.799, -4.736, 1.169), Angle(0, 0, 0), nil, 0.737, nil, nil, 1)
c:AddModel("models/props_junk/PlasticCrate01a.mdl", Vector(0.144, -0.356, -3.024), Angle(0, 90, 0), nil, 0.56, nil, Color(0, 255, 255, 255), 1)
c.Author = "drbroly"
c.AuthorID = "STEAM_0:0:20385712"

c = Costume("carslippers")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_vehicles/car004a.mdl", Vector(4.749, 0, 0), Angle(0, -29.725, 90), "ValveBiped.Bip01_L_Foot", 0.1)
c:AddModel("models/props_vehicles/car004a.mdl", Vector(4.749, 0, 0), Angle(0, -29.725, 90), "ValveBiped.Bip01_R_Foot", 0.1)
c:AddColorOptions()
c.Author = "DrAgOn"
c.AuthorID = "STEAM_0:0:15322972"

c = Costume("lightsaber")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props/cs_assault/pylon.mdl", Vector(2, 1, 4.5), Angle(0, 0, 0), "ValveBiped.Bip01_L_Hand", Vector(0.194, 0.194, 0.35), "models/props_combine/masterinterface01c")
c:AddModel("models/props_trainstation/trashcan_indoor001b.mdl", Vector(0, 0, -3.963), Angle(0, 0, 0), nil, Vector(0.08, 0.08, 0.174), "models/props/cs_militia/milwall006", Color(150, 150, 150, 255), 1)
c:AddColorOptions()
c.Author = "RdJ"
c.AuthorID = "STEAM_0:1:11822143"

c = Costume("hookhand")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_junk/meathook001a.mdl", Vector(7, 0, 1.675), Angle(180, -90, 90), "ValveBiped.Bip01_L_Hand", 0.5, nil, nil)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(-0.5, -1.22, 2.5), Angle(-180, 0, 0), nil, Vector(0.07, 0.07, 0.11), "models/props_pipes/GutterMetal01a", Color(160, 160, 160, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(-0.5, -1.22, 2.5), Angle(0, 0, 0), nil, Vector(0.07, 0.07, 0.11), "models/props_pipes/GutterMetal01a", Color(160, 160, 160, 255), 1)
c:AddColorOptions()
c.Author = "ReaM"
c.AuthorID = "STEAM_0:0:26824596"

c = Costume("headcrabslippers")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/headcrabclassic.mdl", Vector(4.5, 6.788, 0.167), Angle(180, 164, 90), "ValveBiped.Bip01_L_Foot", 0.95)
c:AddModel("models/headcrabclassic.mdl", Vector(4.5, 6.825, 1.374), Angle(180, 164, 90), "ValveBiped.Bip01_R_Foot", 0.95)
c:AddColorOptions()
c.Author = "Exhale"
c.SteamID = "STEAM_0:1:9167704"

c = Costume("sparx")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/canister02a.mdl", Vector(7.5, -2.5, 15), Angle(-75, 20, 120), "ValveBiped.Bip01_Head1", Vector(0.15, 0.15, 0.225), "models/debug/debugwhite")
c:AddModel("models/props_junk/watermelon01.mdl", Vector(0.35, -1.15, 6.3), Angle(26.8, -90, -100), nil, Vector(0.225, 0.25, 0.275), "models/debug/debugwhite", nil, 1)
c:AddModel("models/Combine_Helicopter/helicopter_bomb01.mdl", Vector(-2.45, -4.4, -2.7), Angle(65, 115, 90), nil, Vector(0.075, 0.35, 0.015), "models/debug/debugwhite", Color(255, 175, 255, 255), 1)
c:AddModel("models/props_junk/watermelon01.mdl", Vector(-1, 1.7, -1.05), Angle(0, 12.175, 0), nil, 0.1, "models/debug/debugwhite", Color(255, 255, 254, 255), 2)
c:AddModel("models/props_junk/watermelon01.mdl", Vector(-0.775, 2.25, -1.05), Angle(0, 12.175, 0), nil, Vector(0.06, 0.055, 0.06), "models/debug/debugwhite", Color(0, 0, 0, 255), 2)
c:AddModel("models/props_junk/watermelon01.mdl", Vector(-1, 1.7, 1.05), Angle(0, 12.175, 0), nil, 0.1, "models/debug/debugwhite", Color(255, 255, 254, 255), 2)
c:AddModel("models/Combine_Helicopter/helicopter_bomb01.mdl", Vector(5.5, 0, 3), Angle(-70, 0, 90), nil, Vector(0.075, 0.35, 0.015), "models/debug/debugwhite", Color(255, 175, 254, 255), 1)
c:AddModel("models/Combine_Helicopter/helicopter_bomb01.mdl", Vector(-4, -4.4, 3), Angle(110, 130, 90), nil, Vector(0.075, 0.35, 0.015), "models/debug/debugwhite", Color(255, 175, 255, 255), 1)
c:AddModel("models/Combine_Helicopter/helicopter_bomb01.mdl", Vector(5.4, -1.35, -2.7), Angle(-115, 15, 90), nil, Vector(0.075, 0.35, 0.015), "models/debug/debugwhite", Color(255, 175, 255, 255), 1)
c:AddModel("models/props_junk/watermelon01.mdl", Vector(0.075, -1, 7.081), Angle(0, 0, 131.919), nil, Vector(0.225, 0.15, 0.1), "models/debug/debugwhite", Color(255, 105, 180, 255), 1)
c:AddModel("models/props_junk/watermelon01.mdl", Vector(-0.775, 2.25, 1.05), Angle(0, 12.175, 0), nil, Vector(0.06, 0.055, 0.06), "models/debug/debugwhite", Color(0, 0, 0, 255), 2)
c:AddColorOptions()
c.Author = "PseudoHorse"
c.AuthorID = "STEAM_0:1:42272799"

c = Costume("ufo")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/tubes/tube4x4x1to2x2.mdl", Vector(3.994, -0.399, -22.951), Angle(0.95, 92.912, 86.925), "ValveBiped.Bip01_Head1", Vector(0.113, 0.113, 0.042), "models/shiny", Color(120, 120, 120, 255))
c:AddModel("models/hunter/tubes/tube4x4x1to2x2.mdl", Vector(0, 0, -4.03), Angle(179.962, 4.125, 0.338), nil, Vector(0.113, 0.113, 0.042), "models/shiny", Color(120, 120, 120, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(0.031, -0.194, -0.256), Angle(0, 0, 1.018), nil, Vector(0.106, 0.106, 0.079), "models/shiny", Color(120, 120, 120, 255), 1)
c:AddModel("models/props_phx/cannonball.mdl", Vector(-4.612, -1.768, 0.237), Angle(-29.907, 0, 0), nil, Vector(0.03, 0.03, 0.054), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(0, 0, -3.788), Angle(180, 0, 0), nil, Vector(0.106, 0.106, 0.079), "models/shiny", Color(120, 120, 120, 255), 1)
c:AddModel("models/props_phx/cannonball.mdl", Vector(-4.699, 1.169, 0.237), Angle(-29.907, 0, 0), nil, Vector(0.03, 0.03, 0.054), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c.Author = "Crucket"
c.AuthorID = "STEAM_0:1:19442508"

c = Costume("spikewristbands")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/mechanics/wheels/wheel_spike_24.mdl", Vector(11.319, 0, 0), Angle(90, 6, 0), "ValveBiped.Bip01_R_Forearm", 0.241)
c:AddModel("models/mechanics/wheels/wheel_spike_24.mdl", Vector(11.319, 0, 0), Angle(90, 6, 0), "ValveBiped.Bip01_L_Forearm", 0.241)
c:AddColorOptions()
c.Author = "Remnic"
c.AuthorID = "STEAM_0:1:18880707"

c = Costume("wristwatch")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_vehicles/carparts_wheel01a.mdl", Vector(-2, 0.375, 0.12), Angle(0, -90, 0), "ValveBiped.Bip01_L_Hand", 0.14)
c:AddModel("models/props_trainstation/trainstation_clock001.mdl", Vector(-2.45, 0, 0), Angle(180, 0, 0), nil, Vector(0.1, 0.05, 0.05), nil, nil, 1)
c:AddColorOptions()
c.Author = "ReaM"
c.AuthorID = "STEAM_0:0:26824596"

c = Costume("armcannon")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(0.4, 0.15, -0.625), Angle(-83.475, 0.425, -0.375), "ValveBiped.Bip01_L_Forearm", Vector(0.285, 0.285, 0.2), "models/props_debris/metalwall001a")
c:AddModel("models/props_c17/lampShade001a.mdl", Vector(0, 0, 11.775), Angle(0.1, 2.025, -0.15), nil, 0.485, "models/props_debris/metalwall001a", nil, 1)
c:AddModel("models/Effects/combineball.mdl", Vector(0, 0, 17.3), Angle(-87.475, 105.475, -180), nil, 0.325, nil, nil, 1)
c:AddModel("models/props_trainstation/trainstation_clock001.mdl", Vector(-0.05, -0.05, 14.525), Angle(-90.15, 6.1, 1.65), nil, 0.064, "models/shiny", Color(255, 165, 0, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("sonicshoes")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/gibs/helicopter_brokenpiece_04_cockpit.mdl", Vector(0.75, -0.875, 0), Angle(0, 70, -90), "ValveBiped.Bip01_L_Foot", 0.1, "phoenix_storms/barrel_fps")
c:AddModel("models/gibs/helicopter_brokenpiece_04_cockpit.mdl", Vector(0.75, -0.875, 0), Angle(0, 70, -90), "ValveBiped.Bip01_R_Foot", 0.1, "phoenix_storms/barrel_fps")
c:AddModel("models/gibs/helicopter_brokenpiece_04_cockpit.mdl", Vector(0, 0, -5), Angle(150, 0, 0), nil, 0.1, "phoenix_storms/barrel_fps", nil, 1)
c:AddModel("models/gibs/helicopter_brokenpiece_04_cockpit.mdl", Vector(0, 0, -5), Angle(150, 0, 0), nil, 0.1, "phoenix_storms/barrel_fps", nil, 2)
c.Author = "I Waste Air"
c.AuthorID = "STEAM_0:1:5288558"

c = Costume("megabuster")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_phx/cannonball.mdl", Vector(11.226, 0, -4.719), Angle(0, 90, -2.368), "ValveBiped.Bip01_L_Forearm", Vector(0.365, 0.19, 0.19), "models/shiny", Color(0, 99, 255, 255))
c:AddModel("models/props_phx/misc/potato_launcher_chamber.mdl", Vector(0, 7.763, 4.594), Angle(0, 0, 85.688), nil, 0.344, "models/shiny", Color(0, 99, 255, 255), 1)
c:AddModel("models/hunter/blocks/cube025x1x025.mdl", Vector(0.557, 0, 7.512), Angle(0, 0, 0), nil, Vector(0.087, 0.099, 0.087), "models/shiny", Color(255, 150, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(0, 0, 0), Angle(0, 0, 0), nil, Vector(0.031, 0.031, 0.01), "models/shiny", Color(255, 150, 0, 255), 2)
c.Author = "Crucket"
c.AuthorID = "STEAM_0:1:19442508"

c = Costume("lifecapsule")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/tubes/tube2x2x2.mdl", Vector(-10.212, -0.987, 0), Angle(0, 0, 0), "ValveBiped.Bip01_Pelvis", Vector(0.057, 0.057, 0.101), "phoenix_storms/glass", Color(254, 255, 255, 255))
c:AddModel("models/props_lab/rotato.mdl", Vector(0, 0, -4.725), Angle(0, 0, 90), nil, 0.943, nil, Color(254, 255, 255, 255), 1)
c:AddModel("models/props_lab/rotato.mdl", Vector(0, 0, 4.724), Angle(0, 0, 90), nil, 0.943, nil, Color(254, 255, 255, 255), 1)
c:AddModel("models/balloons/balloon_classicheart.mdl", Vector(0, 2.424, 0), Angle(90, 0, -90), nil, 0.259, "models/cs_italy/light_orange", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("911p")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/geometric/pent1x1.mdl", Vector(-1.793, 0, 0), Angle(90, -14.554, 0), "ValveBiped.Bip01_Head1", Vector(0.142, 0.142, 0.497), "phoenix_storms/trains/track_plateside")
c:AddModel("models/Gibs/HGIBS.mdl", Vector(-1.77, -3.326, -0.002), Angle(59.931, -47.312, 0), nil, Vector(0.437, 0.721, 0.574), "models/effects/splode1_sheet", nil, 1)
c:AddModel("models/xqm/jetbody3.mdl", Vector(-3.264, -5.103, 0), Angle(163.432, 35.499, -4.191), nil, 0.021, nil, nil, 1)
c:AddModel("models/Gibs/HGIBS.mdl", Vector(-1.77, -3.326, -0.002), Angle(59.931, -47.312, 0), nil, Vector(0.426, 0.499, 0.46), "models/effects/splode_sheet", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("brotherbobby")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/XQM/Rails/gumball_1.mdl", Vector(7.313, -0.394, 8), Angle(13.938, 0, 0), "ValveBiped.Bip01_Head1", 0.213, "models/debug/debugwhite", Color(0, 70, 135, 255))
c:AddModel("models/XQM/Rails/gumball_1.mdl", Vector(-7.576, -0.455, 2.074), Angle(0, 0, 0), nil, 0.047, "models/debug/debugwhite", Color(0, 70, 135, 255), 1)
c:AddModel("models/XQM/Rails/gumball_1.mdl", Vector(-4.825, 0.094, 1.356), Angle(76.813, 0, 0), nil, Vector(0.116, 0.116, 0.172), "models/debug/debugwhite", Color(0, 70, 135, 255), 1)
c:AddModel("models/XQM/Rails/gumball_1.mdl", Vector(-3.931, -0.106, 3.194), Angle(35.475, 0, 0), nil, Vector(0.035, 0.035, 0.079), "models/debug/debugwhite", Color(0, 70, 135, 255), 1)
c:AddModel("models/Mechanics/robotics/a2.mdl", Vector(0.988, 2.844, 1.081), Angle(129.432, -10.249, 0), nil, 0.038, "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/XQM/Rails/gumball_1.mdl", Vector(-4.824, -0.036, -0.575), Angle(-65.625, 0, 0), nil, Vector(0.035, 0.035, 0.079), "models/debug/debugwhite", Color(0, 70, 135, 255), 1)
c:AddModel("models/Mechanics/robotics/a2.mdl", Vector(0.988, 2.862, 1.081), Angle(19.513, 25.401, 0), nil, 0.038, "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/Mechanics/robotics/a2.mdl", Vector(0.425, 2.625, -1.875), Angle(-156.137, -26.644, 0), nil, 0.038, "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_angle180.mdl", Vector(-1.475, 2.318, 0), Angle(168.6, -14.768, 91.544), nil, Vector(0.032, 0.022, 0.176), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/Mechanics/robotics/a2.mdl", Vector(0.425, 2.544, -1.875), Angle(-39.718, 43.256, 0), nil, 0.038, "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c.Author = "Crucket"
c.AuthorID = "STEAM_0:1:19442508"

c = Costume("p3pin")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_phx/construct/metal_angle90.mdl", Vector(-3.275, -8.475, 4.325), Angle(0, 159.325, 60.2), "ValveBiped.Bip01_Spine4", 0.035, "models/debug/debugwhite", Color(0, 0, 0, 255))
c:AddModel("models/props_phx/construct/metal_angle90.mdl", Vector(0, 0, 0), Angle(0, -90, 0), nil, 0.035, "models/debug/debugwhite", nil, 1)
c:AddModel("models/props_phx/construct/metal_angle360.mdl", Vector(0, 0, -0.125), Angle(0, 0, 0), nil, 0.045, "models/debug/debugwhite", Color(255, 0, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_angle90.mdl", Vector(0, 0, 0), Angle(0, 90, 0), nil, 0.035, "models/debug/debugwhite", nil, 1)
c:AddModel("models/props_phx/construct/metal_angle90.mdl", Vector(0, 0, 0), Angle(0, -180, 0), nil, 0.035, "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("wristblades")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_pipes/concrete_pipe001a.mdl", Vector(9.601, 0.081, -0.027), Angle(0.718, -0.682, 127.875), "ValveBiped.Bip01_L_Forearm", Vector(0.023, 0.046, 0.046), "models/props_c17/metalladder001", nil)
c:AddModel("models/Gibs/Antlion_gib_medium_3.mdl", Vector(6.518, -3.069, -2.205), Angle(-137.024, -107.769, -6.424), nil, Vector(0.369, 0.519, 0.7), "models/props_c17/metalladder001", nil, 1)
c:AddModel("models/Gibs/gunship_gibs_midsection.mdl", Vector(-0.637, -1.276, -0.988), Angle(-21.606, 28, -119.8), nil, Vector(0.067, 0.08, 0.08), "models/props_c17/metalladder001", nil, 1)
c:AddModel("models/props_pipes/concrete_pipe001a.mdl", Vector(10.432, 0.024, 0.085), Angle(4.168, 6.487, -77.276), "ValveBiped.Bip01_R_Forearm", Vector(0.023, 0.046, 0.046), "models/props_c17/metalladder001", nil)
c:AddModel("models/Gibs/Antlion_gib_medium_3.mdl", Vector(6.518, -3.069, -2.205), Angle(-137.024, -107.769, -6.424), nil, Vector(0.369, 0.519, 0.7), "models/props_c17/metalladder001", nil, 4)
c:AddModel("models/Gibs/gunship_gibs_midsection.mdl", Vector(-0.637, -1.276, -0.988), Angle(-21.606, 28, -119.8), nil, Vector(0.067, 0.08, 0.08), "models/props_c17/metalladder001", nil, 4)
c:AddColorOptions()
c.Author = "The Darker One"
c.AuthorID = "STEAM_0:0:15529330"

c = Costume("pokeball")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(3.856, 2.207, 0.325), Angle(38.206, -33.737, 180), "ValveBiped.Bip01_L_Hand", 0.041, "debug/debugdrawflat")
c:AddModel("models/props_phx/construct/metal_angle360.mdl", Vector(1.9, 0, 0), Angle(90, 0, 0), nil, 0.022, "debug/debugdrawflat", Color(0, 0, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_angle360.mdl", Vector(2, 0, 0), Angle(90, 0, 0), nil, 0.01, "debug/debugdrawflat", nil, 1)
c:AddModel("models/props_phx/construct/metal_dome360.mdl", Vector(0, 0, 0), Angle(180, 0, 0), nil, 0.041, "debug/debugdrawflat", Color(255, 0, 0, 255), 1)
c:AddModel("models/props_phx/construct/metal_angle360.mdl", Vector(0, 0, -0.693), Angle(0, 0, 0), nil, Vector(0.041, 0.33, 0.042), "debug/debugdrawflat", Color(0, 0, 0, 255), 1)

c = Costume("picarms")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(2.612, -0.506, -1.5), Angle(180, 15.749, 93.475), "ValveBiped.Bip01_R_UpperArm", Vector(0.187, 0.1, 0.106), "phoenix_storms/middle", Color(255, 146, 236, 255))
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(3, -1, 1.4), Angle(-170, -19, -50), "ValveBiped.Bip01_L_UpperArm", Vector(0.187, 0.1, 0.106), "phoenix_storms/middle", Color(255, 146, 236, 255))
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(-6, 1, 4.3), Angle(-13, -12.5, 75), nil, Vector(0.15, 0.1, 0.106), "phoenix_storms/middle", Color(255, 146, 236, 255), 1)
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(6.2, -1, 1.4), Angle(-170, -19, -50), "ValveBiped.Bip01_L_Forearm", Vector(0.187, 0.1, 0.106), "phoenix_storms/middle", Color(255, 146, 236, 255))
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(-7, 2.5, 0.713), Angle(-30, 30, -90), nil, Vector(0.15, 0.1, 0.106), "phoenix_storms/middle", Color(255, 146, 236, 255), 2)
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(6.2, 0, -1.5), Angle(180, 18.269, 90), "ValveBiped.Bip01_R_Forearm", Vector(0.187, 0.1, 0.106), "phoenix_storms/middle", Color(255, 146, 236, 255))
c.Author = "West Nile"
c.AuthorID = "STEAM_0:1:682450"

c = Costume("alchemistblade")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/Gibs/HGIBS.mdl", Vector(4.091, 0.455, -0.955), Angle(1.023, -17.386, -113.524), "ValveBiped.Bip01_R_Hand", Vector(0.936, 1.003, 0.833), "Models/props_pipes/PipeMetal004a", Color(104, 105, 133, 255))
c:AddModel("models/props_c17/streetsign005b.mdl", Vector(22.09, 0.455, 0.555), Angle(-17.386, 90, 90), "ValveBiped.Bip01_L_Forearm", Vector(0.372, 1.2, 1.2), "Models/props_pipes/PipeMetal001a", Color(224, 221, 255, 255))
c:AddModel("models/Gibs/Antlion_gib_small_1.mdl", Vector(4.091, -1.364, -2.274), Angle(-30.583, 12.576, 0.28), nil, Vector(0.709, 0.409, 0.709), "Models/props_pipes/PipeMetal004a", Color(50, 50, 50, 255), 1)
c:AddModel("models/Gibs/Antlion_gib_small_1.mdl", Vector(-1.364, -4.092, -2.274), Angle(-34.863, 88.019, 0.28), nil, Vector(0.709, 0.597, 0.709), "Models/props_pipes/PipeMetal004a", Color(50, 50, 50, 255), 1)
c:AddModel("models/Gibs/Antlion_gib_small_1.mdl", Vector(2.273, -3.182, -1.765), Angle(-30.583, 45.057, 0.28), nil, Vector(0.709, 0.409, 0.709), "Models/props_pipes/PipeMetal004a", Color(50, 50, 50, 255), 1)
c:AddModel("models/Combine_Helicopter/helicopter_bomb01.mdl", Vector(-0.12, -0.113, 1.564), Angle(-5.114, 1.023, -4.657), nil, Vector(0.115, 0.17, 0.1), nil, Color(255, 0, 0, 255), 1)
c:AddModel("models/Gibs/Antlion_gib_small_1.mdl", Vector(4.091, 1.363, -1.765), Angle(-30.583, -17.605, 0.28), nil, Vector(0.709, 0.409, 0.709), "Models/props_pipes/PipeMetal004a", Color(50, 50, 50, 255), 1)
c:AddModel("models/Gibs/Antlion_gib_small_1.mdl", Vector(2.273, 3.181, -1.364), Angle(-30.583, -36.811, 0.28), nil, Vector(0.709, 0.409, 0.709), "Models/props_pipes/PipeMetal004a", Color(50, 50, 50, 255), 1)
c:AddModel("models/gibs/scanner_gib02.mdl", Vector(-0.101, -0.456, -12.273), Angle(-37.841, 91.023, 46.022), nil, nil, nil, nil, 2)
c.Author = "The Darker One"
c.AuthorID = "STEAM_0:0:15529330"

c = Costume("holybook")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/gravestone_coffinpiece001a.mdl", Vector(5.7, 3, 0.7), Angle(-90, 130, 90), "ValveBiped.Bip01_L_Hand", Vector(0.08, 0.13, 0.08))
c:AddModel("models/props_lab/bindergraylabel01a.mdl", Vector(4.6, 4, -4), Angle(0, 130, 0), "ValveBiped.Bip01_L_Hand", Vector(0.7, 0.5, 0.8), nil, Color(100, 100, 100, 255))
c:AddColorOptions()
c.Author = "Pufulet"
c.AuthorID = "STEAM_0:1:19523408"

c = Costume("zombiekennel")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_lab/kennel_physics.mdl", Vector(19.1, 1, 0), Angle(90, 180, 180), "ValveBiped.Bip01_L_Hand", 0.37)
c:AddModel("models/Zombie/Classic_torso.mdl", Vector(0, -0.1, 1), Angle(0, -1, 0), nil, 0.29, nil, nil, 1)
c:AddColorOptions()
c.Author = "Rejax"
c.AuthorID = "STEAM_0:0:4100206"

c = Costume("steedfeet")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/statue_horse.mdl", Vector(-2, -14, 1), Angle(180, 25, 90), "ValveBiped.Bip01_R_Foot", 0.13)
c:AddModel("models/props_c17/statue_horse.mdl", Vector(-2, -14, 1), Angle(180, 25, 90), "ValveBiped.Bip01_L_Foot", 0.13)
c:AddColorOptions()
c.Author = "Pufulet"
c.AuthorID = "STEAM_0:1:19523408"

c = Costume("pugnawand")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_docks/dock03_pole01a_256.mdl", Vector(3, 2, 1), Angle(0, 0, 180), "ValveBiped.Bip01_L_Hand", Vector(0.1, 0.1, 0.075), nil, Color(30, 30, 30, 255))
c:AddModel("models/props_c17/canisterchunk02d.mdl", Vector(0, -0.2, -8), Angle(90, 0, -90), nil, Vector(0.9, 0.5, 0.13), "models/gibs/hgibs/skull1", Color(25, 25, 25, 255), 1)
c:AddModel("models/props_c17/canisterchunk02d.mdl", Vector(0, 0.2, -8), Angle(90, 0, 90), nil, Vector(0.9, 0.5, 0.13), "models/gibs/hgibs/skull1", Color(25, 25, 25, 255), 1)
c:AddModel("models/hunter/tubes/tube4x4x2to2x2.mdl", Vector(0, 0, -6.5), Angle(0, 0, 0), nil, Vector(0.026, 0.026, 0.032), nil, Color(25, 25, 25, 255), 1)
c:AddModel("models/props_phx/ball.mdl", Vector(0, 0, -11.5), Angle(0, 0, 0), nil, 0.12, "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/Gibs/HGIBS.mdl", Vector(-2, 0, -9), Angle(-90, -90, 90), nil, Vector(0.55, 0.55, 0.3), nil, Color(35, 35, 35, 255), 1)
c:AddModel("models/Gibs/HGIBS.mdl", Vector(2, 0, -9), Angle(-90, 90, 90), nil, Vector(0.55, 0.55, 0.3), nil, Color(35, 35, 35, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("dumbbell")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_silhouettes/pipeline_tallstructure01b_skybox.mdl", Vector(0, -8, 3), Angle(104, 89, 0), "ValveBiped.Anim_Attachment_LH", 0.2, nil, Color(60, 60, 60, 255))
c:AddModel("models/props_vehicles/carparts_wheel01a.mdl", Vector(0, 0, 1), Angle(0, 90, 90), nil, 0.25, nil, Color(60, 60, 60, 255), 1)
c:AddModel("models/props_vehicles/carparts_wheel01a.mdl", Vector(0, 0, 15), Angle(0, 90, 90), nil, 0.25, nil, Color(60, 60, 60, 255), 1)
c.Author = "Arty"
c.AuthorID = "STEAM_0:1:31017062"

c = Costume("codexofwisdom")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/tubes/tube2x2x025.mdl", Vector(0, -2, -0.5), Angle(8, -16, 97), "ValveBiped.Bip01_Pelvis", Vector(0.18, 0.14, 0.1), "models/props_c17/FurnitureFabric003a", Color(255, 200, 100, 255))
c:AddModel("models/hunter/triangles/05x05x05.mdl", Vector(10, 1.8, 1.5), Angle(-30, 0, 0), nil, Vector(0.1, 0.12, 0.1), "models/props_pipes/PipeMetal001a", Color(0, 200, 255, 255), 1)
c:AddModel("models/hunter/triangles/05x05x05.mdl", Vector(10, -2.7, 1.5), Angle(-30, 0, 90), nil, Vector(0.1, 0.1, 0.12), "models/props_pipes/PipeMetal001a", Color(0, 200, 255, 255), 1)
c:AddModel("models/hunter/triangles/05x05x05.mdl", Vector(11.6, -2.5, 4.4), Angle(-30, 0, 180), nil, Vector(0.1, 0.12, 0.1), "models/props_pipes/PipeMetal001a", Color(0, 200, 255, 255), 1)
c:AddModel("models/props_lab/binderblue.mdl", Vector(11, -4, 3), Angle(-120, 0, 90), nil, Vector(0.5, 0.7, 0.6), nil, Color(255, 125, 255, 255), 1)
c:AddModel("models/hunter/blocks/cube025x025x025.mdl", Vector(9, -0.5, 0.5), Angle(-160, 0, 90), nil, Vector(0.2, 0.13, 0.1), "models/props_c17/FurnitureFabric003a", Color(255, 200, 100, 255), 1)
c:AddModel("models/hunter/blocks/cube025x025x025.mdl", Vector(11, -0.5, 3), Angle(-120, 0, 90), nil, Vector(0.5, 0.2, 0.1), "models/props_c17/FurnitureFabric003a", Color(255, 200, 100, 255), 1)
c:AddModel("models/hunter/triangles/05x05x05.mdl", Vector(11.6, 1.45, 4.4), Angle(-30, 0, -90), nil, Vector(0.1, 0.1, 0.12), "models/props_pipes/PipeMetal001a", Color(0, 200, 255, 255), 1)
c.Author = "The Darker One"
c.AuthorID = "STEAM_0:0:15529330"

c = Costume("mooneye")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/XQM/Rails/gumball_1.mdl", Vector(18, -8, -5), Angle(0, 0, 0), "ValveBiped.Bip01_Head1", 0.3, nil, Color(254, 254, 254, 255))
c:AddModel("models/XQM/panel360.mdl", Vector(-2.9, 1.9, 0), Angle(0, 60, 0), nil, Vector(2, 0.09, 0.13), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(1, 3.2, 2), Angle(-25, 90, 0), nil, Vector(1.1, 0.025, 0.025), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/props/de_dust/dustteeth_5.mdl", Vector(-2.2, 4.6, 2), Angle(90, 60, -90), nil, Vector(0.011, 0.03, 0.03), "models/debug/debugwhite", Color(125, 125, 125, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(1, 3.2, -2), Angle(25, 90, 0), nil, Vector(1.1, 0.025, 0.025), "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(1, 3.2, 2), Angle(-25, 90, 0), nil, Vector(1, 0.06, 0.06), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/XQM/panel360.mdl", Vector(1, 3.2, -2), Angle(25, 90, 0), nil, Vector(1, 0.06, 0.06), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props/de_dust/dustteeth_5.mdl", Vector(-5, 2.9, 2), Angle(90, 60, 90), nil, Vector(0.011, 0.03, 0.03), "models/debug/debugwhite", Color(125, 125, 125, 255), 1)
c:AddModel("models/hunter/triangles/05x05.mdl", Vector(-0.5, 4, 0), Angle(0, -45, 0), nil, Vector(0.1, 0.1, 0.35), "models/xqm/rails/gumball_1", Color(254, 254, 254, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("claptrap")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_junk/TrashBin01a.mdl", Vector(8.5, 0, 6.5), Angle(0, 90, 90), "ValveBiped.Bip01_Spine4", 0.18, "models/props/cs_assault/metal_stairs1")
c:AddModel("models/props_lab/reciever01b.mdl", Vector(1.15, 0, -2.3), Angle(0, 0, 0), nil, 0.15, nil, nil, 1)
c:AddModel("models/props_rooftop/antenna04a.mdl", Vector(-1.5, 1.5, 5.5), Angle(0, 0, 0), nil, Vector(0.07, 0.07, 0.035), nil, nil, 1)
c:AddModel("models/props_pipes/concrete_pipe001b.mdl", Vector(1.5, 0, 2), Angle(0, 0, 0), nil, 0.017, "models/props/cs_assault/metal_stairs1", nil, 1)
c:AddModel("models/props_vehicles/carparts_wheel01a.mdl", Vector(0, 0, -5), Angle(0, 0, 0), nil, 0.09, nil, nil, 1)
c:AddModel("models/props_junk/Shovel01a.mdl", Vector(0.2, -2.2, -1), Angle(-5, -90, 0), nil, 0.1, "models/props/cs_assault/metal_stairs1", nil, 1)
c:AddModel("models/props_junk/Shovel01a.mdl", Vector(0.2, 2.2, -1), Angle(-5, 90, 0), nil, 0.1, "models/props/cs_assault/metal_stairs1", nil, 1)
c:AddModel("models/props_pipes/pipe02_connector01.mdl", Vector(2.3, 0, 2), Angle(0, 0, 0), nil, 0.11, "models/cs_italy/light_orange", Color(0, 125, 125, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("darkhand")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/XQM/panel360.mdl", Vector(1, 0, 0), Angle(-15, 0, 0), "ValveBiped.Bip01_L_Hand", Vector(0.01, 0.39, 0.55), "models/effects/portalrift_sheet")
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("decay")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/misc/shell2x2.mdl", Vector(3, 2, 0), Angle(0, 0, 180), "ValveBiped.Bip01_L_Hand", 0.09, "blackrockshooter/flame_blue")
c:AddModel("models/hunter/misc/shell2x2.mdl", Vector(3, 2, 0), Angle(0, 0, 0), "ValveBiped.Bip01_R_Hand", 0.09, "blackrockshooter/flame_blue")
c:AddModel("models/hunter/misc/shell2x2.mdl", Vector(0, 0, 0), Angle(0, 0, 0), nil, 0.12, "models/weapons/v_slam/new light2", Color(255, 255, 255, 125), 1)
c:AddModel("models/hunter/misc/shell2x2.mdl", Vector(0, 0, 0), Angle(0, 0, 0), nil, 0.12, "models/weapons/v_slam/new light2", Color(255, 255, 255, 125), 2)
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("estusflask")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props/cs_militia/bottle02.mdl", Vector(3, 1.1, -0.5), Angle(0, 0, 0), "ValveBiped.Bip01_L_Hand", Vector(0.65, 0.65, 0.4), "models/props_c17/metalladder002", Color(0, 200, 200, 225))
c:AddModel("models/props/cs_militia/bottle02.mdl", Vector(0, 0, 0), Angle(0, 0, 0), nil, Vector(0.66, 0.66, 0.4), "models/effects/comball_sphere", nil, 1)
c:AddModel("models/props_canal/rock_riverbed01d.mdl", Vector(0, 0, 2), Angle(0, 0, 90), nil, Vector(0.011, 0.017, 0.012), "models/props_combine/masterinterface01c", nil, 1)
c:AddModel("models/XQM/cylinderx1.mdl", Vector(0, 0, 5.35), Angle(90, 0, 0), nil, 0.16, "models/effects/comball_sphere", nil, 1)
c:AddModel("models/XQM/cylinderx1.mdl", Vector(0, 0, 5.35), Angle(90, 0, 0), nil, 0.15, "models/props_c17/metalladder002", Color(0, 200, 200, 225), 1)
c:AddForcedOption(COSTUMEOPTION_RENDERGROUP, RENDERGROUP_TRANSLUCENT)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("timbersaw")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(2.5, 0, -0.5), Angle(-30, 90, 90), "ValveBiped.Bip01_L_Forearm", Vector(0.315, 0.315, 0.35), "models/props_wasteland/wood_fence01a")
c:AddModel("models/props_phx/construct/plastic/plastic_angle_360.mdl", Vector(0, -3, 29), Angle(90, 0, 90), nil, Vector(0.1, 1.5, 0.25), "phoenix_storms/grey_steel", Color(125, 125, 125, 255), 1)
c:AddModel("models/props_phx/construct/plastic/plastic_angle_360.mdl", Vector(0, -3.3, 29), Angle(90, 0, 90), nil, Vector(0.07, 1.7, 0.2), "phoenix_storms/grey_steel", Color(175, 175, 175, 255), 1)
c:AddModel("models/Mechanics/robotics/g1.mdl", Vector(0, -0.35, 16.5), Angle(0, 90, 90), nil, Vector(0.13, 0.6, 0.24), "models/debug/debugwhite", Color(55, 55, 55, 255), 1)
c:AddModel("models/Mechanics/robotics/k1.mdl", Vector(0, -0.25, 30), Angle(90, 0, 0), nil, Vector(0.2, 0.25, 0.2), "phoenix_storms/grey_steel", nil, 1)
c:AddModel("models/props_junk/sawblade001a.mdl", Vector(0, -0.3, 30), Angle(0, 0, 90), nil, Vector(0.45, 0.8, 3.5), "models/shiny", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("watergun")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/FurnitureBoiler001a.mdl", Vector(9.545, 1.363, 2.273), Angle(-5.114, 86.931, 115.568), "ValveBiped.Bip01_L_Hand", Vector(0.15, 0.159, 0.15), "cs_italy/yellow", Color(255, 255, 0, 255))
c:AddModel("models/hunter/tubes/tube4x4x1to2x2.mdl", Vector(0.2, 0.455, 17), Angle(0, 0, 0), nil, Vector(0.009, 0.009, 0.019), "cs_italy/yellow", Color(255, 75, 0, 255), 1)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(0.1, -4.092, -10.455), Angle(0, 0, 0), nil, Vector(0.1, 0.1, 0.05), "cs_italy/yellow", Color(255, 255, 0, 255), 1)
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(0, -4.092, -2.274), Angle(-90, 0, 0), nil, 1.7, "cs_italy/yellow", Color(255, 255, 0, 255), 1)
c:AddModel("models/hunter/tubes/tube1x1x8.mdl", Vector(0.2, 0.455, 5), Angle(0, 0, 0), nil, 0.03, "cs_italy/yellow", nil, 1)
c:AddModel("models/props_interiors/bottles_shelf_break12.mdl", Vector(5.099, 5.908, -62.3), Angle(5.113, 0, -93.069), nil, Vector(1.23, 1.457, 0.606), "cs_italy/yellow", Color(255, 255, 0, 255), 1)
c:AddModel("models/props_wasteland/laundry_washer001a.mdl", Vector(0.15, 0.879, 8.199), Angle(0, 0, 0), nil, Vector(0.037, 0.045, 0.037), "cs_italy/yellow", Color(255, 255, 0, 255), 1)
c:AddModel("models/props_c17/canister01a.mdl", Vector(0, -4.092, -1), Angle(180, 0, 0), nil, Vector(0.469, 0.469, 0.349), "cs_italy/yellow", Color(0, 255, 0, 255), 1)
c:AddModel("models/props_c17/pipe_cap003.mdl", Vector(0.25, -6.301, -9.4), Angle(0, -94, 0), nil, 0.12, "cs_italy/yellow", Color(255, 75, 0, 255), 1)
c:AddModel("models/weapons/w_pist_elite_single.mdl", Vector(-0.601, 5, -8.636), Angle(90, 0, -90), nil, 0.5, "cs_italy/yellow", Color(255, 255, 0, 255), 1)
c.Author = "SoloTredici"
c.AuthorID = "STEAM_0:1:42033208"

c = Costume("molly")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/MaxOfS2D/companion_doll.mdl", Vector(-5.022, -1.01, 1.598), Angle(3.628, -76.219, 121.46), "ValveBiped.Bip01_R_Shoulder", 0.305)
c:AddModel("models/props_c17/signpole001.mdl", Vector(1.452, 3.233, 3.384), Angle(9.109, 2.253, -21.101), nil, 0.077, "models/debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/MaxOfS2D/balloon_classic.mdl", Vector(0.159, 0.342, 10.704), Angle(14.137, 0, -25.115), nil, 0.5, nil, nil, 1)
c:AddColorOptions()
c.Author = "Kolmio"
c.AuthorID = "STEAM_0:1:21756969"

c = Costume("puni")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/misc/shell2x2a.mdl", Vector(4.762, -0.866, 0), Angle(0, -11.53, -76.58), "ValveBiped.Bip01_R_Clavicle", Vector(0.097, 0.097, 0.122), "models/debug/debugwhite", Color(64, 152, 192, 255))
c:AddModel("models/hunter/misc/roundthing2.mdl", Vector(-1.759, -3.267, 2.653), Angle(0, 12.843, -65.338), nil, 0.01, "models/Debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/misc/roundthing2.mdl", Vector(0.958, -3.602, 2.733), Angle(0, 0, -65.338), nil, 0.01, "models/Debug/debugwhite", Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(-2.816, -3.391, 1.669), Angle(87.199, 20.687, -74.944), nil, Vector(0.009, 0.014, 0.009), "models/debug/debugwhite", Color(248, 128, 120, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(1.842, -4.153, 1.669), Angle(87.218, -40.918, -74.944), nil, Vector(0.009, 0.014, 0.009), "models/debug/debugwhite", Color(248, 128, 120, 255), 1)
c:AddModel("models/gibs/furniture_gibs/furniture_chair01a_gib02.mdl", Vector(-0.522, -4.194, 0.944), Angle(170.393, 67.333, 102.794), nil, Vector(0.365, 0.458, 0.151), "models/debug/debugwhite", Color(192, 40, 32, 255), 1)
c:AddModel("models/hunter/tubes/circle2x2.mdl", Vector(0, 0, 0.159), Angle(0, 0, 0), nil, 0.09, "models/debug/debugwhite", Color(64, 152, 192, 255), 1)
c.Author = "SoloTredici"
c.AuthorID = "STEAM_0:1:42033208"

c = Costume("runnerwristbands")
c:SetSlots(COSTUMESLOT_BODY)
c:AddModel("models/props_c17/oildrum001.mdl", Vector(6.885, 0.2, 0.61), Angle(-95.565, 0, 0), "ValveBiped.Bip01_R_Forearm", Vector(0.195, 0.195, 0.094), "models/combine_scanner/scanner_eye")
c:AddModel("models/props_c17/oildrum001.mdl", Vector(6.876, 0.354, -0.287), Angle(-95.565, 0, 0), "ValveBiped.Bip01_L_Forearm", Vector(0.195, 0.195, 0.094), "models/combine_scanner/scanner_eye")
c:AddModel("models/XQM/panel360.mdl", Vector(0, 0, 2.634), Angle(90, 0, 0), nil, Vector(1.61, 0.108, 0.108), "models/debug/debugwhite", Color(248, 248, 248, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(0, 0, 2.634), Angle(90, 0, 0), nil, Vector(1.61, 0.108, 0.108), "models/debug/debugwhite", Color(248, 248, 248, 255), 2)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("bong")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/Combine_Helicopter/helicopter_bomb01.mdl", Vector(2.273, 2.273, -5.909), Angle(180, 0, 0), "ValveBiped.Bip01_L_Hand", 0.209, "models/Debug/debugwhite", Color(0, 255, 0, 85))
c:AddModel("models/hunter/tubes/tube4x4x16.mdl", Vector(-0.456, 0.455, -9.546), Angle(3.068, 180, 1.023), nil, 0.02, "models/Debug/debugwhite", Color(0, 255, 0, 134), 1)
c:AddModel("models/hunter/tubes/tube2x2x4.mdl", Vector(0, -3.182, 0), Angle(0, -180, -66.477), nil, 0.01, "models/props_combine/Combine_Citadel001_open", Color(0, 59, 60, 255), 1)
c:AddModel("models/cliffs/rocks_small03.mdl", Vector(-0.108, -3.958, -0.436), Angle(180, -35.795, -35.795), nil, 0.02, "models/props_foliage/tree_slice01", nil, 1)
c.Author = "ReeferReferrer"
c.AuthorID = "STEAM_0:0:25307757"

c = Costume("campbellsaw")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_c17/TrapPropeller_Engine.mdl", Vector(0.455, 0.455, -2.274), Angle(93.068, 178.977, 3.068), "ValveBiped.Bip01_L_Hand", 0.347)
c:AddModel("models/hunter/plates/plate1x4.mdl", Vector(2.369, 0.726, 14.34), Angle(2.329, -7.907, -89.746), nil, Vector(0.071, 0.093, 0.314), "phoenix_storms/fender_chrome", Color(215, 255, 255, 255), 1)
c:AddModel("models/props_c17/TrapPropeller_Engine.mdl", Vector(3.181, 0.36, 0.455), Angle(1.023, -1.024, -1.024), nil, 0.347, "phoenix_storms/construct/concrete_pipe_00", Color(64, 47, 0, 255), 1)
c:AddModel("models/mechanics/robotics/g1.mdl", Vector(6.817, 2.273, 3.181), Angle(3.068, 82.841, 25.568), nil, Vector(0.206, 0.16, 0.158), "models/Debug/debugwhite", Color(37, 28, 0, 255), 1)
c:AddModel("models/props_phx/construct/wood/wood_angle180.mdl", Vector(1.94, 1.241, 23.12), Angle(-88.519, -16.066, -98.772), nil, Vector(0.035, 0.314, 0.061), "phoenix_storms/fender_chrome", Color(215, 255, 255, 255), 1)
c:AddColorOptions()
c.Author = "ReeferReferrer"
c.AuthorID = "STEAM_0:0:25307757"

c = Costume("manaearrings")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(0.081, 0.46, -3.406), Angle(-24.121, 90, 0), "ValveBiped.Bip01_Head1", 0.5)
c:AddModel("models/props_wasteland/rockcliff07e.mdl", Vector(-2.862, -1.173, 6.678), Angle(0, 0, 109.782), nil, 0.01, "models/debug/debugwhite", nil, 1)
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(-2.724, -0.003, 6.678), Angle(24.12, 0, 0), nil, 0.5, nil, nil, 1)
c:AddModel("models/props_wasteland/rockcliff07e.mdl", Vector(0, -1.173, -0.334), Angle(0, 0, 76.734), nil, 0.01, "models/debug/debugwhite", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("psiblades")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/XQM/panel360.mdl", Vector(10.6, 0.18, 0.184), Angle(0, 0, 0), "ValveBiped.Bip01_R_Forearm", Vector(4.163, 0.108, 0.108), "models/XQM/deg360", Color(255, 255, 138, 255))
c:AddModel("models/XQM/panel360.mdl", Vector(10.6, 0.379, 0.004), Angle(0, 0, 156.893), "ValveBiped.Bip01_L_Forearm", Vector(4.163, 0.108, 0.108), "models/XQM/deg360", Color(255, 255, 138, 255))
c:AddModel("models/hunter/triangles/025x025mirrored.mdl", Vector(0.638, 0, -2), Angle(0, 180, 0), nil, Vector(1.493, 0.146, 0.136), "models/spawn_effect2", nil, 1)
c:AddModel("models/Gibs/Antlion_gib_small_2.mdl", Vector(-4.38, 0, -0.498), Angle(0, 180, 180), nil, Vector(0.51, 0.871, 0.926), "models/XQM/deg360", Color(255, 255, 138, 255), 2)
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(-1.315, 0.335, -3.01), Angle(0, 32.202, -80.794), nil, 0.053, "models/shiny", nil, 2)
c:AddModel("models/hunter/triangles/025x025mirrored.mdl", Vector(0.638, 0, -2), Angle(0, 180, 0), nil, Vector(1.493, 0.146, 0.136), "models/spawn_effect2", nil, 2)
c:AddModel("models/Gibs/Antlion_gib_small_2.mdl", Vector(-4.38, 0, -0.498), Angle(0, 180, 180), nil, Vector(0.51, 0.871, 0.926), "models/XQM/deg360", Color(255, 255, 138, 255), 1)
c:AddModel("models/Gibs/gunship_gibs_eye.mdl", Vector(-1.315, 0.335, -3.01), Angle(0, 32.202, -80.794), nil, 0.053, "models/shiny", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("mirrorshield2")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/geometric/tri1x1eq.mdl", Vector(5.369, -0.151, 1.383), Angle(35, -90, 0), "ValveBiped.Bip01_L_Forearm", Vector(0.474, 0.456, 0.472), "models/debug/debugwhite")
c:AddModel("models/hunter/geometric/hex025x1.mdl", Vector(9.437, 0, 0), Angle(0, 90, 0), nil, Vector(0.131, 0.097, 0.474), "models/debug/debugwhite", nil, 1)
c:AddModel("models/hunter/tubes/tube4x4x025b.mdl", Vector(4.63, 1.299, 1.708), Angle(0, 46.188, 0), nil, Vector(0.039, 0.039, 0.019), "models/shiny", Color(200, 200, 200, 255), 1)
c:AddModel("models/props_phx/gears/spur12.mdl", Vector(4.593, -1.614, 0), Angle(0, 0, 0), nil, Vector(0.231, 0.331, 0.231), "models/shiny", Color(200, 200, 200, 255), 1)
c:AddModel("models/hunter/geometric/hex05x1.mdl", Vector(0, 0, 0), Angle(0, 180, 0), nil, Vector(0.23, 0.228, 0.474), "models/debug/debugwhite", nil, 1)
c:AddModel("models/hunter/geometric/hex025x1.mdl", Vector(8.727, 0, 0.333), Angle(0, 90, 0), nil, Vector(0.104, 0.059, 0.488), "models/shiny", Color(254, 254, 254, 255), 1)
c:AddModel("models/hunter/geometric/tri1x1eq.mdl", Vector(-0.687, 0, 0.333), Angle(0, 0, 0), nil, Vector(0.374, 0.36, 0.488), "models/shiny", Color(254, 254, 254, 255), 1)
c:AddModel("models/hunter/geometric/hex05x1.mdl", Vector(-0.719, 0, 0.333), Angle(0, 180, 0), nil, Vector(0.23, 0.18, 0.488), "models/shiny", Color(254, 254, 254, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("devilhorns")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_combine/stasisvortex.mdl", Vector(4.695, 0, -1.04), Angle(0, -64.472, 49.296), "ValveBiped.Bip01_Head1", Vector(0.028, 0.024, 0.028), "models/gibs/hgibs/spine", nil)
c:AddModel("models/props_combine/stasisvortex.mdl", Vector(0, -2.215, 2.132), Angle(0, 0, 79.907), nil, Vector(0.028, 0.024, 0.028), "models/gibs/hgibs/spine", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("identitydisk")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_phx/wheels/magnetic_large.mdl", Vector(7.039, 1.74, 0), Angle(0, -18.337, 90), "ValveBiped.Bip01_L_Hand", 0.158, "phoenix_storms/grey_steel", Color(0, 0, 0, 255))
c:AddModel("models/props_phx/wheels/magnetic_large.mdl", Vector(0, 0, 0.202), Angle(0, 0, 0), nil, Vector(0.167, 0.136, 0.167), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props_phx/wheels/magnetic_large.mdl", Vector(0, 0, 0.202), Angle(0, 0, 0), nil, Vector(0.148, 0.136, 0.148), "models/cs_italy/light_orange", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("bbandfr")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props/de_inferno/wine_barrel_p10.mdl", Vector(8.038, 0.326, -0.171), Angle(176.089, 88.287, 93.976), "ValveBiped.Bip01_L_Forearm", Vector(0.136, 0.148, 0.522), "models/props_pipes/pipemetal001a")
c:AddModel("models/props/de_inferno/wine_barrel_p10.mdl", Vector(9.543, 0.381, 0.467), Angle(90, 0, 0), "ValveBiped.Bip01_R_Forearm", Vector(0.142, 0.142, 0.87), "models/props_wasteland/rockgranite02a")
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(0, 2.48, 2.589), Angle(90, 0, 0), nil, Vector(0.032, 0.029, 0.016), "models/weapons/v_slam/new light2", nil, 1)
c:AddModel("models/hunter/geometric/pent1x1.mdl", Vector(-2.691, 0, 0), Angle(0, 90, 90), nil, Vector(0.041, 0.061, 0.041), "models/props_wasteland/rockgranite02a", nil, 2)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(-0.926, 2.47, 1.799), Angle(-28.299, 0, 0), nil, Vector(0.032, 0.029, 0.028), "models/weapons/v_slam/new light2", nil, 1)
c:AddModel("models/hunter/triangles/trapezium3x3x1.mdl", Vector(0, 2.47, 1.799), Angle(0, 0, 0), nil, Vector(0.018, 0.009, 0.032), "models/props_combine/metal_combinebridge001", nil, 1)
c:AddModel("models/props_debris/wood_board06a.mdl", Vector(0.925, 2.47, 1.799), Angle(28.298, 0, 0), nil, Vector(0.032, 0.029, 0.028), "models/weapons/v_slam/new light2", nil, 1)
c:AddModel("models/hunter/geometric/pent1x1.mdl", Vector(-2.721, 0, 0), Angle(0, 90, 90), nil, Vector(0.032, 0.052, 0.039), "models/weapons/v_slam/new light1", nil, 2)
c:AddModel("models/props_lab/citizenradio.mdl", Vector(0, 2.22, 0.809), Angle(0, 90, 180), nil, Vector(0.075, 0.136, 0.136), "models/props_pipes/pipemetal001a", nil, 1)
c:AddModel("models/props_junk/cardboard_box002a.mdl", Vector(0, 2.489, 0), Angle(90, 0, -90), nil, Vector(0.063, 0.068, 0.057), "models/props_combine/metal_combinebridge001", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("cspauldron")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/misc/shell2x2a.mdl", Vector(-0.464, 0.469, -1.951), Angle(-180, -109.815, 106.935), "ValveBiped.Bip01_L_Shoulder", Vector(0.104, 0.104, 0.123), "models/props_wasteland/tugboat01")
c:AddModel("models/props_docks/dock03_pole01a_256.mdl", Vector(2.624, 3.184, 4.242), Angle(-42.894, -36.579, 0), nil, Vector(0.035, 0.035, 0.014), "models/props_wasteland/tugboat01", nil, 1)
c:AddModel("models/props_docks/dock03_pole01a_256.mdl", Vector(3.683, -0.894, 4.842), Angle(-42.894, 0, 0), nil, Vector(0.035, 0.035, 0.014), "models/props_wasteland/tugboat01", nil, 1)
c:AddModel("models/props_docks/dock03_pole01a_256.mdl", Vector(0.448, 0.256, 6.418), Angle(-9.233, 0, 0), nil, Vector(0.035, 0.035, 0.014), "models/props_wasteland/tugboat01", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("constructiontools")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/weapons/w_toolgun.mdl", Vector(8.439, -1.223, 1.935), Angle(-57.366, -69.709, 178.985), "ValveBiped.Bip01_Pelvis")
c:AddModel("models/weapons/w_physics.mdl", Vector(-2.014, -18.664, 4.349), Angle(-9.403, 10.541, -61.002), nil, nil, nil, nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("damnedeye")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/plates/plate1x1.mdl", Vector(0, -7.829, -0.306), Angle(135.727, -37.658, 90), "ValveBiped.Bip01_Spine4", Vector(0.086, 0.086, 0.261), "phoenix_storms/grey_steel", Color(125, 125, 125, 255))
c:AddModel("models/props_phx/misc/smallcannonball.mdl", Vector(0.967, -0.821, -0.401), Angle(0, 45, 180), nil, Vector(0.245, 0.172, 0.029), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props_phx/construct/wood/wood_dome360.mdl", Vector(0.56, -0.401, -0.159), Angle(-180, -46.631, -90), nil, Vector(0.009, 0.019, 0.039), "phoenix_storms/grey_steel", Color(125, 125, 125, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(0.159, 0.059, -0.629), Angle(-90, 45, 0), nil, 0.014, "models/cs_italy/light_orange", Color(255, 33, 44, 255), 1)
c:AddModel("models/props_phx/construct/wood/wood_dome360.mdl", Vector(-0.345, 0.504, -0.16), Angle(-180, 133.613, -90), nil, Vector(0.009, 0.019, 0.039), "phoenix_storms/grey_steel", Color(125, 125, 125, 255), 1)
c:AddModel("models/props/de_inferno/wine_barrel_p10.mdl", Vector(-4.009, 4.412, 2.372), Angle(-1.961, -37.835, -34.082), nil, Vector(0.202, 0.232, 0.203), "phoenix_storms/metalfloor_2-3", Color(150, 150, 150, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("handdrill")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/misc/roundthing1.mdl", Vector(5.918, 1.511, -3.208), Angle(-0.598, 77.509, -2.439), "ValveBiped.Bip01_L_Hand", Vector(0.019, 0.019, 0.032), "models/XQM/deg360")
c:AddModel("models/XQM/panel360.mdl", Vector(0, 3.789, 6.809), Angle(0, 90, 0), nil, 0.027, "models/XQM/deg360", nil, 1)
c:AddModel("models/XQM/cylinderx1.mdl", Vector(0, -0.58, 6.844), Angle(0, 90, 0), nil, Vector(0.331, 0.208, 0.208), "models/XQM/deg360", nil, 1)
c:AddModel("models/XQM/panel360.mdl", Vector(0, 1.49, 6.82), Angle(0, 90, 0), nil, Vector(0.254, 0.054, 0.054), "models/XQM/deg360", nil, 1)
c:AddModel("models/mechanics/wheels/wheel_extruded_48.mdl", Vector(0, 3.971, 6.849), Angle(0, 0, 90), nil, Vector(0.009, 0.009, 0.153), "phoenix_storms/grey_steel", nil, 1)
c:AddModel("models/hunter/tubes/tube4x4x2to2x2.mdl", Vector(0, 2.719, 6.82), Angle(0, 0, 90), nil, Vector(0.014, 0.014, 0.023), "models/XQM/deg360", nil, 1)
c:AddModel("models/XQM/cylinderx1.mdl", Vector(0, -1.792, 3.673), Angle(90, 0, 36.463), nil, Vector(0.368, 0.128, 0.128), nil, nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("fishinabottle")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_junk/garbage_glassbottle001a.mdl", Vector(-9.45, 0, 0), Angle(180, -19.35, -91.009), "ValveBiped.Bip01_Pelvis", Vector(0.853, 0.853, 0.381), "models/props_combine/pipes01")
c:AddModel("models/XQM/cylinderx1.mdl", Vector(0, 0, 2.568), Angle(90, 0, 0), nil, Vector(0.087, 0.109, 0.109), "models/XQM/woodtexture_1", Color(175, 105, 0, 255), 1)
c:AddModel("models/props_junk/garbage_glassbottle001a.mdl", Vector(0, 0, 0), Angle(0, 0, 0), nil, Vector(0.75, 0.75, 0.349), "models/spawn_effect", nil, 1)
c:AddModel("models/props/de_inferno/goldfish.mdl", Vector(0.477, -0.802, -1.451), Angle(-52.433, 34.888, 0), nil, 0.327, nil, nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("keenraygun")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_phx/ball.mdl", Vector(6.473, 1.542, 3.454), Angle(7.383, -12.362, 180), "ValveBiped.Bip01_L_Hand", Vector(0.041, 0.114, 0.041), "models/shiny")
c:AddModel("models/XQM/panel360.mdl", Vector(2.75, 0, 0.896), Angle(0, 0, 0), nil, Vector(0.136, 0.037, 0.037), "models/shiny", Color(254, 254, 254, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(2.368, 0, 0.896), Angle(0, 0, 0), nil, Vector(0.136, 0.045, 0.045), "models/shiny", Color(254, 254, 254, 255), 1)
c:AddModel("models/hunter/plates/tri3x1.mdl", Vector(-0.257, 0.898, 1.291), Angle(138.192, 0, -90), nil, Vector(0.009, 0.009, 0.597), "models/debug/debugwhite", Color(255, 255, 0, 255), 1)
c:AddModel("models/XQM/cylinderx1.mdl", Vector(1.95, 0, 0.896), Angle(0, 0, 0), nil, Vector(0.28, 0.03, 0.03), "models/shiny", Color(255, 255, 0, 255), 1)
c:AddModel("models/hunter/plates/tri3x1.mdl", Vector(0.349, 0.898, 0.804), Angle(-55.993, 0, -90), nil, Vector(0.009, 0.009, 0.597), "models/debug/debugwhite", Color(255, 255, 0, 255), 1)
c:AddModel("models/props_c17/pottery02a.mdl", Vector(-3.1, 0, 3.413), Angle(-141.622, 0, 0), nil, Vector(0.104, 0.057, 0.234), "models/shiny", nil, 1)
c:AddModel("models/gibs/metal_gib5.mdl", Vector(-1.346, 0, 2.082), Angle(0, 180, 90), nil, Vector(0.188, 0.079, 0.054), "models/debug/debugwhite", Color(255, 0, 255, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("lantern")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/editor/air_node_hint.mdl", Vector(3.417, 0.845, -12.353), Angle(0, 0, 0), "ValveBiped.Bip01_L_Hand", Vector(0.316, 0.671, 0.316), "models/shadertest/shader5")
c:AddModel("models/props_phx/construct/wood/wood_wire1x1x1.mdl", Vector(0, 0, -6.842), Angle(0, 0, 0), nil, Vector(0.146, 0.286, 0.146), "models/props_pipes/destroyedpipes01a", nil, 1)
c:AddModel("models/props/de_inferno/wall_lamp3.mdl", Vector(0, 0, 6.699), Angle(0, 0, 0), nil, Vector(0.588, 0.588, 0.172), nil, nil, 1)
c:AddModel("models/hunter/triangles/trapezium3x3x1.mdl", Vector(0, 0, -7.25), Angle(180, 0, 0), nil, Vector(0.048, 0.048, 0.017), "models/props_pipes/guttermetal01a", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("lensoftruth")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_vehicles/tire001b_truck.mdl", Vector(3.21, 0.737, 5.527), Angle(180, 0, 0), "ValveBiped.Bip01_L_Hand", Vector(0.092, 0.129, 0.129), "models/debug/debugwhite")
c:AddModel("models/hunter/triangles/05x05.mdl", Vector(0, -2.08, -1.984), Angle(-90, -90, 90), nil, Vector(0.068, 0.068, 0.272), "models/cs_italy/light_orange", Color(192, 0, 105, 255), 1)
c:AddModel("models/XQM/cylinderx1.mdl", Vector(0, 0, 4.71), Angle(90, 0, 0), nil, Vector(0.375, 0.097, 0.097), "models/debug/debugwhite", nil, 1)
c:AddModel("models/hunter/triangles/05x05.mdl", Vector(0, 0, -2.891), Angle(-45, -90, 90), nil, Vector(0.068, 0.068, 0.272), "models/cs_italy/light_orange", Color(192, 0, 105, 255), 1)
c:AddModel("models/hunter/triangles/05x05.mdl", Vector(0, 2.079, -1.984), Angle(-90, -90, -90), nil, Vector(0.068, 0.068, 0.272), "models/cs_italy/light_orange", Color(192, 0, 105, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(0.15, 0, 0), Angle(0, 0, 0), nil, Vector(0.463, 0.108, 0.108), "phoenix_storms/pro_gear_side", Color(172, 131, 195, 254), 1)
c:AddModel("models/hunter/geometric/para1x1.mdl", Vector(0.305, -0.551, 1.024), Angle(30, 90, -90), nil, Vector(0.046, 0.046, 0.196), "models/cs_italy/light_orange", Color(82, 0, 255, 255), 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("shackles")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/XQM/panel360.mdl", Vector(10.748, 0.37, 0.159), Angle(0, 0, 0), "ValveBiped.Bip01_R_Forearm", Vector(2.364, 0.108, 0.108), "models/props_canal/canal_bridge_railing_01a")
c:AddModel("models/XQM/panel360.mdl", Vector(10.748, 0.261, -0.48), Angle(0, 0, -59.009), "ValveBiped.Bip01_L_Forearm", Vector(2.364, 0.108, 0.108), "models/props_canal/canal_bridge_railing_01a")
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(-0.761, -4.091, 2.104), Angle(0, 0, 30), nil, 1.108, "models/props_canal/canal_bridge_railing_01a", nil, 1)
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(-0.761, -9.068, 4.756), Angle(0, 0, 30), nil, 1.108, "models/props_canal/canal_bridge_railing_01a", nil, 1)
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(-0.761, -6.753, 3.555), Angle(-61.759, 90, 30), nil, 1.108, "models/props_canal/canal_bridge_railing_01a", nil, 2)
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(-0.761, -9.068, 4.756), Angle(0, 0, 30), nil, 1.108, "models/props_canal/canal_bridge_railing_01a", nil, 2)
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(-0.761, -4.091, 2.104), Angle(0, 0, 30), nil, 1.108, "models/props_canal/canal_bridge_railing_01a", nil, 2)
c:AddModel("models/props/de_inferno/wall_lamp_ring.mdl", Vector(-0.761, -6.753, 3.555), Angle(-61.759, 90, 30), nil, 1.108, "models/props_canal/canal_bridge_railing_01a", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("shinesprite")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_vehicles/carparts_tire01a.mdl", Vector(6.162, 0, 4.131), Angle(0, 180, 90), "ValveBiped.Bip01_L_Forearm", Vector(0.363, 0.293, 0.363), "models/cs_italy/light_orange")
c:AddModel("models/XQM/panel360.mdl", Vector(-1.121, -2.998, 0), Angle(0, 90, 0), nil, Vector(0.041, 0.021, 0.041), "models/shiny", Color(0, 0, 0, 255), 1)
c:AddModel("models/XQM/panel360.mdl", Vector(1.12, -2.998, 0), Angle(0, 90, 0), nil, Vector(0.041, 0.021, 0.041), "models/shiny", Color(0, 0, 0, 255), 1)
c:AddModel("models/hunter/misc/cone4x2mirrored.mdl", Vector(0, 0.009, 0), Angle(45, 0, 0), nil, Vector(0.059, 0.02, 0.094), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/hunter/misc/cone4x2mirrored.mdl", Vector(0, 0.009, 0), Angle(90, 0, 0), nil, Vector(0.059, 0.02, 0.094), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props_phx/misc/smallcannonball.mdl", Vector(1.442, 0, -9.233), Angle(0, 0, 0), nil, 0.21, "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/hunter/misc/cone4x2mirrored.mdl", Vector(0, 0.009, 0), Angle(-45, 0, 0), nil, Vector(0.059, 0.02, 0.094), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/hunter/misc/cone4x2mirrored.mdl", Vector(0, 0.009, 0), Angle(0, 0, 0), nil, Vector(0.059, 0.02, 0.094), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props_phx/misc/smallcannonball.mdl", Vector(-5.469, 0, -7.726), Angle(-45, 0, 0), nil, 0.21, "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props_phx/ball.mdl", Vector(0, 2.918, 0), Angle(0, 0, -90), nil, Vector(0.245, 0.245, 0.136), "models/cs_italy/light_orange", nil, 1)
c:AddModel("models/props_phx/misc/smallcannonball.mdl", Vector(7.585, 0, -5.613), Angle(45, 0, 0), nil, 0.21, "models/cs_italy/light_orange", nil, 1)
c:AddColorOptions()
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("midori")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/hunter/misc/cone1x1.mdl", Vector(0.159, 1.49, 0.8), Angle(-90, 0, 0), "ValveBiped.Bip01_L_Hand", Vector(0.201, 0.172, 0.202), "models/combine_scanner/scanner_eye")
c:AddModel("models/maxofs2d/companion_doll.mdl", Vector(-0.053, 2.043, 1.72), Angle(-23.747, 92.928, 1.452), nil, Vector(0.264, 0.3, 0.388), nil, nil, 1)
c:AddModel("models/balloons/balloon_classicheart.mdl", Vector(-0.003, -1.389, 6.418), Angle(0, 0, 0), nil, 0.043, "models/debug/debugwhite", Color(255, 0, 0, 255), 1)
c.Author = "Gormaoife"
c.AuthorID = "STEAM_0:0:15910459"

c = Costume("solbulwark")
c:SetSlots(COSTUMESLOT_ACCESSORY)
c:AddModel("models/props_combine/headcrabcannister01a.mdl", Vector(8.265, -5.033, 0.159), Angle(-28.6, 92.337, 6.676), "ValveBiped.Bip01_L_Forearm", Vector(0.18, 0.319, 0.065), "models/props_pipes/guttermetal01a", Color(255, 151, 0, 255))
c:AddModel("models/gibs/antlion_gib_small_1.mdl", Vector(-3.306, -7.153, 1.661), Angle(0, 78.186, 90), nil, Vector(0.595, 0.264, 0.615), "models/shiny", Color(255, 205, 0, 255), 1)
c:AddModel("models/gibs/antlion_gib_small_1.mdl", Vector(-10.643, -0.747, 1.577), Angle(0, 176.63, -90), nil, Vector(0.595, 0.264, 0.615), "models/shiny", Color(255, 205, 0, 255), 1)
c:AddModel("models/gibs/antlion_gib_small_1.mdl", Vector(-3.984, 7.162, 1.358), Angle(0, -102.819, -90), nil, Vector(0.595, 0.264, 0.615), "models/shiny", Color(255, 205, 0, 255), 1)
c:AddModel("models/gibs/antlion_gib_small_1.mdl", Vector(3.651, 0.155, 1.661), Angle(0, -7.355, -90), nil, Vector(0.595, 0.264, 0.615), "models/shiny", Color(255, 205, 0, 255), 1)
c:AddModel("models/props_c17/streetsign001c.mdl", Vector(-3.414, 0, 1.603), Angle(0, 0, 90), nil, Vector(0.25, 2.128, 0.25), "models/shiny", Color(255, 205, 0, 255), 1)
c.Author = "The Darker One"
c.AuthorID = "STEAM_0:0:15529330"
