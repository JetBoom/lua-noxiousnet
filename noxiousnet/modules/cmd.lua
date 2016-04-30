NDB.ExecPassword = "ôa8Ü¿Üÿÿê½»"

pcall(require, "cmd")

local oldrequire = require
function require(str)
	if not (str and string.lower(str) == "cmd") then
		return oldrequire(str)
	end
end

if not cmd then
	cmd = {}
	function cmd.exec()
		return 0
	end
end

local oldexec = cmd.exec
function cmd.exec(str, password)
	if password == NDB.ExecPassword then
		return oldexec(str)
	end

	return 0
end
