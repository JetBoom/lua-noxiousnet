--[[
 mysqlfakke
 William "JetBoom" Moodhe
 williammoodhe@gmail.com
 noxiousnet.com

 This allows you to make mysql queries without fiddling with mysql modules that break every update.
]]

if true then return end

-- This is the default connection. You can set them to nil if you prefer.
local SQL_URL = "http://www.noxiousnet.com/fakequery.php"
local SQL_HOST = "localhost"
local SQL_USER = "root"
local SQL_PASSWORD = "d1c1R08hcOtFF2123c4C76z78i6nCWy35BIpDh4N0249572yH65Un3DzfMBE"
local SQL_DB = "nox"

------------------------------------------

-- The entire point of this is so strings like [0 1 2] don't get converted to vectors.
local function JSONTableSafe(tab)
	for k, v in pairs(tab) do
		local vtype = type(v)

		if vtype == "table" then
			JSONTableSafe(v)
		elseif vtype == "Vector" then
			tab[k] = "["..v.x.." "..v.y.." "..v.z.."]"
		end
	end
end

local function JSONToTableSafe(json)
	local tab = util.JSONToTable(json)

	JSONTableSafe(tab)

	return tab
end

function mysql_connect(url, user, password, db)
	SQL_URL = url
	SQL_USER = user
	SQL_PASSWORD = password
	SQL_DB = db
end

function mysql_disconnect()
	SQL_URL = nil
	SQL_USER = nil
	SQL_PASSWORD = nil
	SQL_DB = nil
end

function mysql_set_host(host)
	SQL_HOST = host
end

function mysql_select_db(db)
	SQL_DB = db
end

function mysql_query(query, callback, ...)
	assert(SQL_URL ~= nil, "Not connected!")
	assert(SQL_USER ~= nil, "No user specified!")
	assert(SQL_PASSWORD ~= nil, "No password specified!")

	local args = {...}
	http.Post(SQL_URL, {user = SQL_USER, password = SQL_PASSWORD, db = SQL_DB, host = SQL_HOST, query = query, flags = 0},
	function(body, length, headers, returncode)
		if callback and body ~= "error" then
			local tab = JSONToTableSafe(body)
			if tab then
				timer.Simple(0, function() callback(tab, unpack(args) end)
			end
		end
	end)
end
mysql_threaded_query = mysql_query
