/turf/Initialize(mapload)
	. = ..()
	initialize_clinging()

/turf/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	if(user.z != src.z)
		return SCREENTIP_OPENSPACE("OPEN SPACE")
	else
		return SCREENTIP_TURF(uppertext(name))

/turf/MouseDropReceive(atom/movable/dropping, mob/living/user)
	. = ..()
	if(!isliving(dropping) || !isliving(user) || !dropping.has_gravity() || \
		user.incapacitated() || \
		HAS_TRAIT_FROM(dropping, TRAIT_IMMOBILIZED, CLINGING_TRAIT))
		return
	var/turf/dropping_turf = get_turf(dropping)
	if(!dropping_turf || (dropping_turf == src))
		return
	var/z_difference = dropping_turf.z - src.z
	if((z_difference < 0) || (z_difference > 1))
		return
	if(z_difference)
		if(get_dist(src, dropping_turf) > 1)
			return
	else if(!dropping_turf.Adjacent(src) || !Adjacent(dropping_turf))
		return
	//Climb down
	if((dropping_turf.turf_height - src.turf_height >= TURF_HEIGHT_BLOCK_THRESHOLD) || (dropping_turf.z > src.z))
		if(user == dropping)
			dropping.visible_message(span_notice("<b>[user]</b> starts descending down to [src]"), \
								span_notice("I start lowering myself to [src]."))
		else
			dropping.visible_message(span_warning("<b>[user]</b> starts lowering <b>[dropping]</b> down to [src]"), \
								span_notice("I start lowering <b>[dropping]</b> down to [src]."))
		if(do_mob(user, dropping, 2 SECONDS))
			dropping.forceMove(src)
		return
	//Climb up
	else if((src.turf_height - dropping_turf.turf_height >= TURF_HEIGHT_BLOCK_THRESHOLD) || isopenspaceturf(dropping_turf))
		if(!dropping_turf.type == /turf/closed)
//			if(user.body_position != LYING_DOWN)
			if(user == dropping)
				dropping.visible_message(span_notice("<b>[user]</b> starts climbing onto [src]"), \
								span_notice("I start climbing onto [src]."))
			else
				dropping.visible_message(span_warning("<b>[user]</b> starts pulling <b>[dropping]</b> onto [src]"), \
									span_notice("I start pulling <b>[dropping]</b> onto <b>[src]</b>."))
			if(do_mob(user, dropping, 2 SECONDS))
				dropping.forceMove(src)
			return

/*
/turf/attack_hand(mob/user, list/modifiers)
	. = ..()
	var/mob/living/living_user = user
	if(istype(living_user) && living_user.client && living_user.movement_locked && living_user.body_position == LYING_DOWN)
		if(living_user.a_intent == INTENT_GRAB)
			if(!living_user.client.Move(src, get_dir(living_user, src)))
				return
			user.visible_message(span_warning("<b>[user]</b> crawls on [src]."), \
								span_warning("I crawl on [src]."))
*/
/*
/obj/structure/stairs/attack_hand(mob/user, list/modifiers)
	. = ..()
	var/mob/living/living_user = user
	if(istype(living_user) && living_user.client && living_user.movement_locked && living_user.body_position == LYING_DOWN)
		if(living_user.a_intent == INTENT_GRAB)
//			if(!living_user.client.Move(src, get_dir(living_user, src)))
//				return
			living_user.changeNext_move(CLICK_CD_WRENCH)
			living_user.Move(get_step(living_user, get_dir(living_user, src)), get_dir(living_user, src))
			user.visible_message(span_warning("<b>[user]</b> crawls on [src]."), \
								span_warning("I crawl on [src]."))
*/
// safe_throw_at(jump_target, range, throw_speed, src, FALSE, callback = CALLBACK(src, .proc/jump_callback))

/turf/handle_fall(mob/faller)
	if(!faller.mob_has_gravity())
		return
	playsound(faller, "modular_septic/sound/effects/collapse[rand(1,5)].ogg", 50, TRUE)
	sound_hint()
	SEND_SIGNAL(src, COMSIG_TURF_MOB_FALL, faller)
/*
/turf/air_update_turf(update = FALSE, remove = FALSE)
	. = ..()
	liquid_update_turf()
*/
/turf/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_ground[rand(1,5)].ogg"

/turf/proc/initialize_clinging()
	if(clingable)
		AddElement(/datum/element/clingable, SKILL_ACROBATICS, 2, clinging_sound)
		return TRUE
	return FALSE
