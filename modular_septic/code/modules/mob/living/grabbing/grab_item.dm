/obj/item/grab
	name = "grab"
	icon = 'modular_septic/icons/hud/quake/grab.dmi'
	icon_state = "blank"
	base_icon_state = "blank"
	worn_icon = 'modular_septic/icons/hud/quake/grab.dmi'
	worn_icon_state = "blank"
	item_flags = DROPDEL | NOBLUDGEON | ABSTRACT | HAND_ITEM
	slot_flags = ITEM_SLOT_MASK
	carry_weight = 0
	/// A typecache of items that should use attack_hand() instead of item attack procs
	var/static/list/attack_hand_typecache
	/// Our screen object, which is actually used for supporting multiple interactions and shit
	var/atom/movable/screen/grab/grab_hud
	/// Our current mode
	var/grab_mode = GM_STAUNCH
	/// The body zone we're grabbing - not necessarily equal to the grasped bodypart
	var/grasped_zone
	/// The bodypart we're grabbing
	var/obj/item/bodypart/grasped_part
	/// The mob being grabbed
	var/mob/living/victim
	/// The carbon who owns all of this mess
	var/mob/living/carbon/owner
	/// How much we've twisted/strangled the affected limb
	var/actions_done = 0
	/// Boolean used for strangling and takedowns
	var/active = FALSE
	/// Boolean used to differentiate between bite and normal grab
	var/bite_grab = FALSE

/// Initializing the typecache
/obj/item/grab/Initialize()
	if(!attack_hand_typecache)
		//expand this later
		attack_hand_typecache = typecacheof(/obj/structure/table)
	return ..()

/// No wield grab
/obj/item/grab/get_wield_component()
	return

/// Outline looks weird on grabs
/obj/item/grab/apply_outline(outline_color)
	return

