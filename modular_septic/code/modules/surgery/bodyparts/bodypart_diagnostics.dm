/// Used by some medical tools
/obj/item/bodypart/proc/listen()
	var/list/sounds = list()
	for(var/obj/item/organ/organ in get_organs())
		var/gutsound = organ.listen()
		if(gutsound)
			sounds += gutsound
	if(!length(sounds))
		if(owner?.pulse)
			sounds += "faint pulse"
	return sounds

/// Medical scans
/obj/item/bodypart/proc/get_scan_results(do_span = FALSE)
	. = list()
	if(is_robotic_limb())
		. += do_span ? span_info("Mechanical") : "Mechanical"

	if(CHECK_BITFIELD(limb_flags, BODYPART_CUT_AWAY))
		. += do_span ? span_danger("Severed") : "Severed"

	if(rejection_stage)
		. += do_span ? span_danger("<b>Genetic Rejection</b>") : "Genetic Rejection"

	if(CHECK_BITFIELD(limb_flags, BODYPART_DEAD))
		. += do_span ? span_necrosis("<b>Necrotic</b>") : "Necrotic"
	else
		switch(germ_level)
			if(INFECTION_LEVEL_ONE to INFECTION_LEVEL_ONE + ((INFECTION_LEVEL_TWO - INFECTION_LEVEL_ONE) / 3))
				. += do_span ? span_infection("Light Infection") : "Light Infection"
			if(INFECTION_LEVEL_ONE + ((INFECTION_LEVEL_TWO - INFECTION_LEVEL_ONE) / 3) to INFECTION_LEVEL_ONE + (2 * (INFECTION_LEVEL_TWO - INFECTION_LEVEL_ONE) / 3))
				. += do_span ? span_infection("Medium Infection+") : "Medium Infection+"
			if(INFECTION_LEVEL_ONE + (2 * (INFECTION_LEVEL_TWO - INFECTION_LEVEL_ONE) / 3) to INFECTION_LEVEL_TWO)
				. += do_span ? span_infection("Serious Infection") : "Serious Infection"
			if(INFECTION_LEVEL_TWO to INFECTION_LEVEL_TWO + ((INFECTION_LEVEL_THREE - INFECTION_LEVEL_THREE) / 3))
				. += do_span ? span_infection("<b>Acute Infection</b>") : "Acute Infection"
			if(INFECTION_LEVEL_TWO + ((INFECTION_LEVEL_THREE - INFECTION_LEVEL_THREE) / 3) to INFECTION_LEVEL_TWO + (2 * (INFECTION_LEVEL_THREE - INFECTION_LEVEL_TWO) / 3))
				. += do_span ? span_infection("<b>Acute Infection+</b>") : "Acute Infection+"
			if(INFECTION_LEVEL_TWO + (2 * (INFECTION_LEVEL_THREE - INFECTION_LEVEL_TWO) / 3) to INFECTION_LEVEL_THREE)
				. += do_span ? span_infection("<b>Acute Infection++</b>") : "Acute Infection++"
			if(INFECTION_LEVEL_THREE to INFINITY)
				. += do_span ? span_necrosis("<b>Septic</b>") : "Septic"

/// Advanced examine stuff
/obj/item/bodypart/examine_more(mob/user)
	. = list(span_notice("<i>I examine <EM>[src]</EM> closer, and I notice...</i>"), "<br><hr class='infohr'>")
	. |= surgical_examine(user)

