--local ShopCategoryIcons = {[CAT_HEAD] = "icon16/emoticon_smile.png", [CAT_BODY] = "icon16/user.png", [CAT_ACCESSORY] = "icon16/rosette.png", [CAT_TITLE] = "icon16/sound.png", [CAT_SAVEDTITLE] = "icon16/sound.png", [CAT_SAVED3DTITLE] = "icon16/sound.png", [CAT_MODEL] = "icon16/user.png", [CAT_OTHER] = "icon16/plugin.png", [CAT_FACE] = "icon16/emoticon_tongue.png", [CAT_BACK] = "icon16/package.png"}
local ShopCategoryIcons = {[CAT_HEAD] = "icon16/emoticon_smile.png", [CAT_BODY] = "icon16/user.png", [CAT_ACCESSORY] = "icon16/rosette.png", [CAT_TITLE] = "icon16/sound.png", [CAT_SAVEDTITLE] = "icon16/sound.png", [CAT_MODEL] = "icon16/user.png", [CAT_OTHER] = "icon16/plugin.png", [CAT_FACE] = "icon16/emoticon_tongue.png", [CAT_BACK] = "icon16/package.png"}

local colBG = Color(0, 0, 0, 220)
local colBGHover = Color(20, 20, 35, 220)
local colBGSelect = Color(30, 30, 60, 220)
local matDOF = Material("pp/dof")

local PreviewCostume
local PreviewClass

local AngleOffset = Angle(0, 0, 0)
local MouseX, MouseY = 0, 0
local CameraDistance = 85
local CameraUpOffset = 20
local function PreviewCalcView(pl, origin, angles, fov, zfar, znear)
	if input.IsMouseDown(MOUSE_RIGHT) and not gui.IsGameUIVisible() and not gui.IsConsoleVisible() then
		local newx, newy = input.GetCursorPos()
		if input.IsKeyDown(KEY_E) then
			CameraUpOffset = math.Clamp(CameraUpOffset + (MouseY - newy) * (240 / ScrH()), -32, 32)
		elseif input.IsMouseDown(MOUSE_LEFT) then
			CameraDistance = math.Clamp(CameraDistance + (newy - MouseY) * (240 / ScrH()), 20, 140)
		else
			AngleOffset.yaw = math.NormalizeAngle(AngleOffset.yaw + (newx - MouseX) * (240 / ScrH()))
			AngleOffset.pitch = math.Clamp(AngleOffset.pitch + (newy - MouseY) * (160 / ScrH()), -89, 89)
		end
		input.SetCursorPos(MouseX, MouseY)
	else
		MouseX, MouseY = input.GetCursorPos()
	end

	local start = pl:LocalToWorld(pl:OBBCenter()) + pl:GetUp() * CameraUpOffset
	local ang = Angle(0, angles.yaw, 0)

	ang:RotateAroundAxis(ang:Up(), AngleOffset.yaw)
	ang:RotateAroundAxis(ang:Right(), AngleOffset.pitch)

	local tr = util.TraceHull({start = start, endpos = start + CameraDistance * ang:Forward(), mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2), mask = MASK_SOLID_BRUSHONLY, filter = pl})
	local neworigin = tr.HitPos + tr.HitNormal * 4

	return {origin = neworigin, angles = (start - neworigin):Angle()}
end
local function PreviewShouldDrawLocalPlayer(pl) return true end
local function PreviewCreateMove(cmd) cmd:ClearMovement() cmd:ClearButtons(0) end
local function PreviewPreDrawTranslucentRenderables()
	local pos = MySelf:GetPos() + MySelf:OBBMaxs().z * 0.5 * MySelf:GetUp()
	local fwd = EyeAngles():Forward()

	render.UpdateRefractTexture()
	render.SetMaterial(matDOF)
	for i=3, 16 do
		local size = 128 * i
		render.DrawSprite(pos + i * 24 * fwd, size, size, color_white)
	end
end
local function PreviewPrePlayerDraw(pl)
	if pl == MySelf then return end

	local eyepos = EyePos()
	local mypos = MySelf:EyePos()
	if eyepos:DistToSqr(pl:NearestPoint(eyepos)) <= 1024 or mypos:DistToSqr(pl:NearestPoint(mypos)) <= 1024 then --32^2
		return true
	end
end

local pShop
local pShopItem
local pShopClose
local pShopControls
local pShopModelCounter

local Favorites = {}

local function SortItems()
	NDB.ShopItemList = {}
	for k, v in pairs(NDB.ShopItems) do
		table.insert(NDB.ShopItemList, v)
	end
	table.insert(NDB.ShopItemList, tab)
	table.sort(NDB.ShopItemList, function(a, b)
		if Favorites[a.Name] == Favorites[b.Name] then
			return string.lower(a.Name) < string.lower(b.Name)
		end

		if Favorites[b.Name] then return false end

		return true
	end)
end

local function SaveFavorites()
	local tab = {}
	for k in pairs(Favorites) do
		table.insert(tab, k)
	end
	file.Write("nxnstorefavs.txt", table.concat(tab, "%"))
end

local function LoadFavorites()
	Favorites = {}

	if file.Exists("nxnstorefavs.txt", "DATA") then
		for _, name in pairs(string.Explode("%", file.Read("nxnstorefavs.txt", "DATA"))) do
			Favorites[name] = true
		end
	end

	SortItems()
