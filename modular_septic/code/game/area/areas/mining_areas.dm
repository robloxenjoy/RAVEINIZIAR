//Nevado sounds
/area/mine
	droning_sound = DRONING_MINING
//Space sounds
/area/asteroid
	droning_sound = DRONING_MINING

//Base nevado type
/area/nevado
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = NONE
	sound_environment = SOUND_AREA_ICEMOON

//Nevado surface
/area/nevado/surface
	name = "Nevado Surface"
	icon_state = "explored"
	outdoors = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambience_index = AMBIENCE_MINING
	area_flags = VALID_TERRITORY | UNIQUE_AREA
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/nevado/surface/outdoors
	name = "Nevado Surface Outdoors"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | CAVES_ALLOWED
	outdoors = TRUE

/area/nevado/surface/outdoors/unexplored
	name = "Nevado Surface Wastes"
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED | NO_ALERTS
	map_generator = /datum/map_generator/nevado_surface_generator

//Nevado caves
/area/nevado/caves
	name = "Nevado Underground"
	icon_state = "explored"
	outdoors = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambience_index = AMBIENCE_MINING
	area_flags = VALID_TERRITORY | UNIQUE_AREA
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/nevado/caves/outdoors
	name = "Nevado Underground Outdoors"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | CAVES_ALLOWED
	outdoors = TRUE

/area/nevado/caves/outdoors/unexplored
	name = "Nevado Caves"
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED | NO_ALERTS
	map_generator = /datum/map_generator/cave_generator/nevado
