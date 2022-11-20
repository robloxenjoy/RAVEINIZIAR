#define SPENDILIZER_RETRACTED 1
#define SPENDILIZER_RETRACTING 2
#define SPENDILIZER_EXTENDED 3
#define SPENDILIZER_EXTENDING 4

/obj/machinery/resupply_puta
	name = "\improper Atire-Putas"
	desc = "A machine with coursing wires filled with a red substance, containing all you need to keep you going. Has a label explaining everything you need to know about the functions. <span_class='boldwarning'>Just look twice.</span>"
	icon = 'modular_septic/icons/obj/machinery/resupply_puta.dmi'
	icon_state = "new_wallputa"
	base_icon_state = "new_wallputa"
	light_range = 3
	light_power = 1.8
	light_color = "#820000"
	density = FALSE
	var/resupply_stacks = 4
	var/max_resupply_stacks = 4
	var/resupply_rounds = 120
	var/max_resupply_rounds = 120
	var/medical_items = 5
	var/max_medical_items = 5
	var/spendilizer_state = SPENDILIZER_EXTENDED
	var/state_flags = RESUPPLY_READY
	var/list/dispensible_stacks = list(/obj/item/ammo_box/magazine/ammo_stack/shotgun/bolas/loaded,
									/obj/item/ammo_box/magazine/ammo_stack/shotgun/bolas/slugs/loaded,
									/obj/item/ammo_box/magazine/ammo_stack/shotgun/loaded,
									/obj/item/ammo_box/magazine/ammo_stack/shotgun/slugs/loaded,
									/obj/item/ammo_box/magazine/ammo_stack/a276/loaded,
									/obj/item/ammo_box/magazine/ammo_stack/c38/loaded,
									/obj/item/ammo_box/magazine/ammo_stack/c38/pluspee/loaded,
									/obj/item/ammo_box/magazine/ammo_stack/a357/loaded,
									/obj/item/ammo_box/magazine/ammo_stack/a500/loaded)
	var/list/dispensible_medical = list(/obj/item/scalpel,
										/obj/item/reagent_containers/syringe/antiviral,
										/obj/item/stack/medical/ointment,
										/obj/item/stack/medical/gauze,
										/obj/item/reagent_containers/pill/potassiodide,
										/obj/item/stack/medical/suture/medicated)
	var/list/stack_type_to_name = list()
	var/list/medical_stack_type_to_name = list()
	var/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/captagon
	var/obj/item/gun/ballistic/revolver/remis/nova/pluspee/nova = /obj/item/gun/ballistic/revolver/remis/nova

/obj/machinery/resupply_puta/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSkillbitches, src)
	if(prob(50))
		nova = new nova(src)
	else
		nova = null
	name = "\proper [random_adjective()] ([rand(0,9)][rand(0,9)]) [initial(name)]"
	become_hearing_sensitive(trait_source = INNATE_TRAIT)

	//Generate dispensible list
	var/obj/item/dispensable_item
	for(var/dispensable_type as anything in dispensible_stacks)
		dispensable_item = dispensable_type
		stack_type_to_name[dispensable_type] = initial(dispensable_item.name)

	var/obj/item/dispensable_medical_item
	for(var/dispensable_medical_type as anything in dispensible_medical)
		dispensable_medical_item = dispensable_medical_type
		medical_stack_type_to_name[dispensable_medical_type] = initial(dispensable_medical_item.name)

/obj/machinery/resupply_puta/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods)
	. = ..()
	if(get_dist(src, speaker) >= 2)
		return
	for(var/typepath in stack_type_to_name)
		var/stack_name = stack_type_to_name[typepath]
		if(findtext(lowertext(message), lowertext(stack_name)))
			if(resupply_stacks <= 0)
				audible_message("[icon2html(src, world)] [src] [verb_say], \"I'm empty on indevidual stacks, try again later.\"")
				playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
				return
			playsound(src, 'modular_septic/sound/efn/resupply/resupply_vomit.ogg', 45, FALSE)
			new typepath(get_turf(src))
			resupply_stacks--
	for(var/medical_typepath in medical_stack_type_to_name)
		var/medical_stack_name = medical_stack_type_to_name[medical_typepath]
		if(findtext(lowertext(message), lowertext(medical_stack_name)))
			if(medical_items <= 0)
				audible_message("[icon2html(src, world)] [src] [verb_say], \"I'm empty on medical supplies, try again later.\"")
				playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
				return
			playsound(src, 'modular_septic/sound/efn/resupply/resupply_vomit.ogg', 45, FALSE)
			new medical_typepath(get_turf(src))
			medical_items--

