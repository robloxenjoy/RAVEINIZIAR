/turf/closed/mineral
	clingable = TRUE

/turf/closed/mineral/snowmountain/nevado_surface
	baseturfs = /turf/open/floor/plating/polovich/asteroid/snow/nevado_surface
	turf_type = /turf/open/floor/plating/polovich/asteroid/snow/nevado_surface
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
	desc = "This wall makes you sleepy."
	icon = 'modular_septic/icons/turf/tall/purple.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/purple_frill.dmi'
	icon_state = "shale-0"
	base_icon_state = "shale"
	baseturfs = /turf/open/floor/plating/polovich/dirt/blueee
	clingable = TRUE
	mineable = TRUE
	mine_hp = 4
	sheet_type = null
	sheet_amount = null

/turf/closed/wall/purple/nocling
	desc = "This wall makes you sleepy. Also you cant climb here."
	clingable = FALSE

/turf/closed/wall/purple/nocling/hard_to_break
	mineable = FALSE
	hardness = 10
	explosion_block = 2
	rad_insulation = RAD_HEAVY_INSULATION
	heat_capacity = 312500
	mine_hp = 100