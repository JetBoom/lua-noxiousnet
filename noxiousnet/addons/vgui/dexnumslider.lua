local PANEL = {}

function PANEL:Init()
	self.Slider = vgui.Create( "DSlider", self )
	self.Slider:SetLockY( 0.5 )
	self.Slider.TranslateValues = function( slider, x, y ) return self:TranslateSliderValues( x, y ) end
	self.Slider:SetTrapInside( true )
	self.Slider:SetImage( "vgui/slider" )

	self.DInput = vgui.Create("DButton", self)
	self.DInput:SetText(" ")
	self.DInput.Paint = function() end
	self.DInput.DoClick = function(button)
		local mx, my = gui.MousePos()

		local pan = vgui.Create("DEXRoundedFrame")
		pan:SetDeleteOnClose(true)
		pan:SetSize(160, 70)
		pan:SetPos(mx - pan:GetWide() / 2, my - pan:GetTall() / 2)

		local tentry = vgui.Create("DTextEntry", pan)
		tentry:SetNumeric(true)
		tentry:SetText(0)
		tentry:Dock(FILL)

		local ok = vgui.Create("DButton", pan)
		ok:SetTall(16)
		ok:SetText("OK")
		ok:Dock(BOTTOM)
		ok.DoClick = function(button)
			if self:IsValid() then
				self:SetValue(tentry:GetValue())
				pan:Close()
			end
		end

		pan:MakePopup()
	end

	self:SetMin(0)
	self:SetMax(1)
	self:SetDecimals(2)
	self:SetText("")
	self:SetValue(0.5)

	self:SetTall(35)
end

function PANEL:SetMinMax( min, max )
	self:SetMin( min )
	self:SetMax( max )
end

function PANEL:SetMin( min )
	self.m_numMin = tonumber( min )
end

function PANEL:SetMax( max )
	self.m_numMax = tonumber( max )
end

function PANEL:GetFloatValue( max )
	if ( !self.m_fFloatValue ) then m_fFloatValue = 0 end

	return tonumber( self.m_fFloatValue ) or 0
end

function PANEL:SetValue( val )
	if ( val == nil ) then return end

	local OldValue = val
	val = tonumber( val )
	val = val or 0

	if ( self.m_iDecimals == 0 ) then

		val = Format( "%i", val )

	elseif ( val != 0 ) then

		val = Format( "%."..self.m_iDecimals.."f", val )

		// Trim trailing 0's and .'s 0 this gets rid of .00 etc
		val = string.TrimRight( val, "0" )		
		val = string.TrimRight( val, "." )

	end

	self.Value = val
	self:UpdateConVar()
end

function PANEL:GetValue()
	return tonumber( self.Value ) or 0
end

function PANEL:SetConVar( cvar )
	self.ConVar = cvar
end

function PANEL:UpdateConVar()
	if self.ConVar then
		RunConsoleCommand( self.ConVar, self.Value )
	end
end

function PANEL:SetDecimals( num )
	self.m_iDecimals = num
end

function PANEL:GetDecimals()
	return self.m_iDecimals
end

function PANEL:GetFraction( val )
	local Value = val or self:GetValue()

	local Fraction = ( Value - self.m_numMin ) / (self.m_numMax - self.m_numMin)
	return Fraction
end

function PANEL:SetFraction( val )
	local Fraction = self.m_numMin + ( (self.m_numMax - self.m_numMin) * val )
	self:SetValue( Fraction )
end

function PANEL:PerformLayout()
	self.Slider:SetPos( 0, ( self:GetTall() / 2 ) )
	self.Slider:SetSize( self:GetWide(), 13 )

	self.Slider:SetSlideX( self:GetFraction() )

	self.DInput:SetSize(self:GetWide() / 3, self:GetTall() / 2)
	self.DInput:AlignRight()
	self.DInput:AlignTop()
end

function PANEL:Think()
	if self.ConVar and GetConVar( self.ConVar ):GetInt() != self.Value then
		self.Value = GetConVar( self.ConVar ):GetInt()
		self.Slider:SetSlideX( self:GetFraction() )
	end

	if self.LastValue ~= self:GetValue() then
		self.LastValue = self:GetValue()
		self:OnValueChanged(self.LastValue)
	end
end

function PANEL:OnValueChanged(value)
end

function PANEL:Paint( w, h )
	local val = self:GetValue()
	local title = string.upper( self:GetText() )

	if self.Descriptions then
		val = self.Descriptions[val+1]
	end

	surface.SetFont( self:GetFont() )
	local w, h = surface.GetTextSize( val )
	surface.SetTextColor( 255, 255, 255, 255 )

	// Value
	surface.SetTextPos( self:GetWide() - w - 5, 0 )
	surface.DrawText( val )

	// Title
	surface.SetTextPos( 5, 0 )
	surface.DrawText( title)

	// Line
	surface.SetDrawColor( 85, 167, 221, 150 )
	surface.DrawRect( 3, ( self:GetTall() / 2 ) + 6, self:GetWide() - 6, 3 )
end

function PANEL:SetText( text )
	self.Text = text
end

function PANEL:GetText()
	return self.Text or ""
end

function PANEL:SetFont(font)
	self.Font = font
end

function PANEL:GetFont()
	return self.Font or "dexfont_med"
end

function PANEL:ValueChanged( val )
	self.Slider:SetSlideX( self:GetFraction( val ) )
	self:UpdateConVar()
end

function PANEL:TranslateSliderValues( x, y )
	self:SetFraction( x )

	return self:GetFraction(), y
end

vgui.Register( "DEXNumSlider", PANEL, "Panel" )