/obj/machinery/resupply_puta/Destroy()
	. = ..()
	STOP_PROCESSING(SSkillbitches, src)

/obj/machinery/resupply_puta/update_overlays()
	. = ..()
	if(!(state_flags & RESUPPLY_READY || state_flags & RESUPPLY_JUST_FILLED))
		. += "[base_icon_state]_notready"
	else if(state_flags & RESUPPLY_JUST_FILLED)
		. += "[base_icon_state]_filled"
	switch(spendilizer_state)
		if(SPENDILIZER_RETRACTED)
			. += "[base_icon_state]_spendilizer_in"
		if(SPENDILIZER_RETRACTING)
			. += "[base_icon_state]_spendilizer_inner"
		if(SPENDILIZER_EXTENDED)
			. += "[base_icon_state]_spendilizer"
		if(SPENDILIZER_EXTENDING)
			. += "[base_icon_state]_spendilizer_outer"

/obj/machinery/resupply_puta/examine(mob/user)
	. = ..()
	. += span_info("Apply a magazine to the spendilizer to refill with bullets.")
	. += span_info("Insert a Captagon Medipen and press the button on the right side to refill with black tar fluid.")

	var/medical_message_composed = "<span class='info'><div class='infobox'>[src] contains medical items:"
	for(var/medical_type in medical_stack_type_to_name)
		var/medical_name = medical_stack_type_to_name[medical_type]
		medical_message_composed += "\n[medical_name]"
	medical_message_composed += "</div>"
	. += medical_message_composed

	var/stack_message_composed = "<span class='info'><div class='infobox'>[src] contains indevidual stack items:"
	for(var/stack_type in stack_type_to_name)
		var/stack_name = stack_type_to_name[stack_type]
		stack_message_composed += "\n[stack_name]"
	stack_message_composed += "</div></span>"
	. += stack_message_composed

	if(state_flags & RESUPPLY_READY)
		. += span_info("It [p_are()] <b>ready</b> to undergo any function.")
	else
		. += span_warning("It [p_are()] currently <span_class='boldwarning'>unavailable.</span>")
	if(resupply_stacks >= 0)
		. += span_info("It contains <b>[resupply_stacks]</b> out of <b>[max_resupply_stacks]</b> resupply stacks.")
	else
		. += span_boldwarning("It has no resupply stacks at the moment.")
	if(resupply_rounds >= 0)
		. += span_info("It contains <b>[resupply_rounds]</b> out of <b>[max_resupply_rounds]</b> resupply rounds for loading magazines.")
	else
		. += span_boldwarning("It has no resupply rounds at the moment.")
	if(medical_items >= 0)
		. += span_info("It contains <b>[medical_items]</b> out of <b>[max_medical_items]</b> medical supplies.")
	else
		. += span_boldwarning("It has no medical supplies at the moment.")


/obj/machinery/resupply_puta/examine_more(mob/user)
	. = list()
	. += span_infoplain("[src] has two functions.")
	. += span_info(span_alert("The wire on the bottom is called a spendilizer, It can reload magazines by just pressing the wire into the magazine feed all the way to the bottom."))
	. += span_info(span_alert("There's way to get slugs, buckshot, stacks of revolver ammunition, and medical supplies simply stand near the machine and say the correct words."))
	. += span_info(span_alert("There's a slot for Captagon's, just place it inside and press the RIGHT (RMB) button to refill it."))

/obj/machinery/resupply_puta/process(delta_time)
	if(!(state_flags & RESUPPLY_READY))
		return
	var/sputtering = pick("sputters.", "garbles.", "clunks.", "cries.", "cranks.", "bangs.")
	if(DT_PROB(10, delta_time) && resupply_stacks < max_resupply_stacks)
		resupply_stacks++
		audible_message("[icon2html(src, world)] [src] " + span_bolddanger("[sputtering]"))
		playsound(src, list('modular_septic/sound/efn/resupply/garble1.ogg', 'modular_septic/sound/efn/resupply/garble2.ogg'), 65, FALSE)
	if(DT_PROB(5, delta_time) && resupply_rounds < max_resupply_rounds)
		var/added_rounds = 30
		if(resupply_rounds > 90)
			added_rounds = max_resupply_rounds - resupply_rounds
		resupply_rounds += added_rounds
		audible_message("[icon2html(src, world)] [src] " + span_bolddanger("[sputtering]"))
		playsound(src, list('modular_septic/sound/efn/resupply/garble1.ogg', 'modular_septic/sound/efn/resupply/garble2.ogg'), 55, FALSE)
	if(DT_PROB(3, delta_time) && medical_items < max_medical_items)
		medical_items++
		audible_message("[icon2html(src, world)] [src] " + span_bolddanger("[sputtering]"))
		playsound(src, list('modular_septic/sound/efn/resupply/garble1.ogg', 'modular_septic/sound/efn/resupply/garble2.ogg'), 55, FALSE)

