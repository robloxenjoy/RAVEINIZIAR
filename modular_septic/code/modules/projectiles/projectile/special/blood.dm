/obj/projectile/blood
	name = "blood splatter"
	icon = 'modular_septic/icons/obj/items/guns/projectiles/blood.dmi'
	icon_state = "hitsplatter1"
	base_icon_state = "hitsplatter"
	plane = GAME_PLANE_UPPER_FOV_HIDDEN
	layer = BLOOD_PROJECTILE_LAYER
	pass_flags = PASSTABLE
	speed = 1
	hitsound = null
	nodamage = TRUE
	range = 3
	var/loc_gets_bloody = TRUE

/obj/projectile/blood/Initialize(mapload, list/blood_dna, loc_gets_bloody = TRUE)
	. = ..()
	icon_state = "[base_icon_state][rand(1,3)]"
	if(LAZYLEN(blood_dna))
		add_blood_DNA(blood_dna)
	src.loc_gets_bloody = loc_gets_bloody

/obj/projectile/blood/Destroy()
	if(isturf(loc) && loc_gets_bloody)
		loc.add_blood_DNA(return_blood_DNA())
	return ..()

/obj/projectile/blood/on_hit(atom/target, blocked, pierce_hit, reduced, edge_protection)
	. = ..()
	var/final_hitsound
	var/hitsound_volume = 60

	var/turf/target_location = get_turf(target)

	if(.)
		if(iswallturf(target)|| istype(target, /obj/structure/window) || istype(target, /obj/structure/grille))
			var/direction = get_dir(src, target)
			loc_gets_bloody = FALSE
			var/obj/effect/decal/cleanable/blood/splatter/blood = new(loc)
			blood.add_blood_DNA(return_blood_DNA())
			blood.layer = BELOW_MOB_LAYER
			blood.plane = loc.plane
			//Adjust pixel offset to make splatters appear on the wall
			blood.pixel_x = (direction & EAST ? 32 : (direction & WEST ? -32 : 0))
			blood.pixel_y = (direction & NORTH ? 32 : (direction & SOUTH ? -32 : 0))
		else if(istype(target, /obj/structure/window))
			var/obj/structure/window/window = target
			if(!window.fulltile)
				window.add_blood_DNA(return_blood_DNA())
				return
			var/direction = get_dir(src, target)
			loc_gets_bloody = FALSE
			var/obj/effect/decal/cleanable/blood/splatter/blood = new(loc)
			blood.add_blood_DNA(return_blood_DNA())
			blood.layer = BELOW_MOB_LAYER
			blood.plane = GAME_PLANE_UPPER
			//Adjust pixel offset to make splatters appear on the wall
			blood.pixel_x = (direction & EAST ? 32 : (direction & WEST ? -32 : 0))
			blood.pixel_y = (direction & NORTH ? 32 : (direction & SOUTH ? -32 : 0))
		else if(isfloorturf(target_location) && (target == target_location))
			var/turf/open/floor/floor = target_location
			floor.sound_hint()
			final_hitsound = 'modular_septic/sound/effects/blood_splatter1.wav'

			if(final_hitsound)
				playsound(floor, final_hitsound, hitsound_volume, TRUE, -1)
		else
			target.add_blood_DNA(return_blood_DNA())

/obj/projectile/blood/proc/do_squirt(direction = SOUTH, range = 3, spread_min = -25, spread_max = 25)
	if(!direction)
		direction = pick(GLOB.alldirs)
	src.range = range
	var/target = get_ranged_target_turf(src, direction, range)
	preparePixelProjectile(target, src, spread = rand(spread_min, spread_max))
	if(QDELETED(src))
		return FALSE
	fire()
	return TRUE
