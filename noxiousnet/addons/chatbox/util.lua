function NNChat.GetAttributes(contents)
	local attributes = {}

	contents = string.Trim(contents)

	for i=1, 500 do
		local start, stop, attrib, value = string.find(contents, "(.-)=[\"%'-]([^\"']+)[\"%']%s*") -- People might use quotes.
		if not start then
			start, stop, attrib, value = string.find(contents, "(.-)=([^%s]+)%s*")
		end

		if attrib and value then
			attributes[string.lower(attrib)] = value
			contents = string.TrimLeft(string.sub(contents, stop + 1))
		else
			break
		end
	end

	if attributes.c and not attributes.color then
		attributes.color = attributes.c
	end

	return attributes
end

function NNChat.GetTitles(ent)
	local titles = {}

	local pretitle = ent:GetPreTitle()
	local pltitles = {}

	if ent.NewTitle and ent.NewTitle ~= "" or not ent.Titles or #ent.Titles == 0 then
		table.insert(pltitles, ent.NewTitle or "")
	end

	if ent.Titles then
		for ___, pltitle in ipairs(ent.Titles) do
			table.insert(pltitles, pltitle)
		end
	end

	for ti, title in ipairs(pltitles) do
		if pretitle ~= "" then
			if title == "" then
				title = pretitle
			else
				title = pretitle.." "..title
			end
		end

		if title ~= "" then
			titles[#titles + 1] = title
		end
	end

	if #titles > 0 then
		return titles
	end
end

function NNChat.GetRealTextSize(text)
	text = string.gsub(text, "&", "W")
	local tw, th = surface.GetTextSize(text)
	return tw, th
end

function NNChat.CreateChatBoxFont(fontname, fontfamily, size, weight, notaguse)
	surface.CreateFont(fontname, {font = fontfamily, size = size, weight = weight, antialias = true, shadow = true, outline = false})
	--surface.CreateFont(fontname.."shadow", {font = fontfamily, size = size, weight = weight, antialias = false, shadow = false, outline = true, blursize = 1})

	if not table.HasValue(NNChat.ValidChatFonts, fontname) then
		table.insert(NNChat.ValidChatFonts, fontname)
	end

	if notaguse and not table.HasValue(NNChat.NoTagUseFonts, fontname) then
		table.insert(NNChat.NoTagUseFonts, fontname)
	end
end

function NNChat.SafeColor(data)
	return math.Clamp(math.ceil(tonumber(data or 255) or 255), 0, 255)
end

function NNChat.ExtractColor(data)
	if data then
		-- web
		local hex = data:match("#([0-9a-fA-F]+)")
		if hex then
			if #hex == 3 then -- shorthand
				return Color(tonumber("0x"..hex:sub(1, 1)) * 17, tonumber("0x"..hex:sub(2, 2)) * 17, tonumber("0x"..hex:sub(3, 3)) * 17)
			elseif #hex == 6 then
				return Color(tonumber("0x"..hex:sub(1, 2)), tonumber("0x"..hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6)))
			end
		end

		-- rgba255
		local r, g, b, a = data:match("(%d+),(%d+),(%d+),(%d+)")
		if r then
			return Color(NNChat.SafeColor(r), NNChat.SafeColor(g), NNChat.SafeColor(b), NNChat.SafeColor(a))
		end

		-- rgb255
		r, g, b = data:match("(%d+),(%d+),(%d+)")
		if r then
			return Color(NNChat.SafeColor(r), NNChat.SafeColor(g), NNChat.SafeColor(b))
		end
	end

	return Color(255, 255, 255)
end

local texCorner = surface.GetTextureID("zombiesurvival/circlegradient")
local texUpEdge = surface.GetTextureID("gui/gradient_up")
local texDownEdge = surface.GetTextureID("gui/gradient_down")
local texRightEdge = surface.GetTextureID("gui/gradient")
function NNChat.BlurryBox(x, y, wid, hei, edgesize)
	edgesize = edgesize or math.ceil(math.min(hei * 0.1, math.min(16, wid * 0.1)))
	local hedgesize = edgesize * 0.5
	DisableClipping(true)
	surface.DrawRect(x, y, wid, hei)
	surface.SetTexture(texUpEdge)
	surface.DrawTexturedRect(x, y - edgesize, wid, edgesize)
	surface.SetTexture(texDownEdge)
	surface.DrawTexturedRect(x, y + hei, wid, edgesize)
	surface.SetTexture(texRightEdge)
	surface.DrawTexturedRect(wid, y, edgesize, hei)
	surface.DrawTexturedRectRotated(x + hedgesize * -1, y + hei * 0.5, edgesize, hei, 180)
	surface.SetTexture(texCorner)
	surface.DrawTexturedRect(x - edgesize, y - edgesize, edgesize, edgesize)
	surface.DrawTexturedRectRotated(x + wid + hedgesize, y - hedgesize, edgesize, edgesize, 270)
	surface.DrawTexturedRectRotated(x + wid + hedgesize, y + hei + hedgesize, edgesize, edgesize, 180)
	surface.DrawTexturedRectRotated(x - hedgesize, y + hei + hedgesize, edgesize, edgesize, 90)
	DisableClipping(false)
