/area/maintenance/polovich
	name = "Polovich"
	icon_state = "polovich"
//	droning_sound = DRONING_POLOVICHSTAN
	droning_volume = 15
	requires_power = FALSE
	ambience_index = AMBIENCE_GENERIC
	min_ambience_cooldown = 60 SECONDS
	max_ambience_cooldown = 95 SECONDS
	area_flags = NO_ALERTS
//	ambientsounds = list('modular_pod/sound/ambi_sounds/borne.ogg', 'modular_pod/sound/ambi_sounds_three/animalish.ogg', 'modular_pod/sound/ambi_sounds_three/feeder.ogg', 'modular_pod/sound/ambi_sounds_three/meaningg.ogg', 'modular_pod/sound/ambi_sounds_three/aaaaaa.ogg', 'modular_pod/sound/ambi_sounds_three/aaaaaa2.ogg', 'modular_pod/sound/ambi_sounds_two/aloha.ogg', 'modular_pod/sound/ambi_sounds_two/birds.ogg', 'modular_pod/sound/ambi_sounds_two/birds_ds.ogg', 'modular_pod/sound/ambi_sounds_two/birds_po.ogg', 'modular_pod/sound/ambi_sounds_two/birds_sc.ogg', 'modular_pod/sound/ambi_sounds_two/birds_vs.ogg', 'modular_pod/sound/ambi_sounds_two/cyclobe_first.ogg', 'modular_pod/sound/ambi_sounds_two/cyclobe_two.ogg', 'modular_pod/sound/ambi_sounds_two/dead_dawn.ogg', 'modular_pod/sound/ambi_sounds_two/living.ogg', 'modular_pod/sound/ambi_sounds_two/living_two.ogg', 'modular_pod/sound/ambi_sounds_two/mylove.ogg', 'modular_pod/sound/ambi_sounds_two/own.ogg', 'modular_pod/sound/ambi_sounds_two/pain.ogg', 'modular_pod/sound/ambi_sounds_two/pain_two.ogg', 'modular_pod/sound/ambi_sounds_two/peregi.ogg', 'modular_pod/sound/ambi_sounds_two/phil.ogg', 'modular_pod/sound/ambi_sounds_two/phill.ogg', 'modular_pod/sound/ambi_sounds_two/queen.ogg', 'modular_pod/sound/ambi_sounds_two/queen_second.ogg', 'modular_pod/sound/ambi_sounds_two/queen_three.ogg', 'modular_pod/sound/ambi_sounds_two/red.ogg', 'modular_pod/sound/ambi_sounds_two/reddy.ogg', 'modular_pod/sound/ambi_sounds_two/run.ogg', 'modular_pod/sound/ambi_sounds_two/run_two.ogg', 'modular_pod/sound/ambi_sounds_two/slur.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice_three.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice_two.ogg', 'modular_pod/sound/ambi_sounds_two/spiral.ogg', 'modular_pod/sound/ambi_sounds_two/stan.ogg', 'modular_pod/sound/ambi_sounds_two/sun.ogg', 'modular_pod/sound/ambi_sounds_two/sunny.ogg', 'modular_pod/sound/ambi_sounds_two/thee.ogg', 'modular_pod/sound/ambi_sounds_two/things.ogg', 'modular_pod/sound/ambi_sounds_two/things_two.ogg', 'modular_pod/sound/ambi_sounds/essel_first.ogg', 'modular_pod/sound/ambi_sounds/essel_two.ogg', 'modular_pod/sound/ambi_sounds/essel_three.ogg', 'modular_pod/sound/ambi_sounds/fire.ogg', 'modular_pod/sound/ambi_sounds/fire_four.ogg', 'modular_pod/sound/ambi_sounds/fire_three.ogg', 'modular_pod/sound/ambi_sounds/fire_two.ogg', 'modular_pod/sound/ambi_sounds/fire.ogg', 'modular_pod/sound/ambi_sounds/forest_first.ogg', 'modular_pod/sound/ambi_sounds/forest_two.ogg', 'modular_pod/sound/ambi_sounds/forest_three.ogg', 'modular_pod/sound/ambi_sounds/lot.ogg', 'modular_pod/sound/ambi_sounds/ostia.ogg', 'modular_pod/sound/ambi_sounds/weeper_first.ogg', 'modular_pod/sound/ambi_sounds/weeper_three.ogg', 'modular_pod/sound/ambi_sounds/weeper_two.ogg')
/*
/area/Entered(atom/movable/arrived, area/old_area)
	var/area/current_area = get_area(src)
	if(current_area)
		SSdroning.area_entered(current_area, client)
*/
/area/maintenance/polovich/forest
	name = "Polovich Earth"
