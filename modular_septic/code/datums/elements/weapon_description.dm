/datum/element/weapon_description/Attach(datum/target, attached_proc)
	. = ..()
	if(!isitem(target)) // Do not attach this to anything that isn't an item
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_ATOM_TOPIC_EXAMINE, .proc/warning_label)
	RegisterSignal(target, COMSIG_TOPIC, .proc/topic_handler)
	src.attached_proc = attached_proc

/datum/element/weapon_description/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, COMSIG_ATOM_TOPIC_EXAMINE)
	UnregisterSignal(target, COMSIG_TOPIC)

/datum/element/weapon_description/warning_label(obj/item/item, mob/user, list/examine_texts)
	examine_texts += span_notice("<a href='?src=[REF(item)];offense=1'>Offense</a>")

/datum/element/weapon_description/topic_handler(atom/source, mob/user, href_list)
	if(href_list["offense"])
		if((get_dist(user, source) > 1) && !user.DirectAccess(source))
			to_chat(user, span_warning("I can't inspect it clearly at this distance."))
			return
		to_chat(user, div_infobox("[build_label_text(source, user)]"))

/datum/element/weapon_description/build_label_text(obj/item/source, mob/user)
	var/list/readout = list(span_info("<center><u><b>OFFENSIVE CAPABILITIES</b></u></center>"))
	readout += "<hr class='infohr'>"

	// Doesn't show the base notes for items that have the override notes variable set to true
	if(!source.override_notes)
		var/datum/attribute/skill_melee = GET_ATTRIBUTE_DATUM(source.skill_melee)
		readout += span_notice("<b>Melee Skill:</b> [skill_melee.name]")
		if(isgun(source))
			var/datum/attribute/skill_ranged = GET_ATTRIBUTE_DATUM(source.skill_ranged)
			readout += span_notice("<b>Ranged Skill:</b> [skill_ranged.name]")
		var/datum/component/two_handed/two_handed = source.get_wield_component()
		if(two_handed)
			if(two_handed.force_multiplier)
				if(two_handed.wielded)
					readout += span_notice("<b>Force (Wielded):</b> [source.force]")
					readout += span_notice("<b>Force (Unwielded):</b> [source.force/two_handed.force_multiplier]")
				else
					readout += span_notice("<b>Force (Wielded):</b> [source.force*two_handed.force_multiplier]")
					readout += span_notice("<b>Force (Unwielded):</b> [source.force]")
			else
				readout += span_notice("<b>Force (Wielded):</b> [two_handed.force_wielded]")
				readout += span_notice("<b>Force (Unwielded):</b> [two_handed.force_unwielded]")
		else
			readout += span_notice("<b>Force:</b> [source.force]")
		readout += span_notice("<b>Throw Force:</b> [source.throwforce]")
		if(source.wound_bonus)
			readout += span_notice("<b>Wound Bonus:</b> [source.wound_bonus]")
		if(source.bare_wound_bonus)
			readout += span_notice("<b>Bare Wound Bonus:</b> [source.bare_wound_bonus]")
		if(source.organ_bonus)
			readout += span_notice("<b>Organ Bonus:</b> [source.organ_bonus]")
		if(source.bare_organ_bonus)
			readout += span_notice("<b>Bare Organ Bonus:</b> [source.bare_organ_bonus]")

		if(source.poisoned.len)
			readout += span_notice("<b>Covered in:</b> [capitalize_like_old_man(source.poisoned.len)]")

		if(source.havedurability)
			readout += span_notice("<b>Durability:</b> [capitalize_like_old_man(source.durability)]")
		if(source.canrust)
			readout += span_notice("<b>Rust Point:</b> [capitalize_like_old_man(source.rustbegin)]")
		readout += span_notice("<b>Sharpness:</b> [capitalize_like_old_man(translate_sharpness(source.get_sharpness()))]")

	// Custom manual notes
	if(source.offensive_notes)
		readout += source.offensive_notes

	// Check if we have an additional proc, if so, add it to the readout
	if(attached_proc)
		readout += call(source, attached_proc)()

	return readout.Join("\n")