/obj/machinery/resupply_puta/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!(state_flags & RESUPPLY_READY))
		var/doingitsthing = "It's doing It's thing!"
		if(prob(5))
			doingitsthing = "It's a fucking lawyer!"
		to_chat(user, span_notice("[doingitsthing]"))
		return
	if(!captagon)
		to_chat(user, span_warning("Nothing!"))
		return
	else if(captagon)
		begin_refill_captagon()
		return

/obj/machinery/resupply_puta/attack_hand_tertiary(mob/living/user, list/modifiers)
	. = ..()
	if(!nova)
		to_chat(user, span_warning("There's no bright shiny gift for me today."))
		return
	else
		to_chat(user, span_green("There was a bright shiny gift!"))
		user.transferItemToLoc(nova, user.loc)
		user.put_in_hands(nova)
		nova = null

/obj/machinery/resupply_puta/attackby(obj/item/weapon, mob/user, params)
	if(!(state_flags & RESUPPLY_READY))
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	if(istype(weapon, /obj/item/reagent_containers/hypospray/medipen/retractible/blacktar))
		if(captagon)
			to_chat(user, span_warning("There's already something in the goddamn slot."))
			return
		user.transferItemToLoc(weapon, src)
		captagon = weapon
		user.visible_message(span_danger("[user] inserts the [weapon] into the [src]'s liquid refilling slot."), \
					span_danger("I insert \the [weapon] into [src]'s liquid refilling slot."))
		playsound(src, 'modular_septic/sound/efn/resupply/insert.ogg', 35, FALSE)
		return
	if(istype(weapon, /obj/item/ammo_box/magazine))
		INVOKE_ASYNC(src, .proc/spendilize, user, weapon)
		return
	. = ..()

/obj/machinery/resupply_puta/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!(state_flags & RESUPPLY_READY))
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	if(!do_after(user, 1 SECONDS, target = src))
		var/retarded = pick("Retarded.", "Fucking stupid.", "Fucked up.", "I'm a fucking lawyer.")
		to_chat(user, span_bolddanger("[retarded]"))
		return
	if(captagon)
		user.transferItemToLoc(user, captagon)
		user.put_in_hands(captagon)
		to_chat(user, span_notice("I take the [captagon] out of the machine."))
		playsound(src, 'modular_septic/sound/efn/resupply/desert.ogg', 40, FALSE)
		if(state_flags & RESUPPLY_JUST_FILLED && prob(8))
			var/addict_message = list("I'm addicted...", "I'm so fucking gross...", "This IS poison, I'm putting poison inside of MY body...", "It's not MY blood...")
			to_chat(user, span_warning(addict_message))
			state_flags &= ~RESUPPLY_JUST_FILLED
			update_appearance(UPDATE_ICON)
		captagon = null

/obj/machinery/resupply_puta/proc/spendilize(mob/user, obj/item/ammo_box/magazine)
	if(!(state_flags & RESUPPLY_READY))
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	if(resupply_rounds == 0)
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		audible_message("[icon2html(src, world)] [src] [verb_say], \"I'm empty, try again later.\"")
		return
	var/obj/item/ammo_box/magazine/AM = magazine
	if(length(magazine.stored_ammo) == magazine.max_ammo)
		var/tasty_bullets = pick("delicious morsels", "brave warriors", "tasty bullets", "yummy rounds", "scheming lawyers")
		var/not_any_more = pick("you can't add any more!", "you just can't do that!", "you just don't understand!", "you're a fool!", "you're a fucking lawyer!")
		audible_message("[icon2html(src, world)] [src] [verb_say], \"The [magazine] is filled to the brim with [tasty_bullets], [not_any_more]\"")
		sound_hint()
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	state_flags &= ~RESUPPLY_READY
	update_appearance(UPDATE_ICON)
	to_chat(user, span_notice("I begin the spendilization process."))
	needles_in()
	while(length(magazine.stored_ammo) < magazine.max_ammo)
		var/newbullet = magazine.ammo_type
		if(!usr.Adjacent(src) || resupply_rounds == 0)
			playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
			state_flags |= RESUPPLY_READY
			needles_out()
			return
		sleep(2)
		magazine.give_round(new newbullet(), TRUE)
		resupply_rounds--
		magazine.update_ammo_count()
		to_chat(user, span_notice("Loading..."))
		playsound(src, AM.bullet_load, 60, TRUE)
	needles_out()
	playsound(src, 'modular_septic/sound/efn/resupply/ticking.ogg', 65, FALSE)
	addtimer(CALLBACK(src, .proc/donehere), 6)

