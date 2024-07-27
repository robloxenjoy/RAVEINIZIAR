/*
/proc/set_basalt_light(turf/open/floor/B)
	switch(B.icon_state)
		if("basalt1", "basalt2", "basalt3")
			B.set_light(2, 0.6, LIGHT_COLOR_LAVA) //more light
		if("basalt5", "basalt9")
			B.set_light(1.4, 0.6, LIGHT_COLOR_LAVA) //barely anything!
*/

/*
/turf/open
	var/blocks_pollution = FALSE
	var/blocks_liquid = FALSE

/turf/proc/liquid_can_pass()
	if(blocks_liquid)
		return FALSE
	return TRUE

/turf/proc/pollution_can_pass()
	if(blocks_pollution)
		return FALSE
	return TRUE
*/

/turf/open/floor/plating/polovich/codec
	name = "Floor"
	desc = "Crazy."
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
	name = "Dirt"
	desc = "Slows me."
	icon_state = "mud_dirt"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	slowdown = 1

/turf/open/floor/plating/polovich/codec/dirt/mud/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/way
	icon = 'modular_pod/icons/turf/floors_3.dmi'
	desc = "Nothing interesting."
	baseturfs = /turf/open/floor/plating/polovich/way/dirt

/turf/open/floor/plating/polovich/way/soft
	name = "Floor"
	icon_state = "soft"
	footstep = FOOTSTEP_PLATING
	powerfloor = 18

/turf/open/floor/plating/polovich/way/goldenwise
	name = "Floor"
	icon_state = "goldenwise"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/mud
	name = "Mud"
	icon_state = "mud"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	var/finished = FALSE

/turf/open/floor/plating/polovich/way/mud/Initialize(mapload)
	. = ..()
	var/turf/south = get_step(get_turf(src), SOUTH)
	var/turf/north = get_step(get_turf(src), NORTH)
	var/turf/west = get_step(get_turf(src), WEST)
	var/turf/east = get_step(get_turf(src), EAST)
	if(locate(/turf/open/floor/plating/polovich/way/muddy) in south)
		if(prob(10))
			south.ChangeTurf(/turf/open/floor/plating/polovich/way/mud, null, CHANGETURF_IGNORE_AIR)
	if(locate(/turf/open/floor/plating/polovich/way/muddy) in north)
		if(prob(10))
			north.ChangeTurf(/turf/open/floor/plating/polovich/way/mud, null, CHANGETURF_IGNORE_AIR)
	if(locate(/turf/open/floor/plating/polovich/way/muddy) in east)
		if(prob(50))
			east.ChangeTurf(/turf/open/floor/plating/polovich/way/mud, null, CHANGETURF_IGNORE_AIR)
	if(locate(/turf/open/floor/plating/polovich/way/muddy) in west)
		if(prob(50))
			west.ChangeTurf(/turf/open/floor/plating/polovich/way/mud, null, CHANGETURF_IGNORE_AIR)

/turf/open/floor/plating/polovich/way/specialblue
	name = "Floor"
	icon_state = "specialblue"
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET_BAREFOOT
	clawfootstep = FOOTSTEP_CARPET_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/way/cirbricks
	name = "Floor"
	icon_state = "cirbricks"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/cirspecial
	name = "Floor"
	icon_state = "cirspecial"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/cirspecial2
	name = "Floor"
	icon_state = "cirspecial2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/cirfire
	name = "Floor"
	icon_state = "cirfire"
	footstep = FOOTSTEP_PLATING
	light_range = 2
	light_power = 2
	light_color = "#d4ba52"
	powerfloor = 18

/turf/open/floor/plating/polovich/way/ancfire
	name = "Floor"
	icon_state = "ancfire"
	footstep = FOOTSTEP_PLATING
	powerfloor = 18

/turf/open/floor/plating/polovich/way/nightbricks
	name = "Floor"
	icon_state = "nightbricks"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/rust
	name = "Floor"
	icon_state = "rust"
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL
	powerfloor = 18