end

hook.Add("Initialize", "NDB_Shop_Initialize", function()
	surface.CreateFont("NDB_Shop_Font1", {font = "tahoma", size = 24, weight = 600, antialias = false, shadow = true})
	surface.CreateFont("NDB_Shop_Font2", {font = "tahoma", size = 12, weight = 0, antialias = false, shadow = true})
	surface.CreateFont("NDB_Shop_Font3", {font = "tahoma", size = 16, weight = 500, antialias = false, shadow = true})

	LoadFavorites()
end)

function NDB.CreateShopMenu()
	if pShop and pShop:IsValid() then return end

	if GetConVarNumber("nox_displayhats") ~= 1 then
		chat.AddText(COLOR_CYAN, "Enabling drawing of costumes since you had it disabled...")
		RunConsoleCommand("nox_displayhats", "1")
	end

	if not GAMEMODE.NoCostumes then
		hook.Add("CalcView", "ShopPreview", PreviewCalcView)
		hook.Add("ShouldDrawLocalPlayer", "ShopPreview", PreviewShouldDrawLocalPlayer)
		hook.Add("CreateMove", "ShopPreview", PreviewCreateMove)
		hook.Add("PreDrawTranslucentRenderables", "ShopPreview", PreviewPreDrawTranslucentRenderables)
		hook.Add("PrePlayerDraw", "ShopPreview", PreviewPrePlayerDraw)
	end
	PreviewClass = nil
	PreviewCostume = nil

	pShop = vgui.Create("NDBShopMenu")
	pShop:SetSkin("Default")
	pShop:SetSize(240, ScrH() * 0.75)
	pShop:SetPos(ScrW(), ScrH() / 2 - pShop:GetTall() / 2)
	pShop:MoveTo(ScrW() - pShop:GetWide(), ScrH() / 2 - pShop:GetTall() / 2, 0.5, 0, 0.4)

	pShopItem = vgui.Create("NDBShopMenuItemDesc")
	pShopItem:SetSkin("Default")
	pShopItem:SetSize(360, 128)
	pShopItem:SetPos(-pShopItem:GetWide(), ScrH() / 5)

	pShopClose = vgui.Create("NDBShopMenuClose")
	pShopClose:SetSkin("Default")
	pShopClose:SetSize(64, 64)
	pShopClose:SetPos(ScrW(), -pShopClose:GetTall())
	pShopClose:MoveTo(ScrW() - pShopClose:GetWide(), 0, 0.5, 0, 0.4)

	pShopControls = vgui.Create("DEXRoundedPanel")
	pShopControls:SetSkin("Default")
	pShopControls:SetSize(290, 48)
	pShopControls:SetCurveTopLeft(true)
	pShopControls:SetCurveTopRight(true)
	pShopControls:SetCurveBottomLeft(false)
	pShopControls:SetCurveBottomRight(false)
	pShopControls:SetBorderRadius(16)
	pShopControls:SetColor(colBG)

	local helpicon = vgui.Create("DImage", pShopControls)
	helpicon:SetImage("icon32/zoom_extend.png")
	helpicon:SetSize(24, 24)
	helpicon:AlignLeft(8)
	helpicon:CenterVertical()

	local helptext = EasyLabel(pShopControls, "Hold right mouse to rotate the camera.\nHold right and left mouse to zoom.\nHold right mouse and the E key to move up/down.", "NDB_Shop_Font2", color_white)
	helptext:SetContentAlignment(7)
	helptext:SetMultiline(true)
	helptext:SetWrap(true)
	helptext:StretchToParent(40, 8, 8, 0)

	pShopControls:SetPos((ScrW() - pShopControls:GetWide()) / 2, ScrH())
	pShopControls:MoveTo((ScrW() - pShopControls:GetWide()) / 2, ScrH() - pShopControls:GetTall(), 0.5, 0, 0.4)

	pShopModelCounter = vgui.Create("NDBShopMenuModelCounter")
	pShopModelCounter:SetSkin("Default")
	pShopModelCounter:SetSize(200, 48)
	pShopModelCounter:SetPos(-pShopModelCounter:GetWide(), ScrH())
	pShopModelCounter:MoveTo(0, ScrH() - pShopModelCounter:GetTall(), 0.5, 0, 0.4)

	pShopClose:MakePopup()

	NDB.ShopPanel = pShop
end

concommand.Add("shopmenu", function(s, c, a) NDB.CreateShopMenu() end)

local PANEL = {}

PANEL.ItemCategory = 1

local function UnequipDoClick(self)
	RunConsoleCommand("ndb_shop_unequip", self:GetParent().ItemCategory)
end

local function UnequipAllDoClick(self)
	RunConsoleCommand("ndb_shop_unequip_all")
