/datum/mind
	/// Music when combat mode is on
	var/combat_music = 'modular_septic/sound/music/combat/ritual.ogg'

/datum/mind/New()
	. = ..()
	if(SSmapping.config?.combat_map)
		combat_music = 'modular_septic/sound/music/combat/newcombat.ogg'

/datum/mind/give_uplink(silent, datum/antagonist/antag_datum)
	if(!current)
		return
	var/mob/living/carbon/human/traitor_mob = current
	if (!istype(traitor_mob))
		return

	var/list/all_contents = traitor_mob.get_all_contents()
	var/obj/item/pda/PDA = locate() in all_contents
	var/obj/item/radio/R = locate() in all_contents
	var/obj/item/pen/P
	var/obj/item/computer_hardware/hard_drive/portable/sdcard

	if (PDA) // Prioritize PDA pen, otherwise the pocket protector pens will be chosen, which causes numerous ahelps about missing uplink
		P = locate() in PDA
	if (!P) // If we couldn't find a pen in the PDA, or we didn't even have a PDA, do it the old way
		P = locate() in all_contents


	var/obj/item/uplink_loc
	var/implant = FALSE

	var/uplink_spawn_location = traitor_mob.client?.prefs?.read_preference(/datum/preference/choiced/uplink_location)
	switch (uplink_spawn_location)
		if(UPLINK_PDA)
			uplink_loc = PDA
			if(!uplink_loc)
				uplink_loc = R
			if(!uplink_loc)
				uplink_loc = P
		if(UPLINK_RADIO)
			uplink_loc = R
			if(!uplink_loc)
				uplink_loc = PDA
			if(!uplink_loc)
				uplink_loc = P
		if(UPLINK_PEN)
			uplink_loc = P
		if(UPLINK_IMPLANT)
			implant = TRUE
		if(UPLINK_SDCARD)
			sdcard = new /obj/item/computer_hardware/hard_drive/portable/sdcard/uplink(traitor_mob)
			for(var/possible_slot in list(ITEM_SLOT_LPOCKET, \
										ITEM_SLOT_RPOCKET, \
										ITEM_SLOT_LEAR, \
										ITEM_SLOT_REAR, \
										ITEM_SLOT_BACKPACK, \
										ITEM_SLOT_MASK))
				if(traitor_mob.equip_to_slot_if_possible(sdcard, possible_slot, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
					break
			if(!QDELETED(sdcard))
				uplink_loc = sdcard

	// We've looked everywhere, let's just implant you
	if(!uplink_loc)
		implant = TRUE

	if(implant)
		var/obj/item/implant/uplink/starting/new_implant = new(traitor_mob)
		new_implant.implant(traitor_mob, null, silent = TRUE)
		if(!silent)
			to_chat(traitor_mob, span_boldnotice("Your Syndicate Uplink has been cunningly implanted in you, for a small TC fee. Simply trigger the uplink to access it."))
		return new_implant

	. = uplink_loc
	var/unlock_text
	var/datum/component/uplink/new_uplink = uplink_loc.AddComponent(/datum/component/uplink, traitor_mob.key)
	if(!new_uplink)
		CRASH("Uplink creation failed.")
	new_uplink.setup_unlock_code()
	if(uplink_loc == R)
		unlock_text = "Your Uplink is cunningly disguised as your [R.name]. Simply dial the frequency [format_frequency(new_uplink.unlock_code)] to unlock its hidden features."
	else if(uplink_loc == PDA)
		unlock_text = "Your Uplink is cunningly disguised as your [PDA.name]. Simply enter the code \"[new_uplink.unlock_code]\" into the ringtone select to unlock its hidden features."
	else if(uplink_loc == P)
		unlock_text = "Your Uplink is cunningly disguised as your [P.name]. Simply twist the top of the pen [english_list(new_uplink.unlock_code)] from its starting position to unlock its hidden features."
	else if(uplink_loc == sdcard)
		unlock_text = "Your Uplink is cunningly stored in your [sdcard.name]. Simply copy the LimeWire file into any modular computer and execute it."
	new_uplink.unlock_text = unlock_text
	if(!silent)
		to_chat(traitor_mob, span_boldnotice(unlock_text))
	antag_datum.antag_memory += new_uplink.unlock_note + "<br>"