/turf/open/floor/plating/polovich/way/monumental
	name = "Floor"
	icon_state = "monumental"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/waterfloor
	name = "Dirt"
	icon_state = "waterfloor"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/waterfloor/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/way/fish
	name = "Floor"
	icon_state = "fish"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/non
	name = "Dirt"
	icon_state = "non"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/non2
	name = "Dirt"
	icon_state = "non2"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/fish2
	name = "Floor"
	icon_state = "fish2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/stoner
	name = "Floor"
	icon_state = "stoner"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/legend
	name = "Floor"
	icon_state = "legend"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/deadmeat
	name = "Body Floor"
	desc = "Interesting."
	icon_state = "deadmeat"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT

/turf/open/floor/plating/polovich/way/deadmeat_full
	name = "Body Floor"
	desc = "Interesting."
	icon_state = "deadmeat_full"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	var/finished = FALSE

/turf/open/floor/plating/polovich/way/ravein
	name = "Body Floor"
	desc = "Interesting."
	icon_state = "ravein"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT

/turf/open/floor/plating/polovich/way/ancstone
	name = "Floor"
	icon_state = "ancstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/slimebegin
	name = "Зелень"
	icon_state = "slimebegin"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/lifemeat
	name = "Body Floor"
	desc = "Interesting."
	icon_state = "lifemeat"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT

/turf/open/floor/plating/polovich/way/lifemeat2
	name = "Body Floor"
	desc = "Interesting."
	icon_state = "lifemeat2"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT

/turf/open/floor/plating/polovich/way/lifemeat3
	name = "Body Floor"
	desc = "Interesting."
	icon_state = "lifemeat3"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT

/turf/open/floor/plating/polovich/way/exoticwood
	name = "Floor"
	icon_state = "exoticwood"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/reborn
	name = "Floor"
	icon_state = "reborn"
	footstep = FOOTSTEP_CRUMBLE
	barefootstep = FOOTSTEP_CRUMBLE
	clawfootstep = FOOTSTEP_CRUMBLE
	heavyfootstep = FOOTSTEP_CRUMBLE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/dirt
	name = "Dirt"
	icon_state = "dirt"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/muddy
	name = "Dirt"
	icon_state = "muddy"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	var/finished = FALSE
	var/flora = TRUE

/*
/turf/open/floor/plating/polovich/way/muddy/Initialize(mapload)
	. = ..()
	dir = rand(0,4)
*/

/turf/open/floor/plating/polovich/way/muddy/Initialize(mapload)
	. = ..()
	if(flora)
		if(prob(15))
			if(locate(/obj/) in get_turf(src))
				return
			if(prob(70))
				new /obj/structure/flora/ausbushes/cactus(get_turf(src))
				var/near_tt = range(1, src)
				for(var/turf/open/floor/plating/polovich/way/muddy/generat in get_turf(near_tt))
					if(locate(/obj/) in get_turf(near_tt))
						continue
					if(prob(90))
						new /obj/structure/flora/ausbushes/cactus(get_turf(near_tt))
		if(prob(5))
			if(locate(/obj/) in get_turf(src))
				return
			new /obj/structure/flora/ausbushes/granat(get_turf(src))
	if(prob(40))
		var/near_t = range(1, src)
		for(var/turf/open/floor/plating/polovich/way/muddy/generat in near_t)
			if(prob(10))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/redd, null, CHANGETURF_IGNORE_AIR)
			if(prob(20))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/dyingmud, null, CHANGETURF_IGNORE_AIR)
				generat.dir = rand(0,4)
			if(prob(20))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/deadmeat_full, null, CHANGETURF_IGNORE_AIR)
			if(prob(20))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/mud, null, CHANGETURF_IGNORE_AIR)
		finished = TRUE

