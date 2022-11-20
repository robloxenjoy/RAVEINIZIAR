/// Datums are faster than lists
/datum/triangle
	var/x1
	var/x2
	var/x3
	var/y1
	var/y2
	var/y3

/datum/triangle/New(x1,y1,x2,y2,x3,y3)
	src.x1 = x1
	src.x2 = x2
	src.x3 = x3
	src.y1 = y1
	src.y2 = y2
	src.y3 = y3