/obj/item/bodypart/proc/surgical_examine(mob/user)
	. = list()
	if(get_dist(user, src) <= 2)
		var/ouchies = get_injuries_desc()
		if(ouchies)
			. += span_warning("[capitalize(src.name)] has [ouchies] visible on it.")
		var/list/woundies = list()
		for(var/datum/wound/wound as anything in wounds)
			woundies += lowertext(wound.name)
		if(length(woundies))
			. += span_warning("[capitalize(src.name)] is suffering with [english_list(woundies)].")
	if(etching)
		. += span_notice("[capitalize(src.name)] has <b>\"[etching]\"</b> inscribed on it.")
	if(status == BODYPART_ROBOTIC)
		. += span_notice("[capitalize(src.name)] is seemingly of a robotic nature.")
	else
		. += span_notice("[capitalize(src.name)] is seemingly of an organic nature.")
	if(limb_flags & BODYPART_NO_INFECTION)
		. += span_notice("[capitalize(src.name)] will not decay nor get infected.")
	if(GetComponent(/datum/component/edible))
		. += span_notice("[capitalize(src.name)] is edible.")
	if(limb_flags & BODYPART_DEAD)
		. += span_necrosis("[capitalize(src.name)] seems to be gangrenous!")
	else if(germ_level)
		switch(germ_level)
			if(INFECTION_LEVEL_ONE to INFECTION_LEVEL_TWO)
				. += span_infection("[capitalize(src.name)] seems to be mildly infected.")
			if(INFECTION_LEVEL_TWO to INFECTION_LEVEL_THREE)
				. += span_infection("[capitalize(src.name)] seems to be festering.")
			if(INFECTION_LEVEL_THREE to INFINITY)
				. += span_necrosis("[capitalize(src.name)] seems to be necrotic!")
	for(var/obj/item/bodypart/BP in src)
		if(BP.body_zone in children_zones)
			. += span_notice("[capitalize(src.name)] has \a [lowertext(BP.name)] attached.")
	if(!isobserver(user) && (GET_MOB_SKILL_VALUE(user, SKILL_MEDICINE) < 8))
		return
	if(!owner)
		. += span_notice("[src] can be attached on \the [parse_zone(body_zone)].")
	. += span_info("<b>Cavity volume:</b> [max_cavity_volume]")
	. += span_info("<b>Maximum item size:</b> [capitalize(weight_class_to_text(max_cavity_item_size))]")

/obj/item/bodypart/proc/get_injuries_desc()
	var/obj/item/bodypart/parent = owner?.get_bodypart(parent_body_zone)
	var/list/flavor_text = list()
	if(owner && is_cut_away() && !parent?.is_cut_away() && !is_stump())
		if(parent)
			flavor_text += "a tear at the [amputation_point_name] so severe that it hangs by a scrap of [is_organic_limb() ? "flesh" : "metal"] to [parent]"
		else
			flavor_text += "a tear at the [amputation_point_name] so severe that it hangs by a scrap of [is_organic_limb() ? "flesh" : "metal"]"

	var/list/injury_descriptors = list()
	for(var/thing in injuries)
		var/datum/injury/injury = thing
		var/this_injury_desc = injury.get_desc(TRUE)
		if(injury.can_autoheal() && (injury.current_stage >= length(injury.stages)) && (injury.damage < 5))
			this_injury_desc = "<span style='color: [COLOR_PALE_RED_GRAY];'>[this_injury_desc]</span>"
		if(injury.is_bleeding())
			if(is_artery_torn())
				this_injury_desc = "<b><i><span class='artery'>artery-bleeding</span></i></b> [this_injury_desc]"
			//Completely arbitrary value
			else if(injury.get_bleed_rate() > 1)
				this_injury_desc = "<b><i>strongly bleeding</i></b> [this_injury_desc]"
			else
				this_injury_desc = "<b>bleeding</b> [this_injury_desc]"
		if(injury.is_clamped())
			this_injury_desc = "<span style='color: [COLOR_SILVER]'>clamped</span> [this_injury_desc]"
		if(injury.is_sutured())
			this_injury_desc = "<span style='color: [COLOR_MODERATE_BLUE]'>sutured</span> [this_injury_desc]"
		if(injury.is_bandaged())
			this_injury_desc = "<span style='color: [COLOR_ASSEMBLY_WHITE]'>bandaged</span> [this_injury_desc]"
		if(injury.is_salved())
			this_injury_desc = "<span class='nicegreen'>salved</span> [this_injury_desc]"
		if(injury.is_disinfected())
			this_injury_desc = "<span style='color: [COLOR_BLUE_LIGHT]'>desinfected</span> [this_injury_desc]"

		if(injury.germ_level >= INFECTION_LEVEL_TWO)
			this_injury_desc = "<span class='necrosis'><b>pus</b></span> [this_injury_desc]"
		else if(injury.germ_level >= INFECTION_LEVEL_ONE)
			this_injury_desc = "<span class='infection'>inflamed</span> [this_injury_desc]"

		if(length(injury.embedded_objects))
			var/list/embed_strings = list()
			for(var/obj/item/embedded_item as anything in injury.embedded_objects)
				embed_strings += "\ [embedded_item]"
			this_injury_desc += "<span style='color: [COLOR_STRONG_MAGENTA]'> с [english_list(embed_strings)] sticking out [injury.amount > 1 ? "of them" : "of it"]</span>"

		if(injury_descriptors[this_injury_desc])
			injury_descriptors[this_injury_desc] += injury.amount
		else
			injury_descriptors[this_injury_desc] = injury.amount

	if(!is_robotic_limb())
		if(CHECK_MULTIPLE_BITFIELDS(how_open(), SURGERY_INCISED|SURGERY_RETRACTED))
			var/bone_name = GLOB.bones_by_path[bone_type] ? GLOB.bones_by_path[bone_type].name : "bone"
			if(is_fractured())
				bone_name = "broken [bone_name]"
			injury_descriptors["[bone_name] naked"] = 1
			if(!is_encased() || (CHECK_BITFIELD(how_open(), SURGERY_BROKEN)))
				var/list/bits = list()
				for(var/obj/item/organ/organ as anything in get_organs())
					var/visible_state = organ.get_visible_state()
					if(!LAZYLEN(visible_state))
						continue
					bits += visible_state
				if(bits.len)
					injury_descriptors["[english_list(bits)] visible in the wound"] = 1

	for(var/injury in injury_descriptors)
		var/final_text = injury
		switch(injury_descriptors[injury])
			if(-INFINITY to 1)
				final_text = "[final_text]"
			if(2)
				final_text = "a pair [final_text]"
			if(3 to 5)
				final_text = "some [final_text]"
			if(6 to INFINITY)
				final_text = "many [final_text]"
		flavor_text += final_text
	if(length(flavor_text))
		return english_list(flavor_text)

