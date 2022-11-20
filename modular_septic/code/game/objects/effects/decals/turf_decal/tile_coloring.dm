/obj/effect/turf_decal/tile/Initialize()
	if(SSevents.holidays && SSevents.holidays[APRIL_FOOLS])
		color = "#[random_short_color()]"
	return ..()

/// White tiles, fuck TG

/obj/effect/turf_decal/tile/white
	name = "white corner"
	color = "#FFFFFF"

/obj/effect/turf_decal/tile/white/half
	icon_state = "tile_half"
	name = "white half"

/obj/effect/turf_decal/tile/white/anticorner
	icon_state = "tile_anticorner"
	name = "white anticorner"

/obj/effect/turf_decal/tile/white/full
	icon_state = "tile_full"
	name = "white full"
