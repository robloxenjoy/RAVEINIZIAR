/turf/open/floor/plating/polovich
	var/trapturf = FALSE

/turf/open/floor/plating/polovich/way/station
	name = "Пол"
	icon = 'modular_pod/icons/turf/floors_4.dmi'

/turf/open/floor/plating/polovich/way/station/hotfloor
	icon_state = "hotfloor"
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL
	light_range = 3
	light_power = 3
	light_color = "#c2281b"
	powerfloor = 18

/turf/open/floor/plating/polovich/way/station/mystic
	icon_state = "mystic"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/station/mystic/crazy
	var/crazy_id = "station"
	special_floor = TRUE

/turf/open/floor/plating/polovich/way/station/mystic/crazy/special_thing(mob/living/user)
	for(var/turf/open/floor/plating/polovich/way/station/mystic/crazy/spawn_point in world)
		if(spawn_point.crazy_id == "earth")
			user.visible_message(span_meatymeat("[user] телепортируется!"),span_meatymeat("Я телепортируюсь!"), span_hear("Я слышу чё-то."))
			user.forceMove(spawn_point)

/turf/open/floor/plating/polovich/way/station/mystic/crazy/back
	crazy_id = "earth"

/turf/open/floor/plating/polovich/way/station/mystic/crazy/back/special_thing(mob/living/user)
	for(var/turf/open/floor/plating/polovich/way/station/mystic/crazy/spawn_point in world)
		if(spawn_point.crazy_id == "station")
			user.visible_message(span_meatymeat("[user] телепортируется!"),span_meatymeat("Я телепортируюсь!"), span_hear("Я слышу чё-то."))
			user.forceMove(spawn_point)

/turf/open/floor/plating/polovich/way/station/notgood
	icon_state = "notgood"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/station/enga
	icon_state = "enga"
	footstep = FOOTSTEP_PLATING
	powerfloor = 18

/turf/open/floor/plating/polovich/way/station/enga2
	icon_state = "enga2"
	footstep = FOOTSTEP_PLATING
	powerfloor = 18

/turf/open/floor/plating/polovich/way/station/web
	icon_state = "web"
	footstep = FOOTSTEP_PLATING
	powerfloor = 18

/turf/open/floor/plating/polovich/way/station/wayt
	icon_state = "wayt"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18




// PHASE TWO



/turf/open/floor/plating/polovich/way/for4
	name = "Dirt"
	icon_state = "for4"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	var/finished = FALSE
	trapturf = TRUE
	icon = 'modular_pod/icons/content_5.dmi'
	slowdown = 1

/turf/open/floor/plating/polovich/way/for4/Initialize(mapload)
	. = ..()
//	dir = rand(0,4)
	var/near_t = range(1, src)
	for(var/turf/open/floor/plating/polovich/way/muddy/generat in near_t)
		if(!generat.finished)
			continue
		if(prob(10))
			generat.ChangeTurf(/turf/open/floor/plating/polovich/way/for4, null, CHANGETURF_IGNORE_AIR)
//			dir = rand(0,4)

/turf/open/floor/plating/polovich/way/for2
	name = "Dirt"
	icon_state = "for2"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	var/finished = FALSE
	var/flora = TRUE
	trapturf = TRUE
	icon = 'modular_pod/icons/content_5.dmi'
	slowdown = 1

/*
/turf/open/floor/plating/polovich/way/muddy/Initialize(mapload)
	. = ..()
	dir = rand(0,4)
*/

/turf/open/floor/plating/polovich/way/for2/Initialize(mapload)
	. = ..()
	if(flora)
		if(prob(15))
			for(var/obj/M in get_turf(src))
				if(M && !M.can_spawn_various_shit)
					return
			if(prob(70))
				new /obj/structure/flora/ausbushes/cactus(get_turf(src))
				var/near_tt = range(1, src)
				for(var/turf/open/floor/plating/polovich/way/for2 in get_turf(near_tt))
					for(var/obj/M in get_turf(near_tt))
						if(M && !M.can_spawn_various_shit)
							continue
					if(prob(93))
						new /obj/structure/flora/ausbushes/cactus(get_turf(near_tt))
		if(prob(5))
			for(var/obj/M in get_turf(src))
				if(M && !M.can_spawn_various_shit)
					return
			new /obj/structure/flora/ausbushes/granat(get_turf(src))
		if(prob(10))
			for(var/obj/M in get_turf(src))
				if(M && !M.can_spawn_various_shit)
					return
			new /obj/effect/decal/grassnice(get_turf(src))
	if(prob(40))
		var/near_t = range(1, src)
		for(var/turf/open/floor/plating/polovich/way/for2/generat in near_t)
			if(prob(10))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/redd, null, CHANGETURF_IGNORE_AIR)
			if(prob(20))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/for4, null, CHANGETURF_IGNORE_AIR)
