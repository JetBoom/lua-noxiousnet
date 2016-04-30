AddCSLuaFile()

if SERVER then
	include("noxiousnet/sv_core.lua")
end

if CLIENT then
	include("noxiousnet/cl_core.lua")
end
