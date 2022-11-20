/obj/item/reagent_containers/syringe
	name = "syringe"
	desc = "A pointy needle attached to a shakey plunger - This is a professional tool for stabbing someone into the elbow and needlessly scraping into their bone multiple times before injecting the intravenous drug intramuscularly."
	icon = 'modular_septic/icons/obj/items/syringe.dmi'
	base_icon_state = "syringe"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "syringe-0"
	icon_state = "syringe_0"
	worn_icon_state = "pen"
	drop_sound = list('modular_septic/sound/effects/syringe_drop1.wav', 'modular_septic/sound/effects/syringe_drop2.wav')

/obj/item/reagent_containers/syringe/update_overlays()
	. = ..()
	if(reagents?.total_volume)
		var/mutable_appearance/filling_overlay = mutable_appearance('modular_septic/icons/obj/reagentfillings.dmi', "syringe[get_rounded_vol()]")
		filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling_overlay

/obj/item/reagent_containers/syringe/afterattack(atom/target, mob/user, proximity)
	. = ..()

	if (!try_syringe(target, user, proximity))
		return

	var/contained = reagents.log_list()
	log_combat(user, target, "attempted to inject", src, addition="which had [contained]")

	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] is empty! Right-click to draw."))
		return

	if(!isliving(target) && !target.is_injectable(user))
		to_chat(user, span_warning("You cannot directly fill [target]!"))
		return

	if(target.reagents.total_volume >= target.reagents.maximum_volume)
		to_chat(user, span_notice("[target] is full."))
		return

	if(isliving(target))
		var/mob/living/living_target = target
		if(!living_target.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))
			return
		if(living_target != user)
			living_target.visible_message(span_danger("[user] is trying to inject [living_target]!"), \
									span_userdanger("[user] is trying to inject you!"))
			if(!do_mob(user, living_target, CHEM_INTERACT_DELAY(3 SECONDS, user), extra_checks = CALLBACK(living_target, /mob/living/proc/try_inject, user, null, INJECT_TRY_SHOW_ERROR_MESSAGE)))
				return
			if(!reagents.total_volume)
				return
			if(living_target.reagents.total_volume >= living_target.reagents.maximum_volume)
				return
			living_target.visible_message(span_danger("[user] injects [living_target] with the syringe!"), \
							span_userdanger("[user] injects you with the syringe!"))

		if (living_target == user)
			living_target.log_message("injected themselves ([contained]) with [name]", LOG_ATTACK, color="orange")
		else
			log_combat(user, living_target, "injected", src, addition="which had [contained]")
	reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user, methods = INJECT)
	to_chat(user, span_notice("You inject [amount_per_transfer_from_this] units of the solution. The syringe now contains [reagents.total_volume] units."))
	playsound(src, 'modular_septic/sound/effects/syringe_success.wav',	60, FALSE)

/obj/item/reagent_containers/syringe/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	if (!try_syringe(target, user, proximity_flag))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src] is full."))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(isliving(target))
		var/mob/living/living_target = target
		var/drawn_amount = reagents.maximum_volume - reagents.total_volume
		if(target != user)
			target.visible_message(span_danger("[user] is trying to take a blood sample from [target]!"), \
							span_userdanger("[user] is trying to take a blood sample from you!"))
			busy = TRUE
			if(!do_mob(user, target, CHEM_INTERACT_DELAY(3 SECONDS, user), extra_checks = CALLBACK(living_target, /mob/living/proc/try_inject, user, null, INJECT_TRY_SHOW_ERROR_MESSAGE)))
				busy = FALSE
				return SECONDARY_ATTACK_CONTINUE_CHAIN
			if(reagents.total_volume >= reagents.maximum_volume)
				return SECONDARY_ATTACK_CONTINUE_CHAIN
		busy = FALSE
		if(living_target.transfer_blood_to(src, drawn_amount))
			user.visible_message(span_notice("[user] takes a blood sample from [living_target]."))
			playsound(src, 'modular_septic/sound/effects/syringe_extract.wav', volume, TRUE, vary = FALSE)
		else
			to_chat(user, span_warning("You are unable to draw any blood from [living_target]!"))
	else
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty!"))
			return SECONDARY_ATTACK_CONTINUE_CHAIN

		if(!target.is_drawable(user))
			to_chat(user, span_warning("You cannot directly remove reagents from [target]!"))
			return SECONDARY_ATTACK_CONTINUE_CHAIN

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user) // transfer from, transfer to - who cares?

		to_chat(user, span_notice("You fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))
		playsound(src, 'modular_septic/sound/effects/syringe_extract.wav', 60, FALSE)

	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/reagent_containers/syringe/multiver
	name = "syringe (charcoal)"
	desc = "Contains charcoal."
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 15)

/obj/item/reagent_containers/syringe/syriniver
	name = "syringe (dylovenal)"
	desc = "Contains dylovenal."
	list_reagents = list(/datum/reagent/medicine/c2/syriniver = 15)

/obj/item/reagent_containers/syringe/minoxidil
	name = "syringe (minoxidil)"
	desc = "Contains minoxidil."
	list_reagents = list(/datum/reagent/medicine/c2/penthrite = 15)

/obj/item/reagent_containers/syringe/convermol
	name = "syringe (formoterol)"
	desc = "Contains formoterol."
	list_reagents = list(/datum/reagent/medicine/c2/convermol = 15)

/obj/item/reagent_containers/syringe/tirimol
	name = "syringe (tirimol)"
	desc = "Contains tirimol."
	list_reagents = list(/datum/reagent/medicine/c2/tirimol = 15)

/obj/item/reagent_containers/syringe/antiviral
	name = "penicillin syringe"
	desc = "Contains a common antibiotic, penicilin."
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 15)

/obj/item/reagent_containers/syringe/copium
	name = "syringe (copium)"
	desc = "Contains copium.\
			\n<b>Do not inject more or equal to 15u at once.</b>"
	custom_premium_price = PAYCHECK_HARD * 3
	list_reagents = list(/datum/reagent/medicine/copium = 15)

/obj/item/reagent_containers/syringe/morphine
	name = "syringe (morphine)"
	desc = "Contains morphine."
	list_reagents = list(/datum/reagent/medicine/morphine = 15)