//	base_lighting_alpha = 255
//	power_light = FALSE
//	power_equip = FALSE
//	power_environ = FALSE
	requires_power = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	static_lighting = FALSE
	base_lighting_alpha = 255
//	area_has_base_lighting = TRUE
	area_flags = NO_ALERTS
	droning_sound = DRONING_POLOVICHSTAN
	min_ambience_cooldown = 60 SECONDS
	max_ambience_cooldown = 95 SECONDS

/area/maintenance/polovich/forest/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	var/mob/living/living_arrived = arrived
	if(istype(living_arrived) && living_arrived.client)
		living_arrived.overlay_fullscreen("redfog", /atom/movable/screen/fullscreen/foge)

/area/maintenance/polovich/forest/Exited(atom/movable/gone, direction)
	. = ..()
	var/mob/living/living_gone = gone
	if(istype(living_gone))
		living_gone.clear_fullscreen("redfog")

/area/maintenance/polovich/forest/on_joining_game(mob/living/boarder)
	. = ..()
	if(istype(boarder) && boarder.client)
		boarder.overlay_fullscreen("redfog", /atom/movable/screen/fullscreen/foge)

/area/maintenance/polovich/forest/reconnect_game(mob/living/boarder)
	. = ..()
	if(istype(boarder) && boarder.client)
		boarder.overlay_fullscreen("redfog", /atom/movable/screen/fullscreen/foge)

/area/maintenance/polovich/forest/inner
	static_lighting = TRUE
	base_lighting_alpha = 1
	icon_state = "polovich_inner"
	min_ambience_cooldown = 50 SECONDS
	max_ambience_cooldown = 75 SECONDS
	ambientsounds = list('modular_pod/sound/ambi_sounds_in/italy.ogg', 'modular_pod/sound/ambi_sounds_in/italy2.ogg', 'modular_pod/sound/ambi_sounds_in/italy3.ogg')
	droning_sound = null

/area/maintenance/polovich/forest/forestspawn
	name = "Polovich Forest Spawn"

/area/maintenance/polovich/forest/rain
	icon_state = "polovich_no_rain"
//	base_lighting_alpha = 255
//	power_light = FALSE
//	power_equip = FALSE
//	power_environ = FALSE

/area/maintenance/polovich/forest/rain/village
	droning_sound = DRONING_AKT
	min_ambience_cooldown = 60 SECONDS
	max_ambience_cooldown = 95 SECONDS
	requires_power = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	static_lighting = TRUE

/area/maintenance/polovich/evilplace
	name = "Polovich Evil"
	area_flags = NO_ALERTS

/area/maintenance/polovich/village
	name = "Polovich Village"
	icon_state = "village"
	droning_sound = DRONING_AKT
	requires_power = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	static_lighting = TRUE
	area_flags = NO_ALERTS
	min_ambience_cooldown = 60 SECONDS
	max_ambience_cooldown = 95 SECONDS

/area/maintenance/polovich/chaot
	droning_sound = DRONING_CHAOT

/area/maintenance/polovich/forest/rain/chaot
	droning_sound = DRONING_CHAOT
	min_ambience_cooldown = 60 SECONDS
	max_ambience_cooldown = 95 SECONDS

/area/maintenance/polovich/catacombs

/area/maintenance/polovich/night
	name = "Polovich Purenight"
	droning_sound = DRONING_PURENIGHT
	area_flags = NO_ALERTS