//				generat.dir = rand(0,4)
			if(prob(20))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/for3, null, CHANGETURF_IGNORE_AIR)
			if(prob(20))
				generat.ChangeTurf(/turf/open/floor/plating/polovich/way/for1, null, CHANGETURF_IGNORE_AIR)
		finished = TRUE

/turf/open/floor/plating/polovich/way/for3
	name = "Body Floor"
	desc = "Interesting."
	icon_state = "for3"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	var/finished = FALSE
	trapturf = TRUE
	icon = 'modular_pod/icons/content_5.dmi'

/turf/open/floor/plating/polovich/way/for1
	name = "Mud"
	icon_state = "for1"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	var/finished = FALSE
	trapturf = TRUE
	icon = 'modular_pod/icons/content_5.dmi'
	slowdown = 1

/turf/open/floor/plating/polovich/way/for1/Initialize(mapload)
	. = ..()
	var/turf/south = get_step(get_turf(src), SOUTH)
	var/turf/north = get_step(get_turf(src), NORTH)
	var/turf/west = get_step(get_turf(src), WEST)
	var/turf/east = get_step(get_turf(src), EAST)
	if(locate(/turf/open/floor/plating/polovich/way/for2) in south)
		if(prob(10))
			south.ChangeTurf(/turf/open/floor/plating/polovich/way/for1, null, CHANGETURF_IGNORE_AIR)
	if(locate(/turf/open/floor/plating/polovich/way/for2) in north)
		if(prob(10))
			north.ChangeTurf(/turf/open/floor/plating/polovich/way/for1, null, CHANGETURF_IGNORE_AIR)
	if(locate(/turf/open/floor/plating/polovich/way/for2) in east)
		if(prob(50))
			east.ChangeTurf(/turf/open/floor/plating/polovich/way/for1, null, CHANGETURF_IGNORE_AIR)
	if(locate(/turf/open/floor/plating/polovich/way/for2) in west)
		if(prob(50))
			west.ChangeTurf(/turf/open/floor/plating/polovich/way/for1, null, CHANGETURF_IGNORE_AIR)

/turf/open/floor/plating/polovich/way/for5
	name = "Dirt"
	icon_state = "for5"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	var/finished = FALSE
	trapturf = TRUE
	icon = 'modular_pod/icons/content_5.dmi'
	slowdown = 1



// PRISON




/turf/open/floor/plating/polovich/way/stolfl
	icon_state = "stolfl"
	icon = 'modular_pod/icons/content_6.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/stolfl/Initialize(mapload)
	. = ..()
	dir = rand(0,4)

/turf/open/floor/plating/polovich/way/spider
	icon_state = "spider"
	icon = 'modular_pod/icons/content_6.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/spadero
	icon_state = "spadero"
	icon = 'modular_pod/icons/content_6.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/dreamer
	icon_state = "dreamer"
	icon = 'modular_pod/icons/content_6.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
	powerfloor = 18

/turf/open/floor/plating/polovich/way/pryt
	icon_state = "pryt"
	icon = 'modular_pod/icons/content_6.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL
	powerfloor = 18

/turf/open/floor/plating/polovich/way/stola
	icon_state = "stola"
	icon = 'modular_pod/icons/content_6.dmi'
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL
	powerfloor = 18

/turf/open/floor/plating/polovich/way/qiwi
	name = "Qiwi"
	icon_state = "qiwi"
	icon = 'modular_pod/icons/content_6.dmi'
	footstep = FOOTSTEP_CRUMBLE
	barefootstep = FOOTSTEP_CRUMBLE
	clawfootstep = FOOTSTEP_CRUMBLE
	heavyfootstep = FOOTSTEP_CRUMBLE
	slowdown = 1

/turf/open/floor/plating/polovich/way/ditraa
	name = "Dirt"
	icon_state = "ditraa"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND
	icon = 'modular_pod/icons/content_6.dmi'
	slowdown = 1

/turf/open/floor/plating/polovich/way/murda
	name = "Mud"
	icon_state = "murda"
	footstep = FOOTSTEP_MEAT
	barefootstep = FOOTSTEP_MEAT
	clawfootstep = FOOTSTEP_MEAT
	heavyfootstep = FOOTSTEP_MEAT
	icon = 'modular_pod/icons/content_6.dmi'
	slowdown = 1

/turf/open/floor/plating/polovich/way/wiider
	icon_state = "wiider"
	icon = 'modular_pod/icons/content_6.dmi'
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_WOOD
	resistance_flags = FLAMMABLE
	powerfloor = 18