/// Examining (examining the grab hud thing will examine this instead)
/obj/item/grab/examine(mob/user)
	. = ..()
	var/grabbing_wording = (bite_grab ? "Biting" : "Grabbing")
	if(grasped_part)
		if(!bite_grab && LAZYLEN(grasped_part.embedded_objects))
			. += span_alert("[grabbing_wording] [grasped_part.embedded_objects[1]] embedded in <b>[victim]</b>'s [grasped_part.name].")
		else
			. += span_alert("[grabbing_wording] <b>[victim]</b> by [victim.p_their()] [parse_zone(grasped_zone)].")
	else if(victim)
		. += span_alert("[grabbing_wording] <b>[victim]</b>.")
	switch(grab_mode)
		if(GM_STAUNCH)
			. += span_info("Keep holding to staunch the bleeding on <b>[victim]</b>[grasped_part ? "'s [grasped_part.name]" : ""].")
		if(GM_WRENCH)
			. += span_info("Use to wrench <b>[victim]</b>[grasped_part ? "'s [parse_zone(grasped_zone)]" : ""].")
		if(GM_TEAROFF)
			. += span_info("Use to <span class='danger'><b>tear off</b></span> <b>[victim]</b>[grasped_part ? "'s [parse_zone(grasped_zone)]" : ""].")
		if(GM_STRANGLE)
			. += span_info("Use to strangle <b>[victim]</b>.")
		if(GM_TAKEDOWN)
			. += span_info("Use to perform a takedown on <b>[victim]</b>.")
		if(GM_BITE)
			. += span_info("Use to bite <b>[victim]</b>[grasped_part ? "'s [parse_zone(grasped_zone)]" : ""].")
		if(GM_GUTBUSTED)
			. += span_info("Use to tear off <b>[victim]</b>'s guts.")

/obj/item/grab/Destroy()
	. = ..()
	if(owner)
		if(victim)
			playsound(victim, 'modular_septic/sound/attack/thudswoosh.ogg', 50, 1, -1)
			var/grab_wording = (bite_grab ? "biting" : "grabbing")
			if(owner == victim)
				victim.visible_message(span_warning("<b>[owner]</b> stops [grab_wording] [victim.p_themselves()] by [victim.p_their()] [grasped_part.name]!"),\
											span_notice("I stop [grab_wording] myself by my [grasped_part.name]!"))
			else
				victim.visible_message(span_danger("<b>[owner]</b> stops [grab_wording] <b>[victim]</b>[grasped_part ? " by [victim.p_their()] [grasped_part.name]": ""]!"),\
										span_userdanger("<b>[owner]</b> stops [grab_wording] me[grasped_part ? " by my [grasped_part.name]" : ""]!"),\
										ignored_mobs = owner)
				to_chat(owner, span_danger("I stop [grab_wording] <b>[victim]</b>[grasped_part ? " by [victim.p_their()] [grasped_part.name]" : ""]!"))
		//Let's only stop pulling if we have no other hand grasping the victim
		var/stop_pulling = TRUE
		var/list/potential_grabs = owner.held_items | owner.get_item_by_slot(ITEM_SLOT_MASK)
		for(var/obj/item/grab/other_grab in potential_grabs)
			if(other_grab == src)
				continue
			stop_pulling = FALSE
		if(stop_pulling)
			owner.stop_pulling()
		//Stop strangling!
		else if((grab_mode == GM_STRANGLE) && active)
			strangle()
		//Stop taking down!
		else if((grab_mode == GM_TAKEDOWN) && active)
			takedown()
		UnregisterSignal(owner, list(COMSIG_PARENT_QDELETING, COMSIG_MOVABLE_SET_GRAB_STATE))
	if(victim)
		UnregisterSignal(victim, list(COMSIG_PARENT_QDELETING, COMSIG_CARBON_REMOVE_LIMB))
		victim.cure_blind("grab_[grasped_zone]")
		if(bite_grab)
			REMOVE_TRAIT(victim, TRAIT_BITTEN, WEAKREF(owner))
	if(grasped_part)
		UnregisterSignal(grasped_part, COMSIG_PARENT_QDELETING)
		LAZYREMOVE(grasped_part.grasped_by, src)
	if(grab_hud)
		vis_contents -= grab_hud
		QDEL_NULL(grab_hud)
	owner = null
	victim = null
	grasped_part = null

//Attack hand typecache checks
/obj/item/grab/pre_attack(atom/A, mob/living/user, params)
	if(is_type_in_typecache(A, attack_hand_typecache))
		var/list/modifiers = params2list(params)
		A.attack_hand(user, modifiers)
		return TRUE
	return ..()

/obj/item/grab/attack_self(mob/user, modifiers)
	. = ..()
	if(!isliving(user))
		return
	if(iscarbon(victim) && COOLDOWN_FINISHED(user, next_move))
		switch(grab_mode)
			if(GM_STRANGLE)
				strangle()
			if(GM_TAKEDOWN)
				takedown()
			if(GM_EMBEDDED)
				twist_embedded()
			if(GM_TEAROFF, GM_WRENCH)
				wrench_limb()
			if(GM_BITE)
				bite_limb()
			if(GM_GUTBUSTED)
				tear_off_gut()
	for(var/obj/item/grab/grabber in (owner.held_items | owner.get_item_by_slot(ITEM_SLOT_MASK)))
		grabber.update_grab_mode()

/// Throw the mob, not us
/obj/item/grab/on_thrown(mob/living/carbon/user, atom/target)
	if(victim == user)
		user.dropItemToGround(src, silent = TRUE)
		return
	if(victim != user.pulling)
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		user.stop_pulling()
		to_chat(user, span_notice("I gently let go of [victim]."))
		return
	return victim

/// Updates the grab mode based on several circumstances
/obj/item/grab/proc/update_grab_mode()
	if(bite_grab)
		grab_mode = GM_BITE
	else
		if((grasped_part?.body_zone == BODY_ZONE_HEAD) && !LAZYLEN(grasped_part.embedded_objects))
			var/obj/item/bodypart/neck = victim.get_bodypart(BODY_ZONE_PRECISE_NECK)
			if(neck)
				grasped_part = neck
				return update_grab_mode()
		switch(grasped_zone)
			if(BODY_ZONE_HEAD)
				var/obj/item/bodypart/head = victim.get_bodypart(grasped_zone)
				if(head && (head != grasped_part) && LAZYLEN(head?.embedded_objects))
					grasped_part = head
					return update_grab_mode()
				else
					if(grasped_part?.can_dismember() && (GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH) - GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE)) >= GM_TEAROFF_DIFF)
						grab_mode = GM_TEAROFF
					else
						grab_mode = GM_WRENCH
			if(BODY_ZONE_PRECISE_NECK)
				grab_mode = GM_STRANGLE
			if(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_VITALS, BODY_ZONE_PRECISE_GROIN)
				grab_mode = GM_STAUNCH
				if(grasped_part?.get_bleed_rate())
					grab_mode = GM_STAUNCH_BLEEDING
				if(owner != victim)
					var/wrenched_count = 0
					for(var/obj/item/grab/other_grab in owner.held_items)
						if(other_grab == src)
							continue
						if((other_grab.grab_mode in list(GM_TEAROFF, GM_WRENCH)) && other_grab.actions_done)
							wrenched_count += other_grab.actions_done
					if(wrenched_count || (victim.body_position == LYING_DOWN))
						grab_mode = GM_TAKEDOWN
				if(grasped_zone == BODY_ZONE_PRECISE_VITALS)
					var/has_gut = FALSE
					var/list/ropes = victim.GetComponents(/datum/component/rope)
					for(var/datum/component/rope/possible_rope as anything in ropes)
						var/obj/item/organ/roped_organ = possible_rope.roped
						if(istype(roped_organ) && (ORGAN_SLOT_INTESTINES in roped_organ.organ_efficiency))
							has_gut = TRUE
							break
					if(grasped_part.spilled && has_gut)
						grab_mode = GM_GUTBUSTED
			else
				if(grasped_part?.can_dismember() && (GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH) - GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE)) >= GM_TEAROFF_DIFF)
					grab_mode = GM_TEAROFF
				else
					grab_mode = GM_WRENCH
		if(LAZYLEN(grasped_part?.embedded_objects))
			grab_mode = GM_EMBEDDED
	update_hud()

