/turf/open/floor/plating/polovich/way/station
	name = "Пол"
	icon = 'modular_pod/icons/turf/floors_4.dmi'

/turf/open/floor/plating/polovich/way/station/hotfloor
	icon_state = "hotfloor"
	footstep = FOOTSTEP_METAL
	barefootstep = FOOTSTEP_METAL
	clawfootstep = FOOTSTEP_METAL
	heavyfootstep = FOOTSTEP_METAL
	light_range = 1
	light_power = 1
	light_color = "#c2281b"

/turf/open/floor/plating/polovich/way/station/mystic
	icon_state = "mystic"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/way/station/mystic/crazy
	var/crazy_id = "station"
	special_floor = TRUE

/turf/open/floor/plating/polovich/way/station/mystic/crazy/special_thing(mob/living/user)
	for(var/turf/open/floor/plating/polovich/way/station/mystic/crazy/spawn_point in world)
		if(spawn_point.crazy_id == "earth")
			user.visible_message(span_meatymeat("[user] телепортируется!"),span_meatymeat("Я телепортируюсь!"), span_hear("Я слышу чё-то."))
			user.forceMove(spawn_point.loc)

/turf/open/floor/plating/polovich/way/station/mystic/crazy/back
	crazy_id = "earth"

/turf/open/floor/plating/polovich/way/station/mystic/crazy/back/special_thing(mob/living/user)
	for(var/turf/open/floor/plating/polovich/way/station/mystic/crazy/spawn_point in world)
		if(spawn_point.crazy_id == "station")
			user.visible_message(span_meatymeat("[user] телепортируется!"),span_meatymeat("Я телепортируюсь!"), span_hear("Я слышу чё-то."))
			user.forceMove(spawn_point.loc)

/turf/open/floor/plating/polovich/way/station/notgood
	icon_state = "notgood"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE

/turf/open/floor/plating/polovich/way/station/enga
	icon_state = "enga"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/way/station/enga2
	icon_state = "enga2"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/way/station/web
	icon_state = "web"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/plating/polovich/way/station/wayt
	icon_state = "wayt"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_STONE
	clawfootstep = FOOTSTEP_STONE
	heavyfootstep = FOOTSTEP_STONE