end

-- HSV to RGB color conversion
-- by Eugene Vishnevsky at: http://www.cs.rit.edu/~ncs/color/t_convert.html
function NNChat.HSVtoRGB(h, s, v)
	local r, g, b
	local f, p, q, t

	-- Make sure our arguments stay in-range
	h = math.max(0, math.min(360, h))
	s = math.max(0, math.min(100, s))
	v = math.max(0, math.min(100, v))

	--[[We accept saturation and value arguments from 0 to 100 because that's
	how Photoshop represents those values. Internally, however, the
	saturation and value are calculated from a range of 0 to 1. We make
	That conversion here.]]
	s = s / 100
	v = v / 100

	if s == 0 then
		-- Achromatic (grey)
		local gray = math.Round(v * 255)
		return Color(gray, gray, gray)
	end

	h = h / 60 -- sector 0 to 5
	local i = math.floor(h)
	f = h - i -- factorial part of h
	p = v * (1 - s)
	q = v * (1 - s * f)
	t = v * (1 - s * (1 - f))

	if i == 0 then
		r = v
		g = t
		b = p
	elseif i == 1 then
		r = q
		g = v
		b = p
	elseif i == 2 then
		r = p
		g = v
		b = t
	elseif i == 3 then
		r = p
		g = q
		b = v
	elseif i == 4 then
		r = t
		g = p
		b = v
	else
		r = v
		g = p
		b = q
	end

	return Color(math.Round(r * 255), math.Round(g * 255), math.Round(b * 255))
end

function NNChat.ExtractHSV(data)
	local t = string.Explode(",", data or "")
	return tonumber(t[1] or 0) or 0, tonumber(t[2] or 0) or 0, tonumber(t[3] or 0) or 0
end

function NNChat.SafeFont(data)
	return table.HasValue(NNChat.ValidChatFonts, data) and not table.HasValue(NNChat.NoTagUseFonts, data) and data or "nice"
end

function NNChat.NoParseFunction(text, defaultcolor, defaultfont, panel, x, maxwidth)
	return NNChat.EasyLineWrap(panel, text, defaultfont, defaultcolor, x, maxwidth)
end

