/obj/item/geode
	name = "geod"
	desc = "A geode. What could be inside?"
	icon = 'modular_septic/icons/obj/items/deviouslick.dmi'
	icon_state = "geod"
	base_icon_state = "geod"
	var/cracked = FALSE
	var/mob/living/carbon/human/homie_in_geod

/obj/item/geode/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_ICON_STATE)

/obj/item/geode/update_icon_state()
	. = ..()
	if(cracked)
		if(homie_in_geod)
			icon_state = "homie_in_geod"
		else
			icon_state = "geod_empty"
	else
		icon_state = base_icon_state

/obj/item/geode/examine(mob/user)
	. = ..()
	if(cracked)
		. += span_info("The [name] has been cracked open.")
		if(homie_in_geod)
			. += span_info("There is a homie inside the geode!")

/obj/item/geode/attackby(obj/item/weapon, mob/living/user, params)
	. = ..()
	if(!(weapon.get_sharpness() & SHARP_POINTY))
		return
	else if(cracked)
		to_chat(user, span_warning("[src] [p_are()] already cracked."))
		return
	to_chat(user, span_notice("I start cracking open [name] with [weapon]..."))
	if(!do_after(user, 3 SECONDS, src))
		to_chat(user, span_warning(fail_msg()))
		return
	playsound(src, 'modular_septic/sound/effects/homiereveal.ogg', 80, FALSE)
	if(homie_in_geod)
		if(!istype(homie_in_geod))
			homie_in_geod = new homie_in_geod(src)
		to_chat(user, span_notice("There was something inside! It's <b>[homie_in_geod]</b>!"))
	else
		to_chat(user, span_warning("There was nothing inside..."))
	cracked = TRUE
	update_appearance()

/obj/item/geode/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!istype(over, /atom/movable/screen/inventory/hand) || !isliving(usr) || usr.incapacitated() || !cracked || !homie_in_geod)
		return
	if(!istype(homie_in_geod))
		homie_in_geod = new homie_in_geod(src)
	var/mob/living/user = usr
	var/turf/open/homie_release = get_turf(user)
	if(!(istype(homie_release) && user.Adjacent(homie_release) && Adjacent(homie_release)))
		return
	playsound(src, 'modular_septic/sound/effects/homierip.ogg', 80, FALSE)
	to_chat(user, span_notice("I have freed <b>[homie_in_geod]</b> from [homie_in_geod.p_their()] crystal prison!\n\
							It might take a while until [homie_in_geod.p_they()] regain consciousness..."))
	homie_in_geod.Unconscious(40 SECONDS)
	homie_in_geod.forceMove(homie_release)
	INVOKE_ASYNC(src, .proc/offer_homie_to_ghosts, homie_in_geod, user)
	homie_in_geod = null
	update_appearance()

/obj/item/geode/proc/offer_homie_to_ghosts(mob/living/carbon/human/homie, mob/living/user)
	var/poll_message = "Do you want to be [user.real_name]'s homie? ([homie.real_name])"
	var/list/mob/dead/observer/candidates = poll_candidates_for_mob(poll_message, ROLE_HOMIE, FALSE, 30 SECONDS, homie)
	if(LAZYLEN(candidates))
		var/mob/dead/observer/picked = pick(candidates)
		homie.ghostize(FALSE)
		homie.mind_initialize()
		homie.key = picked.key
		playsound(homie, 'modular_septic/sound/effects/homielife.wav', 100, FALSE)
		notify_ghosts("A homie has gained sentience in \the [get_area(homie)]!", source = homie, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Homie Out of a Geod")

/obj/item/geode/homie
	homie_in_geod = /mob/living/carbon/human/species/homie
