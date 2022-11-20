/obj/Initialize(mapload)
	. = ..()
	if(isnull(min_force))
		min_force = force

/obj/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_SUBARMOR_MOD, "Modify subarmor values")

/obj/vv_do_topic(list/href_list)
	if(!(. = ..()))
		return
	if(href_list[VV_HK_SUBARMOR_MOD])
		var/list/pickerlist = list()
		var/list/armorlist = subarmor.getList()

		for(var/i in armorlist)
			pickerlist += list(list("value" = armorlist[i], "name" = i))

		var/list/result = presentpicker(usr, "Modify subarmor", "Modify subarmor: [src]", Button1="Save", Button2 = "Cancel", Timeout=FALSE, inputtype = "text", values = pickerlist)

		if(islist(result))
			if(result["button"] != 2) // If the user pressed the cancel button
				// text2num conveniently returns a null on invalid values
				subarmor = subarmor.setRating(subarmor_flags = text2num(result["values"][SUBARMOR_FLAGS]),\
											edge_protection = text2num(result["values"][EDGE_PROTECTION]),\
											crushing = text2num(result["values"][CRUSHING]),\
											cutting = text2num(result["values"][CUTTING]),\
											piercing = text2num(result["values"][PIERCING]),\
											impaling = text2num(result["values"][IMPALING]),\
											laser = text2num(result["values"][LASER]),\
											energy = text2num(result["values"][ENERGY]),\
											bomb = text2num(result["values"][BOMB]),\
											bio = text2num(result["values"][BIO]),\
											fire = text2num(result["values"][FIRE]),\
											acid = text2num(result["values"][ACID]),\
											magic = text2num(result["values"][MAGIC]),\
											wound = text2num(result["values"][WOUND]),\
											organ = text2num(result["values"][ORGAN]),\
				)
				log_admin("[key_name(usr)] modified the subarmor on [src] ([type]) to subarmor_flags: [subarmor.subarmor_flags], edge_protection: [subarmor.edge_protection], crushing: [subarmor.crushing], cutting: [subarmor.cutting], impaling: [subarmor.impaling], laser: [subarmor.laser], energy: [subarmor.energy], bomb: [subarmor.bomb], bio: [subarmor.bio], fire: [subarmor.fire], acid: [subarmor.acid], magic: [subarmor.magic], wound: [subarmor.wound], organ: [subarmor.organ]")
				message_admins(span_notice("[key_name_admin(usr)] modified the armor on [src] ([type]) to subarmor_flags: [subarmor.subarmor_flags], edge_protection: [subarmor.edge_protection], crushing: [subarmor.crushing], cutting: [subarmor.cutting], impaling: [subarmor.impaling], laser: [subarmor.laser], energy: [subarmor.energy], bomb: [subarmor.bomb], bio: [subarmor.bio], fire: [subarmor.fire], acid: [subarmor.acid], magic: [subarmor.magic], wound: [subarmor.wound], organ: [subarmor.organ]"))

/obj/on_rammed(mob/living/carbon/rammer)
	rammer.ram_stun()
	var/smash_sound = pick('modular_septic/sound/gore/smash1.ogg',
						'modular_septic/sound/gore/smash2.ogg',
						'modular_septic/sound/gore/smash3.ogg')
	playsound(src, smash_sound, 80)
	rammer.sound_hint()
	sound_hint()
	take_damage(GET_MOB_ATTRIBUTE_VALUE(rammer, STAT_STRENGTH))

/**
 * This returns the damage for one given attack with this object, taking into account the base variation and
 * the strength driven variation.
 * Damage will never exceed max_force and will never be below zero.
 *
 * Formulas:
 * Minimum damage = min_force + (min_force_strength * strength_value)
 * Maximum damage = force + (force_strength * strength_value)
 */
/obj/proc/get_force(mob/living/user, strength_value = ATTRIBUTE_MIDDLING)
	strength_value = clamp(strength_value, 0, maximum_strength)
	var/final_force = rand(min_force, force)
	/// Fraggots are always considered to have absolutely 0 strength
	if(user && !HAS_TRAIT(user, TRAIT_FRAGGOT))
		var/strength_multiplier = rand(min_force_strength, force_strength)
		/**
		 * If the multiplier is negative, we instead punish the dude for each point of strength below ATTRIBUTE_MASTER
		 * You really shouldn't make this possible though as it makes understanding the damage of an item even more insane.
		 */
		if(strength_multiplier < 0)
			final_force += (strength_value - ATTRIBUTE_MASTER) * strength_multiplier
		/// Otherwise, elementary multiplier stuff
		else
			final_force += strength_value * strength_multiplier
		/**
		 * If the user is human, we account the limb efficiency of their active hand.
		 */
		if(ishuman(user))
			var/mob/living/carbon/human/human_user = user
			var/obj/item/bodypart/active_hand = human_user.get_active_hand()
			if(active_hand)
				final_force *= active_hand.limb_efficiency/LIMB_EFFICIENCY_OPTIMAL

	return clamp(FLOOR(final_force, DAMAGE_PRECISION), 0, max_force)
