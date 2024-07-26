/mob/living/carbon/examine(mob/user)
	//hehe
	if(user.zone_selected in list(BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE))
		user.handle_eye_contact(src)

	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()
	var/obscured = check_obscured_slots()

	. = list()
	. += "<span class='infoplain'><div class='infobox'><span class='info'>Ой, а это [icon2html(src, user)] <EM>[src]</EM>!</span>"

	. += "<span class='info'>"
	if(handcuffed && !(obscured & ITEM_SLOT_HANDCUFFED) && !(handcuffed.item_flags & EXAMINE_SKIP) && !(handcuffed.item_flags & EXAMINE_SKIP))
		. += "<span class='warning'>[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed with [handcuffed]!</span>"
	if(head && !(obscured & ITEM_SLOT_HEAD) && !(head.item_flags & EXAMINE_SKIP) && !(head.item_flags & ABSTRACT))
		. += "[t_He] [t_is] wearing [head.get_examine_string(user)] on [t_his] head. "
	if(wear_mask && !(obscured & ITEM_SLOT_MASK) && !(wear_mask.item_flags & EXAMINE_SKIP) && !(wear_mask.item_flags & ABSTRACT))
		. += "[t_He] [t_is] wearing [wear_mask.get_examine_string(user)] on [t_his] face."
	if(wear_neck && !(obscured & ITEM_SLOT_NECK) && !(wear_neck.item_flags & EXAMINE_SKIP) && !(wear_neck.item_flags & ABSTRACT))
		. += "[t_He] [t_is] wearing [wear_neck.get_examine_string(user)] around [t_his] neck."

	for(var/obj/item/I in held_items)
		if(!(I.item_flags & EXAMINE_SKIP) && !(I.item_flags & ABSTRACT))
			. += "[t_He] [t_is] holding [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	if(back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] on [t_his] back."

	var/list/msg = list("<span class='warning'>")
	var/list/missing = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	var/list/disabled = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(BP.bodypart_disabled)
			disabled += BP
		missing -= BP.body_zone

	for(var/X in disabled)
		var/obj/item/bodypart/BP = X
		var/damage_text
		if(!(BP.get_damage(include_stamina = FALSE) >= BP.max_damage)) //Stamina is disabling the limb
			damage_text = "limp and lifeless"
		else
			damage_text = (BP.brute_dam >= BP.burn_dam) ? BP.heavy_brute_msg : BP.heavy_burn_msg
		msg += "<B>[capitalize(t_his)] [BP.name] is [damage_text]!</B>\n"

	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			msg += "<span class='dead'><B>[t_His] [parse_zone(t)] is missing!</B></span>\n"
			continue
		msg += "<span class='warning'><B>[t_His] [parse_zone(t)] is missing!</B></span>\n"


	var/temp = getBruteLoss()
	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_is] slightly deformed.\n"
			else if (temp < 50)
				msg += "[t_He] [t_is] <b>moderately</b> deformed!\n"
			else
				msg += "<b>[t_He] [t_is] severely deformed!</b>\n"

	if(HAS_TRAIT(src, TRAIT_DUMB))
		msg += "[t_He] seem[p_s()] to be clumsy and unable to think.\n"

	if(fire_stacks > 0)
		msg += "[t_He] [t_is] covered in something flammable.\n"
	if(fire_stacks < 0)
		msg += "[t_He] look[p_s()] a little soaked.\n"

	if(pulledby?.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"

	var/scar_severity = 0
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(S.is_visible(user))
			scar_severity += S.severity

	switch(scar_severity)
		if(1 to 4)
			msg += "<span class='tinynoticeital'>[t_He] [t_has] visible scarring, you can look again to take a closer look...</span>\n"
		if(5 to 8)
			msg += "<span class='smallnoticeital'>[t_He] [t_has] several bad scars, you can look again to take a closer look...</span>\n"
		if(9 to 11)
			msg += "<span class='notice'><i>[t_He] [t_has] significantly disfiguring scarring, you can look again to take a closer look...</i></span>\n"
		if(12 to INFINITY)
			msg += "<span class='notice'><b><i>[t_He] [t_is] just absolutely fucked up, you can look again to take a closer look...</i></b></span>\n"

	msg += "</span>"

	. += msg.Join("")

	switch(stat)
		if(SOFT_CRIT)
			. += "[t_His] breathing is shallow and labored."
		if(UNCONSCIOUS, HARD_CRIT)
			. += "[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep."

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
	if(mood)
		switch(mood.shown_mood)
			if(-INFINITY to MOOD_LEVEL_SAD4)
				. += "[t_He] look[p_s()] depressed."
			if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
				. += "[t_He] look[p_s()] very sad."
			if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
				. += "[t_He] look[p_s()] a bit down."
			if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
				. += "[t_He] look[p_s()] quite happy."
			if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
				. += "[t_He] look[p_s()] very happy."
			if(MOOD_LEVEL_HAPPY4 to INFINITY)
				. += "[t_He] look[p_s()] ecstatic."
	. += "</span></div>" //info span, infobox div

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .)
	if(on_examined_check(user, FALSE))
		user.on_examine_atom(src, FALSE)

// this is stupid
/mob/living/carbon/examine_more(mob/user)
	if(!all_scars)
		return ..()

	var/list/visible_scars = list()
	for(var/i in all_scars)
		var/datum/scar/scar = i
		if(scar.is_visible(user))
			visible_scars |= scar

	if(!LAZYLEN(visible_scars))
		return ..()

	. = list(span_notice("<i>Я осматриваю [src] ближе, и замечаю...</i></span>"), "<br><hr class='infohr'>")
	for(var/i in visible_scars)
		var/datum/scar/S = i
		var/scar_text = S.get_examine_description(user)
		if(scar_text)
			. += scar_text
	if(on_examined_check(user, TRUE))
		user.on_examine_atom(src, TRUE)

/// Examine messages
/mob/living/carbon/on_examine_atom(atom/examined, examine_more = FALSE)
	if(!client)
		return

	if((src == examined) || (!DirectAccess(examined) && get_dist(src, examined) > EYE_CONTACT_RANGE) || (stat >= UNCONSCIOUS) || is_blind())
		return

	if(CHECK_BITFIELD(wear_mask?.flags_inv, HIDEFACE) || CHECK_BITFIELD(head?.flags_inv, HIDEFACE) || CHECK_BITFIELD(glasses?.flags_inv, HIDEFACE))
		return

	if(!HAS_TRAIT(src, TRAIT_FLUORIDE_STARE))
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> looks at [examined].")), \
							span_notice("I look at [examined]."), \
							vision_distance = EYE_CONTACT_RANGE)
		else
			var/mob/mob_examined = examined
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> looks at \
							<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
							span_notice("I look at <b>[examined]</b>."), \
							vision_distance = EYE_CONTACT_RANGE)
	else
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> strangely looks at [examined].")), \
						span_notice("I strangely look at <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_RANGE)
		else
			var/mob/mob_examined = examined
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> strangely looks at \
						<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
						span_notice("I strangely look at <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_RANGE)
	if(HAS_TRAIT(src, TRAIT_HORROR_STARE))
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> horror stares [examined].")), \
						span_notice("I horror stare <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_HORROR_RANGE)
		else
			var/mob/mob_examined = examined
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> horror stares \
						<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
						span_notice("I horror stare <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_HORROR_RANGE	)
