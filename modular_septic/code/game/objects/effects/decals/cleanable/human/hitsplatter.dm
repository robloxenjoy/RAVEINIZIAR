//Blood splattering, taken from hippiestation
/obj/effect/decal/cleanable/blood/hitsplatter
	name = "blood splatter"
	pass_flags = PASSTABLE
	icon = 'modular_septic/icons/effects/blood.dmi'
	icon_state = "hitsplatter1"
	random_icon_states = list("hitsplatter1", "hitsplatter2", "hitsplatter3")
	var/loc_gets_bloody = TRUE
	var/amount = 2

/obj/effect/decal/cleanable/blood/hitsplatter/Initialize(mapload, list/blood_dna, loc_gets_bloody = TRUE)
	. = ..()
	if(LAZYLEN(blood_dna))
		add_blood_DNA(blood_dna)
	loc_gets_bloody = loc_gets_bloody

/obj/effect/decal/cleanable/blood/hitsplatter/Destroy()
	if(isturf(loc) && loc_gets_bloody)
		loc.add_blood_DNA(return_blood_DNA())
	return ..()

/obj/effect/decal/cleanable/blood/hitsplatter/proc/do_squirt(direction = SOUTH, range = 3, instant = FALSE)
	if(!direction)
		direction = pick(GLOB.alldirs)
	//we need to return IMMEDIATELY to avoid bonkers stuff
	INVOKE_ASYNC(src, .proc/squirt_process, direction, range, instant)
	return TRUE

/obj/effect/decal/cleanable/blood/hitsplatter/proc/squirt_process(direction, range, instant = FALSE)
	if(range)
		for(var/i in 1 to range)
			if(QDELETED(src))
				return
			if(!instant)
				sleep(1)
			if(!Move(get_step(src, direction)))
				break
	if(!QDELETED(src))
		qdel(src)
	return TRUE

/obj/effect/decal/cleanable/blood/hitsplatter/Bump(atom/A)
	. = ..()
	if(istype(A, /turf/closed/wall) || istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
		var/commit_die = TRUE
		var/direction = get_dir(src, A)
		if(istype(A, /obj/structure/window))
			var/obj/structure/window/window = A
			if(!window.fulltile)
				if(!(direction == window.dir || direction == REVERSE_DIR(window.dir)))
					commit_die = FALSE
		if(commit_die)
			loc_gets_bloody = FALSE
			var/obj/effect/decal/cleanable/blood/splatter/blood = new(loc)
			blood.add_blood_DNA(return_blood_DNA())
			blood.layer = BELOW_MOB_LAYER
			blood.plane = loc.plane
			//Adjust pixel offset to make splatters appear on the wall
			blood.pixel_x = (dir == EAST ? 32 : (dir == WEST ? -32 : 0))
			blood.pixel_y = (dir == NORTH ? 32 : (dir == SOUTH ? -32 : 0))
			qdel(src)
	else
		A.add_blood_DNA(return_blood_DNA())
	amount--
	A.update_appearance()
	if(amount <= 0 && !QDELETED(src))
		qdel(src)
