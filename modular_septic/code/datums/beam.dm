/datum/beam/New(beam_origin, \
				beam_target, \
				beam_icon = 'icons/effects/beam.dmi', \
				beam_icon_state = "b_beam", \
				time = INFINITY, \
				maxdistance = INFINITY, \
				btype = /obj/effect/ebeam)
	origin = beam_origin
	target = beam_target
	max_distance = maxdistance
	icon = beam_icon
	icon_state = beam_icon_state
	beam_type = btype
	if(time < INFINITY)
		QDEL_IN(src, time)

/datum/beam/Draw()
	var/Angle = round(get_angle(origin,target))
	var/matrix/rot_matrix = matrix()
	var/turf/origin_turf = get_turf(origin)
	rot_matrix.Turn(Angle)

	//Translation vector for origin and target
	var/DX = (world.icon_size*target.x+target.pixel_x)-(world.icon_size*origin.x+origin.pixel_x)
	var/DY = (world.icon_size*target.y+target.pixel_y)-(world.icon_size*origin.y+origin.pixel_y)
	var/N = 0
	var/length = round(sqrt((DX)**2+(DY)**2)) //hypotenuse of the triangle formed by target and origin's displacement

	for(N in 0 to length-1 step 32)//-1 as we want < not <=, but we want the speed of X in Y to Z and step X
		if(QDELETED(src))
			break
		var/obj/effect/ebeam/X = new beam_type(origin_turf)
		X.owner = src
		elements += X

		//Assign our single visual ebeam to each ebeam's vis_contents
		//ends are cropped by a transparent box icon of length-N pixel size laid over the visuals obj
		if(N+32>length) //went past the target, we draw a box of space to cut away from the beam sprite so the icon actually ends at the center of the target sprite
			var/icon/II = new(icon, icon_state)//this means we exclude the overshooting object from the visual contents which does mean those visuals don't show up for the final bit of the beam...
			II.DrawBox(null,1,(length-N),32,32)//in the future if you want to improve this, remove the drawbox and instead use a 513 filter to cut away at the final object's icon
			X.icon = II
		else
			X.vis_contents += visuals
		X.transform = rot_matrix

		//Calculate pixel offsets (If necessary)
		var/Pixel_x
		var/Pixel_y
		if(DX == 0)
			Pixel_x = 0
		else
			Pixel_x = round(sin(Angle)+32*sin(Angle)*(N+16)/32)
		if(DY == 0)
			Pixel_y = 0
		else
			Pixel_y = round(cos(Angle)+32*cos(Angle)*(N+16)/32)

		//Position the effect so the beam is one continous line
		var/a
		if(abs(Pixel_x)>32)
			a = Pixel_x > 0 ? round(Pixel_x/32) : CEILING(Pixel_x/32, 1)
			X.x += a
			Pixel_x %= 32
		if(abs(Pixel_y)>32)
			a = Pixel_y > 0 ? round(Pixel_y/32) : CEILING(Pixel_y/32, 1)
			X.y += a
			Pixel_y %= 32

		X.pixel_x = Pixel_x
		X.pixel_y = Pixel_y
		CHECK_TICK

/datum/beam/redrawing(atom/movable/mover, atom/oldloc, direction)
	if(origin && target && (get_dist(origin, target) <= max_distance) && (origin.z == target.z))
		QDEL_LIST(elements)
		INVOKE_ASYNC(src, .proc/Draw)
	else
		qdel(src)

/datum/beam/proc/on_moved_origin(atom/movable/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	redrawing()

/datum/beam/proc/on_moved_target(atom/movable/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	redrawing()

/atom/Beam(atom/beam_target, \
		icon_state = "b_beam", \
		icon = 'icons/effects/beam.dmi', \
		time = INFINITY, \
		maxdistance = INFINITY, \
		beam_type = /obj/effect/ebeam)
	var/datum/beam/newbeam = new(src, beam_target, icon, icon_state, time, maxdistance, beam_type)
	INVOKE_ASYNC(newbeam, /datum/beam/.proc/Start)
	return newbeam