/// Registers signals and variables and stuff
/obj/item/grab/proc/registergrab(mob/new_victim, mob/new_owner, instant = FALSE, biting_grab = FALSE, forced = FALSE, grabsound = TRUE, silent = FALSE)
	if(!new_victim || !new_owner)
		return
	owner = new_owner
	RegisterSignal(new_owner, COMSIG_PARENT_QDELETING, .proc/qdel_void)
	victim = new_victim
	if(owner != victim)
		RegisterSignal(owner, COMSIG_MOVABLE_SET_GRAB_STATE, .proc/new_grab_state)
		if(owner.grab_state < GRAB_AGGRESSIVE)
			owner.setGrabState(GRAB_AGGRESSIVE)
			owner.set_pull_offsets(new_victim, owner.grab_state)
		RegisterSignal(victim, COMSIG_PARENT_QDELETING, .proc/qdel_void)
		RegisterSignal(victim, COMSIG_ATOM_NO_LONGER_PULLED, .proc/qdel_void)
		RegisterSignal(victim, COMSIG_CARBON_REMOVE_LIMB, .proc/check_delimb)

	grasped_zone = new_owner.zone_selected
	if(grasped_zone in list(BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE))
		victim.become_blind("grab_[grasped_zone]")
	if(!biting_grab && (grasped_zone == BODY_ZONE_HEAD) && !LAZYLEN(target_zone.embedded_objects))
		target_zone = victim.get_bodypart(BODY_ZONE_PRECISE_NECK)
	if(target_zone)
		grasped_part = target_zone
		LAZYADD(grasped_part.grasped_by, src)
		RegisterSignal(grasped_part, COMSIG_PARENT_QDELETING, .proc/qdel_void)
		// Bloody hands if the part is bleeding
		if(!biting_grab)
			if(grasped_part.get_bleed_rate(FALSE))
				if(owner.gloves)
					owner.gloves.add_mob_blood(victim)
				else
					owner.add_mob_blood(victim)
		else if(ishuman(owner))
			owner.AddComponent(/datum/component/creamed/blood)
	bite_grab = biting_grab
	if(bite_grab)
		ADD_TRAIT(victim, TRAIT_BITTEN, WEAKREF(owner))
	create_hud_object()
	update_grab_mode()

