local PANEL = {}

AccessorFunc( PANEL, "m_bScrollbars", 			"Scrollbars", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_bAllowLua", 			"AllowLua", 		FORCE_BOOL )

function PANEL:Init()

	self.LoadedContent = true

	self.History = {}
	self.CurrentPage = 0

	self.URL = ""

	self:SetScrollbars( true )
	self:SetAllowLua( true )

	self.JS = {}
	self.Callbacks = {}

	--
	-- Implement a console.log - because awesomium doesn't provide it for us anymore.
	--
	self:AddFunction( "console", "log", function( param ) self:ConsoleMessage( param ) end )
	self:AddFunction( "console", "error", function( param ) self:ConsoleMessage( param ) end )

	self:AddFunction( "gmod", "getUrl", function( href, finished )
		self.URL = href

		if finished then
			self:OpeningURL( href ) -- browser controls suck
			self:FinishedURL( href )
		else
			self:OpeningURL( href )
		end
	end )

	local oldFunc = self.OpenURL
	self.OpenURL = function( panel, url, history )

		if !history then
			-- Pop URLs from the stack
			while #panel.History != panel.CurrentPage do
				table.remove( panel.History )
			end
			table.insert( panel.History, url )
			panel.CurrentPage = panel.CurrentPage + 1
		end

		panel.URL = url
		oldFunc( panel, url )
	end

end

function PANEL:Think()

	if self:IsLoading() then
		if self.LoadedContent then
			self:RunJavascript("gmod.getUrl(window.location.href, false);")
			self.LoadedContent = false
		end
	else
		if !self.LoadedContent then
			self:RunJavascript("gmod.getUrl(window.location.href, true);")
			self.LoadedContent = true
		end
	end

	if ( self.JS && !self:IsLoading() ) then

		for k, v in pairs( self.JS ) do

			self:RunJavascript( v )

		end

		self.JS = nil

	end

end

function PANEL:Paint()

	if ( self:IsLoading() ) then
		return true
	end

end

function PANEL:QueueJavascript( js )

	--
	-- Can skip using the queue if there's nothing else in it
	--
	if ( !self.JS && !self:IsLoading() ) then
		return self:RunJavascript( js )
	end

	self.JS = self.JS or {}

	table.insert( self.JS, js )
	self:Think();

end

function PANEL:Call( js )
	self:QueueJavascript( js )
end

function PANEL:ConsoleMessage( msg )

	if ( !isstring( msg ) ) then msg = "*js variable*" end

	if ( self.m_bAllowLua && msg:StartWith( "RUNLUA:" ) ) then

		local strLua = msg:sub( 8 )

		SELF = self
		RunString( strLua );
		SELF = nil
		return; 

	end

	MsgC( Color( 255, 160, 255 ), "[HTML] " );
	MsgC( Color( 255, 255, 255 ), msg, "\n" )	

end

--
-- Called by the engine when a callback function is called
--
function PANEL:OnCallback( obj, func, args )

	--
	-- Use AddFunction to add functions to this.
	--
	local f = self.Callbacks[ obj .. "." .. func ]

	if ( f ) then
		return f( unpack( args ) )
	end

end

--
-- Add a function to Javascript
--
function PANEL:AddFunction( obj, funcname, func )

	--
	-- Create the `object` if it doesn't exist
	--
	if ( !self.Callbacks[ obj ] ) then
		self:NewObject( obj )
		self.Callbacks[ obj ] = true
	end

	--
	-- This creates the function in javascript (which redirects to c++ which calls OnCallback here)
	--
	self:NewObjectCallback( obj, funcname )

	--
	-- Store the function so OnCallback can find it and call it
	--
	self.Callbacks[ obj .. "." .. funcname ] = func;

end

function PANEL:GetURL()
	return self.URL
end

function PANEL:HTMLBack()
	if self.CurrentPage <= 1 then return end
	self.CurrentPage = self.CurrentPage - 1
	self:OpenURL( self.History[ self.CurrentPage ], true )
end

function PANEL:HTMLForward()
	if self.CurrentPage == #self.History then return end
	self.CurrentPage = self.CurrentPage + 1
	self:OpenURL( self.History[ self.CurrentPage ], true )
end

function PANEL:OpeningURL( url )
end

function PANEL:FinishedURL( url )
end

function PANEL:Remove()
	self.BaseClass.Remove( self )
end

derma.DefineControl( "DEXHTML", "Extended DHTML control", PANEL, "DHTML" )