/turf/open/floor/plating/polovich/way/stone
	name = "Floor"
	icon_state = "stone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/hotstone2
	name = "Floor"
	icon_state = "hotstone2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/hotstone
	name = "Floor"
	icon_state = "hotstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/wisestone
	name = "Floor"
	icon_state = "wisestone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/vomitdirt
	name = "Dirt"
	icon_state = "vomitdirt"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/vomitdirt2
	name = "Dirt"
	icon_state = "vomitdirt2"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/dirtyd
	name = "Dirt"
	icon_state = "dirtyd"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/redd
	name = "Dirt"
	icon_state = "redd"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	var/finished = FALSE

/turf/open/floor/plating/polovich/way/platier
	name = "Floor"
	icon_state = "platier"
	footstep = FOOTSTEP_PLATING
	powerfloor = 18

/turf/open/floor/plating/polovich/way/platrie
	name = "Floor"
	icon_state = "platrie"
	footstep = FOOTSTEP_PLATING
	powerfloor = 18

/turf/open/floor/plating/polovich/way/beautry
	name = "Красивый Floor"
	icon_state = "beautry"
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET_BAREFOOT
	clawfootstep = FOOTSTEP_CARPET_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/way/dirtun
	name = "Dirt"
	icon_state = "dirtun"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/dirtun/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/way/dirtun2
	name = "Dirt"
	icon_state = "dirtun2"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/dirtun3
	name = "Dirt"
	icon_state = "dirtun3"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/pheno
	name = "Dirt"
	icon_state = "pheno"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/dyingmud
	name = "Dirt"
	icon_state = "dyingmud"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	var/finished = FALSE

/turf/open/floor/plating/polovich/way/dyingmud/Initialize(mapload)
	. = ..()
	dir = rand(0,4)
	var/near_t = range(1, src)
	for(var/turf/open/floor/plating/polovich/way/muddy/generat in near_t)
		if(!generat.finished)
			continue
		if(prob(10))
			generat.ChangeTurf(/turf/open/floor/plating/polovich/way/dyingmud, null, CHANGETURF_IGNORE_AIR)
			dir = rand(0,4)

/turf/open/floor/plating/polovich/way/evilmud
	name = "Dirt"
	icon_state = "evilmud"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/evilmud/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/way/stoneold
	name = "Floor"
	icon_state = "stoneold"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/exoticf
	name = "Floor"
	icon_state = "exoticf"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/hotstone5
	name = "Floor"
	icon_state = "hotstone5"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/sota
	name = "Floor"
	icon_state = "sota"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/stoner2
	name = "Floor"
	icon_state = "stoner2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/hotstone4
	name = "Floor"
	icon_state = "hotstone4"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/hotstone3
	name = "Floor"
	icon_state = "hotstone3"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/beautry2
	name = "Красивый Floor"
	icon_state = "beautry2"
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET_BAREFOOT
	clawfootstep = FOOTSTEP_CARPET_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/way/beautry3
	name = "Красивый Floor"
	icon_state = "beautry3"
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET_BAREFOOT
	clawfootstep = FOOTSTEP_CARPET_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	resistance_flags = FLAMMABLE

/turf/open/floor/plating/polovich/way/korvutic
	name = "Floor"
	icon_state = "korvutic"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/exoticwood2
	name = "Floor"
	icon_state = "exoticwood2"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/metalla
	name = "Floor"
	icon_state = "metalla"
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL
	powerfloor = 18

/turf/open/floor/plating/polovich/way/painstone
	name = "Floor"
	icon_state = "painstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/hotstone22
	name = "Floor"
	icon_state = "hotstone22"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/painwood
	name = "Floor"
	icon_state = "painwood"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/uzstone
	name = "Floor"
	icon_state = "uzstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/ystone
	name = "Floor"
	icon_state = "ystone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/cavero1
	name = "Floor"
	icon_state = "cavero1"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/cavero1/Initialize(mapload)
	. = ..()