/// Grab examination
/obj/item/bodypart/proc/inspect(mob/user)
	user.visible_message(span_notice("[user] starts inspecting [owner]'s [name] carefully."))
	var/ouchies = get_injuries_desc()
	if(ouchies)
		to_chat(user, span_warning("I find [get_injuries_desc()]."))
	else
		to_chat(user, span_notice("Can't find any wounds."))

	to_chat(user, span_notice("Checking skin now..."))
	if(!do_mob(user, owner, 1 SECONDS))
		to_chat(user, span_warning("I must stand still to check [owner]'s skin for abnormalities."))
		return

	var/list/badness = list()
	if(owner.getShockStage() >= SHOCK_STAGE_2)
		badness |= "sticky and cool to the touch"
	if(owner.getToxLoss() >= 25)
		badness |= "yellowish"
	if(owner.get_blood_oxygenation() <= BLOOD_VOLUME_OKAY)
		badness |= "turns bluish"
	if(owner.get_blood_circulation() <= BLOOD_VOLUME_OKAY + 70)
		badness |= "very pale"
	if(is_dead())
		badness |= "rotting"

	if(!length(badness))
		to_chat(user, span_notice("[owner] skin is ok."))
	else
		to_chat(user, span_warning("[owner] skin is [english_list(badness)]."))

	if(bone_needed())
		to_chat(user, span_notice("Checking bones now..."))
		if(!do_mob(user, owner, 1 SECONDS))
			to_chat(user, span_warning("I must stand still to feel [src] for fractures."))
			return

		var/bone_name = GLOB.bones_by_path[bone_type].name
		if(bone_missing())
			to_chat(user, span_warning("[name] don't have [bone_name]!"))
		else if(is_dislocated())
			var/joint_name = GLOB.bones_by_path[bone_type].joint_name
			to_chat(user, span_warning("[joint_name] is dislocated!"))
		else if(is_fractured())
			to_chat(user, span_warning("[bone_name] in [name] extends a little!"))
			owner.custom_pain("[name] hurts when touched.", 25, affecting = src)
		else
			to_chat(user, span_notice("[bone_name] in [name] is ok."))

	if(tendon_needed() || artery_needed())
		to_chat(user, span_notice("Checking tendons and arteries now..."))
		if(!do_mob(user, owner, 1 SECONDS))
			to_chat(user, span_warning("I must stand still to feel [src] for torn tendons and arteries."))
			return

		if(tendon_needed())
			var/tendon_name = GLOB.tendons_by_path[tendon_type].name
			if(tendon_missing())
				to_chat(user, span_warning("The [name] is missing it's tendons!"))
			else if(is_tendon_torn())
				to_chat(user, span_warning("The [tendon_name] in [name] is torn!"))
			else
				to_chat(user, span_notice("The [tendon_name] in [name] is OK."))

		if(artery_needed())
			var/artery_name = GLOB.arteries_by_path[artery_type].name
			if(artery_missing())
				to_chat(user, span_warning("The [name] is missing it's [artery_name]!"))
			else if(is_artery_torn())
				to_chat(user, span_warning("The [artery_name] in [name] is severed!"))
			else
				to_chat(user, span_notice("The [artery_name] in [name] is OK."))

	return TRUE
