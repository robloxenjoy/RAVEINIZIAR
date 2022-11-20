/turf/closed/mineral
	clingable = TRUE

/turf/closed/mineral/snowmountain/nevado_surface
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface
	turf_type = /turf/open/floor/plating/asteroid/snow/nevado_surface
	initial_gas_mix = NEVADO_SURFACE_DEFAULT_ATMOS

/turf/closed/mineral/shale
	icon = 'modular_septic/icons/turf/tall/shale.dmi'
	smooth_icon = 'modular_septic/icons/turf/tall/shale.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/shale_frill.dmi'
	icon_state = "shale-0"
	base_icon_state = "shale"
	plane = GAME_PLANE
	layer = CLOSED_TURF_LAYER
	environment_type = "shale"
	needs_translation = FALSE

/turf/closed/wall/purple
	name = "Midnightstone Wall"
	icon = 'modular_septic/icons/turf/tall/purple.dmi'
//	smooth_icon = 'modular_septic/icons/turf/tall/purple.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/purple_frill.dmi'
	icon_state = "shale-0"
	base_icon_state = "shale"
	baseturfs = /turf/open/floor/plating/polovich/dirt/dark
	clingable = TRUE
//	turf_type = /turf/open/floor/plating/polovich/dirt/dark
//	plane = GAME_PLANE
//	layer = CLOSED_TURF_LAYER
//	environment_type = "shale"
//	needs_translation = FALSE

/turf/closed/wall/purple/nocling
	clingable = FALSE
