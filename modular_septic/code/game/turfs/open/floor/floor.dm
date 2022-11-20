#define MAX_DENT_DECALS 15

/turf/open/floor
	var/list/dent_decals

/turf/open/floor/proc/add_dent(denttype = WALL_DENT_SHOT, x = rand(-8, 8), y = rand(-8, 8))
	if(LAZYLEN(dent_decals) >= MAX_DENT_DECALS)
		return

	var/mutable_appearance/decal = mutable_appearance('icons/effects/effects.dmi', "", ABOVE_OPEN_TURF_LAYER)
	switch(denttype)
		if(WALL_DENT_SHOT)
			decal.icon_state = "bullet_hole"
		if(WALL_DENT_HIT)
			decal.icon_state = "impact[rand(1, 3)]"

	decal.pixel_x = x
	decal.pixel_y = y

	if(LAZYLEN(dent_decals))
		cut_overlay(dent_decals)
		dent_decals += decal
	else
		dent_decals = list(decal)

	add_overlay(dent_decals)

/turf/open/floor/crowbar_act(mob/living/user, obj/item/tool)
	return

/turf/open/floor/crowbar_act_secondary(mob/living/user, obj/item/tool)
	if(overfloor_placed && pry_tile(tool, user))
		return TRUE

#undef MAX_DENT_DECALS
