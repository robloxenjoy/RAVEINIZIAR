/// Used by some medical tools
/obj/item/organ/proc/listen()
	return

/// Medical scans
/obj/item/organ/proc/get_scan_results(do_span = FALSE)
	. = list()
	if(status == ORGAN_ROBOTIC)
		. += do_span ? span_notice("Mechanical") : "Mechanical"

	if(CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
		. += do_span ? span_danger("Severed") : "Severed"

	if(rejection_stage)
		. += do_span ? span_danger("<b>Genetic Rejection</b>") : "Genetic Rejection"

	if(CHECK_BITFIELD(organ_flags, ORGAN_DEAD))
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
/obj/item/organ/examine_more(mob/user)
	. = list(span_notice("<i>I examine <EM>[src]</EM> closer, and note the following...</i>"), "<br><hr class='infohr'>")
	. |= surgical_examine(user)

/obj/item/organ/proc/surgical_examine(mob/user)
	. = list()
	var/failing = FALSE
	var/decayed = FALSE
	var/damaged = FALSE
	if(status == BODYPART_ROBOTIC)
		. += span_notice("[capitalize(src.name)] is seemingly of a robotic nature.")
	else
		. += span_notice("[capitalize(src.name)] is seemingly of an organic nature.")
	if(GetComponent(/datum/component/edible))
		. += span_notice("[capitalize(src.name)] is edible.")
	if(organ_flags & ORGAN_NOINFECTION)
		. += span_notice("[capitalize(src.name)] will not decay nor get infected.")
	if(organ_flags & ORGAN_UNREMOVABLE)
		. += span_notice("[capitalize(src.name)] cannot be removed via normal means.")
	if(organ_flags & ORGAN_VITAL)
		. += span_warning("[capitalize(src.name)] is a <b>vital</b> organ.")
	if(organ_flags & ORGAN_SYNTHETIC_EMP)
		. += span_danger("[capitalize(src.name)] has been EMPed!")
	else if(organ_flags & ORGAN_SYNTHETIC)
		. += span_warning("[capitalize(src.name)] is susceptible to electromagnetic pulses.")
	if(is_necrotic())
		decayed = TRUE
	if(is_dead())
		failing = TRUE
		. += span_warning("[capitalize(src.name)] is destroyed!")
	else if(is_failing())
		failing = TRUE
		. += span_warning("[capitalize(src.name)] is failing!")
	if(damage > low_threshold)
		if(!failing)
			damaged = TRUE
			if(status == ORGAN_ORGANIC)
				if(istype(src, /obj/item/organ/bone))
					. += span_warning("[capitalize(src.name)] has some cracks on the surface.")
				else
					. += span_warning("[capitalize(src.name)] is starting to look discolored.")
			else
				if(istype(src, /obj/item/organ/bone))
					. += span_warning("[capitalize(src.name)] is a bit bent.")
				else
					. += span_warning("[capitalize(src.name)] is leaking some oil.")
	if(!failing && !damaged && !decayed)
		. += span_notice("[capitalize(src.name)] seems to be decently healthy.")
	if(decayed)
		. += span_necrosis("[capitalize(src.name)] seems to be gangrenous!")
	else if(germ_level)
		switch(germ_level)
			if(INFECTION_LEVEL_ONE to INFECTION_LEVEL_TWO)
				. += span_infection("[capitalize(src.name)] seems to be mildly infected.")
			if(INFECTION_LEVEL_TWO to INFECTION_LEVEL_THREE)
				. += span_infection("[capitalize(src.name)] seems to be festering.")
			if(INFECTION_LEVEL_THREE to INFINITY)
				. += span_necrosis("[capitalize(src.name)] seems to be necrotic!")
	if(owner)
		if(CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
			. += span_danger("[capitalize(src.name)] has been severed from [owner].")
		else
			. += span_notice("[capitalize(src.name)] is still attached to [owner].")
	if(etching)
		. += span_notice("[capitalize(src.name)] has <b>\"[etching]\"</b> inscribed on it.")
	if(side != NO_SIDE)
		var/side_result = "None"
		if((side & LEFT_SIDE) && (side & RIGHT_SIDE))
			side_result = "Both"
		else if(side & LEFT_SIDE)
			side_result = "Left"
		else if(side & RIGHT_SIDE)
			side_result = "Right"
		. += span_notice("<b>Body side:</b> [side_result]")
	if(GET_MOB_SKILL_VALUE(user, SKILL_SURGERY) >= 8)
		. += span_info("<b>Organ volume:</b> [organ_volume]")
		var/requirement_string = "<span class='info'><b>Requirements:</b> "
		requirement_string += "<span style='color: [COLOR_MOSTLY_PURE_RED];'>[blood_req]</span> "
		requirement_string += "<span style='color: [COLOR_BLUE];'>[oxygen_req]</span> "
		requirement_string += "<span style='color: [COLOR_TAN_ORANGE];'>[nutriment_req]</span> "
		requirement_string += "<span style='color: [COLOR_BRIGHT_BLUE];'>[hydration_req]</span> "
		requirement_string += "</span>"
		. += requirement_string
	if(GET_MOB_SKILL_VALUE(user, SKILL_SURGERY) >= 12)
		. += span_info("<b>Efficiencies:</b>")
		for(var/slot in organ_efficiency)
			. += "<b>[capitalize_like_old_man(slot)]:</b> [organ_efficiency[slot]]"
	if(!owner && (GET_MOB_SKILL_VALUE(user, SKILL_SURGERY) >= 8))
		. += span_info("<b>This organ is normally inserted in:</b>")
		. += span_info("[capitalize_like_old_man(parse_zone(zone))]")
		var/list/parsed_zones = possible_zones.Copy()
		for(var/thing in parsed_zones)
			parsed_zones -= thing
			parsed_zones += capitalize_like_old_man(parse_zone(thing))
		if(!length(parsed_zones))
			parsed_zones += "Nowhere"
		. += span_info("<b>This organ can be inserted in:</b>\n[jointext(parsed_zones, ", ")].")

/// Used by injuries
/obj/item/organ/proc/get_visible_state()
	if(is_destroyed())
		. = "destroyed "
	else if(is_broken())
		. = "broken "
	else if(is_bruised())
		. = "badly damaged "
	else if(damage >= 3)
		. = "damaged "
	if(CHECK_BITFIELD(organ_flags, ORGAN_DEAD))
		. = "gangrenous [.]"
	. = "[.][name]"