/*
	if(flora)
		if(prob(15))
			if(locate(/obj/) in get_turf(src))
				return
			if(prob(70))
				new /obj/structure/flora/ausbushes/cactus(get_turf(src))
				var/near_tt = range(1, src)
				for(var/turf/open/floor/plating/polovich/way/muddy/generat in get_turf(near_tt))
					if(locate(/obj/) in get_turf(near_tt))
						continue
					if(prob(90))
						new /obj/structure/flora/ausbushes/cactus(get_turf(near_tt))
		if(prob(5))
			if(locate(/obj/) in get_turf(src))
				return
			new /obj/structure/flora/ausbushes/granat(get_turf(src))
*/
	if(prob(40))
		var/near_t = range(1, src)
		for(var/turf/open/floor/plating/polovich/way/cavero2/generat in near_t)
			if(prob(50))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/cavero1, null, CHANGETURF_IGNORE_AIR)

/turf/open/floor/plating/polovich/way/cavero2
	name = "Floor"
	icon_state = "cavero2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/cavero
	name = "Dirt"
	icon_state = "cavero"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/plating/polovich/way/cavero/Initialize(mapload)
	. = ..()
	if(prob(20))
		new /obj/effect/decal/grassgood(get_turf(src))
	if(prob(7))
		new /obj/effect/decal/shroomworms(get_turf(src))
	if(prob(15))
		if(locate(/obj/) in get_turf(src))
			return
		new /obj/structure/stalag(get_turf(src))
	if(prob(8))
		if(locate(/obj/) in get_turf(src))
			return
		new /obj/structure/gelatine/smelly(get_turf(src))
	if(prob(1))
		if(locate(/obj/) in get_turf(src))
			return
		new /obj/structure/mineexplosive/mineplit(get_turf(src))
	if(prob(1))
		if(prob(5))
			if(locate(/obj/) in get_turf(src))
				return
			new /obj/structure/beast/worm(get_turf(src))
	if(prob(1))
		if(prob(10))
			if(locate(/obj/) in get_turf(src))
				return
			new /obj/structure/beast/goat(get_turf(src))
	if(prob(40))
		var/near_t = range(1, src)
		for(var/turf/open/floor/plating/polovich/way/cavero/generat in near_t)
			if(prob(20))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/cavero2, null, CHANGETURF_IGNORE_AIR)
	if(prob(20))
		var/near_t = range(1, src)
		for(var/turf/open/floor/plating/polovich/way/cavero/generat in near_t)
			if(prob(30))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/cavero1, null, CHANGETURF_IGNORE_AIR)
	if(prob(45))
		var/near_t = range(1, src)
		for(var/turf/open/floor/plating/polovich/way/cavero/generat in near_t)
			if(locate(/obj/) in get_turf(generat))
				return
			if(prob(75))
				generat.ChangeTurf(/turf/podpol/wall/caverak, null, CHANGETURF_IGNORE_AIR)

/turf/open/floor/plating/polovich/way/blackstoner2
	name = "Floor"
	icon_state = "blackstoner2"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/kaos
	name = "Chaos"
	desc = "Kaotika. MMO-ROGUELIKE."
	icon_state = "kaos1"
	icon = 'modular_pod/icons/turf/floors_4.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/kaos/se
	icon_state = "kaos2"

/turf/open/floor/plating/polovich/way/kaos/th
	icon_state = "kaos3"

/turf/open/floor/plating/polovich/way/kaos/fo
	icon_state = "kaos4"

/turf/open/floor/plating/polovich/way/kaos/fi
	icon_state = "kaos5"

/turf/open/floor/plating/polovich/way/kaos/si
	icon_state = "kaos6"

/turf/open/floor/plating/polovich/way/kaos/se
	icon_state = "kaos7"

/turf/open/floor/plating/polovich/way/kaos/ei
	icon_state = "kaos8"

/turf/open/floor/plating/polovich/way/kaos/ni
	icon_state = "kaos9"
