webchat = {}

function webchat.Add(message, name, ip, forumid, time)
	mysql_query(string.format("INSERT INTO csc (name, message, ip, forumid, time) VALUES(%q, %q, %q, %s, %s)", name or "", message, ip or "", forumid or 0, time or os.time()))
end