end
function PANEL:Init()
	self:SetSkin("Default")

	self.Title = EasyLabel(self, "Shop", "NDB_Shop_Font1", color_white)

	self.CategoryButtons = {}
	for catid, catname in ipairs(NDB.ShopCategories) do
		local catbut = vgui.Create("NDBShopCategoryButton", self)
		catbut:SetCategory(catid)
		catbut:SetTall(20)
		table.insert(self.CategoryButtons, catbut)
	end

	self.ItemList = vgui.Create("DPanelList", self)
	self.ItemList:SetSpacing(2)
	self.ItemList:EnableVerticalScrollbar()

	self.UnequipButton = vgui.Create("NDBShopImageButton", self)
	self.UnequipButton:SetTall(20)
	self.UnequipButton:SetImage("icon16/brick_delete.png")
	self.UnequipButton:SetButtonText("Unequip slot")
	self.UnequipButton.DoClick = UnequipDoClick

	self.UnequipAllButton = vgui.Create("NDBShopImageButton", self)
	self.UnequipAllButton:SetTall(20)
	self.UnequipAllButton:SetImage("icon16/stop.png")
	self.UnequipAllButton:SetButtonText("Unequip ALL")
	self.UnequipAllButton.DoClick = UnequipAllDoClick

	self.ItemCounter = EasyLabel(self, "", "NDB_Shop_Font2", color_white)

	self:RefreshItems()

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	local y = 16

	self.Title:SetPos(0, y)
	self.Title:CenterHorizontal()
	y = y + self.Title:GetTall() + 8

	local x = 8
	local col = 1
	for i, catbut in ipairs(self.CategoryButtons) do
		catbut:SetWide(self:GetWide() / 2 - 16)
		catbut:SetPos(x, y)

		col = col + 1
		if col >= 3 or i == #self.CategoryButtons then
			x = 8
			y = y + catbut:GetTall() + 8
			col = 1
		else
			x = x + catbut:GetWide() + 8
		end
	end

	self.ItemList:SetSize(self:GetWide() - 16, self:GetTall() - y - 68)
	self.ItemList:SetPos(0, y)
	self.ItemList:CenterHorizontal()

	self.ItemCounter:AlignBottom(8)
	self.ItemCounter:CenterHorizontal()

	self.UnequipButton:SetWide(self:GetWide() / 2 - 12)
	self.UnequipAllButton:SetWide(self.UnequipButton:GetWide())

	self.UnequipButton:MoveAbove(self.ItemCounter, 8)
	self.UnequipButton:AlignLeft(8)
	self.UnequipAllButton:MoveAbove(self.ItemCounter, 8)
	self.UnequipAllButton:AlignRight(8)
end

local function SavedTitleDoClick(self)
	Derma_Query("You are about to change your title to\n"..self.Title.."\nThis will clear any title you currently have!", "Notice", "OK", function()
		RunConsoleCommand("nox_usesavedtitle", self.TitleID)
	end, "Cancel", function() end)
end
--[[local function Saved3DTitleDoClick(self)
	Derma_Query("You are about to change your 3D title to\n"..self.Title.."\nThis will clear any 3D title you currently have!", "Notice", "OK", function()
		RunConsoleCommand("nox_usesaved3dtitle", self.TitleID)
	end, "Cancel", function() end)
end]]
function PANEL:RefreshItems()
	self.ItemList:Clear(true)
	if self.ItemList.VBar then self.ItemList.VBar:SetScroll(0) end

	for i, catbut in ipairs(self.CategoryButtons) do
		catbut:SetDisabled(self.ItemCategory == catbut.CategoryID)
	end

	local count = 0
	local hascount = 0

	if self.ItemCategory == CAT_SAVEDTITLE then
		local savedtitles = LocalPlayer().SavedTitles
		if savedtitles then
			for i, title in ipairs(savedtitles) do
				local itempanel = vgui.Create("NDBShopItemPanel", self.ItemList)
				itempanel:SetTall(24)
				itempanel:SetItemName(title)
				itempanel.DoClick = SavedTitleDoClick
				itempanel.Title = title
				itempanel.TitleID = i
				self.ItemList:AddItem(itempanel)
			end
		end
	--[[elseif self.ItemCategory == CAT_SAVED3DTITLE then
		savedtitles = LocalPlayer().Saved3DTitles
		if savedtitles then
			for i, title in ipairs(savedtitles) do
				local itempanel = vgui.Create("NDBShopItemPanel", self.ItemList)
				itempanel:SetTall(24)
				itempanel:SetItemName(title)
				itempanel.DoClick = Saved3DTitleDoClick
				itempanel.Title = title
				itempanel.TitleID = i
				self.ItemList:AddItem(itempanel)
			end
		end]]
	else
		for k, itemtab in pairs(NDB.ShopItemList) do
			if itemtab.Category == self.ItemCategory then
				local has = NDB.PlayerHasShopItem(MySelf, itemtab.Name)
				if not itemtab.Hidden or has then
					count = count + 1

					local itempanel = vgui.Create("NDBShopItemPanel", self.ItemList)
					itempanel:SetTall(24)
					itempanel:SetItemTable(itemtab)
					self.ItemList:AddItem(itempanel)
				end
				if has then hascount = hascount + 1 end
			end
		end
	end

	--if self.ItemCategory == CAT_SAVEDTITLE or self.ItemCategory == CAT_SAVED3DTITLE then
	if self.ItemCategory == CAT_SAVEDTITLE then
		self.ItemCounter:SetText(count.." saved custom titles.")
	else
		self.ItemCounter:SetText(count.." items in "..tostring(NDB.ShopCategories[self.ItemCategory])..". You own "..hascount..".")
	end
	self.ItemCounter:SizeToContents()
	self.ItemCounter:CenterHorizontal()
