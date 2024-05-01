/turf/podpol
	name = "Стена"
	icon = 'icons/wall.dmi'
	icon_state = "wall"
	base_icon_state = "wall"
	var/state1 = "wall1"
	var/state2 = "wall2"
	var/special_dir = FALSE
	var/base_turf = /turf/open/floor/plating/polovich/codec/dirt/mud

/turf/podpol/proc/update_icon_turf()
	icon_state = state2
	var/list/surround = list(0, 0, 0, 0) //up, down, right, left
	if(istype(locate(x, y + 1, z), type))
		surround[1] = 1
	if(istype(locate(x, y - 1, z), type))
		surround[2] = 1
	if(istype(locate(x + 1, y, z), type))
		surround[3] = 1
	if(istype(locate(x - 1, y, z), type))
		surround[4] = 1
	switch(list2params(surround))
		if("1&0&0&0")
			icon_state = "[base_icon_state]_north"
			if(special_dir)
				if(dir)
					dir = rand(0, 4)
		if("0&1&0&0")
			dir = SOUTH
		if("0&0&1&0")
			dir = EAST
		if("0&0&0&1")
			dir = WEST
		if("0&1&0&1")
			dir = NORTHWEST
		if("1&0&0&1")
			dir = SOUTHWEST
		if("0&1&1&0")
			dir = NORTHEAST
		if("1&0&1&0")
			dir = SOUTHEAST

		if("1&0&1&1")
			icon_state = state1
			dir = SOUTHEAST
		if("0&1&1&1")
			icon_state = state1
			dir = SOUTHWEST
		if("1&1&1&0")
			icon_state = state1
			dir = NORTHEAST
		if("1&1&0&1")
			icon_state = state1
			dir = NORTHWEST
		if("1&1&0&0")
			icon_state = state1
			dir = SOUTH
		if("0&0&1&1")
			icon_state = state1
			dir = NORTH
		if("1&1&1&1")
			icon_state = state1
			dir = EAST
		else
			icon_state = state1
			dir = WEST

/turf/podpol/wall/Destroy()
	new base_turf(src)
	for(var/turf/podpol/wall/F in oview(1, base_turf))
		F.update_icon_turf()
	..()