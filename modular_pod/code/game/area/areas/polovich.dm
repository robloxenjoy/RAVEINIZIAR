/*
/area/maintenance/liminal/deep
	name = "Liminal Deep"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALDEEP
	mood_message = "<span class='bloody'>This area is pretty nice!</span>\n"
	mood_bonus = -1

/area/maintenance/liminal/bunker
	name = "Liminal Bunker"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALBUNKER
	mood_message = "<span class='swarmer'>THIS AREA FUCKS!</span>\n"
	mood_bonus = 3

/area/maintenance/liminal/derelict
	name = "Liminal Derelict"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALDERELICT
	mood_message = "<span class='swarmer'>It's fucked up here.</span>\n"
	mood_bonus = 1
*/

/area/maintenance/polovich
	name = "Polovich"
	droning_sound = DRONING_POLOVICHSTAN
	droning_volume = 35
	requires_power = FALSE
	ambience_index = AMBIENCE_GENERIC
	min_ambience_cooldown = 20 SECONDS
	max_ambience_cooldown = 30 SECONDS
	area_flags = NO_ALERTS
/*
/area/Entered(atom/movable/arrived, area/old_area)
	var/area/current_area = get_area(src)
	if(current_area)
		SSdroning.area_entered(current_area, client)
*/
/area/maintenance/polovich/forest
	name = "Polovich Forest"
//	base_lighting_alpha = 255
//	power_light = FALSE
//	power_equip = FALSE
//	power_environ = FALSE
	requires_power = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	static_lighting = TRUE
	area_flags = NO_ALERTS
	ambientsounds = list('modular_pod/sound/ambi_sounds/borne.ogg', 'modular_pod/sound/ambi_sounds/buffmfffpampam.ogg', 'modular_pod/sound/ambi_sounds/BOOOM.ogg')
	droning_sound = DRONING_FOREST
	min_ambience_cooldown = 30 SECONDS
	max_ambience_cooldown = 50 SECONDS

/area/maintenance/polovich/forest/rain
//	base_lighting_alpha = 255
//	power_light = FALSE
//	power_equip = FALSE
//	power_environ = FALSE

/area/maintenance/polovich/evilplace
	name = "Polovich Evil"
	droning_sound = DRONING_EVIL
	area_flags = NO_ALERTS

/area/maintenance/polovich/village
	name = "Polovich Village"
	droning_sound = DRONING_VILL
	area_flags = NO_ALERTS

/area/maintenance/polovich/night
	name = "Polovich Purenight"
	droning_sound = DRONING_PURENIGHT
	area_flags = NO_ALERTS