end

function PANEL:Paint()
	draw.RoundedBoxEx(16, 0, 0, self:GetWide(), self:GetTall(), colBG, true, false, true, false)
end

vgui.Register("NDBShopMenu", PANEL, "DPanel")

local PANEL = {}

local function UseButtonDoClick(self)
	if PreviewCostume then
		MySelf:RemoveCostume(PreviewCostume)
		PreviewCostume = nil
	end

	RunConsoleCommand("ndb_useshopitem", self.ItemName)
	surface.PlaySound("buttons/button15.wav")
end
local function ItemConfirmPaint(p)
	draw.RoundedBox(8, 4, 4, p:GetWide() - 8, p:GetTall() - 8, color_black)
	draw.RoundedBox(8, 0, 0, p:GetWide(), p:GetTall(), color_black)

	surface.SetDrawColor(50, 50, 50, 255)
	surface.DrawRect(4, 28, p:GetWide() - 8, draw.GetFontHeight("DefaultFont") + 8)

	return true
end
local function BuyButtonDoClick(self)
	local itemname = self.ItemName
	local itemtab = NDB.ShopItems[itemname]
	local money = itemtab.Money
	local modelname = itemtab.Model
	local paint = itemtab.Paint
	local discount = MySelf:GetDiscount()
	local parent = self:GetParent()

	local df = vgui.Create("DFrame")
	df:SetSkin("Default")
	df:SetSize(360, 200)
	df:Center()
	if money and money > 0 then
		df:SetTitle("Confirm Purchase - "..itemname.." (".. string.CommaSeparate(discount * money) .." Silver)")
	else
		df:SetTitle("Confirm Purchase - "..itemname)
	end
	df:SetVisible(true)
	df:MakePopup()
	df:SetScreenLock(true)
	df.Paint = ItemConfirmPaint

	if paint then
		local sb = vgui.Create("Panel", df)
		sb:SetVisible(true)
		sb:SetPos(130.5, 72)
		sb:SetSize(64, 64)
		sb.Paint = paint
	elseif modelname then
		local sb = vgui.Create("SpawnIcon", df)
		sb:SetPos(130.5, 72)
		sb:SetModel(modelname)
	end

	local dl = EasyLabel(df, "Are you sure you want to buy the "..itemname.."?")
	dl:AlignTop(32)
	dl:CenterHorizontal()
	local dbutton = EasyButton(df, "OK", 8, 4)
	dbutton:AlignBottom(50)
	dbutton:CenterHorizontal()
	dbutton.Item = itemname
	dbutton.DoClick = function(btn)
		RunConsoleCommand("ndb_buyshopitem", btn.Item)
		surface.PlaySound("buttons/button15.wav")
		timer.Simple(0.5, function()
			if pShopItem and pShopItem:IsValid() then
				pShopItem:SetItemTable(itemtab)
			end
		end)
		dbutton:GetParent():Remove()
	end

	df:SetSkin("Default")
end
local function option_checkbox_onchange(self, value)
	value = value and "true" or "false"
	RunConsoleCommand("_setcostumeoption", self.UniqueID, self.ID, value)
	MySelf:SetCostumeOption(self.UniqueID, self.ID, value)
end

local function option_slider_onchange(self, value)
	value = tonumber(value)
	RunConsoleCommand("_setcostumeoption", self.UniqueID, self.ID, value)
	MySelf:SetCostumeOption(self.UniqueID, self.ID, value)
end

local function option_dropdown_onchange(self, index, value, data)
	if self.IsNumber then value = tonumber(value) end
	RunConsoleCommand("_setcostumeoption", self.UniqueID, self.ID, value)
	MySelf:SetCostumeOption(self.UniqueID, self.ID, value)
end

local function option_textentry_ontextchanged(self)
	local value = self:GetText()
	RunConsoleCommand("_setcostumeoption", self.UniqueID, self.ID, value)
	MySelf:SetCostumeOption(self.UniqueID, self.ID, value)
end

local function colormixer_update(self, col)
	RunConsoleCommand("_setcostumeoption", self.UniqueID, COSTUMEOPTION_RED, col.r)
	RunConsoleCommand("_setcostumeoption", self.UniqueID, COSTUMEOPTION_GREEN, col.g)
	RunConsoleCommand("_setcostumeoption", self.UniqueID, COSTUMEOPTION_BLUE, col.b)
	MySelf:SetCostumeOption(self.UniqueID, COSTUMEOPTION_RED, col.r)
	MySelf:SetCostumeOption(self.UniqueID, COSTUMEOPTION_GREEN, col.g)
	MySelf:SetCostumeOption(self.UniqueID, COSTUMEOPTION_BLUE, col.b)
end

local currentuid
local customizewindow
local function CheckClose()
	if not customizewindow or not customizewindow:IsValid() then
		RunConsoleCommand("_forcecostumeoptionupdate", currentuid)
		hook.Remove("Think", "CostumeCustomizeCheckClose")
	end
end

local function CustomizePaint(self)
	draw.RoundedBoxEx(8, 0, 0, self:GetWide(), self:GetTall(), colBG, true, false, true, true)
end

