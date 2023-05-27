/area
	min_ambience_cooldown = 30 SECONDS
	max_ambience_cooldown = 90 SECONDS
	/// If this is not null, it's printed to the player when he enters the area, along with room_desc
	var/room_name
	/// If this is not null, it's printed to the player when he enters the area after room_name
	var/room_desc
	// ~DRONING SYSTEM VARIABLES
	var/droning_sound = DRONING_DEFAULT
	var/droning_repeat = TRUE
	var/droning_wait = 0
	var/droning_volume = 25
	var/droning_channel = CHANNEL_AMBIENCE_MUSIC
	var/droning_frequency = 0

/area/Initialize(mapload)
	. = ..()
	if(droning_sound)
		/// To make the client droning system not SHIT itself, we need to ensure only one track per area, per round
		droning_sound = pick(droning_sound)

/area/Entered(atom/movable/arrived, area/old_area)
	set waitfor = FALSE
	SEND_SIGNAL(src, COMSIG_AREA_ENTERED, arrived, old_area)
	var/mob/mob_arrived = arrived
	if(istype(mob_arrived) && mob_arrived.client)
		mob_arrived.client.area_entered(src, mob_arrived)
	if(!LAZYACCESS(arrived.important_recursive_contents, RECURSIVE_CONTENTS_AREA_SENSITIVE))
		return
	for(var/atom/movable/recipient as anything in arrived.important_recursive_contents[RECURSIVE_CONTENTS_AREA_SENSITIVE])
		SEND_SIGNAL(recipient, COMSIG_ENTER_AREA, src)
/*
/area/on_joining_game(atom/movable/boarder)
	. = ..()
	var/mob/mob_arrived = boarder
	if(istype(mob_arrived) && mob_arrived.client)
		SSdroning.area_entered(src, boarder.client)
		boarder.client.update_ambience_pref()
//		SSambience.process_ambience_client(src, boarder.client)
*/