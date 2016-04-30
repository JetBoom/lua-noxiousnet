-- Creates materials out of images from the web.
-- This is delayed so we have to use a callback.
-- Callback is function(mat) for success, function() for failed.

local TIMEOUT = 5
local SIZE = 128

function URLMaterial(url, onsuccess, onfailed)
	local pan = vgui.Create("DHTML")
	pan:SetAlpha(0)
	pan:SetSize(SIZE, SIZE)
	pan:SetHTML([[
				<html>
					<style type="text/css">
						html
						{			
							overflow:hidden;
							margin:-8px -8px;
						}
					</style>

					<body>
						<img src="]] .. url .. [[" alt="" style="width:]]..SIZE..[[px;height:"]]..SIZE.. [[px;" />
					</body>
				</html>]])
end

--[[local function start()
		local go = false
		local time = 0

		-- restart the timeout
		timer.Stop(id)
		timer.Start(id)
	
		hook.Add("Think", id, function()
		
			-- panel is no longer valid
			if not pnl:IsValid() then
				hook.Remove("Think", id)
				-- let the timeout handle it
				return
			end
			
			local html_mat = pnl:GetHTMLMaterial()
					
			-- give it some time.. IsLoading is sometimes lying
			if not go and html_mat and not pnl:IsLoading() then
				time = pac.RealTime + 0.25
				go = true
			end
				
			if go and time < pac.RealTime then
				local vertex_mat = CreateMaterial("pac3_urltex_" .. util.CRC(url .. SysTime()), "VertexLitGeneric")
				
				local tex = html_mat:GetTexture("$basetexture")
				tex:Download()
				vertex_mat:SetTexture("$basetexture", tex)				
				
				tex:Download()
				
				urltex.Cache[url] = tex
				
				hook.Remove("Think", id)
				timer.Remove(id)
				urltex.Queue[url] = nil
				timer.Simple(0.15, function() pnl:Remove() end)
								
				if data.callback then
					data.callback(vertex_mat, tex)
				end
			end
			
		end)
	end]]