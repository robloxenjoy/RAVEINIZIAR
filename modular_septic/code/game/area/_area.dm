/area
	min_ambience_cooldown = 20 SECONDS
	max_ambience_cooldown = 30 SECONDS
	/// If this is not null, it's printed to the player when he enters the area, along with room_desc
	var/room_name
	/// If this is not null, it's printed to the player when he enters the area after room_name
	var/room_desc
	// ~DRONING SYSTEM VARIABLES
	var/droning_sound = DRONING_DEFAULT
	var/droning_vary = 0
	var/droning_repeat = TRUE
	var/droning_wait = 25
	var/droning_volume = 15
	var/droning_channel = CHANNEL_BUZZ
	var/droning_frequency = 0

/area/Entered(atom/movable/arrived, area/old_area)
	set waitfor = FALSE
	SEND_SIGNAL(src, COMSIG_AREA_ENTERED, arrived, old_area)
	var/mob/living/living_arrived = arrived
	if(istype(living_arrived) && living_arrived.client)
//	if(istype(living_arrived) && living_arrived.client && !living_arrived.combat_mode)
		//Ambience if combat mode is off
		SSdroning.area_entered(src, living_arrived.client)
	if(!LAZYACCESS(arrived.important_recursive_contents, RECURSIVE_CONTENTS_AREA_SENSITIVE))
		return
	for(var/atom/movable/recipient as anything in arrived.important_recursive_contents[RECURSIVE_CONTENTS_AREA_SENSITIVE])
		SEND_SIGNAL(recipient, COMSIG_ENTER_AREA, src)

/area/on_joining_game(mob/living/boarder)
	. = ..()
	if(istype(boarder) && boarder.client)
		SSdroning.area_entered(src, boarder.client)
		boarder.client.update_ambience_pref()
//		SSambience.process_ambience_client(src, boarder.client)