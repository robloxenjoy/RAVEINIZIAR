/obj/effect/decal/cleanable/blood
	name = "blood"
	desc = "It's red and gooey."
	icon = 'modular_septic/icons/effects/blood.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", \
						"floor7", "floor8", "floor9", "floor10", "floor11", "floor12")

/obj/effect/decal/cleanable/blood/drip/update_icon_state()
	. = ..()
	if(drips > 5)
		icon_state = "bigdrip[rand(1, 4)]"

/obj/effect/decal/cleanable/blood/footprints
	icon = 'modular_septic/icons/effects/blood_footprints.dmi'

/obj/effect/decal/cleanable/blood/footprints/can_bloodcrawl_in()
	if(blood_state in list(BLOOD_STATE_HUMAN, BLOOD_STATE_XENO))
		return TRUE
	return FALSE

/obj/effect/decal/cleanable/trail_holder
	beauty = 0
	var/datum/weakref/next_trail
	var/datum/weakref/previous_trail
	var/last_dir = 0

/obj/effect/decal/cleanable/trail_holder/Destroy()
	. = ..()
	previous_trail = null

/obj/effect/decal/cleanable/trail_holder/can_bloodcrawl_in()
	return LAZYLEN(existing_dirs)
