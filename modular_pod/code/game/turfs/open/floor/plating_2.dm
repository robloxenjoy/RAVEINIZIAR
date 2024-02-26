/turf/open/floor/plating/polovich/codec
	name = "Пол"
	desc = "Ебанутый пацан."
	icon_state = "codec"
	icon = 'modular_pod/icons/turf/floors_2.dmi'

/turf/open/floor/plating/polovich/codec/fagut
	desc = "Фагутовский."
	icon_state = "fagut"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/codec/fagut/two
	icon_state = "fagut2"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/codec/fagut/three
	icon_state = "fagut3"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/codec/fagut/four
	icon_state = "fagut4"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/codec/fagut/five
	icon_state = "fagut5"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/codec/redizna
	desc = "Редизна."
	icon_state = "redizna1"
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/codec/redizna/two
	icon_state = "redizna2"

/turf/open/floor/plating/polovich/codec/redizna/three
	icon_state = "redizna3"

/turf/open/floor/plating/polovich/codec/redizna/four
	icon_state = "redizna4"

/turf/open/floor/plating/polovich/codec/redizna/five
	icon_state = "redizna5"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/codec/bluezo
	desc = "Блузо!"
	icon_state = "bluezo"
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/codec/bluezo/two
	icon_state = "bluezo1"

/turf/open/floor/plating/polovich/codec/bluezo/three
	icon_state = "bluezo2"

/turf/open/floor/plating/polovich/codec/bluezo/four
	icon_state = "bluezo3"

/turf/open/floor/plating/polovich/codec/groid
	desc = "Гроидовский."
	icon_state = "groid"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/codec/groid/two
	icon_state = "groid2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/codec/drazin
	desc = "Такая вот модель только в подводных штуках стоит."
	icon_state = "drazin"
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL

/turf/open/floor/plating/polovich/codec/dirt/mud
	name = "Грязь"
	desc = "Она медлит тебя."
	icon_state = "mud_dirt"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 1

/turf/open/floor/plating/polovich/codec/dirt/mud/Initialize(mapload)
	. = ..()
	dir = rand(0,4)