local function CustomizeDoClick(self)
	if customizewindow and customizewindow:IsValid() then
		customizewindow:Close()
	end

	local wid, hei = 300, 400

	customizewindow = vgui.Create("DFrame")
	customizewindow:SetSkin("Default")
	customizewindow:SetSize(wid, hei)
	customizewindow:SetDeleteOnClose(true)
	customizewindow:SetTitle(self.ItemName)
	customizewindow.Paint = CustomizePaint

	local list = vgui.Create("DPanelList", customizewindow)
	list:StretchToParent(8, 32, 8, 8)
	list:SetSpacing(2)
	list:SetPadding(2)
	list:EnableVerticalScrollbar()

	local uniqueid = self.UniqueID
	local options = costumes[uniqueid] and costumes[uniqueid].Options
	if options and table.Count(options) > 0 then
		for optionid, optionstab in pairs(options) do
			if optionid == COSTUMEOPTION_BLUE or optionid == COSTUMEOPTION_GREEN then continue end

			local storedtype = COSTUMEOPTIONTYPES[optionid]
			if storedtype then
				local currentoptions = MySelf.CostumeOptions or {}
				local currentvalue = (currentoptions[uniqueid] or {})[optionid]

				if optionstab.List then
					local dlabel = EasyLabel(nil, storedtype.Name, "DefaultFontBold")
					list:AddItem(dlabel)

					local dropdown = vgui.Create("DComboBox")
					for i, listitem in ipairs(optionstab.List) do
						dropdown:AddChoice(listitem)
					end
					if currentvalue then
						dropdown:SetText(currentvalue)
					elseif storedtype.Default then
						dropdown:SetText(storedtype.Default)
					elseif optionstab.List[1] then
						dropdown:SetText(optionstab.List[1])
					end
					dropdown.UniqueID = uniqueid
					dropdown.ID = optionid
					dropdown.OnSelect = option_dropdown_onchange
					dropdown.IsNumber = storedtype.Type == COSTUMEOPTION_TYPE_NUMBER or storedtype.Type == COSTUMEOPTION_TYPE_FLOAT

					list:AddItem(dropdown)
				elseif optionid == COSTUMEOPTION_RED then
					local lab = EasyLabel(nil, "Color")
					list:AddItem(lab)

					local colpicker = vgui.Create("DColorMixer")
					colpicker:SetAlphaBar(false)
					colpicker:SetTall(128)
					colpicker:SetColor(costumes[uniqueid] and costumes[uniqueid]:GetColorOption(MySelf) or color_white)
					colpicker.UniqueID = uniqueid
					colpicker.UpdateConVars = colormixer_update
					list:AddItem(colpicker)
				elseif storedtype.Type == COSTUMEOPTION_TYPE_NUMBER or storedtype.Type == COSTUMEOPTION_TYPE_FLOAT then
					local slider = vgui.Create("DEXNumSlider")
					slider:SetText(storedtype.Name)

					if currentvalue then
						slider:SetValue(tonumber(currentvalue) or 0)
					elseif storedtype.Default then
						slider:SetValue(storedtype.Default)
					end

					slider:SetDecimals(storedtype.Type == COSTUMEOPTION_TYPE_FLOAT and 3 or 0)
					if optionstab.Min then slider:SetMin(optionstab.Min) end
					if optionstab.Min then slider:SetMax(optionstab.Max) end

					slider:SetValue(math.Clamp(tonumber(slider:GetValue()) or 0, optionstab.Min or -99999, optionstab.Max or 99999))

					slider.UniqueID = uniqueid
					slider.ID = optionid
					slider.OnValueChanged = option_slider_onchange

					list:AddItem(slider)
				elseif storedtype.Type == COSTUMEOPTION_TYPE_BOOL then
					local checkbox = vgui.Create("DCheckBox")
					checkbox:SetText(storedtype.Name)

					if currentvalue then
						checkbox:SetValue(currentvalue == true)
					elseif storedtype.Default then
						slider:SetValue(storedtype.Default)
					end

					checkbox.UniqueID = uniqueid
					checkbox.ID = optionid
					checkbox.OnChange = option_checkbox_onchange

					list:AddItem(checkbox)
				elseif storedtype.Type == COSTUMEOPTION_TYPE_STRING then
					local dlabel = EasyLabel(nil, storedtype.Name, "DefaultFontBold")
					list:AddItem(dlabel)

					local textentry = vgui.Create("DTextEntry")
					if storedtype.Default then
						textentry:SetText(storedtype.Default)
					end

					textentry.UniqueID = uniqueid
					textentry.ID = optionid
					textentry.OnTextChanged = option_textentry_ontextchanged

					list:AddItem(textentry)
				end
			end
		end
	end

	customizewindow:SetPos(gui.MousePos())
	customizewindow:AlignLeft(2)
	customizewindow:SetSkin("Default")
	customizewindow:MakePopup()

	currentuid = uniqueid
	hook.Add("Think", "CostumeCustomizeCheckClose", CheckClose)
