/turf/closed/wall/codec
	name = "Стена"
	desc = "Внеочередная стена."
	icon = 'modular_pod/icons/turf/closed/wall.dmi'
	frill_icon = null
	icon_state = "wall-0"
	base_icon_state = "wall"
	mine_hp = 7
	canSmoothWith = list(SMOOTH_GROUP_WALLS)
	smoothing_groups = list(SMOOTH_GROUP_WALLS)

/turf/closed/wall/codec/nocling
	desc = "Внеочередная стена. Забраться тут нельзя."
	clingable = FALSE

/turf/closed/wall/codec/gra
	name = "Стена"
	desc = "Не особо то и страшная."
	icon = 'modular_pod/icons/turf/closed/wall_gra.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	mine_hp = 5

/turf/closed/wall/codec/gra/nocling
	desc = "Не особо то и страшная. Забраться тут нельзя."
	clingable = FALSE