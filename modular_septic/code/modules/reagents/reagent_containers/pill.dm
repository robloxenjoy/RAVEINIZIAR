/obj/item/reagent_containers/pill/attack(mob/M, mob/user, def_zone)
	if(!canconsume(M, user))
		return FALSE

	if(M == user)
		M.visible_message(span_notice("[user] пытается [apply_method] [src]."))
		if(self_delay)
			if(!do_mob(user, M, self_delay))
				return FALSE
		to_chat(M, span_notice("Я [apply_method] [src]."))
		playsound(src, 'modular_septic/sound/effects/pill_swallow.ogg', volume, TRUE, vary = FALSE)

	else
		M.visible_message(span_danger("[user] пытается заставить [M] [apply_method] [src]."), \
							span_userdanger("[user] пытается заставить меня [apply_method] [src]."))
		if(!do_mob(user, M, CHEM_INTERACT_DELAY(3 SECONDS, user)))
			return FALSE
		M.visible_message(span_danger("[user] заставляет [apply_method] [M] [src]."), \
							playsound(src, 'modular_septic/sound/effects/pill_swallow.ogg', volume, TRUE, vary = FALSE), \
							span_userdanger("[user] заставляет [apply_method] [src]."))

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
	name = "White Tablet"
	desc = "Surely useful."
	icon = 'modular_septic/icons/obj/items/firstaid.dmi'
	icon_state = "pep-pill"
	list_reagents = list(/datum/reagent/drug/carbonylmethamphetamine = 20)
	apply_method = "жевать"

/obj/item/reagent_containers/pill/crocin
	name = "crocin pill"
	desc = "I've fallen, and I can't get it up!"
	icon_state = "pill10"
	list_reagents = list(/datum/reagent/drug/aphrodisiac = 10)

/obj/item/reagent_containers/pill/hexacrocin
	name = "hexacrocin pill"
	desc = "It has a creepy smiling face on it."
	icon_state = "pill_happy"
	list_reagents = list(/datum/reagent/drug/aphrodisiacplus = 10)

/obj/item/reagent_containers/pill/camphor
	name = "camphor pill"
	desc = "For the early bird."
	icon_state = "pill0"
	list_reagents = list(/datum/reagent/drug/anaphrodisiac = 10)
