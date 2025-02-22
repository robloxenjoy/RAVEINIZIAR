/turf/closed
	plane = GAME_PLANE
	layer = CLOSED_TURF_LAYER
	upper_frill_plane = FRILL_PLANE
	upper_frill_layer = ABOVE_MOB_LAYER
	lower_frill_plane = GAME_PLANE_ABOVE_WINDOW
	lower_frill_layer = ABOVE_DOOR_LAYER
	var/powerwall = 10
	var/dangerwall = 5

/turf/closed/on_rammed(mob/living/carbon/rammer)
	rammer.ram_stun()
	var/smash_sound = pick('modular_septic/sound/gore/smash1.ogg',
						'modular_septic/sound/gore/smash2.ogg',
						'modular_septic/sound/gore/smash3.ogg')
	playsound(src, smash_sound, 75)
	rammer.sound_hint()
	sound_hint()

/turf/closed/attackby(obj/item/W, mob/living/carbon/user, params)
	. = ..()
	if(.)
		return

	if(user.a_intent == INTENT_GRAB)
		if(istype(W, /obj/item/grab))
			var/obj/item/grab/G = W
			if(G.grasped_part?.body_zone == BODY_ZONE_PRECISE_FACE)
				var/mob/living/GR = user.pulling
				if(GR == null)
					return
				if(GR.body_position == STANDING_UP)
					var/obj/item/bodypart/head = GR.get_bodypart(BODY_ZONE_HEAD)
					var/damage = ((GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/2) + src?.powerwall)
					GR.visible_message(span_pinkdang("[user] бьёт [GR] головой об [src]!"))
					head.receive_damage(brute = damage, wound_bonus = dangerwall, sharpness = null)
					user.changeNext_move(CLICK_CD_GRABBING)
					user.adjustFatigueLoss(10)
					playsound(get_turf(GR), 'modular_pod/sound/eff/punch 1.ogg', 80, 0)
/*
/turf/closed/attack_hand(mob/user, list/modifiers)
	. = ..()
	var/mob/living/living_user = user
	if(istype(living_user) && living_user.client && living_user.movement_locked && living_user.body_position == LYING_DOWN)
		if(living_user.a_intent == INTENT_GRAB)
			living_user.changeNext_move(CLICK_CD_WRENCH)
			living_user.Move(get_step(living_user, get_dir(living_user, src)), get_dir(living_user, src))
			user.visible_message(span_warning("<b>[user]</b> crawls on [src]."), \
								span_warning("I crawl on [src]."))
*/
