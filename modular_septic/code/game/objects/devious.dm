/obj/item/deviouslick
	var/lickable = TRUE
	var/tiktok_accepted = TRUE

/obj/item/deviouslick/sounding
	name = "Sounding Rod"
	desc = "UUUUUUUUUUUUUUUUUA\n\
			AUUUUUUUUUUUUUUUUUUUUUUUUU"
	icon = 'modular_septic/icons/obj/items/deviouslick.dmi'
	icon_state = "OOOOOOO"
	inhand_icon_state = "buildpipe"
	item_flags = NO_PIXEL_RANDOM_DROP | NO_ANGLE_RANDOM_DROP
	tetris_width = 32
	tetris_height = 128
	var/uuuua = FALSE
	var/doing_animation = FALSE
	var/flip_count = 0

/obj/item/deviouslick/sounding/attack_self(mob/user, modifiers)
	. = ..()
	if(doing_animation)
		return
	uuuua = !uuuua
	flip_count++
	var/sound_to_play
	//make uuuuuuua sound
	if(uuuua)
		sound_to_play = 'modular_septic/sound/memeshit/uuua.ogg'
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "sounding[flip_count]", /datum/mood_event/sounding_ua)
	else
		sound_to_play = 'modular_septic/sound/memeshit/auuu.ogg'
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "sounding[flip_count]", /datum/mood_event/sounding_au)
	INVOKE_ASYNC(src, .proc/do_sounding, user, sound_to_play)

/obj/item/deviouslick/sounding/proc/do_sounding(mob/user, sound_to_play = 'modular_septic/sound/memeshit/uuua.ogg')
	doing_animation = TRUE
	var/duration = 1 SECONDS
	var/smoothness = 4
	var/turning = 180/smoothness
	var/turning_duration = duration/smoothness
	for(var/step in 1 to smoothness)
		animate(src, transform = transform.Turn(turning), time = turning_duration, flags = LINEAR_EASING)
		sleep(turning_duration)
	sleep(0.5 SECONDS)
	if(uuuua)
		icon_state = "AAAAAAAAAU"
	else
		icon_state = "UAAAAAAAAA"
	playsound(src, sound_to_play, 75, FALSE)
	if(user)
		if(uuuua)
			to_chat(user, span_nicegreen(span_big("UUUUUUUUUUUA")))
		else
			to_chat(user, span_nicegreen(span_big("AUUUUUUUUUUU")))
	//this sleeps for a bit more than the animation lasts for
	sleep(1 SECONDS)
	doing_animation = FALSE
	if(uuuua)
		icon_state = "AAAAAAA"
	else
		icon_state = "OOOOOOO"

/obj/item/deviouslick/soapdispenser
	name = "Soap Dispensed"
	desc = "<b>DEVIOUS.</b>"
	icon = 'modular_septic/icons/obj/items/deviouslick.dmi'
	icon_state = "soapdispenser"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "dispenser"
	tetris_width = 96
	tetris_height = 96

/obj/structure/soapmount
	name = "Soap Dispenser mount"
	desc = "A mount for a soap dispenser. Commonly seen in buisnesses, schools, malls and pools. Basically everywhere that has a bathroom, you'd have one of these. \
	Your peers would be disappointed in you If you did a <b>devious lick.</b>"
	icon = 'modular_septic/icons/obj/structures/deviouslick.dmi'
	icon_state = "soapmount_occupied"
	anchored = TRUE
	density = FALSE
	max_integrity = 420
	integrity_failure = 0.25
	var/obj/item/deviouslick/soapdispenser/stored_soapdispenser

/obj/structure/soapmount/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -27 : 27)
		pixel_y = (dir & 3)? (dir ==1 ? -30 : 30) : 0
		icon_state = "soapmount_empty"
	else
		stored_soapdispenser = new /obj/item/deviouslick/soapdispenser(src)

/obj/structure/soapmount/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/structure/soapmount/directional/south
	dir = NORTH
	pixel_y = -32

/obj/structure/soapmount/directional/east
	dir = WEST
	pixel_x = 32

/obj/structure/soapmount/directional/west
	dir = EAST
	pixel_x = -32

/obj/structure/soapmount/deviouslick
	max_integrity = 99420

/obj/structure/soapmount/deviouslick/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/structure/soapmount/deviouslick/directional/south
	dir = NORTH
	pixel_y = -32

/obj/structure/soapmount/deviouslick/directional/east
	dir = WEST
	pixel_x = 32

/obj/structure/soapmount/deviouslick/directional/west
	dir = EAST
	pixel_x = -32

/obj/item/deviouslick/broken_lcd
	name = "broken LCD"
	desc = "A shattered LCD with valuable components inside. Barely, valuable. Who the hell would steal this?"
	icon = 'modular_septic/icons/obj/items/deviouslick.dmi'
	icon_state = "lcd"
	tetris_width = 64
	tetris_height = 32
	w_class = WEIGHT_CLASS_TINY
