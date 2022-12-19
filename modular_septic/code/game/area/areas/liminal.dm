/area/maintenance/liminal
	name = "Liminal Space"
	icon_state = "liminal"
	icon = 'modular_septic/icons/turf/areas.dmi'
	requires_power = FALSE
	droning_sound = null

/area/maintenance/liminal/red
	name = "Liminal Red"
	icon_state = "red"

/area/maintenance/liminal/purple
	name = "Liminal Purple"
	icon_state = "purple"
	ambience_index = AMBIENCE_ZEETHREE

/area/maintenance/liminal/green
	name = "Liminal Green"
	icon_state = "green"
	ambience_index = AMBIENCE_ZEETHREE

/area/maintenance/liminal/darkgreen
	name = "Liminal Dark Green"
	icon_state = "darkgreen"

/area/maintenance/liminal/hallways
	name = "Liminal Hallways"
	icon_state = "engine"
	mood_message = "<span class='bloody'>This area is pretty nice!</span>\n"
	mood_bonus = -1

/area/maintenance/liminal/labs
	name = "Liminal Labs"
	icon_state = "engine"
	ambience_index = AMBIENCE_LAB
	mood_message = "<span class='bloody'>It feels safer here.</span>\n"
	mood_bonus = 1

/area/maintenance/liminal/termination_centre
	name = "Liminal Termination Centre"
	icon_state = "engine"
	mood_message = "<span class='bloody'>I feel unnerved being here.</span>\n"
	mood_bonus = -1


/area/maintenance/liminal/deep
	name = "Liminal Deep"
	icon_state = "engine_sm"
	mood_message = "<span class='bloody'>This area is pretty nice!</span>\n"
	mood_bonus = -1

/area/maintenance/liminal/bunker
	name = "Liminal Bunker"
	icon_state = "engine_sm"
	mood_message = "<span class='swarmer'>THIS AREA FUCKS!</span>\n"
	mood_bonus = 3

/area/maintenance/liminal/derelict
	name = "Liminal Derelict"
	icon_state = "engine_sm"
	mood_message = "<span class='swarmer'>It's fucked up here.</span>\n"
	mood_bonus = 1

/area/maintenance/liminal/darkclub
	name = "Liminal Club"
	icon_state = "darkgreen"

/area/maintenance/liminal/observitory
	name = "Liminal Observitory"
	icon_state = "engine_sm"

/area/maintenance/liminal/solar
	name = "Liminal Solars"
	icon_state = "engine_sm"

/area/maintenance/liminal/chromosome
	name = "Liminal Chromosome"
	icon_state = "engine_sm"

/area/maintenance/liminal/train
	name = "Liminal Train"
	icon_state = "engine_sm"

/area/maintenance/liminal/intro
	name = "Liminal Introduction"

/area/maintenance/liminal/intro/barracks
	name = "Liminal Introduction Barracks"

/area/maintenance/liminal/intro/elevators
	name = "Liminal Intro Elevators"

/area/maintenance/liminal/elevators
	name = "Liminal Elevators"
	droning_sound = null
	ambience_index = AMBIENCE_ELEVATOR
	sound_environment = SOUND_ENVIRONMENT_SEWER_PIPE

/area/maintenance/liminal/waitroom
	name = "Liminal Waitroom"

/area/maintenance/liminal/windowclub
	name = "Liminal Window Club"

/area/maintenance/liminal/boltduel
	name = "Liminal Boltie Tunnels"
	ambience_index = AMBIENCE_ZEETHREE

/area/maintenance/liminal/boltduel/mechanism
	name = "Liminal Mechanists Room"
	ambience_index = AMBIENCE_ZEETHREE

/area/maintenance/liminal/tensity
	name = "Liminal Tense Rooms"

/area/maintenance/liminal/divine
	name = "Liminal Divine"

/area/maintenance/liminal/beattheboss
	name = "Liminal Beat The Boss"

/area/maintenance/liminal/denominator
	name = "Denominator's Hideout"

/area/maintenance/liminal/denominator/barracks
	name = "Denominator's Barracks"

/area/maintenance/liminal/outdoor
	name = "Liminal Fake Outdoors"
	area_flags = VALID_TERRITORY | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED | NO_ALERTS
	map_generator = /datum/map_generator/efn_surface_generator

/area/maintenance/liminal/outdoor/explored
	name = "Liminal Fake Outdoors no generator"
	area_flags = VALID_TERRITORY | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED | NO_ALERTS
	map_generator = null
	ambience_index = AMBIENCE_OUTDOOR

/area/maintenance/liminal/outdoor/interior
	name = "Liminal Fake Outdoors Room"
	map_generator = null
	ambience_index = null

/area/maintenance/liminal/intro/Entered(atom/movable/arrived, area/old_area, volume = 70)
	. = ..()
	var/mob/living/living_arrived = arrived
	if(istype(living_arrived) && !HAS_TRAIT(living_arrived, TRAIT_PACIFISM))
		//When a human enters the hallway, what happens?
		ADD_TRAIT(living_arrived, TRAIT_PACIFISM, AREA_TRAIT)
		//They become a soyjack

/area/maintenance/liminal/intro/Exited(atom/movable/gone, direction, volume = 70)
	. = ..()
	var/mob/living/living_gone = gone
	if(istype(living_gone) && HAS_TRAIT(living_gone, TRAIT_PACIFISM))
		//When a human exits the hallway, what happens?
		REMOVE_TRAIT(living_gone, TRAIT_PACIFISM, AREA_TRAIT)
		//They become a doomerjackxx

/area/maintenance/liminal/intro/barracks/Entered(atom/movable/arrived, area/old_area, volume = 70)
	. = ..()
	var/mob/living/living_arrived = arrived
	if(istype(living_arrived) && !HAS_TRAIT(living_arrived, TRAIT_PACIFISM))
		//When a human enters the hallway, what happens?
		ADD_TRAIT(living_arrived, TRAIT_PACIFISM, AREA_TRAIT)
		//They become a soyjack
		//But no sound

/area/maintenance/liminal/intro/barracks/Exited(atom/movable/gone, direction, volume = 70)
	. = ..()
	var/mob/living/living_gone = gone
	if(istype(living_gone) && HAS_TRAIT(living_gone, TRAIT_PACIFISM))
		//When a human exits the hallway, what happens?
		REMOVE_TRAIT(living_gone, TRAIT_PACIFISM, AREA_TRAIT)
		//They become a doomerjackxx
		//But no sound
