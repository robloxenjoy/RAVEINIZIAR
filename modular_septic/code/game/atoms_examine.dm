// Generate the full examine string of this atom (including icon for goonchat)
/atom/get_examine_string(mob/user, thats = FALSE)
//	return "[icon2html(src, user)] [thats ? "That's ":""][thats ? "<EM><b>[get_examine_name(user)]</b></EM>" : get_examine_name(user)]"
	return "<EM><b>[get_examine_name(user)]</b></EM>"

// Calling on_examine()
/atom/examine(mob/user)
	. = list("[get_examine_string(user, TRUE)].")
	. += get_name_chaser(user)
	. += "<br><hr class='infohr'>"
	if(desc)
		. += desc
	var/desc_chaser = desc_chaser(user)
	if(LAZYLEN(desc_chaser))
		. += desc_chaser
	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .)
	if(on_examined_check(user, FALSE))
		user.on_examine_atom(src, FALSE)

/atom/examine_more(mob/user)
	. = list()
	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE_MORE, user, .)
	if(on_examined_check(user, TRUE))
		user.on_examine_atom(src, TRUE)

/// Currently only matters for items, shows buttons to inspect stats that should be in a consistent position
/atom/proc/topic_examine(mob/user)
	. = list()
	if(uses_integrity)
		. += span_notice("<a href='?src=[REF(src)];integrity=1'>Condition</a>")
	SEND_SIGNAL(src, COMSIG_ATOM_TOPIC_EXAMINE, user, .)

/// Displayed after desc, but before examine child calls
/atom/proc/desc_chaser(mob/user)
	return

/// Displayed after examine child calls
/atom/proc/examine_chaser(mob/user)
	. = list()
//	if(custom_materials)
//		var/list/materials_list = list()
//		for(var/i in custom_materials)
//			var/datum/material/M = i
//			materials_list += "[M.name]"
//		. += "<u>[p_they(TRUE)] [p_are()] made out of [english_list(materials_list)]</u>."
	if(reagents)
		if(reagents.flags & TRANSPARENT)
			. += "Это содержит:"
			if(length(reagents.reagent_list))
				if(user.can_see_reagents()) //Show each individual reagent
					for(var/datum/reagent/R in reagents.reagent_list)
						. += "[round(R.volume, 0.01)] юнитов [R.name]"
					if(reagents.is_reacting)
						. += span_warning("В данный момент, там реакция!")
					. += span_notice("pH [round(reagents.ph, 0.01)] и температура [reagents.chem_temp].")
				else //Otherwise, just show the total volume
					var/total_volume = 0
					for(var/datum/reagent/R in reagents.reagent_list)
						total_volume += R.volume
					. += "[total_volume] юнитов различных реагентов."
			else
				. += "Ничего."
		else if(reagents.flags & AMOUNT_VISIBLE)
			if(reagents.total_volume)
				. += span_notice("Там осталось [reagents.total_volume] юнитов.")
			else
				. += span_danger("Это пусто.")

/// Override this to impede examine messages etc
/atom/proc/on_examined_check(mob/user, examine_more = FALSE)
	return TRUE
