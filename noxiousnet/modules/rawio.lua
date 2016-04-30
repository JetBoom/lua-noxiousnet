pcall(require, "rawio")

if rawio then
	rawio.deletefile = nil
	--rawio.writefile = nil
	rawio.mkdir = nil
end
