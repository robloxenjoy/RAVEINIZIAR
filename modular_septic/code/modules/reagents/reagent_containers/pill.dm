/obj/item/reagent_containers/pill/attack(mob/M, mob/user, def_zone)
	if(!canconsume(M, user))
		return FALSE

	if(M == user)
		M.visible_message(span_notice("[user] attempts to [apply_method] [src]."))
		if(self_delay)
			if(!do_mob(user, M, self_delay))
				return FALSE
		to_chat(M, span_notice("I [apply_method] [src]."))
		playsound(src, 'modular_septic/sound/effects/pill_swallow.wav', volume, TRUE, vary = FALSE)

	else
		M.visible_message(span_danger("[user] attempts to force [M] to [apply_method] [src]."), \
							span_userdanger("[user] attempts to force you to [apply_method] [src]."))
		if(!do_mob(user, M, CHEM_INTERACT_DELAY(3 SECONDS, user)))
			return FALSE
		M.visible_message(span_danger("[user] forces [M] to [apply_method] [src]."), \
							playsound(src, 'modular_septic/sound/effects/pill_swallow.wav', volume, TRUE, vary = FALSE), \
							span_userdanger("[user] forces you to [apply_method] [src]."))

	return on_consumption(M, user)

/obj/item/reagent_containers/pill/multiver
	name = "charcoal pill"
	desc = "Neutralizes many common toxins."
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 10)

/obj/item/reagent_containers/pill/probital
	name = "dicorderal pill"
	desc = "Used to treat brute and burn damage of minor and moderate severity."
	list_reagents = list(/datum/reagent/medicine/c2/probital = 10)

/obj/item/reagent_containers/pill/carbonylmethamphetamine
	name = "white tablet"
	desc = "Tasty, chewable flintstones vitamens, clearly."
	icon = 'modular_septic/icons/obj/items/firstaid.dmi'
	icon_state = "pep-pill"
	list_reagents = list(/datum/reagent/drug/carbonylmethamphetamine = 20)
	apply_method = "chew"