end
local colGray = Color(220, 220, 220, 255)
function PANEL:Init()
	self.ItemTitle = EasyLabel(self, "", "NDB_Shop_Font1", color_white)

	self.ItemDesc = EasyLabel(self, "", "NDB_Shop_Font2", colGray)
	self.ItemDesc:SetContentAlignment(8)

	self.ItemAuthor = EasyLabel(self, "", "NDB_Shop_Font2", colGray)
	self.ItemAuthor:SetContentAlignment(8)

	self.ModelCount = EasyLabel(self, "", "NDB_Shop_Font3", colGray)

	self.Price = EasyLabel(self, "", "NDB_Shop_Font1", colGray)

	self.BuyButton = vgui.Create("NDBShopImageButton", self)
	self.BuyButton:SetButtonText("Purchase")
	self.BuyButton:SetImage("icon16/cart_add.png")
	self.BuyButton:SetVisible(false)
	self.BuyButton:SetSize(100, 20)
	self.BuyButton.DoClick = BuyButtonDoClick

	self.UseButton = vgui.Create("NDBShopImageButton", self)
	self.UseButton:SetButtonText("Use")
	self.UseButton:SetImage("icon16/add.png")
	self.UseButton:SetVisible(false)
	self.UseButton:SetSize(100, 20)
	self.UseButton.DoClick = UseButtonDoClick

	self.CustomizeButton = vgui.Create("NDBShopImageButton", self)
	self.CustomizeButton:SetButtonText("Customize")
	self.CustomizeButton:SetImage("icon16/palette.png")
	self.CustomizeButton:SetVisible(false)
	self.CustomizeButton:SetSize(100, 20)
	self.CustomizeButton.DoClick = CustomizeDoClick

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	self.ItemTitle:AlignTop(10)
	self.ItemTitle:CenterHorizontal()

	self.ItemDesc:SetWide(self:GetWide())
	self.ItemDesc:MoveBelow(self.ItemTitle, -2)
	self.ItemDesc:CenterHorizontal()

	self.ItemAuthor:SetWide(self:GetWide())
	self.ItemAuthor:MoveBelow(self.ItemDesc, -2)
	self.ItemAuthor:CenterHorizontal()

	self.ModelCount:AlignRight(8)
	self.ModelCount:AlignBottom(8)

	self.BuyButton:AlignBottom(8)
	self.BuyButton:AlignLeft(8)
	self.UseButton:CopyPos(self.BuyButton)

	self.CustomizeButton:AlignBottom(8)
	self.CustomizeButton:MoveRightOf(self.BuyButton, 8)

	self.Price:MoveAbove(self.BuyButton, 8)
	self.Price:AlignLeft(8)
end

function PANEL:SetItemTable(tab)
	self.ItemTable = tab

	self:Stop()
	if tab then
		local class = tab.Class
		local hasitem = tab.CanUseCallback or NDB.PlayerHasShopItem(MySelf, tab.Name) or not tab.Bit
		local costumetab = class and costumes[class]

		self.ItemTitle:SetText(tab.Name)
		self.ItemDesc:SetText(tab.Description or "")
		if costumetab and costumetab.Author then
			self.ItemAuthor:SetText("Created by "..costumes[tab.Class].Author)
		else
			self.ItemAuthor:SetText("")
		end
		if costumetab and costumetab.Elements and #costumetab.Elements > 0 then
			local count = #costumetab.Elements
			self.ModelCount:SetText(count.." model"..(count == 1 and "" or "s"))
			self.ModelCount:SetTextColor((MySelf:GetCostumesElementCount(class) + count > NDB.GetMaxCostumeModels(MySelf)) and Color(255, 0, 0, 255) or colGray)
		else
			self.ModelCount:SetText("")
		end

		self.CustomizeButton:SetVisible(costumetab and table.Count(costumetab.Options) > 0)
		if hasitem then
			self.UseButton:SetVisible(true)
			self.BuyButton:SetVisible(false)
			self.Price:SetText("")
		else
			self.UseButton:SetVisible(false)
			if tab.SpecialRequire then
				self.Price:SetFont("NDB_Shop_Font2")
				self.Price:SetText(tab.SpecialRequire)
			elseif tab.Money and tab.Money > 0 then
				self.Price:SetFont("NDB_Shop_Font1")
				self.Price:SetText("Costs "..string.CommaSeparate(tab.Money).." Silver")
				self.BuyButton:SetVisible(true)
			else
				self.Price:SetFont("NDB_Shop_Font1")
				self.Price:SetText("Can't be purchased")
				self.BuyButton:SetVisible(false)
			end
			self.Price:SizeToContents()
		end

		self.UseButton.ItemName = tab.Name
		self.BuyButton.ItemName = tab.Name
		self.CustomizeButton.ItemName = tab.Name
		self.CustomizeButton.UniqueID = class

		self:MoveTo(0, ScrH() / 5, 0.5, 0, 0.4)
	else
		self.ItemTitle:SetText("")
		self.ItemDesc:SetText("")
		self.ItemAuthor:SetText("")
		self.ModelCount:SetText("")
		self.Price:SetText("")
		self.UseButton:SetVisible(false)
		self.BuyButton:SetVisible(false)
		self.CustomizeButton:SetVisible(false)
		self.UseButton.ItemName = nil
		self.BuyButton.ItemName = nil
		self.CustomizeButton.ItemName = nil
		self.CustomizeButton.UniqueID = nil

		self:MoveTo(-self:GetWide(), ScrH() / 5, 0.4, 0, 0.1)
	end
	self.ItemTitle:SizeToContents()
	self.ItemTitle:CenterHorizontal()
	self.ModelCount:SizeToContents()

	self:InvalidateLayout()
