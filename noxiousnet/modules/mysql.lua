require("mysqloo")

local SQL_HOST = game.IsDedicated() and "localhost" or "noxiousnet.com"
local SQL_USER = "root"
local SQL_PASSWORD = "d1c1R08hcOtFF2123c4C76z78i6nCWy35BIpDh4N0249572yH65Un3DzfMBE"
local SQL_DB = "nox"

local COLOR_RED = Color(255, 0, 0)
local COLOR_LIMEGREEN = Color(30, 255, 30)

local RetryTime = 10
local StatusCheckTime = 180

---------

local Queue = {}
local Processing = {}
local NextRetry = 0
local NextStatusCheck = 0

local function CreateConnection()
	local systime = SysTime()

	NextRetry = systime + RetryTime
	NextStatusCheck = systime + StatusCheckTime

	--TEMPDB = mysqloo.connect(SQL_HOST, SQL_USER, SQL_PASSWORD, SQL_DB, 3306, "", mysqloo.CLIENT_MULTI_STATEMENTS)
	TEMPDB = mysqloo.connect(SQL_HOST, SQL_USER, SQL_PASSWORD, SQL_DB)
	TEMPDB.onConnectionFailed = function(db, err)
		MsgC(COLOR_RED, "Error connecting to MySQL: ", err, "\n")
		TEMPDB = nil
	end
	TEMPDB.onConnected = function(db)
	MsgC(COLOR_LIMEGREEN, "Connected to MySQL!\n")
		MYSQL_CONNECTION = db
		TEMPDB = nil
	end
	TEMPDB:connect()
end

local function onError(self, err, strquery)
	MsgC(COLOR_RED, "MySQL Error: ", err, "\n")
end

function mysql_query(strquery, callback, ...)
	if MYSQL_CONNECTION then
		if not strquery then return end

		--strquery = MYSQL_CONNECTION:escape(strquery)
		local query = MYSQL_CONNECTION:query(strquery)

		if callback then
			local args = {...}
			query.onSuccess = function(q, data)
				callback(q, data, unpack(args))
			end
		end

		query.onError = onError

		query:start()
		--MsgC(Color(0, 255, 0), "Query: ", strquery, "\n")
	else
		table.insert(Queue, {strquery, callback, {...}})
	end
end

function mysql_multi_query(queries)
	if #queries > 0 then
		--mysql_query(table.concat(queries, ";\n"))
		for _, query in pairs(queries) do
			mysql_query(query)
		end
	end
end

--local QUERY_NOT_RUNNING = mysqloo.QUERY_NOT_RUNNING
local QUERY_RUNNING = mysqloo.QUERY_RUNNING
local QUERY_READING_DATA = mysqloo.QUERY_READING_DATA
--local QUERY_COMPLETE = mysqloo.QUERY_COMPLETE
--local QUERY_ABORTED = mysqloo.QUERY_ABORTED

local DATABASE_CONNECTED = mysqloo.DATABASE_CONNECTED
local DATABASE_CONNECTING = mysqloo.DATABASE_CONNECTING
--local DATABASE_NOT_CONNECTED = mysqloo.DATABASE_NOT_CONNECTED
--local DATABASE_INTERNAL_ERROR = mysqloo.DATABASE_INTERNAL_ERROR

hook.Add("Think", "MySQLWrapper", function()
	if TEMPDB then return end

	local systime = SysTime()

	local qcount = #Processing
	if qcount > 0 then
		local query = Processing[qcount]
		if query ~= nil then
			local status = query:status()
			if status ~= QUERY_RUNNING and status ~= QUERY_READING_DATA then
				table.remove(Processing, qcount)
			end
		end
	end

	if MYSQL_CONNECTION then
		if qcount == 0 and systime > NextStatusCheck then
			NextStatusCheck = systime + StatusCheckTime

			--if #player.GetAll() <= 16 then -- This creates lag so only do it if the population is low.
				local status = MYSQL_CONNECTION:status()
				if status ~= DATABASE_CONNECTING and status ~= DATABASE_CONNECTED then
					MsgC(COLOR_RED, "MySQL connection went away.\n")
					CreateConnection()
				end
			--end
		else
			local q = Queue[1]
			if q then
				local query
				local strquery = q[1]
				local callback = q[2]
				local args = q[3]
				table.remove(q, 1)
				if args then
					query = mysql_query(strquery, callback, unpack(args))
				else
					query = mysql_query(strquery, callback)
				end

				if query then
					table.insert(Processing, query)
				end
			end
		end
	elseif systime > NextRetry then
		CreateConnection()
	end
end)

hook.Add("ShutDown", "MySQLWrapper", function()
	TEMPDB = nil
	MYSQL_CONNECTION = nil
	hook.Remove("Think", "MySQLWrapper")
end)

CreateConnection()

-- TODO: move Mysqloo::poll function from Think to Tick (maybe with a limiter if called too quick)