local safeimg = {}
local function IsGUISafe(fil)
	if not fil or safeimg[fil] == false then return false end
	if safeimg[fil] == true then return true end

	if string.EndsWith(string.lower(fil), ".png") then
		local noext = string.sub(fil, 1, -5)
		if string.find(noext, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") or not file.Exists("materials/"..noext..".png", "GAME") then
			safeimg[fil] = false
		else
			local mat = Material(fil)
			safeimg[fil] = mat and not mat:IsError() and mat:Height() <= 512 and mat:Width() <= 512
		end
	elseif string.EndsWith(string.lower(fil), ".jpg") then
		local noext = string.sub(fil, 1, -5)
		if string.find(noext, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") or not file.Exists("materials/"..noext..".jpg", "GAME") then
			safeimg[fil] = false
		else
			local mat = Material(fil)
			safeimg[fil] = mat and not mat:IsError() and mat:Height() <= 512 and mat:Width() <= 512
		end
	else
		if string.find(fil, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") or not file.Exists("materials/"..fil..".vmt", "GAME") then
			safeimg[fil] = false
		else
			local contents = file.Read("materials/"..fil..".vmt", "GAME")
			if contents then
				local ignorez = string.find(contents, "UnlitGeneric")
				local model = string.match(contents, "$model.-(%d)")
				local nocull = string.match(contents, "$nocull.-(%d)")
				local additive = string.match(contents, "$additive.-(%d)")
				safeimg[fil] = ignorez and (not model or model == "0") and (not nocull or nocull == "0") and (not additive or additive == "0")
			else
				safeimg[fil] = false
			end
		end
	end

	return safeimg[fil]
end

function NNChat.GetParserByName(name)
	for _, parsertab in pairs(NNChat.Parsers) do
		if parsertab.ParserName == name then
			return parsertab
		end
	end
end

local cachedexists = {}

local function IsLocalEmoticon(filename)
	if cachedexists[filename] ~= nil then
		return cachedexists[filename]
	end

	local localfile = "materials/noxemoticons/"..filename
	local exists = file.Exists(localfile..".png", "GAME") or file.Exists(localfile..".jpg", "GAME") or file.Exists(localfile..".vmt", "GAME")

	cachedexists[filename] = exists

	return exists
end

function NNChat.CreateEmoticon(filename, attributes, panel, packages)
	if NNChat.DynamicImages[filename] then
		return NNChat.CreateIMGDyn(NNChat.DynamicImages[filename], attributes, panel, packages)
	end

	if IsLocalEmoticon(filename) then
		return NNChat.CreateIMG("noxemoticons/"..filename, attributes, panel, packages)
	end
end

function NNChat.CreateIMG(fil, attributes, panel, packedstuff, maxw, maxh, nilinvalid, noresize)
	if fil ~= "debug/debugempty" and not IsGUISafe(fil) then
		if IsGUISafe(fil..".png") then
			fil = fil..".png"
		elseif IsGUISafe(fil..".jpg") then
			fil = fil..".jpg"
		elseif nilinvalid then
			return
		else
			return NNChat.CreateIMG("debug/debugempty", attributes, panel, packedstuff, math.min(maxw or 24, 24), math.min(maxh or 24, 24))
		end
	end

	local newpanel = vgui.Create("NNChatImage", panel)

	if not noresize then
		newpanel:SetMaxSize(math.min(48, maxw or 48, maxh or 48)) -- Hard clamped limit of 48
	end

	newpanel:SetPreAttribs(attributes)
	newpanel:SetImage(fil)
	newpanel:SetPostAttribs(attributes)
	newpanel:SetTooltip(tostring(fil))

	return {Panel = newpanel}
end

function NNChat.CreateIMGDyn(fil, attributes, panel, packedstuff, maxw, maxh, nilinvalid, noresize)
	local newpanel = vgui.Create("NNChatDynImage", panel)

	if not noresize then
		newpanel:SetMaxSize(math.min(48, maxw or 48, maxh or 48)) -- Hard clamped limit of 48
	end

	newpanel:SetSize(48, 48)
	newpanel:SetPreAttribs(attributes)
	newpanel:SetPostAttribs(attributes)
	newpanel:SetFileName(fil)
	newpanel:SetTooltip(tostring(fil))

	return {Panel = newpanel}
end

local PANEL = {}

AccessorFunc(PANEL, "m_Color", "ImageColor")
AccessorFunc(PANEL, "m_BackgroundColor", "ImageBackgroundColor")
AccessorFunc(PANEL, "m_RotationDesired", "RotationDesired")
AccessorFunc(PANEL, "m_RotationBase", "RotationBase")
AccessorFunc(PANEL, "m_RotationRate", "RotationRate")
AccessorFunc(PANEL, "m_CreatedTime", "CreatedTime")
AccessorFunc(PANEL, "m_Material", "Material")
AccessorFunc(PANEL, "m_MaxSize", "MaxSize", FORCE_NUMBER)
AccessorFunc(PANEL, "m_SizeMultiplier", "SizeMultiplier", FORCE_NUMBER)

function PANEL:Init()
	if not self.m_Color then
		self:SetImageColor(Color(255, 255, 255))
	end
	if not self.m_MaxSize then
		self:SetMaxSize(-1)
	end
	if not self.m_SizeMultiplier then
		self:SetSizeMultiplier(1)
	end
	self:SetCreatedTime(RealTime())

	self:SetMouseInputEnabled(true)
end

function PANEL:SetPreAttribs(attributes)
	if attributes.size then
		self:SetSizeMultiplier(math.Clamp((tonumber(attributes.size) or 100) / 100, 0.1, 10))
	end
end

function PANEL:SetPostAttribs(attributes)
	if attributes.drot then
		self:SetRotationBase((tonumber(attributes.rot or 0) or 0) % 360)
		self:SetRotationRate(math.Clamp(tonumber(attributes.rotrate or 0) or 0, -1200, 1200))
		self:SetRotationDesired(tonumber(attributes.drot) or 0)
	elseif attributes.rot or attributes.rotrate and tonumber(attributes.rotrate) ~= 0 then
		self:SetRotationBase((tonumber(attributes.rot or 0) or 0) % 360)
		self:SetRotationRate(math.Clamp(tonumber(attributes.rotrate or 0) or 0, -1200, 1200))
	end

	if attributes.color then
		local col = NNChat.ExtractColor(attributes.color)
		if attributes.a then
			col.a = NNChat.SafeColor(attributes.a)
		end
		self:SetImageColor(col)
	end

	local bg = attributes.bg or attributes.background
	if bg then
		local col = NNChat.ExtractColor(bg)
		if attributes.a then
			col.a = NNChat.SafeColor(attributes.a)
		end
		self:SetImageBackgroundColor(col)
	end

	if attributes.hsv then
		local col = NNChat.HSVtoRGB(NNChat.ExtractHSV(attributes.hsv))
		if attributes.a then
			col.a = NNChat.SafeColor(attributes.a)
		end
		self:SetImageColor(col)
	end

	if attributes.a then
		self.m_Color.a = NNChat.SafeColor(attributes.a)
	end
end

function PANEL:Paint(w, h)
	local mat = self:GetMaterial()
	if not mat then return true end

	if self.m_BackgroundColor then
		surface.SetDrawColor(self.m_BackgroundColor)
		surface.DrawRect(0, 0, w, h)
	end

	surface.SetMaterial(mat)
	surface.SetDrawColor(self.m_Color)

	local rot
	if self.m_RotationDesired then
		self.m_RotationBase = math.Approach(self.m_RotationBase, self.m_RotationDesired, self.m_RotationRate * FrameTime())
		rot = self.m_RotationBase
	elseif self.m_RotationBase then
		rot = self.m_RotationBase + self.m_RotationRate * (RealTime() - self.m_CreatedTime)
	end

	if rot then
		surface.DrawTexturedRectRotated(w / 2, h / 2, w, h, -(rot % 360))
	else
		surface.DrawTexturedRect(0, 0, w, h)
	end

	return true
end

function PANEL:SetImage(mat)
	self:SetMaterial(type(mat) == "string" and Material(mat) or mat)
	self:SizeToContents()
end

function PANEL:SizeToContents()
	local mat = self:GetMaterial()
	if not mat or mat:IsError() then
		self:SetSize(48, 48)
		return
	end

	local w, h = mat:Width() * self.m_SizeMultiplier, mat:Height() * self.m_SizeMultiplier

	local maxsize = self:GetMaxSize()
	if maxsize > 0 then
		if w > maxsize or h > maxsize then
			if w > h then
				h = maxsize * (h / w)
				w = maxsize
			else
				w = maxsize * (w / h)
				h = maxsize
			end
		end
	end

	self:SetSize(w, h)
end

vgui.Register("NNChatImage", PANEL)

PANEL = {}

PANEL.NextThink = 0

local DynMaterial = {}
local DynMaterialRequested = {}

function PANEL:Init()
	self.GiveUp = RealTime() + 10
end

function PANEL:SetFileName(fil)
	self.URL = fil
	self.RawFileName = string.GetFileFromFilename(fil)
	self.FileName = "../data/"..self.RawFileName
	self:Think()
end

local function FetchDynImage(url, rawfilename)
	--print("fetching", "http://heavy.noxiousnet.com/"..rawfilename, "material from internet")
	http.Fetch("https://noxiousnet.com/"..url,
	function(body, length, headers, code)
		if not body:lower():find("<html", 1, true) then
			file.Write(rawfilename, body)
			--print("successfully fetched "..rawfilename)
		end
	end,
	function()
		--print("failed to GET "..rawfilename)
	end)
end
local NextHTTPFetch = 0
function PANEL:Think()
	local time = RealTime()
	if time < self.NextThink then return end
	self.NextThink = time + 0.5

	if not self.URL then return end

	if time >= self.GiveUp then
		self.Think = nil
	elseif DynMaterial[self.RawFileName] then
		self:SetImage(DynMaterial[self.RawFileName])
		self.Think = nil
		--print("using cached material")
	elseif file.Exists(self.RawFileName, "DATA") then
		local mat = Material(self.FileName)
		DynMaterial[self.RawFileName] = mat
		self:SetImage(mat)
		self.Think = nil
		--print("pulling material from disk", self.FileName)
	elseif not DynMaterialRequested[self.RawFileName] then
		if time >= NextHTTPFetch then
			NextHTTPFetch = time + 0.75
			DynMaterialRequested[self.RawFileName] = true
			FetchDynImage(self.URL, self.RawFileName)
		end
	end
end

vgui.Register("NNChatDynImage", PANEL, "NNChatImage")