end

function PANEL:GetItemTable()
	return self.m_ItemTable
end

function PANEL:Paint()
	draw.RoundedBoxEx(16, 0, 0, self:GetWide(), self:GetTall(), colBG, false, true, false, true)
end

vgui.Register("NDBShopMenuItemDesc", PANEL, "DPanel")

local PANEL = {}

function PANEL:Init()
	self:SetText("")

	self.m_CloseImage = vgui.Create("DImage", self)
	self.m_CloseImage:SetImage("VGUI/notices/error")

	self:SetTooltip("Close")

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	self.m_CloseImage:SetSize(self:GetWide() / 2, self:GetTall() / 2)
	self.m_CloseImage:Center()
end

function PANEL:Paint()
	draw.RoundedBoxEx(16, 0, 0, self:GetWide(), self:GetTall(), colBG, false, false, true, false)
end

function PANEL:DoClick()
	if pShop and pShop:IsValid() then pShop:Remove() end
	if pShopItem and pShopItem:IsValid() then pShopItem:Remove() end
	if pShopControls and pShopControls:IsValid() then pShopControls:Remove() end
	if pShopModelCounter and pShopModelCounter:IsValid() then pShopModelCounter:Remove() end

	hook.Remove("CalcView", "ShopPreview")
	hook.Remove("ShouldDrawLocalPlayer", "ShopPreview")
	hook.Remove("CreateMove", "ShopPreview")
	hook.Remove("PreDrawTranslucentRenderables", "ShopPreview")
	hook.Remove("PrePlayerDraw", "ShopPreview")

	if PreviewCostume then
		MySelf:RemoveCostume(PreviewCostume)
		PreviewCostume = nil
	end
	PreviewClass = nil

	self:Remove()
end

vgui.Register("NDBShopMenuClose", PANEL, "DButton")

local PANEL = {}

PANEL.LastCount = -1

function PANEL:Init()
	self.Counter = EasyLabel(self, "", "NDB_Shop_Font1", color_white)
	self.BonusCount = EasyLabel(self, "", "NDB_Shop_Font2", color_white)

	self:InvalidateLayout()
end

function PANEL:Think()
	local count = MySelf:GetCostumesElementCount(PreviewCostume)
	if count ~= self.LastCount then
		local maxmodels = NDB.GetMaxCostumeModels(LocalPlayer())

		self.Counter:SetText("Models: "..count.."/"..maxmodels)
		self.Counter:SetTextColor(count >= maxmodels and COLOR_RED or count >= maxmodels / 2 and COLOR_YELLOW or color_white)
		self.Counter:SizeToContents()

		local bonus = NDB.MemberExtraCostumeModels[MySelf:GetMemberLevel()]
		if bonus then
			self.BonusCount:SetText("(+"..bonus.." from membership)")
		else
			self.BonusCount:SetText("")
		end
		self.BonusCount:SizeToContents()

		self:InvalidateLayout()
	end
end

function PANEL:PerformLayout()
	self.Counter:Center()
	self.BonusCount:AlignBottom(4)
	self.BonusCount:CenterHorizontal()
end

function PANEL:Paint()
	draw.RoundedBoxEx(16, 0, 0, self:GetWide(), self:GetTall(), colBG, false, true, false, false)
end

vgui.Register("NDBShopMenuModelCounter", PANEL, "Panel")

local PANEL = {}

PANEL.m_CategoryID = 1

function PANEL:Init()
	self:SetText("")

	self.m_Text = EasyLabel(self, "", "DefaultFont", color_black)
	self.m_Image = vgui.Create("DImage", self)

	self:SetCategory(1)

	self:InvalidateLayout()
end

function PANEL:SetCategory(catid)
	self.m_CategoryID = catid

	self.m_Text:SetText(tostring(NDB.ShopCategories[catid]))
	self.m_Text:SizeToContents()

	self.m_Image:SetImage(ShopCategoryIcons[catid] or "VGUI/notices/error")
	self.m_Image:SetSize(16, 16)
end

function PANEL:GetCategory()
	return self.m_CategoryID
end

function PANEL:PerformLayout()
	self.m_Text:AlignLeft(4)
	self.m_Text:CenterVertical()
	self.m_Image:AlignRight(4)
	self.m_Image:CenterVertical()
end

function PANEL:DoClick()
	pShop.ItemCategory = self:GetCategory()
	pShop:RefreshItems()
end

vgui.Register("NDBShopCategoryButton", PANEL, "DButton")

local PANEL = {}

PANEL.m_CategoryID = 1

function PANEL:Init()
	self:SetText("")

	self.m_Text = EasyLabel(self, "", "DefaultFont", color_black)
	self.m_Image = vgui.Create("DImage", self)

	self:SetImage("VGUI/notices/error")

	self:InvalidateLayout()
end

function PANEL:SetButtonText(text)
	self.m_Text:SetText(text)
	self.m_Text:SizeToContents()

	self:InvalidateLayout()
end

function PANEL:SetImage(image)
	self.m_Image:SetImage(image)
	self.m_Image:SetSize(16, 16)

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	self.m_Text:AlignLeft(4)
	self.m_Text:CenterVertical()
	self.m_Image:AlignRight(4)
	self.m_Image:CenterVertical()