/// Displays the initial grabbing message
/obj/item/grab/proc/display_grab_message(biting_grab = FALSE, grabsound = TRUE, silent = FALSE)
	if(!silent)
		if(grabsound)
			if(biting_grab)
				playsound(victim, owner.dna.species.bite_sound, 75, FALSE)
			else
				playsound(victim, 'modular_septic/sound/attack/grapple.wav', 75, FALSE)
	/// The owner always has to be a carbon - Thus selfgrab always has a bodypart being grasped
	if(owner == victim)
		if(!silent)
			if(grabsound)
				if(biting_grab)
					victim.visible_message(span_danger("<b>[owner]</b> bites [owner.p_their()] [grasped_part.name]!"), \
								span_userdanger("I bite my [grasped_part.name]!"), \
								vision_distance = COMBAT_MESSAGE_RANGE)
				else
					victim.visible_message(span_danger("<b>[owner]</b> grasps [owner.p_their()] [grasped_part.name]."), \
								span_userdanger("I grab hold of my [grasped_part.name] tightly."), \
								vision_distance = COMBAT_MESSAGE_RANGE)
	else
		if(!silent)
			if(grabsound)
				if(biting_grab)
					victim.visible_message(span_danger("<b>[owner]</b> bites <b>[victim]</b>[grasped_part ? " by [victim.p_their()] [grasped_part.name]" : ""]!"),\
											span_userdanger("I am bitten [grasped_part ? "on my [grasped_part.name] " : ""]by <b>[owner]</b>!"), \
											span_warning("I hear a gnawing sound."),\
											vision_distance = COMBAT_MESSAGE_RANGE, \
											ignored_mobs = owner)
					to_chat(owner, span_userdanger("I bite <b>[victim]</b>[grasped_part ? " by [victim.p_their()] [grasped_part.name]" : ""]!"))
				else
					victim.visible_message(span_danger("<b>[owner]</b> grasps <b>[victim]</b>[grasped_part ? " by [victim.p_their()] [grasped_part.name]" : ""]!"),\
											span_userdanger("I am grasped [grasped_part ? "on my [grasped_part.name] " : ""]by <b>[owner]</b>!"), \
											span_warning("I hear a shuffling sound."),\
											vision_distance = COMBAT_MESSAGE_RANGE, \
											ignored_mobs = owner)
					to_chat(owner, span_userdanger("I grab <b>[victim]</b>[grasped_part ? " by [victim.p_their()] [grasped_part.name]" : ""]!"))
			return TRUE

/// Creates the hud object we are tied to
/obj/item/grab/proc/create_hud_object()
	if(grab_hud)
		QDEL_NULL(grab_hud)
	grab_hud = new()
	grab_hud.parent = src
	vis_contents += grab_hud

/// Updates the appearance of the hud object
/obj/item/grab/proc/update_hud()
	if(!grab_hud)
		return
	grab_hud.update_appearance()

/// The victim got deleted, owner got deleted, or the bodypart we're grasping got deleted
/obj/item/grab/proc/qdel_void()
	if(!QDELETED(src))
		return qdel(src)

/// Handling grab state changes
/obj/item/grab/proc/new_grab_state(mob/living/source, new_state)
	if(new_state <= GRAB_PASSIVE)
		qdel_void()
		return

/// Update the grab mode, which then updates the hud icon, too lazy to implement a limb check
/obj/item/grab/proc/handle_embed_removal()
	update_grab_mode()

/// Delete ourselves, but only if the limb removed was our associated limb
/obj/item/grab/proc/check_delimb(mob/living/carbon/source, obj/item/bodypart/limb_removed)
	if(grasped_part == limb_removed)
		qdel_void()
		return
