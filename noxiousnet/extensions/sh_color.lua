function encodecolor(r, g, b)
	return (bit.lshift(r, 16)) + (bit.lshift(g, 8)) + b
end

function decodecolor(col)
	return bit.band((bit.rshift(col, 16)), 255), bit.band((bit.rshift(col, 8)), 255), bit.band(col, 255)
end