end

vgui.Register("NDBShopImageButton", PANEL, "DButton")

local PANEL = {}

AccessorFunc(PANEL, "m_HasItem", "HasItem", FORCE_BOOL)

function PANEL:Init()
	self.ItemTitle = EasyLabel(self, "", "DefaultFont", color_white)
	self.StatusImage = vgui.Create("DImage", self)
	self.StatusImage:SetMouseInputEnabled(true)

	self.AuthorImage = vgui.Create("DImage", self)
	self.AuthorImage:SetMouseInputEnabled(true)
	self.AuthorImage:SetImage("icon16/key.png")
	self.AuthorImage:SizeToContents()

	self.FavoriteButton = vgui.Create("DImageButton", self)
	self.FavoriteButton:SetImage("icon16/heart.png")
	self.FavoriteButton:SizeToContents()

	self:SetText("")

	self:SetItemTable(NDB.ShopItems["Mask"])
end

local function FavoriteDoClick(self)
	local name = self:GetParent():GetItemTable().Name

	if Favorites[name] then
		Favorites[name] = nil
		self:SetAlpha(60)
	else
		Favorites[name] = true
		self:SetAlpha(255)
	end

	SortItems()
	SaveFavorites()
end
function PANEL:PerformLayout()
	self.ItemTitle:AlignLeft(16)
	self.ItemTitle:CenterVertical()

	self.StatusImage:AlignRight(16)
	self.StatusImage:CenterVertical()

	self.FavoriteButton:MoveLeftOf(self.StatusImage)
	self.FavoriteButton:CenterVertical()
	self.FavoriteButton:SetTooltip("Toggle favorite")
	self.FavoriteButton.DoClick = FavoriteDoClick

	self.AuthorImage:MoveLeftOf(self.FavoriteButton)
	self.AuthorImage:CenterVertical()
end

function PANEL:SetHasItem(has)
	if has then
		self.StatusImage:SetImage("icon16/accept.png")
		self.StatusImage:SetTooltip("You have this item.")
		self.StatusImage:SetVisible(true)
	elseif self:GetItemTable() and (self:GetItemTable().Money or 0) > 0 then
		--self.StatusImage:SetImage("icon16/money.png")
		--self.StatusImage:SetTooltip("You have not purchased this item.")
		self.StatusImage:SetVisible(false)
	else
		self.StatusImage:SetImage("icon16/stop.png")
		self.StatusImage:SetTooltip("This item can't be bought.")
		self.StatusImage:SetVisible(true)
	end
	self.StatusImage:SizeToContents()

	self:InvalidateLayout()
end

function PANEL:SetItemTable(tab)
	self.ItemTable = tab

	self.ItemTitle:SetText(tab.Name)
	self.ItemTitle:SizeToContents()

	if tab.Class and costumes[tab.Class] and costumes[tab.Class].AuthorID == MySelf:SteamID() then
		self.AuthorImage:SetTooltip("You authored this item.\nEvery time someone buys it,\nyou will receive "..string.CommaSeparate(NDB.CostumeAuthorSilver).." Silver!")
		self.AuthorImage:SetVisible(true)
	else
		self.AuthorImage:SetTooltip()
		self.AuthorImage:SetVisible(false)
	end

	if Favorites[tab.Name] then
		self.FavoriteButton:SetAlpha(255)
	else
		self.FavoriteButton:SetAlpha(60)
	end

	self:SetHasItem(NDB.PlayerHasShopItem(MySelf, tab.Name))

	self:InvalidateLayout()
end

function PANEL:SetItemName(name)
	self.ItemTitle:SetText(name)
	self.ItemTitle:SizeToContents()

	self.AuthorImage:SetTooltip()
	self.AuthorImage:SetVisible(false)

	self.FavoriteButton:SetAlpha(60)

	self:SetHasItem(true)

	self:InvalidateLayout()
end

function PANEL:GetItemTable()
	return self.ItemTable
end

function PANEL:Paint()
	draw.RoundedBoxEx(8, 0, 0, self:GetWide(), self:GetTall(), self:IsDown() and colBGSelect or self.Hovered and colBGHover or colBG, true, false, true, false)
end

function PANEL:SetItemPreview(tab)
	if PreviewClass and PreviewClass == tab.Class then return end

	self:ClearItemPreview()

	PreviewClass = tab.Class
	pShopItem:SetItemTable(tab)

	local slot
	for k, v in ipairs(NDB.ShopItemList) do
		if v == tab then
			slot = k
			break
		end
	end
	if slot then MySelf:EmitSound("weapons/physcannon/physcannon_dryfire.wav", 0, 150 + (slot / #NDB.ShopItemList) * 100) end

	if not MySelf:HasCostume(tab.Class) then
		PreviewCostume = tab.Class
		MySelf:AddCostume(PreviewCostume)
	end
end

function PANEL:ClearItemPreview()
	PreviewClass = nil

	if PreviewCostume then
		MySelf:RemoveCostume(PreviewCostume)
		PreviewCostume = nil
	end

	pShopItem:SetItemTable(nil)
end

function PANEL:DoClick()
	self:SetItemPreview(self:GetItemTable())
end

vgui.Register("NDBShopItemPanel", PANEL, "DButton")
