/obj/item/reagent_containers/blood
	name = "\improper IV bag"
	desc = "An IV bag. Can be attached to a human to slowly transfer it's reagents to their bloodstream. Can also take blood from a human."
	amount_per_transfer_from_this = 0.1
	possible_transfer_amounts = list(0.1, 0.2, 0.5, 1, 2, 5)
	///Who are we sticking our needle in?
	var/mob/living/carbon/attached
	///Are we injecting or sucking?
	var/injecting = FALSE

/obj/item/reagent_containers/blood/Destroy()
	if(attached)
		detach_iv()
	return ..()

/obj/item/reagent_containers/blood/examine(mob/user)
	. = ..()
	. |= bloodpack_examine()

/obj/item/reagent_containers/blood/AltClick(mob/user)
	. = ..()
	if(attached)
		to_chat(user, span_notice("\The IV bag needle is removed from <b>[attached]</b>."))
		detach_iv()

/obj/item/reagent_containers/blood/attack_self_secondary(mob/user)
	. = ..()
	injecting = !injecting
	to_chat(user, span_notice("\The [src] will now [injecting ? "inject" : "take blood from"] the attached patient."))

/obj/item/reagent_containers/blood/update_name(updates)
	. = ..()
	if(labelled)
		return
	name = "\improper IV bag[blood_type ? " - [blood_type]" : null]"

/obj/item/reagent_containers/blood/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(iscarbon(over) && (loc == usr) && isliving(usr) && distance_check(over))
		attach_iv(over, usr)

/obj/item/reagent_containers/blood/process(delta_time)
	if(!attached)
		return PROCESS_KILL

	if(!distance_check(attached))
		attached.visible_message(span_danger("\The IV bag needle is ripped out of <b>[attached]</b>!"), \
								span_userdanger("Ouch! \The IV bag needle is ripped from me!"))
		attached.apply_damage(3, BRUTE, pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM), sharpness = SHARP_POINTY)

		detach_iv()
		return PROCESS_KILL

	return reagent_handling(delta_time)

/obj/item/reagent_containers/blood/proc/reagent_handling(delta_time)
	if(reagents)
		// Inject reagents
		if(injecting)
			if(reagents.total_volume)
				reagents.trans_to(attached, amount_per_transfer_from_this * delta_time * 0.5, methods = INJECT, show_message = FALSE) //make reagents reacts, but don't spam messages
				update_appearance()
		// Take blood
		else
			var/amount = reagents.maximum_volume - reagents.total_volume
			amount = min(amount, amount_per_transfer_from_this) * 0.5 * delta_time

			attached.transfer_blood_to(src, amount_per_transfer_from_this)
			update_appearance()

/obj/item/reagent_containers/blood/proc/bloodpack_examine(mob/user)
	. = list()
	. += span_notice("Currently in [injecting ? "injection" : "extraction"] mode.")
	if(attached)
		. += span_notice("Currently [injecting ? "injecting" : "taking blood from"] <b>[attached]</b>.")

/obj/item/reagent_containers/blood/proc/distance_check(mob/living/target)
	. = TRUE
	if(!(get_dist(loc, target) <= 1) || !isturf(target.loc) || !isliving(loc))
		return FALSE

/obj/item/reagent_containers/blood/proc/attach_iv(mob/living/target, mob/user)
	SEND_SIGNAL(src, COMSIG_IV_ATTACH, target)
	user.visible_message(span_warning("<b>[user]</b> attaches [src] to [target]."), \
					span_notice("I attach [src] to [target]."))
	log_combat(user, target, "attached", src, "containing: ([reagents.log_list()])")
	add_fingerprint(user)
	attached = target
	START_PROCESSING(SSobj, src)

	update_appearance()

/obj/item/reagent_containers/blood/proc/detach_iv()
	SEND_SIGNAL(src, COMSIG_IV_DETACH, attached)

	attached = null
	STOP_PROCESSING(SSobj, src)
	update_appearance()