/obj/machinery/resupply_puta/proc/begin_refill_captagon(mob/user)
	if(!captagon) // NO CAPTAGON?
		return
	playsound(src, 'modular_septic/sound/efn/resupply/buttonpress.ogg', 65, FALSE)
	if(captagon.reagent_holder_right.total_volume && captagon.reagent_holder_left.total_volume)
		to_chat(user, span_warning("Both vials are full!"))
		return
	playsound(src, 'modular_septic/sound/efn/resupply/liquid_fill.ogg', 35, FALSE)
	state_flags &= ~RESUPPLY_READY
	addtimer(CALLBACK(src, .proc/finalize_refill_captagon), 3 SECONDS)

/obj/machinery/resupply_puta/proc/finalize_refill_captagon()
	var/left_vial_check = FALSE
	var/right_vial_check = FALSE
	while(captagon.reagent_holder_right.maximum_volume > captagon.reagent_holder_right.total_volume)
		right_vial_check = TRUE
		if(!captagon) //Fucking idiot=...,, you have no catagon
			right_vial_check = FALSE
			break
		captagon.reagent_holder_right.add_reagent(/datum/reagent/medicine/blacktar, 2)
		captagon.reagent_holder_right.add_reagent(/datum/reagent/medicine/c2/helbital, 1)
	while(captagon.reagent_holder_left.maximum_volume > captagon.reagent_holder_left.total_volume)
		left_vial_check = TRUE
		if(!captagon) //Stupifd rtetard... no ufcking captagon idiot
			left_vial_check = FALSE
			break
		captagon.reagent_holder_left.add_reagent(/datum/reagent/medicine/blacktar, 2)
		captagon.reagent_holder_left.add_reagent(/datum/reagent/medicine/c2/helbital, 1)
	if(right_vial_check)
		audible_message("[icon2html(src, world)] [src] [verb_say], \"Right vial has been filled.\"")
		captagon.reagent_holder_right.flags = initial(captagon.reagent_holder_right.flags)
	if(left_vial_check)
		audible_message("[icon2html(src, world)] [src] [verb_say], \"Left vial has been filled.\"")
		captagon.reagent_holder_left.flags = initial(captagon.reagent_holder_left.flags)
	captagon.update_appearance(UPDATE_ICON)
	state_flags |= RESUPPLY_READY
	playsound(src, 'modular_septic/sound/efn/captagon/heroin_fill.ogg', 65, FALSE)


/obj/machinery/resupply_puta/proc/donehere(mob/user)
	state_flags |= RESUPPLY_READY
	update_appearance(UPDATE_ICON)
	var/yep = pick("Yep", "Yessir", "Alright", "Okay", "Great", "Finally", "Mhm", "It's over")
	audible_message("[icon2html(src, world)] [src] [verb_say], \"[yep], we're done here.\"")
	sound_hint()
	playsound(src, 'modular_septic/sound/efn/resupply/success.ogg', 65, FALSE)

/obj/machinery/resupply_puta/proc/needles_out()
	spendilizer_state = SPENDILIZER_EXTENDING
	update_appearance(UPDATE_ICON)
	sleep(3)
	spendilizer_state = SPENDILIZER_EXTENDED
	update_appearance(UPDATE_ICON)

/obj/machinery/resupply_puta/proc/needles_in()
	spendilizer_state = SPENDILIZER_RETRACTING
	update_appearance(UPDATE_ICON)
	sleep(3)
	spendilizer_state = SPENDILIZER_RETRACTED
	update_appearance(UPDATE_ICON)

/obj/machinery/resupply_puta/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/machinery/resupply_puta/directional/east
	dir = WEST
	pixel_x = 32

/obj/machinery/resupply_puta/directional/west
	dir = EAST
	pixel_x = -32

#undef SPENDILIZER_RETRACTED
#undef SPENDILIZER_RETRACTING
#undef SPENDILIZER_EXTENDED
#undef SPENDILIZER_EXTENDING
