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
	drop_sound = list('modular_septic/sound/effects/syringe_drop1.ogg', 'modular_septic/sound/effects/syringe_drop2.ogg')

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
		to_chat(user, span_warning("[src] is empty!"))
		return

	if(!isliving(target) && !target.is_injectable(user))
		to_chat(user, span_warning("Не могу это сделать с [target]!"))
		return

	if(target.reagents.total_volume >= target.reagents.maximum_volume)
		to_chat(user, span_notice("[target] полно."))
		return

	if(isliving(target))
		var/mob/living/living_target = target
		if(!living_target.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))
			return
		if(living_target != user)
			living_target.visible_message(span_danger("[user] пытается уколоть [living_target]!"), \
									span_userdanger("[user] пытается уколоть меня!"))
			if(!do_mob(user, living_target, CHEM_INTERACT_DELAY(3 SECONDS, user), extra_checks = CALLBACK(living_target, /mob/living/proc/try_inject, user, null, INJECT_TRY_SHOW_ERROR_MESSAGE)))
				return
			if(!reagents.total_volume)
				return
			if(living_target.reagents.total_volume >= living_target.reagents.maximum_volume)
				return
			living_target.visible_message(span_danger("[user] колит [living_target] с помощью [src]"), \
							span_userdanger("[user] колит меня с помощью [src]!"))

		if (living_target == user)
			living_target.log_message("injected themselves ([contained]) with [name]", LOG_ATTACK, color="orange")
		else
			log_combat(user, living_target, "injected", src, addition="which had [contained]")
	reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user, methods = INJECT)
	to_chat(user, span_notice("Я колю [amount_per_transfer_from_this] юнитов. Теперь, [src] содержит [reagents.total_volume] юнитов."))
	playsound(src, 'modular_septic/sound/effects/syringe_success.ogg',	60, FALSE)

/obj/item/reagent_containers/syringe/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	if (!try_syringe(target, user, proximity_flag))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src] полно."))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(isliving(target))
		var/mob/living/living_target = target
		var/drawn_amount = reagents.maximum_volume - reagents.total_volume
		if(target != user)
			target.visible_message(span_danger("[user] пытается взять кровь у [target]!"), \
							span_userdanger("[user] пытается взять кровь у меня!"))
			busy = TRUE
			if(!do_mob(user, target, CHEM_INTERACT_DELAY(3 SECONDS, user), extra_checks = CALLBACK(living_target, /mob/living/proc/try_inject, user, null, INJECT_TRY_SHOW_ERROR_MESSAGE)))
				busy = FALSE
				return SECONDARY_ATTACK_CONTINUE_CHAIN
			if(reagents.total_volume >= reagents.maximum_volume)
				return SECONDARY_ATTACK_CONTINUE_CHAIN
		busy = FALSE
		if(living_target.transfer_blood_to(src, drawn_amount))
			user.visible_message(span_notice("[user] берёт кровь у [living_target]."))
			playsound(src, 'modular_septic/sound/effects/syringe_extract.ogg', volume, TRUE, vary = FALSE)
		else
			to_chat(user, span_warning("Не могу взять кровь у [living_target]!"))
	else
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty!"))
			return SECONDARY_ATTACK_CONTINUE_CHAIN

		if(!target.is_drawable(user))
			to_chat(user, span_warning("Не могу взять реагенты из [target]!"))
			return SECONDARY_ATTACK_CONTINUE_CHAIN

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user) // transfer from, transfer to - who cares?

		to_chat(user, span_notice("Я наполняю [src] с помощью [trans] юнитов. Теперь, [src] содержит [reagents.total_volume] юнитов."))
		playsound(src, 'modular_septic/sound/effects/syringe_extract.ogg', 60, FALSE)

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
	name = "Шприц (копиум)"
	desc = "По сути, содержит копиум."
	custom_premium_price = PAYCHECK_HARD * 3
	list_reagents = list(/datum/reagent/medicine/copium = 15)

/obj/item/reagent_containers/syringe/morphine
	name = "Шприц (морфин)"
	desc = "По сути, содержит морфин."
	list_reagents = list(/datum/reagent/medicine/morphine = 15)
