#define BEEPING 1
#define FAST_BEEPING 2

/obj/machinery/infocom
	name = "Infocom"
	desc = "An information communication machine, a very creative name! It's a device used to dispense information when used, how do you know that? I don't fucking know, click on it to learn how."
	icon = 'modular_septic/icons/obj/machinery/intercom.dmi'
	icon_state = "infocom"
	base_icon_state = "infocom"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE
	var/radiotune = list('modular_septic/sound/efn/infocom1.ogg', 'modular_septic/sound/efn/infocom2.ogg', 'modular_septic/sound/efn/infocom3.ogg', 'modular_septic/sound/efn/infocom4.ogg')
	var/virused = FALSE
	var/tip_sound = 'modular_septic/sound/efn/infocom_trigger.ogg'
	var/untip_sound = 'modular_septic/sound/efn/infocom_untrigger.ogg'
	var/list/voice_lines = list("This place is damp and dirty, many of the rooms don't make sense but I can help you.", "Find more Infocoms next to things you're curious about, they say different things.", "It'll tell you the location name and what you can find there.", \
	"Avoid everyone! Or kill them, they're out to get your loot and your life.")
	var/tipped = FALSE
	var/voice_delay = 3 SECONDS
	var/cooldown_delay = 3 SECONDS
	var/speak_prob = 80
	var/state

/obj/machinery/infocom/combat
	name = "Evil Infocom"
	desc = "An information communication machine, specifically used for relaying calm and concise information about combat."
	icon_state = "infocom_evil"
	base_icon_state = "infocom_evil"
	radiotune = list('modular_septic/sound/efn/evilcom1.ogg', 'modular_septic/sound/efn/evilcom2.ogg', 'modular_septic/sound/efn/evilcom3.ogg')
	voice_lines = list("NO-ONE BUT YOU CAN ESCAPE WILLINGLY.", "TAKE A GUN, TAKE SOMETHING HEAVY", "DEFEND YOURSELF AT ALL COSTS, KILL EVERYONE IN YOUR WAY", "DON'T THINK, SHOOT.")
	voice_delay = 2.5 SECONDS
	speak_prob = 100

/obj/machinery/infocom/combat/north
	dir = SOUTH
	pixel_y = 33

/obj/machinery/infocom/combat/east
	dir = WEST
	pixel_x = 12

/obj/machinery/infocom/combat/west
	dir = EAST
	pixel_x = -12

/obj/machinery/infocom/proc/set_hacking()
	return new /datum/hacking/infocom(src)

/obj/machinery/infocom/proc/spit_facts()
	if(prob(speak_prob))
		playsound(src, radiotune, 40, FALSE)

/obj/machinery/infocom/Initialize(mapload)
	. = ..()
	hacking = set_hacking()
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/update_overlays()
	. = ..()
	switch(state)
		if(BEEPING)
			. += "[base_icon_state]_blipper"
		if(FAST_BEEPING)
			. += "[base_icon_state]_blipper_fast"
	if(!tipped)
		. += "[icon_state]_beeper"

/obj/machinery/infocom/attackby(obj/item/W, mob/living/user, params)
	var/list/modifiers = params2list(params)
	if(is_wire_tool(W) && !IS_HARM_INTENT(user, modifiers))
		attempt_hacking_interaction(user)
		return
	return ..()

/obj/machinery/infocom/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(tipped)
		var/explicit = pick("fucking", "goddamn", "goshdarn", "fricking")
		to_chat(user, span_notice("I need to let it [explicit] speak."))
		return
	playsound(src, tip_sound, 65, FALSE)
	tipped = TRUE
	update_appearance(UPDATE_ICON)
	INVOKE_ASYNC(src, .proc/start_spitting_fax)

/obj/machinery/infocom/proc/start_spitting_fax(mob/living/user, list/modifiers)
	beep()
	sleep(9)
	for(var/line in voice_lines)
		spit_facts()
		say(line)
		sound_hint()
		sleep(voice_delay)
	sleep(cooldown_delay)
	tipped = FALSE
	playsound(src, untip_sound, 45, FALSE)
	beep_fast()
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/proc/beep()
	state = BEEPING
	update_appearance(UPDATE_ICON)
	sleep(6)
	state = null
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/proc/beep_fast()
	state = FAST_BEEPING
	update_appearance(UPDATE_ICON)
	sleep(4)
	state = null
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/north
	dir = SOUTH
	pixel_y = 33

/obj/machinery/infocom/east
	dir = WEST
	pixel_x = 12

/obj/machinery/infocom/west
	dir = EAST
	pixel_x = -12

#undef BEEPING
#undef FAST_BEEPING
