/obj/effect/decal/cleanable/can_bloodcrawl_in()
	if(blood_state in list(BLOOD_STATE_HUMAN, BLOOD_STATE_XENO))
		return bloodiness
	return 0

/obj/effect/decal/cleanable/blood/gibs
	var/nice_noises = list('modular_septic/sound/gore/fleshstep1.ogg', 'modular_septic/sound/gore/fleshstep2.ogg', 'modular_septic/sound/gore/fleshstep3.ogg')

/obj/effect/decal/cleanable/blood/gibs/on_entered(datum/source, atom/movable/L)
	if(isliving(L) && has_gravity(loc))
		playsound(loc, nice_noises, HAS_TRAIT(L, TRAIT_LIGHT_STEP) ? 20 : 50, TRUE)
	. = ..()
