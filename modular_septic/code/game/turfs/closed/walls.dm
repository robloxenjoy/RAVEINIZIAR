/turf/closed/wall
	icon = 'modular_septic/icons/turf/tall/walls/victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/victorian_frill.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	clingable = TRUE
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_LOW_WALLS)
//	turf_height = TURF_HEIGHT_BLOCK_THRESHOLD_TEST

/turf/closed/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].wav"

/turf/closed/wall/r_wall
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/reinforced_victorian_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"

/turf/closed/wall/r_wall/alt
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_victorian_alt.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/reinforced_victorian_alt_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"

/turf/closed/wall/r_wall/rusty
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_rusty.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/reinforced_rusty_frill.dmi'
	icon_state = "rusty_reinforced_wall-0"
	base_icon_state = "rusty_reinforced_wall"

/turf/closed/wall/pink_crazy
	icon = 'modular_septic/icons/turf/tall/walls/pink_crazy.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/pink_crazy_frill.dmi'
	icon_state = "pink_crazy-0"
	base_icon_state = "pink_crazy"
	desc = "Strange wall."

/turf/closed/wall/darkrock
	icon = 'modular_septic/icons/turf/tall/walls/rockcoolnew.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/rockcoolnew_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	desc = "So dark and evil!"

/turf/closed/wall/mineral/wood
	icon = 'modular_septic/icons/turf/tall/walls/wood.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/wood_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	resistance_flags = FLAMMABLE
	desc = "Just wood wall."

/turf/closed/wall/bluegreen
	icon = 'modular_septic/icons/turf/tall/walls/woodbluegreen.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/woodbluegreen_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
	resistance_flags = FLAMMABLE
	desc = "Interesting wood wall."

/turf/closed/wall/bluegreen/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,4)].ogg"

/turf/closed/wall/mineral/wood/alt
	icon = 'modular_septic/icons/turf/tall/walls/wood_victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/wood_victorian_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	resistance_flags = FLAMMABLE
	desc = "Just wood wall."

/turf/closed/wall/mineral/wood/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,4)].ogg"

//Example smooth wall
/turf/closed/wall/smooth
	frill_icon = null
/*
/turf/closed/wall/smooth/rockcool
	name = "Stone Wall"
	icon = 'modular_septic/icons/turf/tall/walls/rockcool.dmi'
	icon_state = "diamond_wall-0"
	base_icon_state = "diamond_wall"
	clingable = TRUE
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_LOW_WALLS)
*/
